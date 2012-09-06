package ggp.repository.base;

import ggp.repository.MetadataCompleter;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;

import org.json.JSONException;
import org.json.JSONObject;

public class BaseRepository {
    public static final String repositoryRootDirectory = "http://games.ggp.org/base";    
    
    public static byte[] getResponseBytesForURI(String reqURI) throws IOException {
        // Special case: the main page.
        if (reqURI.equals("/") || reqURI.equals("/index.html")) {
            return BaseRepository.readFile(new File("root/gameListBase.html")).getBytes();
        }
        
        // Files not under /games/ aren't versioned, and can just be
        // accessed directly.
        if (!reqURI.startsWith("/games/")) {
            return getBytesForFile(new File("root" + reqURI));
        }
        
        // Provide a listing of all of the metadata files for all of
        // the games, on request.
        if (reqURI.equals("/games/metadata")) {
            JSONObject theGameMetaMap = new JSONObject();
            for (String gameName : new File("root", "games").list()) {
                try {
                    theGameMetaMap.put(gameName, new JSONObject(new String(getResponseBytesForURI("/games/" + gameName + "/"))));
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
            return theGameMetaMap.toString().getBytes();
        }
        
        // Accessing the folder containing a game should show the game's
        // associated metadata (which includes the contents of the folder).
        if(reqURI.endsWith("/") && reqURI.length() > 9) {
            reqURI += "METADATA";
        }
        
        // Extract out the version number
        String thePrefix = reqURI.substring(0, reqURI.lastIndexOf("/"));
        String theSuffix = reqURI.substring(reqURI.lastIndexOf("/")+1);
        Integer theExplicitVersion = null;
        try {
            String vPart = thePrefix.substring(thePrefix.lastIndexOf("/v")+2);
            theExplicitVersion = Integer.parseInt(vPart);            
            thePrefix = thePrefix.substring(0, thePrefix.lastIndexOf("/v"));
        } catch (Exception e) {
            ;
        }
        
        // Sanity check: raise an exception if the parsing didn't work.
        if (theExplicitVersion == null) {
            if (!reqURI.equals(thePrefix + "/" + theSuffix)) {
                throw new RuntimeException(reqURI + " != [~v] " + (thePrefix + "/" + theSuffix));
            }
        } else {
            if (!reqURI.equals(thePrefix + "/v" + theExplicitVersion + "/" + theSuffix)) {
                throw new RuntimeException(reqURI + " != [v] " + (thePrefix + "/v" + theExplicitVersion + "/" + theSuffix));
            }
        }

        // When no version number is explicitly specified, assume that we want the
        // latest version, whatever that is. Also, make sure the game version being
        // requested actually exists (i.e. is between 0 and the max version).
        int nMaxVersion = getMaxVersionForDirectory(new File("root", thePrefix));        
        Integer theFetchedVersion = theExplicitVersion;
        if (theFetchedVersion == null) theFetchedVersion = nMaxVersion;
        if (theFetchedVersion < 0 || theFetchedVersion > nMaxVersion) return null;

        while (theFetchedVersion >= 0) {
            byte[] theBytes = getBytesForVersionedFile(thePrefix, theFetchedVersion, theSuffix);
            if (theBytes != null) {
                if (theSuffix.equals("METADATA")) {
                    theBytes = adjustMetadataJSON(reqURI, theBytes, theExplicitVersion, nMaxVersion);
                }
                return theBytes;
            }
            theFetchedVersion--;
        }
        return null;
    }
    
    // When the user requests a particular version, the metadata should always be for that version.
    // When the user requests the latest version, the metadata should always indicate the most recent version.
    public static byte[] adjustMetadataJSON(String reqURI, byte[] theMetaBytes, Integer nExplicitVersion, int nMaxVersion) throws IOException {
        try {
            JSONObject theMetaJSON = new JSONObject(new String(theMetaBytes));
            if (nExplicitVersion == null) {
                theMetaJSON.put("version", nMaxVersion);                
            } else {
                theMetaJSON.put("version", nExplicitVersion);
            }
            String theRulesheet = new String(getResponseBytesForURI(reqURI.replace("METADATA",theMetaJSON.getString("rulesheet"))));
            MetadataCompleter.completeMetadataFromRulesheet(theMetaJSON, theRulesheet);
            return theMetaJSON.toString().getBytes();
        } catch (JSONException je) {
            throw new IOException(je);
        }
    }    
    
    private static int getMaxVersionForDirectory(File theDir) {
        if (!theDir.exists() || !theDir.isDirectory()) {
            return -1;
        }
        
        int maxVersion = 0;
        String[] children = theDir.list();
        for (String s : children) {
            if (s.startsWith("v")) {
                int nVersion = Integer.parseInt(s.substring(1));
                if (nVersion > maxVersion) {
                    maxVersion = nVersion;
                }
            }
        }
        return maxVersion;
    }
    
    private static byte[] getBytesForVersionedFile(String thePrefix, int theVersion, String theSuffix) {
        if (theVersion == 0) {
            return getBytesForFile(new File("root", thePrefix + "/" + theSuffix));
        } else {
            return getBytesForFile(new File("root", thePrefix + "/v" + theVersion + "/" + theSuffix));
        }
    }
    
    private static byte[] getBytesForFile(File theFile) {
        try {
            if (!theFile.exists()) {
                return null;
            } else if (theFile.isDirectory()) {
                return readDirectory(theFile).getBytes();
            } else if (theFile.getName().endsWith(".png")) {
                // TODO: Handle other binary formats?
                return readBinaryFile(theFile);
            } else if (theFile.getName().endsWith(".xsl")) {
                return transformXSL(readFile(theFile)).getBytes();
            } else if (theFile.getName().endsWith(".js")) {
                return transformJS(readFile(theFile)).getBytes();
            } else {
                return readFile(theFile).getBytes();
            }
        } catch (IOException e) {
            return null;
        }
    }
    
    private static String transformXSL(String theContent) {
        // Special case override for XSLT        
        return "<!DOCTYPE stylesheet [<!ENTITY ROOT \""+repositoryRootDirectory+"\">]>\n\n" + theContent;
    }
    
    private static String transformJS(String theContent) throws IOException {
        // Horrible hack; fix this later. Right now this is used to
        // let games share a common board user interface, but this should
        // really be handled in a cleaner, more general way with javascript
        // libraries and imports.
        if (theContent.contains("[BOARD_INTERFACE_JS]")) {
            String theCommonBoardJS = readFile(new File("root/resources/scripts/BoardInterface.js"));
            theContent = theContent.replaceFirst("\\[BOARD_INTERFACE_JS\\]", theCommonBoardJS);
        }
        return theContent;
    }

    private static String readDirectory(File theDirectory) throws IOException {
        StringBuilder response = new StringBuilder();
        // Show contents of the directory, using JSON notation.
        response.append("[");

        String[] children = theDirectory.list();
        for (int i=0; i<children.length; i++) {
            // Get filename of file or directory
            response.append("\"");
            response.append(children[i]);
            response.append("\",\n ");
        }

        response.delete(response.length()-3, response.length());
        response.append("]");
        return response.toString();
    }
    
    public static String readFile(File rootFile) throws IOException {
        // Show contents of the file.                                        
        FileReader fr = new FileReader(rootFile);
        BufferedReader br = new BufferedReader(fr);
        
        String response = "";
        String line;
        while( (line = br.readLine()) != null ) {
            response += line + "\n";
        }
        
        return response;
    }
    
    private static byte[] readBinaryFile(File rootFile) throws IOException {
        InputStream in = new FileInputStream(rootFile);
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        
        // Transfer bytes from in to out
        byte[] buf = new byte[1024];
        while (in.read(buf) > 0) {
            out.write(buf);
        }
        in.close();
        
        return out.toByteArray();
    }
}
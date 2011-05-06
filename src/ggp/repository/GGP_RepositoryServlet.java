package ggp.repository;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.*;

import java.util.Collections;
import net.sf.jsr107cache.Cache;
import net.sf.jsr107cache.CacheException;
import net.sf.jsr107cache.CacheManager;

@SuppressWarnings("serial")
public class GGP_RepositoryServlet extends HttpServlet {
    public static final String repositoryRootDirectory = "http://games.ggp.org";
    
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        // Initialize the memcache.
        Cache cache;
        try {
            cache = CacheManager.getInstance().getCache("gameCache");
            if (cache == null) {
                cache = CacheManager.getInstance().getCacheFactory().createCache(Collections.emptyMap());
                CacheManager.getInstance().registerCache("gameCache", cache);
            }
        } catch (CacheException e) {
            throw new RuntimeException(e);
        }        
        
        // Allow cross-site access to the files, since nothing is mutable.
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "*");
        resp.setHeader("Access-Control-Allow-Age", "86400");        
        
        // Generate the response content.
        String reqURI = req.getRequestURI();
        
        // Generate the content type based on the URL.
        resp.setContentType(getContentType(reqURI));

        // Cache control administrative requests
        if (reqURI.equals("/cache/stats")) {
            String theStatsString = "Cache statistics [v2]: ";
            theStatsString += "Hits(" + cache.getCacheStatistics().getCacheHits() + ") ";
            theStatsString += "Misses(" + cache.getCacheStatistics().getCacheMisses() + ") ";
            theStatsString += "Size(" + cache.size() + ") ";
            resp.getWriter().println(theStatsString);
            resp.setStatus(200);
            return;
        } else if (reqURI.equals("/cache/flush")) {
            cache.clear();
            resp.getWriter().println("Cache flushed.");
            resp.setStatus(200);
            return;            
        }

        // Query the cache for the requested URL, and return the cached
        // value if there's a cache hit.
        if (cache.containsKey(reqURI)) {
            byte[] theCachedValue = (byte[])cache.get(reqURI);
            resp.getOutputStream().write(theCachedValue);
            resp.setStatus(200);
            return;
        }

        // Otherwise, get the bytes for the response.
        byte[] responseBytes = null;
        try {
            responseBytes = getResponseBytesForURI(reqURI);
        } catch (IOException e) {
            ;
        }
        
        // Write the response content.
        if(responseBytes != null && responseBytes.length > 0) {
            // First, cache the content for later use.
            cache.put(reqURI, responseBytes);

            // Then write it out to the client.
            resp.getOutputStream().write(responseBytes);
            resp.setStatus(200);
        } else {
            resp.setStatus(404);
        }
    }
    
    private static byte[] getResponseBytesForURI(String reqURI) throws IOException {
        // Special case: the main page.
        if (reqURI.equals("/") || reqURI.equals("/index.html")) {
            return readFile(new File("root/gameList.html")).getBytes();
        }
        
        if (reqURI.startsWith("/games/")) {
            if(reqURI.endsWith("/") && reqURI.length() > 9) {
                reqURI += "METADATA";
            }

            // TODO: Come up with a much better implementation of versioning
            // than this hacky hack.
            if (reqURI.contains("v0/")) reqURI = reqURI.replaceFirst("v0/", "");            
            
            /*
            String vPrefix = reqURI;
            int nVersion = -1;            
            try {
                String lastPart = reqURI.substring(reqURI.lastIndexOf("/v")+1);
                String vPart = lastPart.substring(0,lastPart.indexOf("/"));
                nVersion = Integer.parseInt(vPart);
            } catch (Exception e) {
                ;
            }
            */
        }            
        
        return getBytesForFile(new File("root" + reqURI));        
    }

    private static String getContentType(String theURL) {
        if (theURL.endsWith(".xml")) {
            return "application/xml";
        } else if (theURL.endsWith(".xsl")) {
            return "application/xml";
        } else if (theURL.endsWith(".js")) {
            return "text/javascript";   
        } else if (theURL.endsWith(".json")) {
            return "text/javascript";
        } else if (theURL.endsWith(".html")) {
            return "text/html";
        } else if (theURL.endsWith(".png")) {
            return "image/png";
        } else {
            if (theURL.equals("/")) {
                return "text/html";
            } else if (theURL.endsWith("/")) {
                return "text/javascript";
            }
            
            return "text/plain";
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
    
    private static String readFile(File rootFile) throws IOException {
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

package ggp.repository;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.*;

@SuppressWarnings("serial")
public class GGP_RepositoryServlet extends HttpServlet {
    public static final String repositoryRootDirectory = "http://games.ggp.org";
    
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        // Allow cross-site access to the files, since nothing is mutable.
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "*");
        resp.setHeader("Access-Control-Allow-Age", "86400");        
        
        // Generate the response content.
        String response = "";
        String contentType = "";
        String reqURI = req.getRequestURI();
        
        // TODO: Come up with a much better implementation of versioning
        // than this hacky hack.
        if (reqURI.contains("v0/")) reqURI = reqURI.replaceFirst("v0/", "");
                
        if (reqURI.equals("/") || reqURI.equals("/index.html")) {
            response = readFile(new File("root/gameList.html"));
            contentType = "text/html";
        } else if(reqURI.startsWith("/games/") && reqURI.endsWith("/") && reqURI.length() > 9) {
            response = readFile(new File("root" + reqURI + "METADATA"));
            contentType = "text/javascript";
        } else {
            String rootURI = "root" + reqURI;            
            File rootFile = new File(rootURI);
            if (rootFile.exists()) {
                if (rootFile.isDirectory()) {
                    // Show contents of the directory, using JSON notation.
                    contentType = "text/javascript";
                    response = "[";

                    String[] children = rootFile.list();
                    for (int i=0; i<children.length; i++) {
                        // Get filename of file or directory
                        response += '"' + children[i] + "\",\n ";
                    }

                    response = response.substring(0, response.length() - 3) + "]";
                } else if(reqURI.endsWith(".png")) {
                    InputStream in = new FileInputStream(rootFile);
                
                    // Transfer bytes from in to out
                    byte[] buf = new byte[1024];
                    while (in.read(buf) > 0) {
                        resp.getOutputStream().write(buf);
                    }
                    in.close();
                    
                    contentType = "image/png";
                    response = "";
                } else {
                    // Show contents of the file.                                        
                    response += readFile(rootFile);

                    // Special case override for XSLT
                    if (reqURI.endsWith(".xsl")) {
                        response = "<!DOCTYPE stylesheet [<!ENTITY ROOT \""+repositoryRootDirectory+"\">]>\n\n" + response;
                    }
                    
                    // Horrible hack; fix this later. Right now this is used to
                    // let games share a common board user interface, but this should
                    // really be handled in a cleaner, more general way with javascript
                    // libraries and imports.
                    if (reqURI.endsWith(".js") && response.contains("[BOARD_INTERFACE_JS]")) {
                        String theCommonBoardJS = readFile(new File("root/resources/scripts/BoardInterface.js"));
                        response = response.replaceFirst("\\[BOARD_INTERFACE_JS\\]", theCommonBoardJS);
                    }
                }
            } else {
                resp.setStatus(404);
                response = "";
            }
        }
        
        // Content type: use explicitly set type, or infer from filename,
        // or fall back to using text/plain.
        if (contentType.length() > 0) {
            resp.setContentType(contentType);
        } else if (reqURI.endsWith(".xml")) {
            resp.setContentType("application/xml");
        } else if (reqURI.endsWith(".xsl")) {
            resp.setContentType("application/xml");
        } else if (reqURI.endsWith(".js")) {
            resp.setContentType("text/javascript");   
        } else if (reqURI.endsWith(".json")) {
            resp.setContentType("text/javascript");
        } else {
            resp.setContentType("text/plain");
        }
        
        // Write the response content.
        if(response.length() > 0) {
            resp.getWriter().println(response);
        }
    }
    
    private String readFile(File rootFile) throws IOException {
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
}

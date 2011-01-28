package ggp.repository;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
        if (reqURI.contains("v0/")) reqURI = reqURI.replace("v0/", "");
                
        if (reqURI.equals("/") || reqURI.equals("/index.html")) {
            response = generateIndexPage();
            contentType = "text/html";
        } else if(reqURI.startsWith("/games/") && reqURI.endsWith("/index.html") && reqURI.length() > 18) {
            response = generateGameDirectoryPage(reqURI);
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
    
    private String generateIndexPage() {
        StringBuilder b = new StringBuilder();
        
        b.append("<html><head><title>GGP Game Repository</title></head>");
        
        b.append("<body><h1>GGP Game Repository</h1>");
        b.append("Welcome to an active instance of a GGP Game Repository. ");
        b.append("The games available in this repository are:<ul>");
        
        List<String> theKeyList = new ArrayList<String>(getAvailableGames());
        Collections.sort(theKeyList);        
        for (String gameName : theKeyList) {
            b.append("<li><a href=games/" + gameName + "/index.html>" + gameName + "</a>");
        }
        b.append("</ul></body></html>");
        
        return b.toString();
    }
    
    private String generateGameDirectoryPage(String reqURI) {
        StringBuilder b = new StringBuilder();
        String gameName = reqURI.replace("/games/", "").replace("/index.html", "");        
        
        b.append("<html><head><title>GGP Game Repository</title></head>");
        
        b.append("<body><h1>GGP Game Repository</h1>");
        b.append("<body><h2>"+gameName+"</h2>");
        
        b.append("Files associated with this game are:<ul>");
        
        String rootURI = "root" + reqURI.replace("/index.html", ""); 
        File rootFile = new File(rootURI);
        if (rootFile.exists() && rootFile.isDirectory()) {
            String[] children = rootFile.list();
            for (int i=0; i<children.length; i++) {
                // Get filename of file or directory
                b.append("<li><a href=" + children[i] + ">" + children[i] + "</a>");                    
            }
        }
        
        b.append("</ul></body></html>");

        return b.toString();
    }
    
    private Set<String> getAvailableGames() {
        Set<String> theSet = new HashSet<String>();        
        String[] children = new File("root/games/").list();
        for (int i=0; i<children.length; i++) {
            theSet.add(children[i]);
        }
        return theSet;
    }
}

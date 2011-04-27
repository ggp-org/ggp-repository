package ggp.repository;

import java.io.BufferedReader;
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
        String response = "";
        String reqURI = req.getRequestURI();
        
        // Generate the content type based on the URL.
        resp.setContentType(getContentType(reqURI));
        
        if (reqURI.equals("/cache/stats")) {
            String theStatsString = "Cache statistics: ";
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
            String theCachedValue = cache.get(reqURI).toString();
            resp.getWriter().println(theCachedValue);
            resp.setStatus(200);
            return;
        }
        
        // TODO: Come up with a much better implementation of versioning
        // than this hacky hack.
        if (reqURI.contains("v0/")) reqURI = reqURI.replaceFirst("v0/", "");
                
        if (reqURI.equals("/") || reqURI.equals("/index.html")) {
            response = readFile(new File("root/gameList.html"));
        } else if(reqURI.startsWith("/games/") && reqURI.endsWith("/") && reqURI.length() > 9) {
            response = readFile(new File("root" + reqURI + "METADATA"));
        } else {
            String rootURI = "root" + reqURI;            
            File rootFile = new File(rootURI);
            if (rootFile.exists()) {
                if (rootFile.isDirectory()) {
                    // Show contents of the directory, using JSON notation.
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
        
        // Write the response content.
        if(response.length() > 0) {
            // First, cache the content for later use.
            cache.put(reqURI, response);

            // Then write it out to the client.
            resp.getWriter().println(response);
            resp.setStatus(200);
        }
    }
    
    private String getContentType(String theURL) {
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

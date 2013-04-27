package ggp.repository;

import static com.google.appengine.api.taskqueue.RetryOptions.Builder.withTaskRetryLimit;
import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

import java.io.File;
import java.io.IOException;

import org.ggp.galaxy.shared.website.CachedStaticServlet;

import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.taskqueue.TaskOptions.Method;

import ggp.repository.base.BaseRepository;
import ggp.repository.dresden.DresdenRepository;
import ggp.repository.stanford.StanfordRepository;

@SuppressWarnings("serial")
public class GGP_RepositoryServlet extends CachedStaticServlet {
	private final int UPDATE_RETRIES = 10;
	
    protected byte[] getResponseBytesForURI(String reqURI) throws IOException {
    	// Main pages
    	if (reqURI.equals("/base/") || reqURI.equals("/stanford/") || reqURI.equals("/dresden/") ||
    		reqURI.equals("/base") || reqURI.equals("/stanford") || reqURI.equals("/dresden")) {
    		return BaseRepository.readFile(new File("root/gameList.html")).getBytes();
    	}
    	
        // Repository: the /dresden/ games.
        if (reqURI.startsWith("/dresden/")) {
            return DresdenRepository.getResponseBytesForURI(reqURI.substring("/dresden".length()));
        }
        
        // Repository: the /stanford/ games.
        if (reqURI.startsWith("/stanford/")) {
            return StanfordRepository.getResponseBytesForURI(reqURI.substring("/stanford".length()));
        }        

        // Repository: the /base/ games.
        if (reqURI.startsWith("/base/")) {
            return BaseRepository.getResponseBytesForURI(reqURI.substring("/base".length()));
        }

        // Web plumbing: return a well-formed robots.txt file discouraging crawling.
        if (reqURI.equals("/robots.txt")) {
            return BaseRepository.readFile(new File("root/robots.txt")).getBytes();
        }
        
        // Otherwise show a static page for the root directory.
        if (reqURI.equals("/") || reqURI.equals("/index.html")) {
            return BaseRepository.readFile(new File("root/index.html")).getBytes();
        }
        
        return null;
    }

    @Override
    protected void handleCronRequest(String reqURI) throws IOException {
    	QueueFactory.getDefaultQueue().add(withUrl("/tasks" + reqURI).method(Method.GET).retryOptions(withTaskRetryLimit(UPDATE_RETRIES)));
    }
    
    @Override
    protected boolean handleTaskQueueRequest(String reqURI, int nRetryAttempt) throws IOException {
    	try {
    		if (reqURI.equals("/update_dresden_quick")) {
	        	DresdenRepository.performRegularIngestion(false);
	        } else if (reqURI.equals("/update_stanford_quick")) {
	        	StanfordRepository.performRegularIngestion(false);
	        } else if (reqURI.equals("/update_dresden_full")) {
	        	DresdenRepository.performRegularIngestion(true);
	        } else if (reqURI.equals("/update_stanford_full")) {
	        	StanfordRepository.performRegularIngestion(true);
	        } else {
	        	return false;
	        }
	        return true;
    	} catch (IOException e) {
    		// For the first few exceptions, silently issue errors to task queue to trigger retries.
    		// After a few retries, start surfacing the exceptions, since they're clearly not transient.
        	// This reduces the amount of noise in the error logs caused by transient server errors.
        	if (nRetryAttempt > UPDATE_RETRIES - 3) {
        		throw new RuntimeException(e);
        	}
        	return false;
    	}
    }
    
    @Override
    protected String getContentTypeForUnknown(String theURL) {
    	if (theURL.equals("/")) {
    		return "text/html";
    	} else if (theURL.equals("/base/")) {
    		return "text/html";
    	} else if (theURL.equals("/dresden/")) {
    		return "text/html";
    	} else if (theURL.equals("/stanford/")) {
    		return "text/html";
    	} else if (theURL.equals("/base")) {
    		return "text/html";
    	} else if (theURL.equals("/dresden")) {
    		return "text/html";
    	} else if (theURL.equals("/stanford")) {
    		return "text/html";    		
    	} else if (theURL.endsWith("/")) {
    		return "text/javascript";
    	}
    	return "text/plain";
    }
}

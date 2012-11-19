package ggp.repository;

import static com.google.appengine.api.taskqueue.RetryOptions.Builder.withTaskRetryLimit;
import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

import java.io.File;
import java.io.IOException;

import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.taskqueue.TaskOptions.Method;

import ggp.repository.base.BaseRepository;
import ggp.repository.dresden.DresdenRepository;

@SuppressWarnings("serial")
public class GGP_RepositoryServlet extends CachedStaticServlet {
	private final int DRESDEN_UPDATE_RETRIES = 10;
	
    protected byte[] getResponseBytesForURI(String reqURI) throws IOException {
        // Repository: the /dresden/ games.
        if (reqURI.startsWith("/dresden/")) {
            return DresdenRepository.getResponseBytesForURI(reqURI.substring("/dresden".length()));
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
    	QueueFactory.getDefaultQueue().add(withUrl("/tasks/update_dresden").method(Method.GET).retryOptions(withTaskRetryLimit(DRESDEN_UPDATE_RETRIES)));
    }
    
    @Override
    protected boolean handleTaskQueueRequest(String reqURI, int nRetryAttempt) throws IOException {
        if (reqURI.equals("/update_dresden")) {
        	try {
        		DresdenRepository.performRegularIngestion();
        		return true;
        	} catch (IOException e) {
        		// For the first few exceptions, silently issue errors to task queue to trigger retries.
        		// After a few retries, start surfacing the exceptions, since they're clearly not transient.
            	// This reduces the amount of noise in the error logs caused by transient server errors.
            	if (nRetryAttempt > DRESDEN_UPDATE_RETRIES - 3) {
            		throw new RuntimeException(e);
            	}
            	return false;
        	}
        }
        return false;
    }    
}

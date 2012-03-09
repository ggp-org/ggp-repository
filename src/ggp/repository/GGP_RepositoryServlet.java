package ggp.repository;

import java.io.File;
import java.io.IOException;

import ggp.repository.base.BaseRepository;
import ggp.repository.dresden.DresdenRepository;

@SuppressWarnings("serial")
public class GGP_RepositoryServlet extends CachedStaticServlet {
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
        
        // TODO: Do something more clever with the root directory.
        return null;
    }

    @Override
    protected void handleCronRequest(String reqURI) throws IOException {
        if (reqURI.equals("/update_dresden")) {
            DresdenRepository.performRegularIngestion();
        }
    }
}

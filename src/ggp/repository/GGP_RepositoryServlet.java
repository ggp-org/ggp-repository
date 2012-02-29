package ggp.repository;

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

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

        // Special case: the implied /base/ tree. To be phased out.
        return BaseRepository.getResponseBytesForURI(reqURI);
    }
}

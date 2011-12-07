package ggp.repository;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.jdo.JDOHelper;
import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.jdo.PersistenceManagerFactory;

import org.datanucleus.store.query.AbstractQueryResult;

public class Persistence {
    @SuppressWarnings("unchecked")
    public static <T> Set<T> loadAll(Class<T> theClass) {
        Set<T> theSet = new HashSet<T>();
        PersistenceManager pm = getPersistenceManager();
        try {
            Iterator<?> sqr = ((AbstractQueryResult) pm.newQuery(theClass).execute()).iterator();
            while (sqr.hasNext()) {
                theSet.add((T)sqr.next());
            }            
        } catch(JDOObjectNotFoundException e) {
            ;
        } finally {
            pm.close();
        }
        return theSet;
    }
    
    public static <T> T loadSpecific(String theKey, Class<T> theClass) {
        T theData = null;
        PersistenceManager pm = getPersistenceManager();
        try {
            theData = (T)pm.detachCopy(pm.getObjectById(theClass, theKey));
        } catch(JDOObjectNotFoundException e) {
            ;
        } finally {
            pm.close();
        }
        return theData;
    }
    
    public static <T> void clearAll(Class<T> theClass) {
        Set<T> theData = loadAll(theClass);        
        
        for (T m : theData) {
            PersistenceManager pm = getPersistenceManager();
            try {
                pm.deletePersistent(pm.getObjectById(theClass, pm.getObjectId(m)));                
            } catch(JDOObjectNotFoundException e) {
                ;
            } finally {
                pm.close();
            }
        }
    }
    
    public static <T> void clearSpecific(String theKey, Class<T> theClass) {
        PersistenceManager pm = getPersistenceManager();
        try {
            pm.deletePersistent(pm.getObjectById(theClass, theKey));
        } catch(JDOObjectNotFoundException e) {
            ;
        } finally {
            pm.close();
        }
    }
    
    private static final PersistenceManagerFactory pmfInstance =
        JDOHelper.getPersistenceManagerFactory("transactions-optional");    
    public static PersistenceManager getPersistenceManager() {
        return pmfInstance.getPersistenceManager();
    }
}
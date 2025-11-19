// DSAC-Library-ejb/src/java/com/dsac/library/ejb/dao/LibraryService.java
package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.Library;
import javax.ejb.Stateless;
import java.util.List;

@Stateless
public class LibraryService {
    
    private LibraryDAO libraryDAO = new LibraryDAO();
    
    
    public List<Library> getAllLibraries() {
        return libraryDAO.getAllLibraries();
    }
    
    public Library getLibraryById(Integer libraryId) {
        return libraryDAO.getLibraryById(libraryId);
    }
    
    public Library getLibraryByName(String name) {
    return libraryDAO.getLibraryByName(name);
}
    
     public List<Library> getLibrariesByDistrict(String district) {
        if (district == null || district.trim().isEmpty() || "all".equalsIgnoreCase(district)) {
            return getAllLibraries();
        }
        return libraryDAO.getLibrariesByDistrict(district);
    }
    
    public List<String> getAllDistricts() {
        return libraryDAO.getAllDistricts();
    }
    
    // Optional: If you added the search method
public List<Library> searchLibrariesByName(String name) {
    return libraryDAO.searchLibrariesByName(name);
}
    
    public boolean createLibrary(Library library) {
        return libraryDAO.createLibrary(library);
    }
}
package com.dsac.library.ejb.model;

import java.io.Serializable;
import java.util.Objects;

public class LibraryServiceId implements Serializable {
    private Integer library;
    private Integer service;
    
    public LibraryServiceId() {}
    
    public LibraryServiceId(Integer library, Integer service) {
        this.library = library;
        this.service = service;
    }
    
    // Getters and setters
    public Integer getLibrary() {
        return library;
    }
    
    public void setLibrary(Integer library) {
        this.library = library;
    }
    
    public Integer getService() {
        return service;
    }
    
    public void setService(Integer service) {
        this.service = service;
    }
    
    // equals() and hashCode() methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof LibraryServiceId)) return false;
        LibraryServiceId that = (LibraryServiceId) o;
        return Objects.equals(library, that.library) && 
               Objects.equals(service, that.service);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(library, service);
    }
}
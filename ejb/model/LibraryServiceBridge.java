package com.dsac.library.ejb.model;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name = "library_services")
@IdClass(LibraryServiceId.class)
public class LibraryServiceBridge implements Serializable {
    
    @Id
    @ManyToOne
    @JoinColumn(name = "library_id")
    private Library library;
    
    @Id
    @ManyToOne
    @JoinColumn(name = "service_id")
    private Service service;
    
    private Boolean isAvailable;
    private String additionalInfo;
    
    // Constructors
    public LibraryServiceBridge() {}
    
    public LibraryServiceBridge(Library library, Service service) {
        this.library = library;
        this.service = service;
        this.isAvailable = true;
    }
    
    // Getters and setters
    public Library getLibrary() {
        return library;
    }
    
    public void setLibrary(Library library) {
        this.library = library;
    }
    
    public Service getService() {
        return service;
    }
    
    public void setService(Service service) {
        this.service = service;
    }
    
    public Boolean getIsAvailable() {
        return isAvailable;
    }
    
    public void setIsAvailable(Boolean isAvailable) {
        this.isAvailable = isAvailable;
    }
    
    public String getAdditionalInfo() {
        return additionalInfo;
    }
    
    public void setAdditionalInfo(String additionalInfo) {
        this.additionalInfo = additionalInfo;
    }
}
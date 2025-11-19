// DSAC-Library-ejb/src/java/com/dsac/library/ejb/model/Service.java
package com.dsac.library.ejb.model;

import java.io.Serializable;

public class Service implements Serializable {
    private Integer serviceId;
    private String name;
    private String description;
    private String iconClass;
    private String pageLink;
    private Boolean isActive;
    
    // Constructors
    public Service() {}
    
    public Service(Integer serviceId, String name, String description, String iconClass, String pageLink) {
        this.serviceId = serviceId;
        this.name = name;
        this.description = description;
        this.iconClass = iconClass;
        this.pageLink = pageLink;
        this.isActive = true;
    }
    
    // Getters and setters
    public Integer getServiceId() {
        return serviceId;
    }
    
    public void setServiceId(Integer serviceId) {
        this.serviceId = serviceId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getIconClass() {
        return iconClass;
    }
    
    public void setIconClass(String iconClass) {
        this.iconClass = iconClass;
    }
    
    public String getPageLink() {
        return pageLink;
    }
    
    public void setPageLink(String pageLink) {
        this.pageLink = pageLink;
    }
    
    public Boolean getIsActive() {
        return isActive;
    }
    
    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
    
    @Override
    public String toString() {
        return "Service{" +
                "serviceId=" + serviceId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", iconClass='" + iconClass + '\'' +
                ", pageLink='" + pageLink + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}
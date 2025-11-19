// Library.java
package com.dsac.library.ejb.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "libraries")
@NamedQueries({
    @NamedQuery(name = "Library.findAll", query = "SELECT l FROM Library l"),
    @NamedQuery(name = "Library.findActive", query = "SELECT l FROM Library l"),
    @NamedQuery(name = "Library.findByDistrict",query = "SELECT l FROM Library l WHERE l.district = :district ORDER BY l.name"),
    @NamedQuery(name = "Library.findAllDistricts",query = "SELECT DISTINCT l.district FROM Library l ORDER BY l.district")
})
public class Library implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "library_id")
    private Integer libraryId;
    
    @Column(name = "name", nullable = false)
    private String name;
    
    @Column(name = "address")
    private String address;
    
    @Column(name = "phone")
    private String phone;
    
    @Column(name = "email")
    private String email;
    
    @Column(name = "district")
    private String district; // Add this field
    
    @Column(name = "hours")
    private String hours;
    
    @Column(name = "image_url")
    private String imageUrl;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date createdAt;
    
    // Constructors, getters, and setters
    public Library() {}

    public Library(Integer libraryId, String name, String address, String phone, String email, String district, String hours, String imageUrl, Date createdAt) {
        this.libraryId = libraryId;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.district = district;
        this.hours = hours;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
    }
    
    
    // Getters and setters...
    public Integer getLibraryId() { return libraryId; }
    public void setLibraryId(Integer libraryId) { this.libraryId = libraryId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }
    
    
    
    public String getHours() { return hours; }
    public void setHours(String hours) { this.hours = hours; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
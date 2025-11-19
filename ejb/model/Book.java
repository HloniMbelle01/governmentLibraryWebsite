// Book.java
package com.dsac.library.ejb.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "books")
public class Book implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "book_id")
    private Integer bookId;
    
    @Column(name = "title", nullable = false)
    private String title;
    
    @Column(name = "author", nullable = false)
    private String author;
    
    @Column(name = "isbn")
    private String isbn;
    
    @Column(name = "publisher")
    private String publisher;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "published_date")
    private Date publishedDate;
    
    @Column(name = "description", length = 2000)
    private String description;
    
    @Column(name = "cover_image")
    private String coverImage;
    
    @Column(name = "category")
    private String category;
    
    @Column(name = "total_copies")
    private Integer totalCopies;
    
    @Column(name = "available_copies")
    private Integer availableCopies;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date createdAt;
    
    // Constructors, getters, and setters
    public Book() {}

    public Book(Integer bookId, String title, String author, String isbn, String publisher, Date publishedDate, String description, String coverImage, String category, Integer totalCopies, Integer availableCopies, Date createdAt) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.isbn = isbn;
        this.publisher = publisher;
        this.publishedDate = publishedDate;
        this.description = description;
        this.coverImage = coverImage;
        this.category = category;
        this.totalCopies = totalCopies;
        this.availableCopies = availableCopies;
        this.createdAt = createdAt;
    }
    
    
    
    // ... similar to Library entity

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public Date getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(Date publishedDate) {
        this.publishedDate = publishedDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Integer getTotalCopies() {
        return totalCopies;
    }

    public void setTotalCopies(Integer totalCopies) {
        this.totalCopies = totalCopies;
    }

    public Integer getAvailableCopies() {
        return availableCopies;
    }

    public void setAvailableCopies(Integer availableCopies) {
        this.availableCopies = availableCopies;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
}
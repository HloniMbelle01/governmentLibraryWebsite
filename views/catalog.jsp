<%-- views/catalog.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Catalog - DSAC Libraries</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .catalog-header {
            text-align: center;
            margin-bottom: 3rem;
            padding: 2rem 0;
            /*background: linear-gradient(135deg, var(--green-700), var(--green-900));*/
            color: white;
            border-radius: 16px;
            position: relative;
            overflow: hidden;
        }
        
        .catalog-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=1200&q=80");
        }
        
        .categories-nav {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            justify-content: center;
            margin: 2rem 0;
            padding: 0 1rem;
        }
        
        .category-filter {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .category-filter:hover,
        .category-filter.active {
            background: var(--yellow);
            color: var(--green-900);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(253, 216, 53, 0.3);
        }
        
        .category-section {
            margin: 4rem 0;
        }
        
        .category-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 3px solid var(--yellow);
        }
        
        .category-title {
            font-family: "Playfair Display", serif;
            font-size: 2.2rem;
            color: var(--green-900);
            margin: 0;
        }
        
        .category-count {
            /*background: var(--green-700);*/
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .books-grid-category {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        
        .view-all-btn {
            background: transparent;
            color: var(--green-700);
            border: 2px solid var(--green-700);
            padding: 0.7rem 1.5rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .view-all-btn:hover {
            background: var(--green-700);
            color: white;
            transform: translateY(-2px);
        }
        
        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 2rem;
            font-size: 0.9rem;
        }
        
        .breadcrumb a {
            color: var(--green-700);
            text-decoration: none;
        }
        
        .breadcrumb .separator {
            color: var(--muted);
        }
        
        .back-to-catalog {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--green-700);
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 2rem;
            transition: var(--transition);
        }
        
        .back-to-catalog:hover {
            gap: 0.8rem;
            color: var(--green-900);
        }
        
        /* Search Section Styles */
        .search-section {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: var(--shadow);
            margin-bottom: 3rem;
            border: 2px solid var(--light-yellow);
        }
        
        .search-section h2 {
            color: var(--green-900);
            margin-bottom: 1.5rem;
            text-align: center;
            font-family: "Playfair Display", serif;
        }
        
        .catalog-search-form {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .search-field-enhanced {
            display: flex;
            background: var(--bg);
            border-radius: 12px;
            padding: 0.5rem;
            border: 2px solid var(--green-600);
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 8px 20px rgba(15,75,34,0.1);
            transition: var(--transition);
        }
        
        .search-field-enhanced:focus-within {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(15,75,34,0.15);
            border-color: var(--green-700);
        }
        
        .search-field-enhanced i {
            padding: 0 0.5rem;
            color: var(--green-700);
            font-size: 1.1rem;
        }
        
        .search-field-enhanced input {
            flex: 1;
            border: 0;
            outline: none;
            padding: 1rem 0.5rem;
            font-size: 1rem;
            background: transparent;
            font-weight: 500;
        }
        
        .search-field-enhanced select {
            border: 0;
            background: transparent;
            padding: 0.8rem 1rem;
            border-left: 2px solid rgba(15,75,34,0.1);
            border-right: 2px solid rgba(15,75,34,0.1);
            font-weight: 600;
            cursor: pointer;
            color: var(--green-800);
            min-width: 150px;
        }
        
        .search-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .search-tips {
            text-align: center;
            margin-top: 1rem;
            color: var(--muted);
            font-size: 0.9rem;
        }
        
        .search-results-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: linear-gradient(135deg, var(--green-500), var(--green-700));
            color: white;
            border-radius: 12px;
        }
        
        .search-results-count {
            background: var(--yellow);
            color: var(--green-900);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 700;
        }
    </style>
</head>
<body>
    <header class="site-header">
        <div class="container header-inner">
            <a class="brand" href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/images/Screenshot 2025-09-05 094525.png" alt="DSAC Logo" class="brand-logo">
            </a>
            <nav class="nav">
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/libraries">Our Libraries</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalog" class="active">Catalog</a></li>
                    <li><a href="${pageContext.request.contextPath}/Events">Events</a></li>
                    <li><a href="${pageContext.request.contextPath}/kids-teens">Kids & Teens</a></li>
                </ul>
            </nav>
                                      <button class="nav-toggle" id="navToggle" aria-label="Toggle navigation">
        <i class="fas fa-bars"></i>
      </button>
      <div>
        <img src="${pageContext.request.contextPath}/images/images (3).jpeg" alt="SA flag" class="brand-logo">
      </div>
        </div>
    </header>

    <main class="container" style="padding-top: 120px; padding-bottom: 60px;">
        
        <c:if test="${not empty selectedCategory}">
            <a href="${pageContext.request.contextPath}/catalog" class="back-to-catalog">
                <i class="fas fa-arrow-left"></i>
                Back to Full Catalog
            </a>
        </c:if>

        <div class="catalog-header">
            <h1>Library Catalog</h1>
            <p class="lead">Discover our extensive collection of books across various categories</p>
            
            <div class="categories-nav">
                <a href="${pageContext.request.contextPath}/catalog" class="category-filter ${empty selectedCategory ? 'active' : ''}">All Categories</a>
                <c:forEach var="cat" items="${allCategories}">
                    <a href="${pageContext.request.contextPath}/catalog?category=${fn:replace(cat, ' ', '%20')}" 
                       class="category-filter ${selectedCategory == cat ? 'active' : ''}">${cat}</a>
                </c:forEach>
            </div>
        </div>

        <!-- Search Section -->
        <div class="search-section">
            <h2>Find Your Next Great Read</h2>
            <form action="${pageContext.request.contextPath}/search" method="get" class="catalog-search-form">
                <div class="search-field-enhanced">
                    <i class="fas fa-search"></i>
                    <input type="search" name="q" value="${param.q}" placeholder="Search by title, author, or subject..." required>
                    <select name="scope">
                        <option value="all" ${param.scope == 'all' ? 'selected' : ''}>All Libraries</option>
                        <c:forEach var="library" items="${libraries}">
                            <option value="${library.libraryId}" ${param.scope == library.libraryId ? 'selected' : ''}>${library.name}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn-primary" style="white-space: nowrap;">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>
                
                <div class="search-actions">
                    <a href="${pageContext.request.contextPath}/catalog?category=Fiction" class="btn-sm outline">
                        <i class="fas fa-book"></i> Fiction
                    </a>
                    <a href="${pageContext.request.contextPath}/catalog?category=Non-Fiction" class="btn-sm outline">
                        <i class="fas fa-globe"></i> Non-Fiction
                    </a>
                    <a href="${pageContext.request.contextPath}/catalog?category=Science" class="btn-sm outline">
                        <i class="fas fa-flask"></i> Science
                    </a>
                    <a href="${pageContext.request.contextPath}/catalog?category=Technology" class="btn-sm outline">
                        <i class="fas fa-laptop"></i> Technology
                    </a>
                    <a href="${pageContext.request.contextPath}/catalog?category=History" class="btn-sm outline">
                        <i class="fas fa-landmark"></i> History
                    </a>
                </div>
                
                <div class="search-tips">
                    <i class="fas fa-lightbulb"></i> Tip: Search by title, author, ISBN, or keywords
                </div>
            </form>
        </div>

        <!-- Display search results if coming from search -->
        <c:if test="${not empty searchResults}">
            <div class="search-results-header">
                <h2 style="color: white; margin: 0; flex: 1;">
                    Search Results for "${searchQuery}"
                </h2>
                <span class="search-results-count">${fn:length(searchResults)} results</span>
            </div>
            
            <div class="books-grid-category">
                <c:forEach var="book" items="${searchResults}">
                    <div class="book-card">
                        <img src="${not empty book.coverImage ? book.coverImage : 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=400&q=60'}" alt="${book.title}">
                        <div class="book-body">
                            <h4>${book.title}</h4>
                            <p class="author">by ${book.author}</p>
                            <p class="small muted">${book.publisher} • <fmt:formatDate value="${book.publishedDate}" pattern="yyyy" /></p>
                            <c:if test="${book.availableCopies > 0}">
                                <span class="badge">Available (${book.availableCopies})</span>
                            </c:if>
                            <c:if test="${book.availableCopies == 0}">
                                <span class="badge" style="background: #f44336;">Checked Out</span>
                            </c:if>
                        </div>
                        <div class="book-actions">
                            <a href="${pageContext.request.contextPath}/book/detail?id=${book.bookId}" class="btn-sm">View Details</a>
                            <c:if test="${book.availableCopies > 0}">
                                <a href="${pageContext.request.contextPath}/reserve?bookId=${book.bookId}" class="btn-sm outline">Reserve</a>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <div style="text-align: center; margin-top: 3rem;">
                <a href="${pageContext.request.contextPath}/catalog" class="btn-primary">
                    <i class="fas fa-book"></i> Back to Full Catalog
                </a>
            </div>
        </c:if>

        <!-- Regular catalog content (only show if no search results) -->
        <c:if test="${empty searchResults}">
            <c:choose>
                <c:when test="${not empty selectedCategory}">
                    <!-- Single Category View -->
                    <div class="category-section">
                        <div class="category-header">
                            <h2 class="category-title">${selectedCategory}</h2>
                            <span class="category-count">${fn:length(categoryBooks)} Books</span>
                        </div>
                        
                        <c:choose>
                            <c:when test="${not empty categoryBooks}">
                                <div class="books-grid-category">
                                    <c:forEach var="book" items="${categoryBooks}">
                                        <div class="book-card">
                                            <img src="${not empty book.coverImage ? book.coverImage : 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=400&q=60'}" alt="${book.title}">
                                            <div class="book-body">
                                                <h4>${book.title}</h4>
                                                <p class="author">by ${book.author}</p>
                                                <p class="small muted">${book.publisher} • <fmt:formatDate value="${book.publishedDate}" pattern="yyyy" /></p>
                                                <c:if test="${book.availableCopies > 0}">
                                                    <span class="badge">Available (${book.availableCopies})</span>
                                                </c:if>
                                                <c:if test="${book.availableCopies == 0}">
                                                    <span class="badge" style="background: #f44336;">Checked Out</span>
                                                </c:if>
                                            </div>
                                            <div class="book-actions">
                                                <a href="${pageContext.request.contextPath}/book/detail?id=${book.bookId}" class="btn-sm">View Details</a>
                                                <c:if test="${book.availableCopies > 0}">
                                                    <a href="${pageContext.request.contextPath}/reserve?bookId=${book.bookId}" class="btn-sm outline">Reserve</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="no-results" style="text-align: center; padding: 3rem;">
                                    <i class="fas fa-book" style="font-size: 3rem; color: var(--muted); margin-bottom: 1rem;"></i>
                                    <h3>No Books in This Category</h3>
                                    <p>We don't have any books in the ${selectedCategory} category yet.</p>
                                    <a href="${pageContext.request.contextPath}/catalog" class="btn-primary" style="margin-top: 1rem;">Browse All Categories</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>
                
                <c:otherwise>
                    <!-- Full Catalog View - All Categories -->
                    <c:forEach var="category" items="${booksByCategory}">
                        <c:if test="${not empty category.value}">
                            <div class="category-section">
                                <div class="category-header">
                                    <h2 class="category-title">${category.key}</h2>
                                    <span class="category-count">${fn:length(category.value)} Books</span>
                                </div>
                                
                                <div class="books-grid-category">
                                    <c:forEach var="book" items="${category.value}" end="7">
                                        <div class="book-card">
                                            <img src="${not empty book.coverImage ? book.coverImage : 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=400&q=60'}" alt="${book.title}">
                                            <div class="book-body">
                                                <h4>${book.title}</h4>
                                                <p class="author">by ${book.author}</p>
                                                <p class="small muted">${book.publisher} • <fmt:formatDate value="${book.publishedDate}" pattern="yyyy" /></p>
                                                <c:if test="${book.availableCopies > 0}">
                                                    <span class="badge">Available (${book.availableCopies})</span>
                                                </c:if>
                                                <c:if test="${book.availableCopies == 0}">
                                                    <span class="badge" style="background: #f44336;">Checked Out</span>
                                                </c:if>
                                            </div>
                                            <div class="book-actions">
                                                <a href="${pageContext.request.contextPath}/book/detail?id=${book.bookId}" class="btn-sm">View Details</a>
                                                <c:if test="${book.availableCopies > 0}">
                                                    <a href="${pageContext.request.contextPath}/reserve?bookId=${book.bookId}" class="btn-sm outline">Reserve</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                
                                <c:if test="${fn:length(category.value) > 8}">
                                    <div style="text-align: center; margin-top: 2rem;">
                                        <a href="${pageContext.request.contextPath}/catalog?category=${fn:replace(category.key, ' ', '%20')}" class="view-all-btn">
                                            View All ${fn:length(category.value)} Books in ${category.key}
                                            <i class="fas fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </c:if>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:if>
    </main>

   <footer class="site-footer enhanced-footer">
    <div class="floating-shapes">
      <div class="shape"></div>
      <div class="shape"></div>
      <div class="shape"></div>
    </div>

    <div class="container">
      <div class="footer-grid footer-section">
        <div class="footer-brand">
          <div class="footer-logo mb-3">
            <img src="${pageContext.request.contextPath}/images/Screenshot 2025-09-05 094525.png" alt="DSAC Logo" class="brand-logo">
          </div>
          <p class="small text-light">Promoting literacy, learning and cultural development across Limpopo through accessible library services.</p>
          
          <div class="social-links">
            <a href="#" class="social-link facebook" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
            <a href="#" class="social-link twitter" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
            <a href="#" class="social-link instagram" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
            <a href="#" class="social-link youtube" aria-label="YouTube"><i class="fab fa-youtube"></i></a>
          </div>
        </div>

        <div>
          <h4 class="footer-title">Quick Links</h4>
          <ul class="footer-links list-unstyled">
            <li><a href="#home" class="footer-link">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/libraries" class="footer-link">Find a Library</a></li>
            <li><a href="${pageContext.request.contextPath}/catalog" class="footer-link">Catalog</a></li>
            <li><a href="#events" class="footer-link">Events</a></li>
            <li><a href="#services" class="footer-link">Services</a></li>
          </ul>
        </div>

        <div>
          <h4 class="footer-title">Contact Info</h4>
          <div class="footer-links">
            <div class="contact-item">
              <i class="fas fa-phone contact-icon"></i>
              <a href="tel:+27151234567" class="footer-link">(015) 123 4567</a>
            </div>
            <div class="contact-item">
              <i class="fas fa-envelope contact-icon"></i>
              <a href="mailto:info@dsaclibraries.gov.za" class="footer-link">info@dsaclibraries.gov.za</a>
            </div>
            <div class="contact-item">
              <i class="fas fa-clock contact-icon"></i>
              <span class="footer-link">Mon-Fri: 8:00 AM - 5:00 PM</span>
            </div>
          </div>
        </div>

        <div class="footer-map">
          <h4 class="footer-title">Visit Us</h4>
          <div class="map-container mb-3">
            <iframe 
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3586.234567890123!2d29.12345678901234!3d-23.90123456789012!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x1ec6d987654321ab%3A0xabcdef1234567890!2s21%20Biccard%20St%2C%20Polokwane%20Central%2C%20Polokwane%2C%200700!5e0!3m2!1sen!2sza!4v1234567890123!5m2!1sen!2sza" 
              width="100%" 
              height="200" 
              style="border:0; border-radius: 12px;" 
              allowfullscreen="" 
              loading="lazy" 
              referrerpolicy="no-referrer-when-downgrade">
            </iframe>
          </div>
          <div class="contact-item">
            <i class="fas fa-map-marker-alt contact-icon"></i>
            <span class="footer-link">21 Biccard St, Polokwane Central, Polokwane, 0700</span>
          </div>
        </div>
      </div>

      <hr class="footer-divider">

      <div class="footer-bottom footer-section">
        <div class="footer-bottom-content">
          <p class="small mb-2">&copy; 2025 DSAC Libraries — Limpopo. All rights reserved.</p>
          <div class="footer-bottom-links">
            <a href="#" class="muted">Privacy Policy</a>
            <a href="#" class="muted">Terms of Use</a>
            <a href="#" class="muted">Accessibility</a>
            <a href="#" class="muted">Sitemap</a>
          </div>
        </div>
      </div>
    </div>
  </footer>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${book.title} - DSAC Libraries</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .book-detail-container {
            max-width: 1200px;
            margin: 100px auto 50px;
            padding: 0 2rem;
        }
        
        .breadcrumb {
            margin-bottom: 2rem;
            font-size: 0.9rem;
            color: var(--muted);
        }
        
        .breadcrumb a {
            color: var(--green-700);
            text-decoration: none;
        }
        
        .breadcrumb a:hover {
            text-decoration: underline;
        }
        
        .book-detail-grid {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 3rem;
            margin-bottom: 3rem;
        }
        
        .book-cover {
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
        }
        
        .book-info h1 {
            font-family: "Playfair Display", serif;
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--green-900);
        }
        
        .book-author {
            font-size: 1.2rem;
            color: var(--muted);
            margin-bottom: 1.5rem;
        }
        
        .book-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: var(--card);
            border-radius: 12px;
            box-shadow: var(--shadow);
        }
        
        .meta-item {
            display: flex;
            flex-direction: column;
        }
        
        .meta-label {
            font-size: 0.9rem;
            color: var(--muted);
            font-weight: 600;
            margin-bottom: 0.25rem;
        }
        
        .meta-value {
            font-weight: 600;
            color: var(--green-800);
        }
        
        .book-description {
            line-height: 1.8;
            margin-bottom: 2rem;
            font-size: 1.1rem;
        }
        
        .availability-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .available {
            background: var(--yellow);
            color: #000;
        }
        
        .unavailable {
            background: #f44336;
            color: white;
        }
        
        .libraries-section {
            margin-top: 3rem;
        }
        
        .libraries-section h2 {
            font-family: "Playfair Display", serif;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            color: var(--green-900);
        }
        
        .library-search-container {
            margin-bottom: 2rem;
            position: relative;
        }
        
        .library-search {
            width: 100%;
            padding: 1rem 1.5rem 1rem 3rem;
            border: 2px solid var(--border);
            border-radius: 50px;
            font-size: 1rem;
            transition: var(--transition);
            background: var(--card);
        }
        
        .library-search:focus {
            outline: none;
            border-color: var(--green-700);
            box-shadow: 0 0 0 3px rgba(34, 139, 34, 0.1);
        }
        
        .search-icon {
            position: absolute;
            left: 1.25rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted);
        }
        
        .library-results-count {
            margin-bottom: 1rem;
            color: var(--muted);
            font-size: 0.9rem;
        }
        
        .library-card {
            background: var(--card);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: var(--shadow);
            display: flex;
            gap: 1.5rem;
            align-items: start;
            transition: var(--transition);
        }
        
        .library-card.hidden {
            display: none;
        }
        
        .library-info h3 {
            margin-bottom: 0.5rem;
            color: var(--green-800);
        }
        
        .library-meta {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            color: var(--muted);
            margin-bottom: 1rem;
        }
        
        .library-meta span {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .btn-reserve {
            background: var(--green-700);
            color: white;
            padding: 1rem 2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .btn-reserve:hover {
            background: var(--green-800);
            transform: translateY(-2px);
        }
        
        .btn-back {
            background: transparent;
            color: var(--green-700);
            padding: 1rem 2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            border: 2px solid var(--green-700);
            transition: var(--transition);
        }
        
        .btn-back:hover {
            background: var(--green-700);
            color: white;
        }
        
        .no-libraries {
            text-align: center;
            padding: 3rem;
            background: var(--card);
            border-radius: 12px;
            box-shadow: var(--shadow);
        }
        
        .no-libraries i {
            font-size: 3rem;
            color: var(--muted);
            margin-bottom: 1rem;
        }
        
        .no-results {
            text-align: center;
            padding: 2rem;
            background: var(--card);
            border-radius: 12px;
            box-shadow: var(--shadow);
            display: none;
        }
        
        .no-results.show {
            display: block;
        }
        
        .btn-sm {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: var(--transition);
        }
        
        .btn-sm.outline {
            background: transparent;
            color: var(--green-700);
            border: 1px solid var(--green-700);
        }
        
        .btn-sm.outline:hover {
            background: var(--green-700);
            color: white;
        }
        
        .btn-sm {
            background: var(--green-700);
            color: white;
        }
        
        .btn-sm:hover {
            background: var(--green-800);
        }
        
        @media (max-width: 768px) {
            .book-detail-grid {
                grid-template-columns: 1fr;
            }
            
            .book-cover {
                max-width: 250px;
                margin: 0 auto;
            }
            
            .library-card {
                flex-direction: column;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <header class="site-header" id="top">
        <div class="container header-inner">
            <a class="brand" href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/images/Screenshot 2025-09-05 094525.png" alt="DSAC Logo" class="brand-logo">
            </a>
            <nav class="nav">
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/libraries">Our Libraries</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalog">Catalog</a></li>
                    <li><a href="${pageContext.request.contextPath}/Events">Events</a></li>
                    <li><a href="${pageContext.request.contextPath}/kids-teens">Kids & Teens</a></li>
                    <li><a href="#events">Events</a></li>
                    <li><a href="#services">Services</a></li>
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

    <div class="book-detail-container">
        <c:if test="${not empty book}">
            <!-- Breadcrumb -->
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/home">Home</a> &gt; 
                <a href="${pageContext.request.contextPath}/catalog">Catalog</a> &gt; 
                <span>${book.title}</span>
            </div>

            <!-- Book Details -->
            <div class="book-detail-grid">
                <div class="book-cover-container">
                    <img src="${not empty book.coverImage ? book.coverImage : 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=400&q=60'}" 
                         alt="${book.title}" class="book-cover">
                </div>
                
                <div class="book-info">
                    <h1>${book.title}</h1>
                    <p class="book-author">by ${book.author}</p>
                    
                    <div class="availability-badge ${book.availableCopies > 0 ? 'available' : 'unavailable'}">
                        <c:choose>
                            <c:when test="${book.availableCopies > 0}">
                                <i class="fas fa-check-circle"></i> Available (${book.availableCopies} copies)
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-times-circle"></i> Currently Checked Out
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="book-meta">
                        <div class="meta-item">
                            <span class="meta-label">Publisher</span>
                            <span class="meta-value">${not empty book.publisher ? book.publisher : 'Not specified'}</span>
                        </div>
                        
                        <div class="meta-item">
                            <span class="meta-label">Published Date</span>
                            <span class="meta-value">
                                <c:if test="${not empty book.publishedDate}">
                                    <fmt:formatDate value="${book.publishedDate}" pattern="MMMM yyyy" />
                                </c:if>
                                <c:if test="${empty book.publishedDate}">
                                    Not specified
                                </c:if>
                            </span>
                        </div>
                        
                        <div class="meta-item">
                            <span class="meta-label">ISBN</span>
                            <span class="meta-value">${not empty book.isbn ? book.isbn : 'Not available'}</span>
                        </div>
                        
                        <div class="meta-item">
                            <span class="meta-label">Category</span>
                            <span class="meta-value">${not empty book.category ? book.category : 'General'}</span>
                        </div>
                    </div>
                    
                    <div class="book-description">
                        <h3>About this Book</h3>
                        <p>${not empty book.description ? book.description : 'No description available for this book.'}</p>
                    </div>
                    
                    <div class="action-buttons">
                        <c:if test="${book.availableCopies > 0}">
                            <a href="${pageContext.request.contextPath}/reserve?bookId=${book.bookId}" class="btn-reserve">
                                <i class="fas fa-bookmark"></i> Reserve This Book
                            </a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/catalog" class="btn-back">
                            <i class="fas fa-arrow-left"></i> Back to Catalog
                        </a>
                    </div>
                </div>
            </div>

            <!-- Available Libraries Section -->
            <div class="libraries-section">
                <h2>
                    <i class="fas fa-map-marker-alt"></i>
                    Available at These Libraries
                </h2>
                
                <c:choose>
                    <c:when test="${not empty availableLibraries}">
                        <!-- Search Box -->
                        <div class="library-search-container">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" id="librarySearch" class="library-search" placeholder="Search libraries by name, address, or phone number...">
                        </div>
                        
                        <!-- Results Count -->
                        <div class="library-results-count">
                            Showing <span id="resultsCount">${fn:length(availableLibraries)}</span> of ${fn:length(availableLibraries)} libraries
                        </div>
                        
                        <!-- Libraries List -->
                        <c:forEach var="library" items="${availableLibraries}" varStatus="status">
                            <div class="library-card" data-library-name="${fn:toLowerCase(library.name)}" 
                                 data-library-address="${fn:toLowerCase(library.address)}" 
                                 data-library-phone="${library.phone}">
                                <div class="library-image">
                                    <img src="${not empty library.imageUrl ? library.imageUrl : 'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&w=150&q=60'}" 
                                         alt="${library.name}" style="width: 100px; height: 80px; object-fit: cover; border-radius: 8px;">
                                </div>
                                <div class="library-info">
                                    <h3>${library.name}</h3>
                                    <div class="library-meta">
                                        <span><i class="fas fa-map-marker-alt"></i> ${library.address}</span>
                                        <span><i class="fas fa-clock"></i> ${library.hours}</span>
                                        <span><i class="fas fa-phone"></i> ${library.phone}</span>
                                        <c:if test="${not empty library.email}">
                                            <span><i class="fas fa-envelope"></i> ${library.email}</span>
                                        </c:if>
                                    </div>
                                    <div class="library-actions">
                                        <a href="tel:${library.phone}" class="btn-sm outline">
                                            <i class="fas fa-phone"></i> Call Library
                                        </a>
                                        <a href="${pageContext.request.contextPath}/library/services?id=${library.libraryId}" class="btn-sm">
                                            <i class="fas fa-info-circle"></i> Library Info
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <!-- No Results Message -->
                        <div class="no-results" id="noResults">
                            <i class="fas fa-search" style="font-size: 3rem; color: var(--muted); margin-bottom: 1rem;"></i>
                            <h3>No Libraries Found</h3>
                            <p>No libraries match your search criteria. Try adjusting your search terms.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-libraries">
                            <i class="fas fa-book"></i>
                            <h3>No Libraries Currently Have This Book</h3>
                            <p>This book is not currently available at any of our library branches.</p>
                            <p>Please check back later or contact your local library for availability.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        
        <c:if test="${empty book}">
            <div style="text-align: center; padding: 4rem;">
                <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: #f44336; margin-bottom: 1rem;"></i>
                <h2>Book Not Found</h2>
                <p>The requested book could not be found in our catalog.</p>
                <a href="${pageContext.request.contextPath}/catalog" class="btn-primary" style="margin-top: 1rem;">
                    <i class="fas fa-arrow-left"></i> Back to Catalog
                </a>
            </div>
        </c:if>
    </div>

       <!-- FOOTER -->
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

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('librarySearch');
            const libraryCards = document.querySelectorAll('.library-card');
            const resultsCount = document.getElementById('resultsCount');
            const noResults = document.getElementById('noResults');
            
            if (searchInput) {
                searchInput.addEventListener('input', function() {
                    const searchTerm = this.value.toLowerCase().trim();
                    let visibleCount = 0;
                    
                    libraryCards.forEach(card => {
                        const name = card.getAttribute('data-library-name');
                        const address = card.getAttribute('data-library-address');
                        const phone = card.getAttribute('data-library-phone');
                        
                        if (name.includes(searchTerm) || 
                            address.includes(searchTerm) || 
                            phone.includes(searchTerm)) {
                            card.classList.remove('hidden');
                            visibleCount++;
                        } else {
                            card.classList.add('hidden');
                        }
                    });
                    
                    // Update results count
                    resultsCount.textContent = visibleCount;
                    
                    // Show/hide no results message
                    if (visibleCount === 0 && searchTerm.length > 0) {
                        noResults.classList.add('show');
                    } else {
                        noResults.classList.remove('show');
                    }
                });
            }
        });
    </script>
</body>
</html>
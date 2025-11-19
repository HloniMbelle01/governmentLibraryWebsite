<%-- views/libraries-list.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - DSAC Libraries</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
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
                    <li><a href="${pageContext.request.contextPath}/libraries" class="active">Our Libraries</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalog">Catalog</a></li>
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

    <main class="main-content">
        <section class="section">
            <div class="container">
                <div class="section-head">
                    <h2>Our Libraries</h2>
                    <p class="section-sub">Discover libraries across all districts</p>
                    
                    <!-- District Filter -->
                    <div class="district-filter">
                        <div class="filter-header">
                            <h3>Filter by District</h3>
                        </div>
                        <div class="filter-options">
                            <a href="${pageContext.request.contextPath}/libraries" 
                               class="filter-btn ${empty selectedDistrict ? 'active' : ''}">
                                All Districts
                            </a>
                            <c:forEach var="district" items="${districts}">
                                <a href="${pageContext.request.contextPath}/libraries?district=${district}" 
                                   class="filter-btn ${selectedDistrict eq district ? 'active' : ''}">
                                    ${district} District
                                </a>
                            </c:forEach>
                        </div>
                        
                        <c:if test="${not empty selectedDistrict}">
                            <div class="current-filter">
                                <span>Showing libraries in: <strong>${selectedDistrict} District</strong></span>
                                <a href="${pageContext.request.contextPath}/libraries" class="clear-filter">
                                    <i class="fas fa-times"></i> Clear filter
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
                
                <!-- Libraries Grid -->
                <c:choose>
                    <c:when test="${not empty libraries}">
                        <div class="cards-grid">
                            <c:forEach var="library" items="${libraries}">
                                <div class="card branch-card">
                                    <c:choose>
                                        <c:when test="${not empty library.imageUrl}">
                                            <img src="${pageContext.request.contextPath}/images/${library.imageUrl}" 
                                                 alt="${library.name}" onerror="this.src='${pageContext.request.contextPath}/images/library-placeholder.jpg'">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/images/library-placeholder.jpg" 
                                                 alt="${library.name}">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="card-body">
                                        <h3>${library.name}</h3>
                                        <div class="meta">
                                            <span><i class="fas fa-map-marker-alt"></i> ${library.address}</span>
                                            <span><i class="fas fa-phone"></i> ${library.phone}</span>
                                            <span><i class="fas fa-envelope"></i> ${library.email}</span>
                                            <span><i class="fas fa-clock"></i> ${library.hours}</span>
                                            <c:if test="${not empty library.district}">
                                                <span><i class="fas fa-map"></i> ${library.district} District</span>
                                            </c:if>
                                        </div>
                                        <div class="card-actions">
                                            <a href="${pageContext.request.contextPath}/library/services?id=${library.libraryId}" class="btn-sm">View Details</a>
                                            <a href="tel:${library.phone}" class="btn-sm outline">Call</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-results">
                            <i class="fas fa-inbox fa-3x"></i>
                            <h3>No Libraries Found</h3>
                            <p>No libraries found for the selected district.</p>
                            <a href="${pageContext.request.contextPath}/libraries" class="btn-primary">
                                View All Libraries
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>

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
        // Library search functionality
        document.getElementById('librarySearch').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const libraryItems = document.querySelectorAll('.library-item');
            
            libraryItems.forEach(item => {
                const libraryName = item.querySelector('h3').textContent.toLowerCase();
                const libraryAddress = item.querySelector('.meta span:first-child').textContent.toLowerCase();
                
                if (libraryName.includes(searchTerm) || libraryAddress.includes(searchTerm)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>
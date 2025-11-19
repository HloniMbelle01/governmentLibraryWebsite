<%-- views/news-detail.jsp (FIXED VERSION) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${news.title} - DSAC Libraries</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Add all the CSS styles from the previous enhanced version */
        .news-detail {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 16px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .news-hero {
            position: relative;
            height: 300px;
            background: linear-gradient(135deg, var(--green-700), var(--green-900));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            padding: 2rem;
        }

        .news-hero-content {
            position: relative;
            z-index: 2;
            max-width: 600px;
        }

        .news-hero h1 {
            font-family: "Playfair Display", serif;
            font-size: 2.2rem;
            margin-bottom: 1rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            line-height: 1.2;
        }

        .news-meta-hero {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 2rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .news-content-wrapper {
            padding: 2rem;
        }

        .news-content {
            font-size: 1.1rem;
            line-height: 1.7;
            color: #333;
        }

        .news-content p {
            margin-bottom: 1.5rem;
        }

        .news-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 2rem;
            border-top: 1px solid #e0e0e0;
            background: var(--bg);
            flex-wrap: wrap;
            gap: 1rem;
        }


        .news-text-content {
            white-space: pre-line;
            line-height: 1.7;
            font-size: 1.1rem;
            color: #333;
        }

        .news-text-content p {
            margin-bottom: 1.5rem;
        }

        
        .share-buttons {
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .share-buttons span {
            font-weight: 600;
            color: var(--muted);
            font-size: 0.9rem;
        }

        .social-share {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--green-700);
            color: white;
            text-decoration: none;
            transition: var(--transition);
            font-size: 0.9rem;
        }

        .social-share:hover {
            transform: translateY(-2px);
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            padding: 1rem 0;
        }

        .breadcrumb a {
            color: var(--green-700);
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .reading-time {
            background: rgba(255,255,255,0.2);
            padding: 0.3rem 0.6rem;
            border-radius: 12px;
            font-size: 0.8rem;
        }

        @media (max-width: 768px) {
            .news-hero {
                height: 250px;
                padding: 1rem;
            }
            .news-hero h1 {
                font-size: 1.8rem;
            }
            .news-meta-hero {
                gap: 1rem;
            }
            .news-actions {
                flex-direction: column;
                text-align: center;
            }
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
                    <li><a href="${pageContext.request.contextPath}/catalog">Catalog</a></li>
                    <li><a href="${pageContext.request.contextPath}/Events">Events</a></li>
                    <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/kids-teens">Kids & Teens</a></li>
                    <li><a href="${pageContext.request.contextPath}/news" class="active">News</a></li>
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
        <c:if test="${not empty news}">
            <!-- Breadcrumb Navigation -->
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/home">Home</a> 
                <span style="color: var(--muted);">/</span>
                <a href="${pageContext.request.contextPath}/news">News</a>
                <span style="color: var(--muted);">/</span>
                <span>Article</span>
            </nav>

            <article class="news-detail">
                <!-- Hero Section -->
                <div class="news-hero">
                    <div class="news-hero-content">
                        <div class="news-meta-hero">
                            <div class="meta-item">
                                <i class="fas fa-calendar"></i>
                                <fmt:formatDate value="${news.publishDate}" pattern="MMMM dd, yyyy" />
                            </div>
                            <div class="meta-item">
                                <i class="fas fa-clock"></i>
                                <!-- Calculate reading time based on content length -->
                                <c:set var="contentLength" value="${fn:length(news.content)}" />
                                <c:set var="readingTime" value="${contentLength / 1200}" />
                                <c:set var="readingTimeMinutes" value="${readingTime < 1 ? 1 : readingTime}" />
                                <span><fmt:formatNumber value="${readingTimeMinutes}" maxFractionDigits="0" /> min read</span>
                            </div>
                        </div>
                        
                        <h1>${news.title}</h1>
                    </div>
                </div>

              <!-- News Content -->
                <div class="news-content-wrapper">
                    <div class="news-content">
                        <div class="news-text-content">${news.content}</div>
                    </div>
                </div>

                <!-- Actions Section -->
                <div class="news-actions">
                    <a href="${pageContext.request.contextPath}/news" class="btn-ghost">
                        <i class="fas fa-arrow-left"></i> Back to News
                    </a>
                    
                    <div class="share-buttons">
                        <span>Share:</span>
                        <a href="#" class="social-share facebook" onclick="shareOnSocial('facebook')">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-share twitter" onclick="shareOnSocial('twitter')">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="social-share linkedin" onclick="shareOnSocial('linkedin')">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </div>
                </div>
            </article>
        </c:if>

        <c:if test="${empty news}">
            <div class="error-message" style="text-align: center; padding: 3rem;">
                <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: #f44336; margin-bottom: 1rem;"></i>
                <h2>News Article Not Found</h2>
                <p>The requested news article could not be found or may have been removed.</p>
                <a href="${pageContext.request.contextPath}/news" class="btn-primary" style="margin-top: 1rem;">
                    <i class="fas fa-newspaper"></i> View All News
                </a>
            </div>
        </c:if>
    </main>

    <!-- FOOTER -->
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
        function shareOnSocial(platform) {
            const url = encodeURIComponent(window.location.href);
            const title = encodeURIComponent('${news.title}');
            
            let shareUrl;
            switch(platform) {
                case 'facebook':
                    shareUrl = `https://www.facebook.com/sharer/sharer.php?u=${url}`;
                    break;
                case 'twitter':
                    shareUrl = `https://twitter.com/intent/tweet?text=${title}&url=${url}`;
                    break;
                case 'linkedin':
                    shareUrl = `https://www.linkedin.com/sharing/share-offsite/?url=${url}`;
                    break;
            }
            
            if (shareUrl) {
                window.open(shareUrl, '_blank', 'width=600,height=400');
            }
        }
    </script>
</body>
</html>
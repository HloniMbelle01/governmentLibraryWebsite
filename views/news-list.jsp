<%-- views/news-list.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>News & Updates - DSAC Libraries</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* All your existing CSS styles remain the same */
        .news-hero {
            background: 
                linear-gradient(135deg, rgba(15, 75, 34, 0.9) 0%, rgba(26, 94, 42, 0.8) 100%),
                url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=1200&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 6rem 0 4rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .news-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%23ffffff' fill-opacity='0.1' fill-rule='evenodd'/%3E%3C/svg%3E");
            opacity: 0.3;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .news-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin: 3rem 0;
        }

        .news-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .news-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-hover);
        }

        .news-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-bottom: 3px solid var(--yellow);
        }

        .news-content {
            padding: 1.5rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .news-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
            font-size: 0.9rem;
            color: var(--muted);
        }

        .news-date {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .news-views {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: var(--light-yellow);
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .news-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin: 1rem 0;
        }

        .news-tag {
            background: var(--green-100);
            color: var(--green-800);
            padding: 0.3rem 0.8rem;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .news-title {
            font-family: "Playfair Display", serif;
            font-size: 1.4rem;
            color: var(--green-900);
            margin-bottom: 1rem;
            line-height: 1.3;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .news-summary {
            color: var(--muted);
            line-height: 1.6;
            margin-bottom: 1.5rem;
            flex: 1;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .news-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
        }

        .read-time {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--muted);
            font-size: 0.9rem;
        }

        .no-news {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 16px;
            box-shadow: var(--shadow);
            margin: 2rem 0;
        }

        .no-news i {
            font-size: 4rem;
            color: var(--muted);
            margin-bottom: 1rem;
        }

        .featured-news {
            margin-bottom: 3rem;
        }

        .featured-card {
            background: linear-gradient(135deg, var(--green-700), var(--green-900));
            color: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow);
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0;
        }

        .featured-content {
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .featured-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .featured-badge {
            background: var(--yellow);
            color: var(--green-900);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.9rem;
            display: inline-block;
            margin-bottom: 1rem;
        }

        .featured-title {
            font-family: "Playfair Display", serif;
            font-size: 2rem;
            margin-bottom: 1rem;
            line-height: 1.2;
        }

        .featured-summary {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 2rem;
            line-height: 1.5;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 2rem;
            font-size: 0.95rem;
            color: rgba(255, 255, 255, 0.9);
        }

        .breadcrumb a {
            color: var(--yellow);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .breadcrumb span {
            color: white;
            font-weight: 600;
        }

        .news-filters {
            display: flex;
            gap: 1rem;
            margin: 2rem 0;
            flex-wrap: wrap;
            justify-content: center;
        }

        .filter-btn {
            background: white;
            color: var(--green-700);
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            border: 2px solid transparent;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: var(--green-700);
            color: white;
            border-color: var(--green-700);
            transform: translateY(-2px);
        }

        .news-count {
            text-align: center;
            margin: 1rem 0;
            color: var(--muted);
            font-size: 1.1rem;
        }

        .news-count strong {
            color: var(--green-700);
        }

        @media (max-width: 768px) {
            .news-hero {
                padding: 4rem 0 2rem;
            }

            .news-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .featured-card {
                grid-template-columns: 1fr;
            }

            .featured-content {
                padding: 2rem 1.5rem;
            }

            .featured-title {
                font-size: 1.6rem;
            }

            .news-filters {
                gap: 0.5rem;
            }

            .filter-btn {
                padding: 0.6rem 1rem;
                font-size: 0.9rem;
            }

            .breadcrumb {
                font-size: 0.85rem;
            }
        }

        .floating-shapes {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
        }

        .shape {
            position: absolute;
            background: rgba(253, 216, 53, 0.1);
            border-radius: 50%;
            animation: float 20s infinite linear;
            border: 1px solid rgba(253, 216, 53, 0.2);
        }

        .shape:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-duration: 25s;
        }

        .shape:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 60%;
            right: 15%;
            animation-duration: 30s;
            animation-direction: reverse;
        }

        .shape:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 30%;
            left: 70%;
            animation-duration: 35s;
        }

        @keyframes float {
            0% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-20px) rotate(120deg); }
            66% { transform: translateY(10px) rotate(240deg); }
            100% { transform: translateY(0px) rotate(360deg); }
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
        </div>
    </header>

    <!-- Hero Section -->
    <section class="news-hero">
        <div class="floating-shapes">
            <div class="shape"></div>
            <div class="shape"></div>
            <div class="shape"></div>
        </div>
        <div class="container">
            <div class="hero-content">
                <nav class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/home">Home</a>
                    <span style="color: var(--yellow);">/</span>
                    <span>News & Updates</span>
                </nav>
                
                <h1 style="font-size: 3.5rem; margin-bottom: 1rem; font-family: 'Playfair Display', serif; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">
                    News & Updates
                </h1>
                <p style="font-size: 1.3rem; margin-bottom: 2rem; opacity: 0.9; max-width: 600px; margin-left: auto; margin-right: auto;">
                    Stay informed about the latest developments, events, and programs at DSAC Libraries
                </p>
            </div>
        </div>
    </section>

    <main class="container" style="padding-top: 2rem; padding-bottom: 4rem;">
        <!-- News Count -->
        <c:if test="${not empty newsList}">
            <div class="news-count">
                Showing <strong>${fn:length(newsList)}</strong> news article(s)
            </div>
        </c:if>

        <!-- Featured News (First article as featured) -->
        <c:if test="${not empty newsList}">
            <c:set var="featuredNews" value="${newsList[0]}" />
            <section class="featured-news">
                <div class="featured-card">
                    <div class="featured-content">
                        <span class="featured-badge">
                            <i class="fas fa-star"></i> Featured Story
                        </span>
                        <h2 class="featured-title">${featuredNews.title}</h2>
                        <p class="featured-summary">
                            <c:choose>
                                <c:when test="${not empty featuredNews.summary}">
                                    ${featuredNews.summary}
                                </c:when>
                                <c:otherwise>
                                    <!-- FIXED: Use JSTL to handle newlines properly -->
                                    <c:set var="cleanContent" value="${fn:replace(featuredNews.content, '
', ' ')}" />
                                    ${fn:substring(cleanContent, 0, 150)}...
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <div style="display: flex; align-items: center; gap: 2rem; margin-bottom: 2rem; flex-wrap: wrap;">
                            <div class="news-date">
                                <i class="fas fa-calendar"></i>
                                <fmt:formatDate value="${featuredNews.publishDate}" pattern="MMMM dd, yyyy" />
                            </div>
                            <div class="read-time">
                                <i class="fas fa-clock"></i>
                                ${featuredNews.readingTime}
                            </div>
                            <c:if test="${featuredNews.viewCount > 0}">
                                <div class="news-views">
                                    <i class="fas fa-eye"></i>
                                    ${featuredNews.viewCount} views
                                </div>
                            </c:if>
                        </div>
                        <a href="${pageContext.request.contextPath}/news/detail?id=${featuredNews.newsId}" class="btn-primary" style="align-self: flex-start; text-decoration: none;">
                            Read Full Story <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                    <img src="https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=600&q=80" 
                         alt="${featuredNews.title}" class="featured-image">
                </div>
            </section>
        </c:if>

        <!-- News Filters -->
        <div class="news-filters">
            <a href="${pageContext.request.contextPath}/news" class="filter-btn active">All News</a>
            <a href="#" class="filter-btn">Library Updates</a>
            <a href="#" class="filter-btn">Events</a>
            <a href="#" class="filter-btn">Programs</a>
            <a href="#" class="filter-btn">Announcements</a>
        </div>

        <!-- News Grid -->
        <c:choose>
            <c:when test="${not empty newsList && fn:length(newsList) > 1}">
                <div class="news-grid">
                    <c:forEach var="news" items="${newsList}" begin="1">
                        <article class="news-card">
                            <img src="https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=400&q=60" 
                                 alt="${news.title}" class="news-image">
                            <div class="news-content">
                                <div class="news-meta">
                                    <div class="news-date">
                                        <i class="fas fa-calendar"></i>
                                        <fmt:formatDate value="${news.publishDate}" pattern="MMM dd, yyyy" />
                                    </div>
                                    <c:if test="${news.viewCount > 0}">
                                        <div class="news-views">
                                            <i class="fas fa-eye"></i>
                                            ${news.viewCount}
                                        </div>
                                    </c:if>
                                </div>

                                <c:if test="${not empty news.tags}">
                                    <div class="news-tags">
                                        <c:forEach var="tag" items="${news.tagsArray}" end="2">
                                            <span class="news-tag">${tag}</span>
                                        </c:forEach>
                                        <c:if test="${fn:length(news.tagsArray) > 3}">
                                            <span class="news-tag">+${fn:length(news.tagsArray) - 3}</span>
                                        </c:if>
                                    </div>
                                </c:if>

                                <h3 class="news-title">${news.title}</h3>
                                
                                <p class="news-summary">
                                    <c:choose>
                                        <c:when test="${not empty news.summary}">
                                            ${news.summary}
                                        </c:when>
                                        <c:otherwise>
                                            <!-- FIXED: Use JSTL to handle newlines properly -->
                                            <c:set var="cleanContent" value="${fn:replace(news.content, '
', ' ')}" />
                                            ${fn:substring(cleanContent, 0, 120)}...
                                        </c:otherwise>
                                    </c:choose>
                                </p>

                                <div class="news-actions">
                                    <div class="read-time">
                                        <i class="fas fa-clock"></i>
                                        ${news.readingTime}
                                    </div>
                                    <a href="${pageContext.request.contextPath}/news/detail?id=${news.newsId}" class="read-more">
                                        Read More <i class="fas fa-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:when>

            <c:when test="${not empty newsList && fn:length(newsList) == 1}">
                <!-- Only featured news exists -->
                <div style="text-align: center; padding: 2rem;">
                    <p>More news articles coming soon!</p>
                </div>
            </c:when>

            <c:otherwise>
                <div class="no-news">
                    <i class="fas fa-newspaper"></i>
                    <h3>No News Articles Available</h3>
                    <p>Check back later for the latest updates and announcements from DSAC Libraries.</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn-primary" style="margin-top: 1rem;">
                        <i class="fas fa-home"></i> Back to Home
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Newsletter Subscription -->
        <section style="background: linear-gradient(135deg, var(--green-50), var(--light-yellow)); padding: 3rem; border-radius: 16px; text-align: center; margin-top: 4rem;">
            <h2 style="color: var(--green-900); margin-bottom: 1rem;">Stay Updated</h2>
            <p style="color: var(--muted); margin-bottom: 2rem; max-width: 500px; margin-left: auto; margin-right: auto;">
                Subscribe to our newsletter and never miss important library updates, events, and announcements.
            </p>
            <form style="max-width: 400px; margin: 0 auto; display: flex; gap: 0.5rem;">
                <input type="email" placeholder="Enter your email" style="flex: 1; padding: 1rem; border: 1px solid #ddd; border-radius: 8px; font-size: 1rem;">
                <button type="submit" class="btn-primary" style="white-space: nowrap;">
                    <i class="fas fa-paper-plane"></i> Subscribe
                </button>
            </form>
        </section>
    </main>

    <!-- FOOTER -->
    <footer class="site-footer enhanced-footer">
        <!-- Your existing footer code remains the same -->
    </footer>

    <script>
        // Interactive features for news list
        document.addEventListener('DOMContentLoaded', function() {
            // Add hover effects to news cards
            const newsCards = document.querySelectorAll('.news-card');
            newsCards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-8px)';
                });
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });

            // Filter button functionality
            const filterButtons = document.querySelectorAll('.filter-btn');
            filterButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');
                    
                    // Here you would typically filter the news content
                    // For now, just show a message
                    console.log('Filter clicked:', this.textContent);
                });
            });

            // Newsletter form submission
            const newsletterForm = document.querySelector('form');
            if (newsletterForm) {
                newsletterForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    const email = this.querySelector('input[type="email"]').value;
                    if (email) {
                        alert('Thank you for subscribing to our newsletter!');
                        this.reset();
                    }
                });
            }
        });
    </script>
</body>
</html>
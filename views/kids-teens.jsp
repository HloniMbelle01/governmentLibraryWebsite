<%-- views/kids-teens.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kids & Teens Zone - DSAC Libraries</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Kids & Teens Specific Styles */
        .kids-teens-hero {
            background: 
                linear-gradient(135deg, rgba(76, 175, 80, 0.9) 0%, rgba(253, 216, 53, 0.8) 100%),
                url('https://images.unsplash.com/photo-1481627834876-b7833e8f5570?auto=format&fit=crop&w=1200&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 6rem 0 4rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .kids-teens-hero::before {
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

        .age-group-nav {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin: 2rem 0;
            flex-wrap: wrap;
        }

        .age-group-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 1rem 2rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .age-group-btn:hover,
        .age-group-btn.active {
            background: var(--yellow);
            color: var(--green-900);
            border-color: var(--yellow);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(253, 216, 53, 0.3);
        }

        .category-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            justify-content: center;
            margin: 2rem 0;
        }

        .category-filter {
            background: white;
            color: var(--green-700);
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid transparent;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .category-filter:hover,
        .category-filter.active {
            background: var(--green-700);
            color: white;
            border-color: var(--green-700);
            transform: translateY(-2px);
        }

        .resources-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 3rem 0;
        }

        .resource-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: var(--shadow);
            transition: var(--transition);
            border-top: 5px solid var(--yellow);
            text-align: center;
        }

        .resource-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-hover);
        }

        .resource-icon {
            font-size: 3rem;
            color: var(--green-700);
            margin-bottom: 1.5rem;
            display: inline-block;
            transition: var(--transition);
        }

        .resource-card:hover .resource-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .age-badge {
            display: inline-block;
            background: var(--light-yellow);
            color: var(--green-900);
            padding: 0.4rem 1rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 700;
            margin-bottom: 1rem;
            border: 1px solid var(--yellow);
        }

        .kids-search-section {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: var(--shadow);
            margin: 2rem 0;
            text-align: center;
        }

        .kids-search-form {
            max-width: 600px;
            margin: 0 auto;
        }

        .kids-search-field {
            display: flex;
            background: var(--bg);
            border-radius: 50px;
            padding: 0.5rem;
            border: 3px solid var(--green-600);
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 8px 20px rgba(15,75,34,0.1);
        }

        .kids-search-field i {
            padding: 0 1rem;
            color: var(--green-700);
            font-size: 1.2rem;
        }

        .kids-search-field input {
            flex: 1;
            border: 0;
            outline: none;
            padding: 1rem 0.5rem;
            font-size: 1.1rem;
            background: transparent;
            font-family: 'Inter', sans-serif;
        }

        .kids-search-btn {
            background: var(--green-700);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            font-family: 'Inter', sans-serif;
        }

        .kids-search-btn:hover {
            background: var(--green-800);
            transform: scale(1.05);
        }

        .book-grid-kids {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
            margin: 2rem 0;
        }

        .kids-book-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: var(--shadow);
            transition: var(--transition);
            text-align: center;
            border: 3px solid transparent;
        }

        .kids-book-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-hover);
            border-color: var(--yellow);
        }

        .kids-book-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 1rem;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }

        .reading-level {
            background: var(--green-100);
            color: var(--green-800);
            padding: 0.3rem 0.8rem;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            display: inline-block;
        }

        .kids-section {
            margin: 4rem 0;
            padding: 3rem;
            background: white;
            border-radius: 16px;
            box-shadow: var(--shadow);
        }

        .section-title {
            font-family: "Playfair Display", serif;
            font-size: 2.5rem;
            color: var(--green-900);
            text-align: center;
            margin-bottom: 3rem;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: var(--yellow);
            border-radius: 2px;
        }

        .educational-resources {
            background: linear-gradient(135deg, var(--green-50), var(--light-yellow));
            border-left: 6px solid var(--green-600);
        }

        .fun-activities {
            background: linear-gradient(135deg, var(--light-yellow), var(--green-50));
            border-left: 6px solid var(--yellow);
        }

        .activity-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .activity-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: var(--shadow);
            transition: var(--transition);
            text-align: center;
        }

        .activity-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .activity-icon {
            font-size: 2.5rem;
            color: var(--green-700);
            margin-bottom: 1rem;
        }

        .no-results {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 16px;
            box-shadow: var(--shadow);
            margin: 2rem 0;
        }

        .no-results i {
            font-size: 4rem;
            color: var(--muted);
            margin-bottom: 1rem;
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
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            animation: float 20s infinite linear;
        }

        .shape:nth-child(1) { width: 60px; height: 60px; top: 20%; left: 10%; animation-duration: 25s; }
        .shape:nth-child(2) { width: 100px; height: 100px; top: 60%; right: 15%; animation-duration: 30s; animation-direction: reverse; }
        .shape:nth-child(3) { width: 80px; height: 80px; bottom: 30%; left: 70%; animation-duration: 35s; }

        @keyframes float {
            0% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-20px) rotate(120deg); }
            66% { transform: translateY(10px) rotate(240deg); }
            100% { transform: translateY(0px) rotate(360deg); }
        }

        @media (max-width: 768px) {
            .kids-teens-hero {
                padding: 4rem 0 2rem;
            }
            
            .age-group-nav {
                flex-direction: column;
                align-items: center;
            }
            
            .age-group-btn {
                width: 200px;
                text-align: center;
            }
            
            .category-filters {
                gap: 0.5rem;
            }
            
            .category-filter {
                padding: 0.6rem 1rem;
                font-size: 0.9rem;
            }
            
            .kids-section {
                padding: 2rem 1.5rem;
                margin: 2rem 0;
            }
            
            .section-title {
                font-size: 2rem;
            }
            
            .resources-grid,
            .book-grid-kids,
            .activity-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
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
                    <li><a href="${pageContext.request.contextPath}/kids-teens" class="active">Kids & Teens</a></li>
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

    <!-- Hero Section -->
    <section class="kids-teens-hero">
        <div class="floating-shapes">
            <div class="shape"></div>
            <div class="shape"></div>
            <div class="shape"></div>
        </div>
        <div class="container">
            <div class="hero-content">
                <h1 style="font-size: 3.5rem; margin-bottom: 1rem; font-family: 'Playfair Display', serif; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">
                    Kids & Teens Zone
                </h1>
                <p style="font-size: 1.3rem; margin-bottom: 2rem; opacity: 0.9; max-width: 600px; margin-left: auto; margin-right: auto;">
                    Discover amazing books, fun activities, and learning resources designed just for you!
                </p>
                
                <!-- Age Group Navigation -->
                <div class="age-group-nav">
                    <a href="${pageContext.request.contextPath}/kids-teens" 
                       class="age-group-btn ${empty selectedAgeGroup ? 'active' : ''}">
                        <i class="fas fa-star"></i> All Ages
                    </a>
                    <a href="${pageContext.request.contextPath}/kids-teens?ageGroup=kids" 
                       class="age-group-btn ${selectedAgeGroup == 'kids' ? 'active' : ''}">
                        <i class="fas fa-child"></i> Kids (5-12)
                    </a>
                    <a href="${pageContext.request.contextPath}/kids-teens?ageGroup=teens" 
                       class="age-group-btn ${selectedAgeGroup == 'teens' ? 'active' : ''}">
                        <i class="fas fa-user-graduate"></i> Teens (13-18)
                    </a>
                </div>
            </div>
        </div>
    </section>

    <main class="container" style="padding-top: 2rem; padding-bottom: 4rem;">
        <!-- Search Section -->
        <section class="kids-search-section">
            <h2 style="color: var(--green-900); margin-bottom: 1.5rem;">Find Your Next Favorite Book!</h2>
            <form action="${pageContext.request.contextPath}/kids-teens" method="get" class="kids-search-form">
                <div class="kids-search-field">
                    <i class="fas fa-search"></i>
                    <input type="search" name="q" value="${searchQuery}" placeholder="Search for books, authors, or topics..." required>
                    <button type="submit" class="kids-search-btn">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>
            </form>
            
            <!-- Category Filters -->
            <div class="category-filters">
                <c:forEach var="ageGroup" items="${ageGroupCategories}">
                    <c:forEach var="category" items="${ageGroup.value}">
                        <a href="${pageContext.request.contextPath}/kids-teens?category=${fn:replace(category, ' ', '%20')}" 
                           class="category-filter ${selectedCategory == category ? 'active' : ''}">
                            ${category}
                        </a>
                    </c:forEach>
                </c:forEach>
            </div>
        </section>

        <!-- Featured Books -->
        <c:if test="${not empty featuredBooks}">
            <section class="kids-section">
                <h2 class="section-title">
                    <c:choose>
                        <c:when test="${not empty searchQuery}">
                            Search Results for "${searchQuery}"
                        </c:when>
                        <c:when test="${not empty selectedAgeGroup}">
                            ${selectedAgeGroup == 'kids' ? 'Awesome Books for Kids' : 'Great Reads for Teens'}
                        </c:when>
                        <c:when test="${not empty selectedCategory}">
                            ${selectedCategory} Books
                        </c:when>
                        <c:otherwise>
                            Featured Books for Young Readers
                        </c:otherwise>
                    </c:choose>
                </h2>
                
                <div class="book-grid-kids">
                    <c:forEach var="book" items="${featuredBooks}">
                        <div class="kids-book-card">
                            <img src="${not empty book.coverImage ? book.coverImage : 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=400&q=60'}" 
                                 alt="${book.title}">
                            <div class="reading-level">
                                <c:choose>
                                    <c:when test="${fn:containsIgnoreCase(book.category, 'Picture')}">Ages 3-7</c:when>
                                    <c:when test="${fn:containsIgnoreCase(book.category, 'Early')}">Ages 6-9</c:when>
                                    <c:when test="${fn:containsIgnoreCase(book.category, 'Children')}">Ages 8-12</c:when>
                                    <c:when test="${fn:containsIgnoreCase(book.category, 'Young Adult')}">Ages 13+</c:when>
                                    <c:otherwise>All Ages</c:otherwise>
                                </c:choose>
                            </div>
                            <h4 style="color: var(--green-900); margin-bottom: 0.5rem; font-size: 1.1rem;">${book.title}</h4>
                            <p style="color: var(--muted); font-size: 0.9rem; margin-bottom: 1rem;">by ${book.author}</p>
                            <c:if test="${book.availableCopies > 0}">
                                <span class="badge" style="background: var(--green-500);">Available</span>
                            </c:if>
                            <div style="margin-top: 1rem;">
                                <a href="${pageContext.request.contextPath}/book/detail?id=${book.bookId}" class="btn-sm">Read More</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </c:if>

        <c:if test="${empty featuredBooks && not empty searchQuery}">
            <div class="no-results">
                <i class="fas fa-book-open"></i>
                <h3>No Books Found</h3>
                <p>We couldn't find any books matching "${searchQuery}". Try different keywords or browse our categories.</p>
                <a href="${pageContext.request.contextPath}/kids-teens" class="btn-primary" style="margin-top: 1rem;">
                    Browse All Books
                </a>
            </div>
        </c:if>

        <!-- Educational Resources -->
        <section class="kids-section educational-resources">
            <h2 class="section-title">Learning Resources</h2>
            <div class="resources-grid">
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-laptop-code"></i>
                    </div>
                    <span class="age-badge">Ages 6-12</span>
                    <h3>Online Learning</h3>
                    <p>Access educational games, interactive lessons, and fun learning activities.</p>
                    <a href="#" class="btn-sm outline" style="margin-top: 1rem;">Explore</a>
                </div>
                
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-book-reader"></i>
                    </div>
                    <span class="age-badge">Ages 4-10</span>
                    <h3>Story Time</h3>
                    <p>Watch recorded story sessions and join virtual reading circles.</p>
                    <a href="#" class="btn-sm outline" style="margin-top: 1rem;">Watch Now</a>
                </div>
                
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <span class="age-badge">Ages 13-18</span>
                    <h3>Homework Help</h3>
                    <p>Get help with school assignments and access study resources.</p>
                    <a href="#" class="btn-sm outline" style="margin-top: 1rem;">Get Help</a>
                </div>
            </div>
        </section>

        <!-- Fun Activities -->
        <section class="kids-section fun-activities">
            <h2 class="section-title">Fun & Activities</h2>
            <div class="activity-grid">
                <div class="activity-card">
                    <div class="activity-icon">
                        <i class="fas fa-palette"></i>
                    </div>
                    <h3>Arts & Crafts</h3>
                    <p>Creative projects and DIY craft ideas for all ages.</p>
                    <a href="#" class="btn-sm">Get Creative</a>
                </div>
                
                <div class="activity-card">
                    <div class="activity-icon">
                        <i class="fas fa-puzzle-piece"></i>
                    </div>
                    <h3>Games & Puzzles</h3>
                    <p>Online games, puzzles, and brain teasers.</p>
                    <a href="#" class="btn-sm">Play Now</a>
                </div>
                
                <div class="activity-card">
                    <div class="activity-icon">
                        <i class="fas fa-microphone-alt"></i>
                    </div>
                    <h3>Reading Challenges</h3>
                    <p>Join reading programs and earn cool badges!</p>
                    <a href="#" class="btn-sm">Join Challenge</a>
                </div>
                
                <div class="activity-card">
                    <div class="activity-icon">
                        <i class="fas fa-robot"></i>
                    </div>
                    <h3>STEM Activities</h3>
                    <p>Science experiments and technology projects.</p>
                    <a href="#" class="btn-sm">Explore STEM</a>
                </div>
            </div>
        </section>

        <!-- Reading Recommendations -->
        <section class="kids-section">
            <h2 class="section-title">Reading Recommendations</h2>
            <div class="resources-grid">
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-dragon"></i>
                    </div>
                    <span class="age-badge">Fantasy</span>
                    <h3>Magical Adventures</h3>
                    <p>Discover enchanting worlds and magical creatures in these fantasy books.</p>
                    <a href="${pageContext.request.contextPath}/kids-teens?category=Fantasy" class="btn-sm outline">Explore</a>
                </div>
                
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-rocket"></i>
                    </div>
                    <span class="age-badge">Science</span>
                    <h3>Science & Discovery</h3>
                    <p>Learn about space, animals, and amazing scientific discoveries.</p>
                    <a href="${pageContext.request.contextPath}/kids-teens?category=Science" class="btn-sm outline">Explore</a>
                </div>
                
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-history"></i>
                    </div>
                    <span class="age-badge">History</span>
                    <h3>History Heroes</h3>
                    <p>Read about amazing people and events from history.</p>
                    <a href="${pageContext.request.contextPath}/kids-teens?category=History" class="btn-sm outline">Explore</a>
                </div>
            </div>
        </section>
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
        // Interactive elements for kids zone
        document.addEventListener('DOMContentLoaded', function() {
            // Add fun hover effects to book cards
            const bookCards = document.querySelectorAll('.kids-book-card');
            bookCards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-8px) scale(1.02)';
                });
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0) scale(1)';
                });
            });

            // Age group filter highlighting
            const ageGroupBtns = document.querySelectorAll('.age-group-btn');
            ageGroupBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    ageGroupBtns.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // Fun animation for resource icons
            const resourceIcons = document.querySelectorAll('.resource-icon');
            resourceIcons.forEach(icon => {
                icon.addEventListener('mouseenter', function() {
                    this.style.transform = 'scale(1.2) rotate(10deg)';
                });
                icon.addEventListener('mouseleave', function() {
                    this.style.transform = 'scale(1) rotate(0deg)';
                });
            });
        });

        // Simple reading level calculator (for demo purposes)
        function calculateReadingLevel(text) {
            const words = text.split(' ');
            if (words.length < 100) return 'Beginner';
            if (words.length < 300) return 'Intermediate';
            return 'Advanced';
        }
    </script>
</body>
</html>
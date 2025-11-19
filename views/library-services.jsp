<%-- DSACLibraryApplication-war/Web Pages/views/library-services.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Services - ${library.name} | DSAC Libraries</title>
    
    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <style>
        /* Services Page Specific Styles */
        .services-header {
            background: 
                linear-gradient(135deg, rgba(15, 75, 34, 0.85) 0%, rgba(26, 94, 42, 0.75) 100%),
                <c:choose>
                    <c:when test="${not empty library.imageUrl}">
                        url('${library.imageUrl}')
                    </c:when>
                    <c:otherwise>
                        url('https://images.unsplash.com/photo-1589998059171-988d887df646?auto=format&fit=crop&w=1200&q=80')
                    </c:otherwise>
                </c:choose>;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: white;
            padding: 8rem 0 4rem;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
            min-height: 400px;
            display: flex;
            align-items: center;
        }

        .services-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%23ffffff' fill-opacity='0.05' fill-rule='evenodd'/%3E%3C/svg%3E");
            opacity: 0.5;
        }
        
        .services-container {
            max-width: var(--container);
            margin: 0 auto;
            padding: 0 2rem;
            position: relative;
            z-index: 2;
        }
        
        .library-info-card {
            background: var(--card);
            border-radius: var(--radius);
            padding: 2.5rem;
            box-shadow: var(--shadow);
            margin-bottom: 3rem;
            border-left: 6px solid var(--yellow);
            transition: var(--transition);
        }

        .library-info-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }
        
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        
        .service-card {
            background: var(--card);
            border-radius: var(--radius);
            padding: 2.5rem 2rem;
            box-shadow: var(--shadow);
            transition: var(--transition);
            border-top: 4px solid var(--green-600);
            position: relative;
            overflow: hidden;
        }

        .service-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--green-700), var(--yellow));
        }
        
        .service-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-hover);
        }
        
        .service-icon {
            font-size: 3rem;
            color: var(--green-700);
            margin-bottom: 1.5rem;
            display: inline-block;
            transition: var(--transition);
        }

        .service-card:hover .service-icon {
            transform: scale(1.1) rotate(5deg);
            color: var(--green-800);
        }
        
        .service-status {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.6rem 1.2rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 700;
            margin-top: 1.5rem;
            background: var(--light-yellow);
            color: var(--green-900);
            border: 2px solid var(--yellow);
        }
        
        .service-status.available {
            background: #e8f5e8;
            color: var(--green-700);
            border-color: var(--green-500);
        }
        
        .no-services {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--card);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            border: 2px dashed var(--green-300);
        }
        
        .no-services i {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            color: var(--green-600);
        }
        
        .breadcrumb {
            margin-bottom: 2rem;
            font-size: 0.95rem;
            color: rgba(255, 255, 255, 0.9);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .breadcrumb a {
            color: var(--yellow);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            padding: 0.3rem 0.8rem;
            border-radius: 6px;
        }

        .breadcrumb a:hover {
            background: rgba(253, 216, 53, 0.2);
            transform: translateY(-2px);
        }
        
        .breadcrumb span {
            color: white;
            font-weight: 600;
        }

        .breadcrumb-separator {
            color: var(--yellow);
            font-weight: bold;
        }
        
        .back-button {
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            color: var(--green-700);
            text-decoration: none;
            font-weight: 700;
            margin-top: 3rem;
            padding: 1rem 2rem;
            border: 2px solid var(--green-600);
            border-radius: 10px;
            transition: var(--transition);
            background: var(--card);
            box-shadow: var(--shadow);
        }

        .back-button:hover {
            background: var(--green-700);
            color: white;
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
            border-color: var(--green-700);
        }

        .contact-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .library-contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .contact-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            padding: 1.2rem;
            background: rgba(15, 75, 34, 0.05);
            border-radius: 10px;
            transition: var(--transition);
        }

        .contact-item:hover {
            background: rgba(15, 75, 34, 0.1);
            transform: translateY(-2px);
        }

        .contact-item i {
            color: var(--green-700);
            font-size: 1.2rem;
            margin-top: 0.2rem;
            min-width: 20px;
        }

        .contact-item strong {
            color: var(--green-800);
            display: block;
            margin-bottom: 0.3rem;
        }

        .services-count {
            background: var(--yellow);
            color: var(--green-900);
            padding: 0.3rem 1rem;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.9rem;
            margin-left: 1rem;
        }

        /* Virtual Tour/Gallery Styles */
        .virtual-tour-section {
            margin: 4rem 0;
            background: var(--card);
            border-radius: var(--radius);
            padding: 3rem;
            box-shadow: var(--shadow);
            border: 1px solid rgba(15, 75, 34, 0.1);
        }

        .tour-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .tour-header h2 {
            font-family: "Playfair Display", serif;
            font-size: 2.5rem;
            color: var(--green-900);
            margin-bottom: 1rem;
        }

        .tour-header p {
            color: var(--muted);
            font-size: 1.1rem;
            max-width: 600px;
            margin: 0 auto;
        }

        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .gallery-item {
            position: relative;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: var(--transition);
            cursor: pointer;
            aspect-ratio: 4/3;
        }

        .gallery-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .gallery-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .gallery-item:hover .gallery-image {
            transform: scale(1.05);
        }

        .gallery-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(transparent, rgba(15, 75, 34, 0.8));
            color: white;
            padding: 1.5rem;
            transform: translateY(100%);
            transition: transform 0.3s ease;
        }

        .gallery-item:hover .gallery-overlay {
            transform: translateY(0);
        }

        .gallery-title {
            font-weight: 700;
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
        }

        .gallery-description {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .virtual-tour-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 2rem;
        }

        .tour-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            padding: 1rem 2rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            border: 2px solid transparent;
        }

        .tour-btn.primary {
            background: var(--green-700);
            color: white;
            border-color: var(--green-700);
        }

        .tour-btn.primary:hover {
            background: var(--green-800);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(15, 75, 34, 0.3);
        }

        .tour-btn.outline {
            background: transparent;
            color: var(--green-700);
            border-color: var(--green-700);
        }

        .tour-btn.outline:hover {
            background: var(--green-700);
            color: white;
            transform: translateY(-2px);
        }

        /* Modal Styles for Gallery */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.9);
            animation: fadeIn 0.3s ease;
        }

        .modal-content {
            position: relative;
            margin: auto;
            padding: 20px;
            width: 90%;
            max-width: 1200px;
            top: 50%;
            transform: translateY(-50%);
        }

        .modal-image {
            width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .modal-caption {
            color: white;
            text-align: center;
            margin-top: 1rem;
            font-size: 1.1rem;
        }

        .close-modal {
            position: absolute;
            top: 20px;
            right: 30px;
            color: white;
            font-size: 2.5rem;
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
            z-index: 1001;
        }

        .close-modal:hover {
            color: var(--yellow);
            transform: scale(1.1);
        }

        .modal-nav {
            position: absolute;
            top: 50%;
            width: 100%;
            display: flex;
            justify-content: space-between;
            padding: 0 20px;
            transform: translateY(-50%);
        }

        .nav-btn {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            font-size: 2rem;
            padding: 1rem;
            border-radius: 50%;
            cursor: pointer;
            transition: var(--transition);
            backdrop-filter: blur(10px);
        }

        .nav-btn:hover {
            background: var(--green-700);
            transform: scale(1.1);
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Library Image Preview */
        .library-image-preview {
            width: 100%;
            height: 300px;
            border-radius: var(--radius);
            object-fit: cover;
            margin-bottom: 2rem;
            box-shadow: var(--shadow);
            border: 3px solid var(--yellow);
        }

        /* Floating shapes for header */
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

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .services-header {
                padding: 6rem 0 3rem;
                min-height: 300px;
            }
            
            .services-container {
                padding: 0 1.5rem;
            }
            
            .services-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .service-card {
                padding: 2rem 1.5rem;
            }
            
            .library-info-card {
                padding: 2rem 1.5rem;
            }
            
            .virtual-tour-section {
                padding: 2rem 1.5rem;
            }
            
            .gallery-grid {
                grid-template-columns: 1fr;
            }
            
            .tour-header h2 {
                font-size: 2rem;
            }
            
            .contact-actions {
                flex-direction: column;
                align-items: center;
            }
            
            .contact-actions .btn-primary,
            .contact-actions .btn-outline {
                width: 100%;
                text-align: center;
            }
            
            .breadcrumb {
                font-size: 0.85rem;
            }
            
            .library-image-preview {
                height: 200px;
            }

            .modal-nav {
                padding: 0 10px;
            }

            .nav-btn {
                font-size: 1.5rem;
                padding: 0.8rem;
            }
        }
    </style>
    
    <style>
/* Scene button styles */
.scene-btn {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.8rem 1.2rem;
    background: rgba(15, 75, 34, 0.1);
    border: 2px solid transparent;
    border-radius: 8px;
    color: var(--green-800);
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 0.9rem;
}

.scene-btn:hover {
    background: rgba(15, 75, 34, 0.15);
    transform: translateY(-2px);
}

.scene-btn.active {
    background: var(--green-700);
    color: white;
    border-color: var(--yellow);
}

.scene-btn i {
    font-size: 1rem;
}

/* Control button hover effects */
.control-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(15, 75, 34, 0.3);
}

/* Responsive design */
@media (max-width: 768px) {
    .scene-buttons {
        flex-direction: column;
        align-items: center;
    }
    
    .scene-btn {
        width: 200px;
        justify-content: center;
    }
    
    .tour-controls {
        flex-direction: column;
        align-items: center;
    }
    
    .control-btn {
        width: 200px;
    }
    
    .tour-instructions {
        flex-direction: column;
        align-items: center;
    }
    
    .instruction-item {
        width: 100%;
        max-width: 300px;
        justify-content: center;
    }
}
</style>
    
</head>
<body>
    <!-- NAV -->
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
                    <li><a href="${pageContext.request.contextPath}/kids-teens">Kids & Teens</a></li>
                    <li><a href="${pageContext.request.contextPath}/services" class="active">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/news">News</a></li>
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

    <!-- Services Header with Library Image -->
    <section class="services-header">
        <div class="floating-shapes">
            <div class="shape"></div>
            <div class="shape"></div>
            <div class="shape"></div>
        </div>
        <div class="services-container">
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <span class="breadcrumb-separator">›</span>
                <a href="${pageContext.request.contextPath}/libraries">Libraries</a>
                <span class="breadcrumb-separator">›</span>
                <span>${library.name} - Services</span>
            </div>
            
            <h1 style="margin: 0 0 1rem 0; font-size: 3rem; font-family: 'Playfair Display', serif; text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">
                Services at ${library.name}
            </h1>
            <p style="font-size: 1.3rem; margin: 0; opacity: 0.9; max-width: 600px; text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">
                Explore all available services at this branch
                <c:if test="${not empty services}">
                    <span class="services-count">${fn:length(services)} services</span>
                </c:if>
            </p>
        </div>
    </section>

    <!-- Main Content -->
    <main class="services-container">
        <!-- Library Image Preview -->
        <c:if test="${not empty library.imageUrl}">
            <div style="text-align: center; margin-bottom: 2rem;">
                <img src="${library.imageUrl}" alt="${library.name}" class="library-image-preview">
            </div>
        </c:if>

        <!-- Library Information -->
        <div class="library-info-card">
            <h2 style="color: var(--green-900); margin-bottom: 1.5rem; display: flex; align-items: center; gap: 1rem;">
                <i class="fas fa-library" style="color: var(--green-700);"></i>
                About ${library.name}
            </h2>
            <div class="library-contact-grid">
                <div class="contact-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <div>
                        <strong>Address</strong>
                        <p style="margin: 0; color: var(--muted);">${library.address}</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-phone"></i>
                    <div>
                        <strong>Phone</strong>
                        <p style="margin: 0; color: var(--muted);">${library.phone}</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-envelope"></i>
                    <div>
                        <strong>Email</strong>
                        <p style="margin: 0; color: var(--muted);">${library.email}</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-clock"></i>
                    <div>
                        <strong>Operating Hours</strong>
                        <p style="margin: 0; color: var(--muted);">${library.hours}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Virtual Tour/Gallery Section -->
        <section class="virtual-tour-section">
            <div class="tour-header">
                <h2>Virtual Tour & Facilities</h2>
                <p>Take a virtual tour of ${library.name} and explore our state-of-the-art facilities</p>
            </div>

            <div class="gallery-grid">
                <div class="gallery-item" onclick="openModal(0)">
                    <img src="../images/G41uHhoW4AAb3oI.jpg" 
                         alt="Main Reading Area" class="gallery-image">
                    <div class="gallery-overlay">
                        <div class="gallery-title">Main Reading Area</div>
                        <div class="gallery-description">Spacious and comfortable reading spaces</div>
                    </div>
                </div>
                
                <div class="gallery-item" onclick="openModal(1)">
                    <img src="https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&w=600&q=80" 
                         alt="Children's Section" class="gallery-image">
                    <div class="gallery-overlay">
                        <div class="gallery-title">Children's Section</div>
                        <div class="gallery-description">Colorful and engaging space for young readers</div>
                    </div>
                </div>
                
                <div class="gallery-item" onclick="openModal(2)">
                    <img src="https://images.unsplash.com/photo-1568667256549-094345857637?auto=format&fit=crop&w=600&q=80" 
                         alt="Computer Lab" class="gallery-image">
                    <div class="gallery-overlay">
                        <div class="gallery-title">Computer Lab</div>
                        <div class="gallery-description">Modern computers with internet access</div>
                    </div>
                </div>
                
                <div class="gallery-item" onclick="openModal(3)">
                    <img src="https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?auto=format&fit=crop&w=600&q=80" 
                         alt="Study Rooms" class="gallery-image">
                    <div class="gallery-overlay">
                        <div class="gallery-title">Study Rooms</div>
                        <div class="gallery-description">Private study areas for group work</div>
                    </div>
                </div>
                
                <div class="gallery-item" onclick="openModal(4)">
                    <img src="https://images.unsplash.com/photo-1555421689-491a97ff2040?auto=format&fit=crop&w=600&q=80" 
                         alt="Multimedia Center" class="gallery-image">
                    <div class="gallery-overlay">
                        <div class="gallery-title">Multimedia Center</div>
                        <div class="gallery-description">Audio-visual resources and equipment</div>
                    </div>
                </div>
                
                <div class="gallery-item" onclick="openModal(5)">
                    <img src="https://images.unsplash.com/photo-1532012197267-da84d127e765?auto=format&fit=crop&w=600&q=80" 
                         alt="Outdoor Garden" class="gallery-image">
                    <div class="gallery-overlay">
                        <div class="gallery-title">Outdoor Reading Garden</div>
                        <div class="gallery-description">Peaceful outdoor reading spaces</div>
                    </div>
                </div>
            </div>

            <div class="virtual-tour-actions">
                <a href="#" class="tour-btn primary">
                    <i class="fas fa-vr-cardboard"></i> Start 360° Virtual Tour
                </a>
                <a href="#" class="tour-btn outline">
                    <i class="fas fa-download"></i> Download Facility Map
                </a>
                <a href="#" class="tour-btn outline">
                    <i class="fas fa-calendar"></i> Schedule In-Person Tour
                </a>
            </div>
        </section>

        <!-- Services List -->
        <c:choose>
            <c:when test="${not empty services}">
                <div class="section-head">
                    <h2>Available Services</h2>
                    <p class="section-sub">All services currently offered at this location</p>
                </div>
                
                <div class="services-grid">
                    <c:forEach var="service" items="${services}">
                        <div class="service-card">
                            <div class="service-icon">
                                <i class="${service.iconClass}"></i>
                            </div>
                            <h3 style="color: var(--green-900); margin-bottom: 1rem; font-size: 1.4rem;">
                                ${service.name}
                            </h3>
                            <p style="color: var(--muted); line-height: 1.6; margin-bottom: 1.5rem;">
                                ${service.description}
                            </p>
                            <div class="service-status available">
                                <i class="fas fa-check-circle"></i> Available
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-services">
                    <i class="fas fa-info-circle"></i>
                    <h3 style="color: var(--green-900); margin-bottom: 1rem;">No Specific Services Listed</h3>
                    <p style="color: var(--muted); max-width: 500px; margin: 0 auto 2rem;">
                        This branch may offer standard library services. Please contact the library directly 
                        for detailed information about available services and programs.
                    </p>
                    <div class="contact-actions">
                        <a href="tel:${library.phone}" class="btn-primary" style="text-decoration: none;">
                            <i class="fas fa-phone"></i> Call Library
                        </a>
                        <a href="mailto:${library.email}" class="btn-outline" style="text-decoration: none;">
                            <i class="fas fa-envelope"></i> Email Library
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Back to Libraries -->
        <div style="text-align: center; margin-top: 4rem;">
            <a href="${pageContext.request.contextPath}/libraries" class="back-button">
                <i class="fas fa-arrow-left"></i> Back to All Libraries
            </a>
        </div>
    </main>

    <!-- Image Modal -->
    <div id="imageModal" class="modal">
        <span class="close-modal" onclick="closeModal()">&times;</span>
        <div class="modal-nav">
            <button class="nav-btn" onclick="changeImage(-1)">&#10094;</button>
            <button class="nav-btn" onclick="changeImage(1)">&#10095;</button>
        </div>
        <div class="modal-content">
            <img id="modalImage" class="modal-image">
            <div id="modalCaption" class="modal-caption"></div>
        </div>
    </div>

    <!-- 360° Virtual Tour Section - FIXED -->
<section class="virtual-tour-section">
    <div class="tour-header">
        <h2>360° Virtual Tour</h2>
        <p>Explore ${library.name} with our interactive virtual tour</p>
    </div>

    <div class="tour-viewer-container">
        <div class="simple-tour-viewer">
            <iframe 
                id="tourIframe"
                src="https://cdn.pannellum.org/2.5/pannellum.htm#panorama=https://i.imgur.com/6jXzZ7Q.jpg&title=DSAC%20Library%20Main%20Hall&author=DSAC%20Libraries&autoLoad=true"
                width="100%" 
                height="500"
                style="border: none; border-radius: 12px;"
                allowfullscreen>
            </iframe>
        </div>
        
        <!-- Scene Selection -->
        <div class="scene-selector" style="text-align: center; margin: 2rem 0;">
            <div class="scene-title" style="font-weight: bold; color: var(--green-900); margin-bottom: 1rem;">
                Explore Library Areas
            </div>
            <div class="scene-buttons" style="display: flex; justify-content: center; gap: 1rem; flex-wrap: wrap;">
                <button class="scene-btn active" data-scene="main-hall">
                    <i class="fas fa-door-open"></i>
                    <span>Main Hall</span>
                </button>
                <button class="scene-btn" data-scene="reading-area">
                    <i class="fas fa-book-open"></i>
                    <span>Reading Area</span>
                </button>
                <button class="scene-btn" data-scene="children-section">
                    <i class="fas fa-child"></i>
                    <span>Children's Area</span>
                </button>
                <button class="scene-btn" data-scene="computer-lab">
                    <i class="fas fa-desktop"></i>
                    <span>Computer Lab</span>
                </button>
            </div>
        </div>

        <!-- Tour Controls -->
        <div class="tour-controls" style="display: flex; justify-content: center; gap: 1rem; margin: 1rem 0;">
            <button class="control-btn" id="fullscreenBtn" style="background: var(--green-700); color: white; border: none; padding: 0.8rem 1.5rem; border-radius: 8px; cursor: pointer;">
                <i class="fas fa-expand"></i> Fullscreen
            </button>
            <button class="control-btn" id="resetViewBtn" style="background: var(--green-600); color: white; border: none; padding: 0.8rem 1.5rem; border-radius: 8px; cursor: pointer;">
                <i class="fas fa-sync-alt"></i> Reset View
            </button>
        </div>
        
        <!-- Tour Instructions -->
        <div class="tour-instructions" style="display: flex; justify-content: center; gap: 2rem; margin-top: 1.5rem; flex-wrap: wrap;">
            <div class="instruction-item" style="display: flex; align-items: center; gap: 0.8rem; padding: 0.8rem 1.2rem; background: rgba(15, 75, 34, 0.05); border-radius: 8px; color: var(--green-800); font-weight: 600;">
                <i class="fas fa-mouse-pointer" style="color: var(--green-700);"></i>
                <span>Click and drag to look around</span>
            </div>
            <div class="instruction-item" style="display: flex; align-items: center; gap: 0.8rem; padding: 0.8rem 1.2rem; background: rgba(15, 75, 34, 0.05); border-radius: 8px; color: var(--green-800); font-weight: 600;">
                <i class="fas fa-mouse" style="color: var(--green-700);"></i>
                <span>Scroll to zoom in/out</span>
            </div>
            <div class="instruction-item" style="display: flex; align-items: center; gap: 0.8rem; padding: 0.8rem 1.2rem; background: rgba(15, 75, 34, 0.05); border-radius: 8px; color: var(--green-800); font-weight: 600;">
                <i class="fas fa-expand" style="color: var(--green-700);"></i>
                <span>Fullscreen for best experience</span>
            </div>
        </div>
    </div>
</section>

<script>
// Virtual Tour Configuration
document.addEventListener('DOMContentLoaded', function() {
    // 360° image URLs - REPLACE THESE WITH YOUR ACTUAL 360° IMAGES
    const sceneConfig = {
        'main-hall': {
            image: 'https://i.imgur.com/6jXzZ7Q.jpg',
            title: 'Library Main Hall',
            description: 'Welcome to our spacious main hall featuring the reception desk and new arrivals display'
        },
        'reading-area': {
            image: 'https://i.imgur.com/6jXzZ7Q.jpg', // Replace with actual reading area 360°
            title: 'Quiet Reading Area', 
            description: 'Peaceful reading spaces with comfortable seating and natural lighting'
        },
        'children-section': {
            image: 'https://i.imgur.com/6jXzZ7Q.jpg', // Replace with actual children's area 360°
            title: 'Children\'s Section',
            description: 'Colorful and engaging space designed for young readers and families'
        },
        'computer-lab': {
            image: 'https://i.imgur.com/6jXzZ7Q.jpg', // Replace with actual computer lab 360°
            title: 'Computer Lab',
            description: 'Modern computers with internet access and digital resources'
        }
    };

    const iframe = document.getElementById('tourIframe');
    
    // Scene selection functionality
    const sceneButtons = document.querySelectorAll('.scene-btn');
    sceneButtons.forEach(button => {
        button.addEventListener('click', function() {
            const scene = this.getAttribute('data-scene');
            changeScene(scene);
        });
    });

    // Change scene function
    function changeScene(sceneName) {
        const scene = sceneConfig[sceneName];
        if (!scene) return;

        // Encode the URL components using JavaScript
        const encodedImage = encodeURIComponent(scene.image);
        const encodedTitle = encodeURIComponent(scene.title);
        
        // Build the iframe URL
        const iframeUrl = `https://cdn.pannellum.org/2.5/pannellum.htm#panorama=${encodedImage}&title=${encodedTitle}&author=DSAC%20Libraries&autoLoad=true`;
        
        // Update iframe source
        iframe.src = iframeUrl;
        
        // Update active button
        sceneButtons.forEach(btn => btn.classList.remove('active'));
        document.querySelector(`.scene-btn[data-scene="${sceneName}"]`).classList.add('active');
        
        console.log('Changed to scene:', sceneName);
    }

    // Fullscreen functionality
    document.getElementById('fullscreenBtn').addEventListener('click', function() {
        const container = document.querySelector('.simple-tour-viewer');
        if (!document.fullscreenElement) {
            if (container.requestFullscreen) {
                container.requestFullscreen();
            } else if (container.webkitRequestFullscreen) {
                container.webkitRequestFullscreen();
            } else if (container.msRequestFullscreen) {
                container.msRequestFullscreen();
            }
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            } else if (document.webkitExitFullscreen) {
                document.webkitExitFullscreen();
            } else if (document.msExitFullscreen) {
                document.msExitFullscreen();
            }
        }
    });

    // Reset view functionality
    document.getElementById('resetViewBtn').addEventListener('click', function() {
        // Reload the iframe to reset the view
        iframe.src = iframe.src;
    });

    // Handle fullscreen change
    document.addEventListener('fullscreenchange', function() {
        const fullscreenBtn = document.getElementById('fullscreenBtn');
        if (document.fullscreenElement) {
            fullscreenBtn.innerHTML = '<i class="fas fa-compress"></i> Exit Fullscreen';
        } else {
            fullscreenBtn.innerHTML = '<i class="fas fa-expand"></i> Fullscreen';
        }
    });

    console.log('Virtual tour initialized successfully');
});
</script>


    
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


    <!-- JavaScript files -->
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    
    <script>
        // Virtual Tour Gallery Functionality
        const galleryImages = [
            {
                src: "https://images.unsplash.com/photo-1589998059171-988d887df646?auto=format&fit=crop&w=1200&q=80",
                title: "Main Reading Area",
                description: "Spacious and comfortable reading spaces with natural lighting"
            },
            {
                src: "https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&w=1200&q=80",
                title: "Children's Section",
                description: "Colorful and engaging space designed for young readers"
            },
            {
                src: "https://images.unsplash.com/photo-1568667256549-094345857637?auto=format&fit=crop&w=1200&q=80",
                title: "Computer Lab",
                description: "Modern computers with high-speed internet access"
            },
            {
                src: "https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?auto=format&fit=crop&w=1200&q=80",
                title: "Study Rooms",
                description: "Private study areas perfect for group work and collaboration"
            },
            {
                src: "https://images.unsplash.com/photo-1555421689-491a97ff2040?auto=format&fit=crop&w=1200&q=80",
                title: "Multimedia Center",
                description: "Audio-visual resources and equipment for creative projects"
            },
            {
                src: "https://images.unsplash.com/photo-1532012197267-da84d127e765?auto=format&fit=crop&w=1200&q=80",
                title: "Outdoor Reading Garden",
                description: "Peaceful outdoor reading spaces surrounded by nature"
            }
        ];

        let currentImageIndex = 0;

        function openModal(index) {
            currentImageIndex = index;
            const modal = document.getElementById('imageModal');
            const modalImg = document.getElementById('modalImage');
            const caption = document.getElementById('modalCaption');
            
            modal.style.display = 'block';
            modalImg.src = galleryImages[index].src;
            caption.innerHTML = `<strong>${galleryImages[index].title}</strong><br>${galleryImages[index].description}`;
            
            // Prevent body scroll when modal is open
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            const modal = document.getElementById('imageModal');
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        function changeImage(direction) {
            currentImageIndex += direction;
            
            if (currentImageIndex >= galleryImages.length) {
                currentImageIndex = 0;
            } else if (currentImageIndex < 0) {
                currentImageIndex = galleryImages.length - 1;
            }
            
            const modalImg = document.getElementById('modalImage');
            const caption = document.getElementById('modalCaption');
            
            modalImg.src = galleryImages[currentImageIndex].src;
            caption.innerHTML = `<strong>${galleryImages[currentImageIndex].title}</strong><br>${galleryImages[currentImageIndex].description}`;
        }

        // Close modal when clicking outside the image
        window.onclick = function(event) {
            const modal = document.getElementById('imageModal');
            if (event.target === modal) {
                closeModal();
            }
        }

        // Keyboard navigation
        document.addEventListener('keydown', function(event) {
            const modal = document.getElementById('imageModal');
            if (modal.style.display === 'block') {
                if (event.key === 'Escape') {
                    closeModal();
                } else if (event.key === 'ArrowLeft') {
                    changeImage(-1);
                } else if (event.key === 'ArrowRight') {
                    changeImage(1);
                }
            }
        });

        // Virtual tour button functionality
        document.querySelector('.tour-btn.primary').addEventListener('click', function(e) {
            e.preventDefault();
            alert('Virtual tour feature coming soon! This will launch an interactive 360° tour of the library facilities.');
        });

        // Download map button
        document.querySelectorAll('.tour-btn.outline')[0].addEventListener('click', function(e) {
            e.preventDefault();
            alert('Facility map download will be available soon!');
        });

        // Schedule tour button
        document.querySelectorAll('.tour-btn.outline')[1].addEventListener('click', function(e) {
            e.preventDefault();
            window.location.href = '${pageContext.request.contextPath}/contact?subject=Schedule%20Library%20Tour';
        });
    </script>
</body>
</html>
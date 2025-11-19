<%-- views/error.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - DSAC Libraries</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header class="site-header">
        <div class="container header-inner">
            <a class="brand" href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/images/Screenshot 2025-09-05 094525.png" alt="DSAC Logo" class="brand-logo">
            </a>
        </div>
    </header>

    <main class="container" style="padding-top: 120px; padding-bottom: 60px; text-align: center;">
        <div class="error-container">
            <i class="fas fa-exclamation-triangle" style="font-size: 4rem; color: #f44336; margin-bottom: 2rem;"></i>
            <h1>Oops! Something went wrong</h1>
            
            <c:if test="${not empty errorMessage}">
                <p class="error-message">${errorMessage}</p>
            </c:if>
            
            <c:if test="${empty errorMessage}">
                <p>We're sorry, but something went wrong on our end. Please try again later.</p>
            </c:if>

            <div class="error-actions" style="margin-top: 2rem;">
                <a href="${pageContext.request.contextPath}/home" class="btn-primary">
                    <i class="fas fa-home"></i> Go Home
                </a>
                <a href="javascript:history.back()" class="btn-ghost">
                    <i class="fas fa-arrow-left"></i> Go Back
                </a>
            </div>

            <div class="error-help" style="margin-top: 3rem; padding: 1.5rem; background: #f8f9fa; border-radius: 8px;">
                <h3>Need Immediate Assistance?</h3>
                <p>Contact our support team during business hours</p>
                <div style="margin-top: 1rem;">
                    <a href="tel:+27151234567" class="btn-sm outline">
                        <i class="fas fa-phone"></i> (015) 123 4567
                    </a>
                    <a href="mailto:support@dsaclibraries.gov.za" class="btn-sm outline">
                        <i class="fas fa-envelope"></i> support@dsaclibraries.gov.za
                    </a>
                </div>
            </div>
        </div>
    </main>

    <footer class="site-footer enhanced-footer">
        <!-- Footer content same as index.jsp -->
    </footer>
</body>
</html>
/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */


// =============== UPCOMING EVENT ALERT LOGIC ===============
document.addEventListener("DOMContentLoaded", () => {
    const eventAlert = document.getElementById("eventAlert");
    const eventAlertText = document.getElementById("eventAlertText");
    const closeAlert = document.getElementById("closeAlert");

    // Check if there are upcoming events from the server
    const upcomingEvents = window.upcomingEvents || [];

    if (upcomingEvents.length > 0) {
        // Get the closest event (first one since they're sorted by date)
        const closestEvent = upcomingEvents[0];
        
        // Format the event date for display
        const eventDate = new Date(closestEvent.eventDate);
        const formattedDate = eventDate.toLocaleDateString('en-US', {
            month: 'short',
            day: 'numeric'
        });
        
        // Create alert message
        let alertMessage = `📅 ${closestEvent.title} on ${formattedDate}`;
        
        // Add location if available
        if (closestEvent.location) {
            alertMessage += ` at ${closestEvent.location}`;
        }
        
        // Add library name if available
        if (closestEvent.library && closestEvent.library.name) {
            alertMessage += ` — ${closestEvent.library.name}`;
        }
        
        // Set the alert text
        eventAlertText.textContent = alertMessage;
        
        // Make the alert clickable to go to events page
        eventAlertText.style.cursor = 'pointer';
        eventAlertText.addEventListener('click', () => {
            window.location.href = '${pageContext.request.contextPath}/events';
        });
        
        // Show the alert with animation
        eventAlert.classList.remove("hidden");
        setTimeout(() => eventAlert.classList.add("show"), 300);
        
        // Auto-hide after 10 seconds
        setTimeout(() => {
            if (eventAlert.classList.contains("show")) {
                eventAlert.classList.remove("show");
                setTimeout(() => eventAlert.classList.add("hidden"), 400);
            }
        }, 10000);
    }

    // Close alert functionality
    if (closeAlert) {
        closeAlert.addEventListener("click", () => {
            eventAlert.classList.remove("show");
            setTimeout(() => eventAlert.classList.add("hidden"), 400);
        });
    }
});
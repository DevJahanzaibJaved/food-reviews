// Flash message auto-hide functionality
function setupFlashMessages() {
  const flashMessages = document.querySelectorAll('.flash-message[data-autohide="true"]');
  flashMessages.forEach(function(message) {
    setTimeout(function() {
      message.style.transition = 'opacity 0.3s ease-out';
      message.style.opacity = '0';
      setTimeout(function() {
        message.remove();
      }, 300);
    }, 5000);
  });
}

// Handle close button clicks
document.addEventListener('click', function(event) {
  if (event.target.matches('.flash-close')) {
    const flashMessage = event.target.closest('.flash-message');
    if (flashMessage) {
      flashMessage.style.transition = 'opacity 0.3s ease-out';
      flashMessage.style.opacity = '0';
      setTimeout(function() {
        flashMessage.remove();
      }, 300);
    }
  }
});

// Initialize on page load
document.addEventListener('DOMContentLoaded', setupFlashMessages);

// Handle Turbo page loads
document.addEventListener('turbo:load', setupFlashMessages);


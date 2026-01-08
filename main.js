// Auto-scroll active pill into view on mobile
document.addEventListener('DOMContentLoaded', function() {
  // Only run on mobile/small screens
  if (window.innerWidth < 768) {
    const activePill = document.querySelector('.pill--active');
    const container = document.querySelector('.pills-container');
    
    if (activePill && container) {
      // Set scroll position immediately without animation
      const scrollLeft = activePill.offsetLeft - (container.clientWidth / 2) + (activePill.offsetWidth / 2);
      container.scrollLeft = scrollLeft;
    }
  }
});
/* ================================================
   MAIN JAVASCRIPT - Toha-inspired Interactions
   ================================================ */

document.addEventListener('DOMContentLoaded', () => {
  initMobileMenu();
  initScrollToTop();
  initScrollReveal();
  initSkillBars();
  initSmoothScroll();
  initNavbarScroll();
});

/* ================================================
   MOBILE MENU
   ================================================ */
function initMobileMenu() {
  const mobileToggle = document.getElementById('mobile-toggle');
  const mobileMenu = document.getElementById('mobile-menu');
  
  if (mobileToggle && mobileMenu) {
    mobileToggle.addEventListener('click', (e) => {
      e.stopPropagation();
      mobileToggle.classList.toggle('active');
      mobileMenu.classList.toggle('active');
    });
    
    // Close when clicking outside
    document.addEventListener('click', (e) => {
      if (!mobileMenu.contains(e.target) && !mobileToggle.contains(e.target)) {
        mobileToggle.classList.remove('active');
        mobileMenu.classList.remove('active');
      }
    });
    
    // Close when clicking a link
    mobileMenu.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        mobileToggle.classList.remove('active');
        mobileMenu.classList.remove('active');
      });
    });
  }
}

/* ================================================
   SCROLL TO TOP BUTTON
   ================================================ */
function initScrollToTop() {
  const scrollBtn = document.getElementById('scroll-to-top');
  
  if (scrollBtn) {
    window.addEventListener('scroll', () => {
      if (window.pageYOffset > 300) {
        scrollBtn.classList.add('visible');
      } else {
        scrollBtn.classList.remove('visible');
      }
    });
    
    scrollBtn.addEventListener('click', () => {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
    });
  }
}

/* ================================================
   SCROLL REVEAL ANIMATIONS
   ================================================ */
function initScrollReveal() {
  const revealElements = document.querySelectorAll('[data-scroll]');
  
  if (revealElements.length === 0) return;
  
  const revealObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('revealed');
          // Unobserve after revealing (performance)
          revealObserver.unobserve(entry.target);
        }
      });
    },
    {
      threshold: 0.1,
      rootMargin: '0px 0px -50px 0px'
    }
  );
  
  revealElements.forEach(el => {
    revealObserver.observe(el);
  });
}

/* ================================================
   SKILL BARS ANIMATION
   ================================================ */
function initSkillBars() {
  const skillBars = document.querySelectorAll('.progress-fill[data-width]');
  
  if (skillBars.length === 0) return;
  
  const skillObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const bar = entry.target;
          const width = bar.getAttribute('data-width');
          
          setTimeout(() => {
            bar.style.width = width + '%';
          }, 200);
          
          skillObserver.unobserve(bar);
        }
      });
    },
    { threshold: 0.5 }
  );
  
  skillBars.forEach(bar => {
    skillObserver.observe(bar);
  });
}

/* ================================================
   SMOOTH SCROLL FOR ANCHOR LINKS
   ================================================ */
function initSmoothScroll() {
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
      const href = this.getAttribute('href');
      
      // Skip if href is just "#"
      if (href === '#') return;
      
      e.preventDefault();
      
      const target = document.querySelector(href);
      if (target) {
        const offsetTop = target.offsetTop - 80;
        
        window.scrollTo({
          top: offsetTop,
          behavior: 'smooth'
        });
      }
    });
  });
}

/* ================================================
   NAVBAR SCROLL EFFECT
   ================================================ */
function initNavbarScroll() {
  const navbar = document.getElementById('navbar');
  
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.pageYOffset > 50) {
        navbar.classList.add('scrolled');
      } else {
        navbar.classList.remove('scrolled');
      }
    });
  }
}

/* ================================================
   UTILITIES
   ================================================ */

// Debounce function for performance
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

// Throttle function for scroll events
function throttle(func, limit) {
  let inThrottle;
  return function() {
    const args = arguments;
    const context = this;
    if (!inThrottle) {
      func.apply(context, args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  };
}


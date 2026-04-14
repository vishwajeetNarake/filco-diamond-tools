/**
 * iPadOS-style Cursor
 * - Small grey circle follows mouse
 * - Morphs into rounded rectangle highlight when hovering buttons/links
 * - Proper boundary detection: cursor only morphs when within button bounds
 * - Text becomes highlighted (not blurred)
 */
(function () {
  // Create cursor element
  const cursor = document.createElement('div');
  cursor.id = 'ipados-cursor';
  document.body.appendChild(cursor);

  let mouseX = -100, mouseY = -100;
  let cursorX = -100, cursorY = -100;
  let currentMorphTarget = null; // The element we're currently morphed onto

  // Smooth follow with lerp (only when NOT morphed)
  function animate() {
    if (!currentMorphTarget) {
      // Free cursor — smooth follow
      cursorX += (mouseX - cursorX) * 0.18;
      cursorY += (mouseY - cursorY) * 0.18;
      cursor.style.left = cursorX + 'px';
      cursor.style.top = cursorY + 'px';
    } else {
      // Morphed onto a button — lock to button center
      var rect = currentMorphTarget.getBoundingClientRect();
      var cx = rect.left + rect.width / 2;
      var cy = rect.top + rect.height / 2;
      cursor.style.left = cx + 'px';
      cursor.style.top = cy + 'px';
      cursorX = cx;
      cursorY = cy;
    }
    requestAnimationFrame(animate);
  }
  animate();

  // Track mouse position continuously
  document.addEventListener('mousemove', function (e) {
    mouseX = e.clientX;
    mouseY = e.clientY;
    
    // Fallback safety to unmorph if somehow stuck outside target element
    if (currentMorphTarget) {
      var rect = currentMorphTarget.getBoundingClientRect();
      var safeZone = 15;
      if (
        mouseX < rect.left - safeZone ||
        mouseX > rect.right + safeZone ||
        mouseY < rect.top - safeZone ||
        mouseY > rect.bottom + safeZone
      ) {
        cursor.classList.remove('morphed');
        currentMorphTarget = null;
      }
    }
  });

  // Hide when mouse leaves window
  document.addEventListener('mouseleave', function () {
    cursor.style.opacity = '0';
  });
  document.addEventListener('mouseenter', function () {
    cursor.style.opacity = '1';
  });

  // Interactive elements that trigger morph
  var morphSelectors = 'a, button, .ht_btn, .widget__btn, .btn, .round-menu, input[type="submit"], input[type="button"], .swiper-button-prev, .swiper-button-next, .action-btn a, .social_media a, .btn-contact';

  // Use event delegation for much higher reliability than attachListeners/MutationObserver
  document.addEventListener('mouseover', function(e) {
    var target = e.target.closest(morphSelectors);
    if (!target) return;
    
    var rect = target.getBoundingClientRect();
    var pad = 8;
    cursor.style.setProperty('--morph-w', (rect.width + pad * 2) + 'px');
    cursor.style.setProperty('--morph-h', (rect.height + pad * 2) + 'px');
    cursor.classList.add('morphed');
    cursor.classList.remove('text-hover');
    currentMorphTarget = target;
  });

  document.addEventListener('mouseout', function(e) {
    var target = e.target.closest(morphSelectors);
    if (!target) return;
    
    // Only unmorph if we are actually leaving the interactive element entirely
    // (not just crossing child boundaries inside it)
    if (!target.contains(e.relatedTarget)) {
      if (currentMorphTarget === target) {
        cursor.classList.remove('morphed');
        currentMorphTarget = null;
      }
    }
  });

  // Pressed state
  document.addEventListener('mousedown', function () {
    cursor.style.transform = 'translate(-50%, -50%) scale(0.9)';
  });
  document.addEventListener('mouseup', function () {
    cursor.style.transform = 'translate(-50%, -50%) scale(1)';
  });

  // Disable on touch devices
  if ('ontouchstart' in window || navigator.maxTouchPoints > 0) {
    cursor.style.display = 'none';
    document.documentElement.style.cursor = 'auto';
  }
})();

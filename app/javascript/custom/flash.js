function fadeOutFlash(element) {
  element.parentElement.style.opacity = "0";
  setTimeout(() => {
    element.parentElement.style.display = "none";
  }, 600);
}
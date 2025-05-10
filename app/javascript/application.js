// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", () => {
  const menuButton = document.querySelector(".menu-button");
  const menuBar = document.querySelector(".menu-bar");

  if (menuButton && menuBar) {
    menuButton.addEventListener("click", () => {
      menuBar.classList.toggle("open");
    });

    document.addEventListener("click", (e) => {
      if (!menuBar.contains(e.target) && !menuButton.contains(e.target)) {
        menuBar.classList.remove("open");
      }
    });
  }
});
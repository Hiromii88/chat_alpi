function setupMenuToggle() {
  const menuButton = document.querySelector(".menu-button");
  const menuBar = document.querySelector(".menu-bar");

  if (menuButton && menuBar) {
    menuButton.addEventListener("click", () => {
      menuBar.classList.toggle("active");
    });

    document.addEventListener("click", (e) => {
      if (!menuBar.contains(e.target) && !menuButton.contains(e.target)) {
        menuBar.classList.remove("active");
      }
    });
  }
}

document.addEventListener("DOMContentLoaded", setupMenuToggle);
document.addEventListener("turbo:load", setupMenuToggle);

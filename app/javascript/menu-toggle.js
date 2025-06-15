// app/javascript/menu_toggle.js
document.addEventListener("turbo:load", () => {
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

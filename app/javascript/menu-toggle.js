// app/javascript/menu_toggle.js
document.addEventListener("turbo:load", () => {
  const menuButton = document.querySelector(".menu-button");
  const menuBar = document.querySelector(".menu-bar");

  if (menuButton && menuBar) {
    // ハンバーガーボタンをクリックしたときにメニューを表示・非表示
    menuButton.addEventListener("click", () => {
      menuBar.classList.toggle("active");
    });

    // メニュー外をクリックしたら閉じる
    document.addEventListener("click", (e) => {
      if (!menuBar.contains(e.target) && !menuButton.contains(e.target)) {
        menuBar.classList.remove("active");
      }
    });
  }
});

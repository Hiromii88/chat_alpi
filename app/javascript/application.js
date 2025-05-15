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

document.addEventListener("turbo:load", () => {
  const button_post = document.getElementById('button_post');
  const formText = document.querySelector("#user_input");
  const list = document.getElementById("conversation");

  if (!button_post || !formText || !list) return;

  const newButton = button_post.cloneNode(true);
  button_post.replaceWith(newButton);

  newButton.addEventListener('click', function(event) {
    event.preventDefault();

    if (formText.value.trim() === "") return;

    const url = `/chatbots/generate_text.json?user_input=${encodeURIComponent(formText.value)}`;
    const postOptions = {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      method: "GET"
    };

    fetch(url, postOptions)
      .then(response => response.json())
      .then(item => {
        const inputHTML = `
          <div class="text-right flex items-end justify-end space-x-2">
            <div class="chat-bubble inline-block bg-blue-100 px-4 py-2 rounded-lg max-w-3/4 break-words">
              <span>${formText.value}</span>
            </div>
            <div class="icon-container w-8 h-8 flex-shrink-0">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="w-full h-full"><path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"/></svg>
            </div>
          </div>`;
        list.insertAdjacentHTML("beforeend", inputHTML);

        const responseHTML = `
          <div class="text-left flex items-start space-x-2">
            <div class="icon-container w-8 h-8 flex-shrink-0">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="w-full h-full"><path d="M320 0c17.7 0 32 14.3 32 32V96H472c39.8 0 72 32.2 72 72V440c0 39.8-32.2 72-72 72H168c-39.8 0-72-32.2-72-72V168c0-39.8 32.2-72 72-72H288V32c0-17.7 14.3-32 32-32zM208 384c-8.8 0-16 7.2-16 16s7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H208zm96 0c-8.8 0-16 7.2-16 16s7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H304zm96 0c-8.8 0-16 7.2-16 16s7.2 16 16 16h32c8.8 0 16-7.2 16-16s-7.2-16-16-16H400zM264 256a40 40 0 1 0 -80 0 40 40 0 1 0 80 0zm152 40a40 40 0 1 0 0-80 40 40 0 1 0 0 80zM48 224H64V416H48c-26.5 0-48-21.5-48-48V272c0-26.5 21.5-48 48-48zm544 0c26.5 0 48 21.5 48 48v96c0 26.5-21.5 48-48 48H576V224h16z"/></svg>
            </div>
            <div class="chat-bubble inline-block bg-gray-100 px-4 py-2 rounded-lg max-w-3/4 break-words">
              <span>${item.text}</span>
            </div>
          </div>`;
        list.insertAdjacentHTML("beforeend", responseHTML);
        formText.value = "";
        list.scrollTop = list.scrollHeight;
      })
      .catch(error => console.error('Error:', error));
  });
});

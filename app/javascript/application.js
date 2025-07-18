// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'menu-toggle';
import "@rails/ujs"


document.addEventListener("turbo:load", () => {
  const formText = document.querySelector("#user_input");
  const list = document.getElementById("conversation");
  const button_post = document.getElementById('button_post');

  // IDのbutton_postが無ければ抜ける
  if (!formText || !list || !button_post) return;

  // 重複登録を防ぐため、すでにイベントが登録済みなら抜ける
  if (button_post.dataset.listenerAdded === "true") return;

  // イベントリスナー追加済みマーク
  button_post.dataset.listenerAdded = "true";

  button_post.addEventListener('click', function(event) {
    event.preventDefault();

    if (formText.value.trim() === "") return;

    const characterType = new URLSearchParams(window.location.search).get("character_type");

    const url = `/chatbots/generate_text.json?user_input=${encodeURIComponent(formText.value)}&character_type=${encodeURIComponent(characterType)}`;
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
          </div>
        `;
        list.insertAdjacentHTML("beforeend", inputHTML);

        const character = characterType;
        const iconData = document.getElementById("character-icon-paths");
        const characterImagePaths = {
          cat: iconData.dataset.cat,
          oldman: iconData.dataset.oldman,
          alien: iconData.dataset.alien
        };

        const characterIconUrl = characterImagePaths[character];

        const responseHTML = `
          <div class="text-left flex items-start space-x-2">
            <div class="icon-container w-8 h-8 flex-shrink-0">
              <img src="${characterIconUrl}" alt="User Icon" class="w-full h-full rounded-full object-cover">
            </div>
            <div class="chat-bubble inline-block bg-gray-100 px-4 py-2 rounded-lg max-w-3/4 break-words">
              <span>${item.text}</span>
            </div>
          </div>
        `;

        list.insertAdjacentHTML("beforeend", responseHTML);
        formText.value = "";
        list.scrollTop = list.scrollHeight;
      })
      .catch(error => console.error('Error:', error));
  });
});

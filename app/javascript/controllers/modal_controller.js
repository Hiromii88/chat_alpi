import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "message", "confirm"]

  connect() {
    this.characterData = {
      cat: { message: "にゃんと話す？" },
      oldman: { message: "じぃと話す？" },
      alien: { message: "うちゅと話す？" }
    }
  }

  open(event) {
    const character = event.target.dataset.character
    const data = this.characterData[character]
    if (!data) return

    this.messageTarget.textContent = data.message
    this.confirmTarget.href = `/chatbots/show?character_type=${character}`
    this.modalTarget.classList.remove("hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
  }
}

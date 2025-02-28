import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    connect() {
        console.log("Post Controller connected!", this.element);
    }
    static targets = ["content", "readMore"];
    toggleReadMore(event) {
        event.preventDefault();

        const postId = event.currentTarget.dataset.postId;

        const contentElement = this.element.querySelector(`#post-content-${postId}`);
        const readMoreLink = this.element.querySelector(`#read-more-${postId}`);

        if (contentElement.dataset.expanded === "true") {
            contentElement.innerHTML = contentElement.dataset.truncate;
            readMoreLink.innerText = "Read More";
            contentElement.dataset.expanded = "false";
        } else {
            contentElement.innerHTML = contentElement.dataset.full;
            readMoreLink.innerText = "Read Less";
            contentElement.dataset.expanded = "true";
        }
    }
}
import { Controller } from "@hotwired/stimulus";
import debounce from "debounce";

export default class extends Controller {
    connect() {
        console.log('Table Controller connected!', this.element);
    }
    initialize() {
        console.log('Table Controller Initialized');
        this.submitFilter = debounce(this.submitFilter.bind(this), 300);
    }
    submitFilter() {
        console.log('submit filter called');
        this.element.requestSubmit();
    }

    deleteItem() {
        const myModalEl = document.querySelector('#modalDelete');
        const modal = new bootstrap.Modal(myModalEl, { keyboard: false });
        const errorMsg = document.querySelector('#formErrorStream');
        errorMsg.innerHTML = '';
        modal.show();

        const href = this.element.dataset.href;
        const deleteBtn = document.querySelector('#jsDeleteItem');
        deleteBtn.setAttribute(
            'href',
            href + '?authenticity_token=' + this.element.dataset.authenticityToken
        );

        deleteBtn.addEventListener('click', function (event) {
            modal.hide();
        });
    }

    sortByColumn(e) {
        console.log('sort by column triggered');
        const clickedBtn = e.currentTarget;
        const orderByField = document.querySelector('[data-order-by]');
        console.log(orderByField);
        orderByField.value = clickedBtn.value;
    }
}



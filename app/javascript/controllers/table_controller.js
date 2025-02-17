import { Controller } from '@hotwired/stimulus';
import debounce from 'debounce';
// Connects to data-controller="table"
export default class extends Controller {
	initialize() {
		console.log('hello');
		this.submitFilter = debounce(this.submitFilter.bind(this), 300);
	}

	submitFilter() {
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

		deleteBtn.addEventListener('click', function(event) {
			modal.hide();
		});
	}

	sortByColumn(e) {
		const clickedBtn = e.currentTarget;
		const orderByField = document.querySelector('[data-order-by]');
		console.log(orderByField);
		orderByField.value = clickedBtn.value;
	}

	submitForm() {
		console.log('hello');
		this.element.requestSubmit();
	}
}
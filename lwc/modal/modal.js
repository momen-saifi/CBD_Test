import { LightningElement, api } from 'lwc';

export default class Modal extends LightningElement {
    @api title;
    @api message;

    close() {
        const closeEvent = new CustomEvent('close');
        this.dispatchEvent(closeEvent);
    }
}
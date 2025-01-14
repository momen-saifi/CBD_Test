import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

export default class ContactCreator extends LightningElement {
    // Fields to be used in the form
    fields = [FIRSTNAME_FIELD, LASTNAME_FIELD, EMAIL_FIELD];

    handleSuccess(event) {
        const createdRecordId = event.detail.id;
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: `Contact created with ID: ${createdRecordId}`,
                variant: 'success',
            })
        );
    }
}
import { LightningElement } from 'lwc';

export default class Ffc_Invoicetable extends LightningElement {
    invoiceData = [
        {
            Amount: 23.73,
            InvoiceDate: '09/26/2024',
            InvoiceId: 'S197419231'
        },
        {
            Amount: 15.09,
            InvoiceDate: '07/26/2023',
            InvoiceId: 'S187265864'
        },
        {
            Amount: 20.82,
            InvoiceDate: '05/26/2023',
            InvoiceId: 'S185694129'
        }
    ];
}
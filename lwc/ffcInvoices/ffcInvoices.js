import { LightningElement } from 'lwc';

export default class FfcInvoices extends LightningElement {
    invoices = [
        { id: 1, date: '06/03/2023', invoiceId: 'S185956189', isAvailable: true },
        { id: 2, date: '09/03/2022', invoiceId: 'S179023096', isAvailable: false },
        { id: 3, date: '08/03/2022', invoiceId: 'S178291464', isAvailable: true },
        { id: 4, date: '05/03/2022', invoiceId: 'S176123060', isAvailable: true },
        { id: 5, date: '11/03/2019', invoiceId: 'S151746819', isAvailable: false }
    ];

    handleDownload(event) {
        const invoiceId = event.target.dataset.id;
        // Handle download action
        console.log(`Downloading invoice: ${invoiceId}`);
        // Add logic for downloading the invoice
    }
}
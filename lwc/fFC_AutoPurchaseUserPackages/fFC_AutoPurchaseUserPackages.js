import { LightningElement, track } from 'lwc';

export default class FFC_AutoPurchaseUserPackages extends LightningElement {
    @track isModalOpen = false;
    @track isEditModalOpen = false; // Control Edit modal visibility
    @track isCancelModalOpen = false; // Control Cancel modal visibility
    @track usageResponseData = []; // Data for datatable
    @track enableEditCancel = false; // Control enabling of Edit/Cancel buttons

    // Dummy Data for demonstration
    connectedCallback() {
        this.usageResponseData = [
            {
                ConsumerRechargeId: 'CR123',
                AgencyId: 'AG001',
                AgencyName: 'Agency A',
                Threshold: 100,
                Package_1: {
                    PackageId: 'PKG123',
                    Units: 50
                }
            },
            {
                ConsumerRechargeId: 'CR456',
                AgencyId: 'AG002',
                AgencyName: 'Agency B',
                Threshold: 200,
                Package_1: {
                    PackageId: 'PKG456',
                    Units: 100
                }
            },
            {
                ConsumerRechargeId: 'CR456',
                AgencyId: 'AG002',
                AgencyName: 'Agency B',
                Threshold: 200,
                Package_1: {
                    PackageId: 'PKG456',
                    Units: 100
                }
            }
        ];
    }

    // Define columns for lightning-datatable
    columns = [
        {
            label: 'Consumer Recharge ID',
            fieldName: 'ConsumerRechargeId',
            type: 'text'
        },
        {
            label: 'Agency ID',
            fieldName: 'AgencyId',
            type: 'text'
        },
        {
            label: 'Agency Name',
            fieldName: 'AgencyName',
            type: 'text'
        },
        {
            label: 'Threshold',
            fieldName: 'Threshold',
            type: 'number'
        },
        {
            label: 'View',
            type: 'button',
            typeAttributes: {
                label: 'View Details',
                name: 'view',
                tooltip: 'View record details',
                disabled: false,
                tabindex: '0'
            }
        },
        {
            label: 'Edit',
            type: 'button',
            typeAttributes: {
                label: 'Edit',
                name: 'edit',
                tooltip: 'Edit record',
                disabled: !this.enableEditCancel,
                tabindex: this.enableEditCancel ? '0' : '-1' // Styling the button
            },
            cellAttributes: {
                style: this.enableEditCancel ? '' : 'box-shadow: none; ',
                tabindex: this.enableEditCancel ? '0' : '-1'
            }
        },
        {
            label: 'Cancel',
            type: 'button',
            typeAttributes: {
                label: 'Cancel',
                name: 'cancel',
                tooltip: 'Cancel record',
                disabled: !this.enableEditCancel,
                tabindex: this.enableEditCancel ? '0' : '-1' // Styling the button
            },
            cellAttributes: {
                style: this.enableEditCancel ? '' : 'box-shadow: none;',
                tabindex: this.enableEditCancel ? '0' : '-1'
            }
        }
    ];

    // Handle row actions like View, Edit, and Cancel
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        switch (actionName) {
            case 'view':
                this.viewRowDetails(row);
                break;
            case 'edit':
                this.editRowDetails(row);
                break;
            case 'cancel':
                this.cancelRowAction(row);
                break;
            default:
                break;
        }
    }

    viewRowDetails(row) {
        this.selectedRowUsageDetailData = row.Package_1;
        this.isModalOpen = true;
    }

    editRowDetails(row) {
        this.selectedRowUsageDetailData = row.Package_1;
        this.isEditModalOpen = true;
    }

    cancelRowAction(row) {
        this.selectedRowUsageDetailData = row.Package_1;
        this.isCancelModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    closeEditModal() {
        this.isEditModalOpen = false;
    }

    closeCancelModal() {
        this.isCancelModalOpen = false;
    }
}
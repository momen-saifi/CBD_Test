public class TestGetAllRelatedRecords {
    @AuraEnabled
    public static void fetchSetupAuditTrailRecords() {
        // Parameters for the method
        String objectApiName = 'SetUpAuditTrail'; // Object API name for SetupAuditTrail
        List<String> fieldsAPINameList = new List<String>{
            'Action', 
            'Section', 
            'Object', 
            'UserId', 
            'CreatedDate', 
            'DisplayName'
        }; // Example field API names

        List<String> columnLabelsList = new List<String>{
            'Action', 
            'Section', 
            'Object', 
            'User ID', 
            'Created Date', 
            'Display Name'
        }; // Column labels

        String sortColumns = 'CreatedDate DESC'; // Sorting criteria
        String filterCriteria = ''; // Any filter criteria you want
        String hyperLinkFieldName = ''; // Hyperlink field name if applicable
        String recordsLimit = '100'; // Limit of records to fetch
        String orgName = ''; // Organization name or any identifier

        // Call the method in your controller
        String jsonData = SK_GenericDataTableCmpController.getAllRelatedRecords(
            objectApiName,
            fieldsAPINameList,
            columnLabelsList,
            sortColumns,
            filterCriteria,
            hyperLinkFieldName,
            recordsLimit,
            orgName
        );

        // Log the output
        System.debug('Fetched SetupAuditTrail Records JSON Data: ' + jsonData);
    }
}
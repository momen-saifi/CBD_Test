public class SK_SetUpAuditTrailController {
    
    @AuraEnabled
    public static completeWrapper findFilters() {
        // Create the wrapper for returning filter options
        completeWrapper returnWrapper = new completeWrapper();
        
        // Initialize the list for filter column options
        List<FilterColoumns> options = new List<FilterColoumns>();
        
        // Add filter for Action
        FilterColoumns col1 = new FilterColoumns('Action', '', 'Equals', 'text');
        options.add(col1);
        
        // Add filter for Created By Name
        FilterColoumns col2 = new FilterColoumns('CreatedBy.Name', '', 'Equals', 'text');
        options.add(col2);
        
        // Add filter for Created Date
        FilterColoumns col3 = new FilterColoumns('CreatedDate', '', 'Equals', 'date');
        options.add(col3);

        // Add filter for Section
        FilterColoumns col4 = new FilterColoumns('Section', '', 'Equals', 'Section'); // New Section filter
        options.add(col4);
        
        // Set the filters in the return wrapper
        returnWrapper.sFilters = options;
        
        return returnWrapper;
    }

    @AuraEnabled
    public static List<Opportunity> getOpportunities() {
        try {
            return [SELECT Id, Name FROM Opportunity ORDER BY Name];
        } catch (Exception e) {
            System.debug('Error fetching opportunities: ' + e.getMessage());
            throw new AuraHandledException('Error fetching opportunities: ' + e.getMessage());
        }
    }

    public class completeWrapper {
        @AuraEnabled
        public List<FilterColoumns> sFilters { get; set; }
        @AuraEnabled
        public List<String> orderByOptions { get; set; }
        @AuraEnabled
        public String selectedOrderByField { get; set; }
        @AuraEnabled
        public String selectedOrder { get; set; }

        // Constructor for completeWrapper
        public completeWrapper() {
            selectedOrderByField = 'Action';
            selectedOrder = 'ASC';
            orderByOptions = new List<String>{'Action', 'CreatedBy.Name', 'CreatedDate', 'Section'}; // Added Section to orderByOptions
            sFilters = new List<FilterColoumns>();
        }
    }
    
    public class FilterColoumns {
        @AuraEnabled
        public String selectedFilter { get; set; }
        @AuraEnabled
        public String filterValue { get; set; }
        @AuraEnabled
        public String fieldType { get; set; }
        @AuraEnabled
        public String filterSequence { get; set; } // Unused 
        @AuraEnabled
        public String selectedComparator { get; set; }

        // Constructor for FilterColoumns
        public FilterColoumns(String sFilter, String sFValue, String selectedComparator, String sFieldType) {
            this.selectedFilter = sFilter;
            this.selectedComparator = selectedComparator;
            this.filterValue = sFValue;
            this.fieldType = sFieldType;
        }
    }
}
public with sharing class LastModifiedComponentsController {
    @AuraEnabled(cacheable=true)
    public static List<ComponentData> fetchComponents(String objectName, Boolean useToolingApi, DateTime lastModifiedAfter) {
        List<ComponentData> results = new List<ComponentData>();
        
        // Define a map to hold the SOQL fields for each object type
        Map<String, String> objectFieldMapping = new Map<String, String>{
            'ApexClass' => 'Id, Name, LastModifiedDate',
            'ApexTrigger' => 'Id, Name, LastModifiedDate',
            'ApexPage' => 'Id, Name, LastModifiedDate',
            'AuraDefinitionBundle' => 'Id, LastModifiedDate',
            'Report' => 'Id, Name, LastModifiedDate',
            'Dashboard' => 'Id, DeveloperName , LastModifiedDate',
            'Layout' => 'Id, Name, LastModifiedDate',
            'CustomTab' => 'Id, Name, LastModifiedDate',
            'EmailTemplate' => 'Id, Subject, LastModifiedDate',
            'ProcessDefinition' => 'Id, Name, LastModifiedDate',
            'WorkflowRule' => 'Id, Name, LastModifiedDate',
            'ValidationRule' => 'Id, Name, LastModifiedDate',
            'CustomLabel' => 'Id, Name, LastModifiedDate',
            'Profile' => 'Id, Name, LastModifiedDate',
            'PermissionSet' => 'Id, Name, LastModifiedDate',
            'RecordType' => 'Id, Name, LastModifiedDate',
            'Flow' => 'Id, DeveloperName, LastModifiedDate',
            'ApprovalProcess' => 'Id, Name, LastModifiedDate',
            'DuplicateRule' => 'Id, Name, LastModifiedDate',
            'EmailService' => 'Id, Name, LastModifiedDate',
            'ExternalDataSource' => 'Id, MasterLabel, LastModifiedDate',
            'Site' => 'Id, Name, LastModifiedDate'
        };

        // Check if the object type is valid
        if (!objectFieldMapping.containsKey(objectName)) {
            throw new AuraHandledException('Invalid object name: ' + objectName);
        }

        // Construct the query
        String query = 'SELECT ' + objectFieldMapping.get(objectName) + ' FROM ' + objectName ;
        if (lastModifiedAfter != null) {
            query += ' WHERE LastModifiedDate > :lastModifiedAfter Limit 5';
        }

        try {
            if (useToolingApi) {
                // Use Tooling API to fetch data
                results = fetchFromToolingApi(query);
            } else {
                // Execute dynamic SOQL query using normal API
                List<SObject> records = Database.query(query);
                processRecords(results, records, objectName);
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching components: ' + e.getMessage());
        }

        return results;
    }

    // Fetch records using Tooling API via HTTP request
    private static List<ComponentData> fetchFromToolingApi(String query) {
        List<ComponentData> results = new List<ComponentData>();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint( 'https://oraqosoft7-dev-ed.develop.my.salesforce.com/'+'/services/data/v57.0/tooling/query?q=' + 
                        EncodingUtil.urlEncode(query, 'UTF-8'));
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + '00DdL000003TXho!AQEAQAAofHetVj5x14yW8qTMDigo_iAvVQe5IshMvopafOuX3wPpVKVkfJtT70jaSJVSEVq5UQqcmILSoU68AHF.wjMtdlQ5');
    
        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            // Parse the response body
            Map<String, Object> jsonResponse = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            
            // Ensure the records key exists and is a list
            if (jsonResponse.containsKey('records') && jsonResponse.get('records') instanceof List<Object>) {
                List<Object> records = (List<Object>)jsonResponse.get('records');
                
                // Process the result to extract ComponentData
                for (Object recordObj : records) {
                    Map<String, Object> record = (Map<String, Object>)recordObj; // Cast each record to Map
                    Map<String, Object> attributes = (Map<String, Object>)record.get('attributes'); // Cast to Map
                    String type = (String)attributes.get('type'); // Use the casted map
                    
                    // Handle LastModifiedDate conversion
                    String lastModifiedDateStr = (String)record.get('LastModifiedDate');
                    DateTime lastModifiedDate;

                    // Convert string to DateTime
                    if (lastModifiedDateStr != null) {
                        lastModifiedDate = parseISO8601ToDateTime(lastModifiedDateStr);
                    } else {
                        lastModifiedDate = null; // Handle null case if necessary
                    }

                    String displayName = getDisplayNameFromTooling(record, type);
                    results.add(new ComponentData((String)record.get('Id'), type, displayName, lastModifiedDate));
                }
            } else {
                System.debug('No records found or records is not a list');
                throw new AuraHandledException('No records found in Tooling API response.');
            }
        } else {
            System.debug('Error fetching from Tooling API: Status Code: ' + res.getStatusCode() + ', Response: ' + res.getBody());
            throw new AuraHandledException('Error fetching from Tooling API: ' + res.getBody());
        }

        return results;
    }

    // Helper method to parse ISO 8601 date to DateTime
    private static DateTime parseISO8601ToDateTime(String isoDate) {
        // Extract components from the ISO 8601 format
        String datePart = isoDate.substring(0, 10); // "2024-07-09"
        String timePart = isoDate.substring(11, 19); // "12:40:57"

        // Combine into a standard format
        String formattedDateTime = datePart + ' ' + timePart;

        // Parse and return as DateTime
        return DateTime.valueOf(formattedDateTime);
    }

    // Extract display name from Tooling API response
    private static String getDisplayNameFromTooling(Map<String, Object> record, String objectName) {
        if (objectName == 'ApexClass' || objectName == 'ApexTrigger' || objectName == 'ApexPage' ||
            objectName == 'Report' || objectName == 'Dashboard' || objectName == 'Layout' || 
            objectName == 'CustomTab' || objectName == 'ProcessDefinition' || 
            objectName == 'WorkflowRule' || objectName == 'ValidationRule' || 
            objectName == 'CustomLabel' || objectName == 'Profile' || 
            objectName == 'PermissionSet' || objectName == 'RecordType' || 
            objectName == 'ApprovalProcess' || objectName == 'DuplicateRule' || 
            objectName == 'EmailService' || objectName == 'Site') {
            return (String)record.get('Name');
        } else if (objectName == 'EmailTemplate') {
            return (String)record.get('Subject');
        } else if (objectName == 'Flow' || objectName == 'FieldSet') {
            return (String)record.get('DeveloperName');
        } else if (objectName == 'AuraDefinitionBundle') {
            return (String)record.get('Id'); // Aura components may not have a display name.
        } else if (objectName == 'ExternalDataSource') {
            return (String)record.get('MasterLabel');
        } else {
            return 'Unknown';
        }
    }

    // Helper method to process records and map fields according to object type
    private static void processRecords(List<ComponentData> results, List<SObject> records, String objectName) {
        for (SObject record : records) {
            String displayName = getDisplayName(record, objectName);
            DateTime lastModifiedDate = (DateTime)record.get('LastModifiedDate');
            results.add(new ComponentData(record.Id, objectName, displayName, lastModifiedDate));
        }
    }

    // Helper method to determine the display name based on the component type
    private static String getDisplayName(SObject record, String objectName) {
        if (objectName == 'ApexClass' || objectName == 'ApexTrigger' || objectName == 'ApexPage' ||
            objectName == 'Report' || objectName == 'Dashboard' || objectName == 'Layout' || 
            objectName == 'CustomTab' || objectName == 'ProcessDefinition' || 
            objectName == 'WorkflowRule' || objectName == 'ValidationRule' || 
            objectName == 'CustomLabel' || objectName == 'Profile' || 
            objectName == 'PermissionSet' || objectName == 'RecordType' || 
            objectName == 'ApprovalProcess' || objectName == 'DuplicateRule' || 
            objectName == 'EmailService' || objectName == 'Site') {
            return (String)record.get('Name');
        } else if (objectName == 'EmailTemplate') {
            return (String)record.get('Subject');
        } else if (objectName == 'Flow' || objectName == 'FieldSet') {
            return (String)record.get('DeveloperName');
        } else if (objectName == 'AuraDefinitionBundle') {
            return (String)record.get('Id'); // Aura components may not have a display name.
        } else if (objectName == 'ExternalDataSource') {
            return (String)record.get('MasterLabel');
        } else {
            return 'Unknown';
        }
    }

    public class ComponentData {
        @AuraEnabled public String Id { get; set; }
        @AuraEnabled public String type { get; set; }
        @AuraEnabled public String displayName { get; set; }
        @AuraEnabled public DateTime LastModifiedDate { get; set; }

        public ComponentData(String id, String type, String displayName, DateTime lastModifiedDate) {
            this.Id = id;
            this.type = type;
            this.displayName = displayName;
            this.LastModifiedDate = lastModifiedDate;
        }
    }
}
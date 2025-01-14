public with sharing class CsvFileUploadController {
    @AuraEnabled
    public static void saveCsvData(List<Map<String, String>> csvData) {
        List<MyCustomObject__c> recordsToInsert = new List<MyCustomObject__c>();

        for (Map<String, String> row : csvData) {
            MyCustomObject__c record = new MyCustomObject__c();
            record.Name = row.get('Name').trim(); // Remove any leading or trailing spaces from Name
            
            String valueStr = row.get('Value').replace('"', '').trim(); // Remove quotes and spaces around Value
            if (!String.isBlank(valueStr)) {
                try {
                    record.Value__c = Integer.valueOf(valueStr); // Convert cleaned value to integer
                } catch (Exception e) {
                    System.debug('Error converting value to integer: ' + valueStr);
                    throw new AuraHandledException('Invalid value in CSV: ' + valueStr);
                }
            }
            recordsToInsert.add(record);
        }

        // Insert records into Salesforce
        if (!recordsToInsert.isEmpty()) {
            insert recordsToInsert;
        }
    }
}
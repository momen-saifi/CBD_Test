public with sharing class RecordControler {
    @AuraEnabled
    public static Id saveRecord(Map<String, String> record) {
        Customer__c customer = new Customer__c();
        customer.Name = record.get('CustomerName');
        customer.Email__c = record.get('Email');
        customer.Mobile_No__c = record.get('Mobile');
        customer.Active__c = record.get('Status');

        try {
            upsert customer;
            return customer.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error saving record: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static Id updateRecord(Map<String, String> record) {
        try {
            Customer__c customer = [SELECT Id, Name, Email__c, Mobile_No__c, Active__c FROM Customer__c WHERE Id = :record.get('Id') LIMIT 1];
            customer.Name = record.get('CustomerName');
            customer.Email__c = record.get('Email');
            customer.Mobile_No__c = record.get('Mobile');
            customer.Active__c = record.get('Status');

            update customer;
            return customer.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating record: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteRecord(Id recordId) {
        try {
            Customer__c customer = [SELECT Id FROM Customer__c WHERE Id = :recordId LIMIT 1];
            delete customer;
        } catch (Exception e) {
            throw new AuraHandledException('Error deleting record: ' + e.getMessage());
        }
    }
}
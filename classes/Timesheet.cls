public class Timesheet{
 @AuraEnabled(cacheable=true)
    public static List<Timesheet__c> getTimesheetData() { // Replace 'Timesheet__c' with your actual custom object name.
        return [SELECT Id, Date__c,Hours_Logged__c FROM Timesheet__c];
    }
   
}
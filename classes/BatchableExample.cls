public class BatchableExample implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name FROM Contact');
    } 

    public void execute(Database.BatchableContext bc, List<Contact> cList) {
        for(Contact con : cList) {
            con.Status__c= 'Active';
        }
        update cList;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Job is finished');
    }
}
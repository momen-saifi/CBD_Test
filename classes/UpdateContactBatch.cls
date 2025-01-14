public class UpdateContactBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext BC) {
      
        return Database.getQueryLocator('SELECT Id FROM Contact');
    }

    public void execute(Database.BatchableContext BC, List<Contact> scope) {
        for(Contact con : scope) {
            con.Status__c = 'Active';
        }
        update scope;
    }

    public void finish(Database.BatchableContext BC) {
        System.debug('Contact records updated successfully');
    }
}
public class AccountProcessor {

    @future
    public static void countContacts(List<Id> accountIds) {
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accountId : accountIds) {
            Integer contactCount = [SELECT COUNT() FROM Contact WHERE AccountId = :accountId];
            accountsToUpdate.add(new Account(Id = accountId, Number_Of_Contacts__c = contactCount));
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
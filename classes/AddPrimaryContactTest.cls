@isTest
public class AddPrimaryContactTest {
    @isTest static void testAddPrimaryContact() {
        List<Account> nyAccounts = new List<Account>();
        List<Account> caAccounts = new List<Account>();
        
        for (Integer i = 0; i < 50; i++) {
            nyAccounts.add(new Account(Name = 'NY Account ' + i, BillingState = 'NY'));
            caAccounts.add(new Account(Name = 'CA Account ' + i, BillingState = 'CA'));
        }
        
        insert nyAccounts;
        insert caAccounts;
        
        Contact primaryContact = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'test@example.com');
        
        AddPrimaryContact job = new AddPrimaryContact(primaryContact, 'CA');
        
        Test.startTest();
        System.enqueueJob(job);
        Test.stopTest();
        
         List<Contact> insertedContacts = [SELECT Id, AccountId FROM Contact WHERE Email = 'test@example.com'];
        
        System.assertEquals(50, insertedContacts.size(), '50 Contact records should have been inserted');
        
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : caAccounts) {
            accountIds.add(acc.Id);
        }
        
        for (Contact con : insertedContacts) {
            System.assert(accountIds.contains(con.AccountId), 'Contact should be associated with an Account in CA');
        }
    }
}
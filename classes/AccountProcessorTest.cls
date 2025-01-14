@isTest
public class AccountProcessorTest {

    @isTest
    static void testCountContacts() {
        List<Account> testAccounts = new List<Account>();
        List<Contact> testContacts = new List<Contact>();

        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'Test Account ' + i);
            testAccounts.add(acc);

            for (Integer j = 0; j <= i; j++) {
                testContacts.add(new Contact(FirstName = 'Contact', LastName = 'Test ' + j, AccountId = acc.Id));
            }
        }

        insert testAccounts;
        insert testContacts;

        List<Id> accountIds = new List<Id>();
        for (Account acc : testAccounts) {
            accountIds.add(acc.Id);
        }

        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        List<Account> updatedAccounts = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id IN :accountIds];
        System.assertEquals(testAccounts.size(), updatedAccounts.size(), 'Number of accounts should match');

        for (Account acc : updatedAccounts) {
            Integer expectedContactCount = acc.Name.substring(acc.Name.lastIndexOf(' ') + 1).contains('Account') ? 0 : Integer.valueOf(acc.Name.substring(acc.Name.lastIndexOf(' ') + 1));
            System.assertEquals(expectedContactCount, acc.Number_Of_Contacts__c, 'Number of contacts should match');
        }
    }
}
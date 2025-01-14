@isTest
public class AccountVipTierUpdateControllerTest {

    @isTest
    static void testSendEmailVipTierChange_Success() {
       
        OrgWideEmailAddress orgWideEmail = [SELECT Id FROM OrgWideEmailAddress LIMIT 1];
        if (orgWideEmail == null) {
            System.debug('No Org-Wide Email Address found. Please create one in your org to run this test.');
            return;
        }

        User testUser = TestDataFactory.createTestUser();

        AccountVipTierUpdateController.EmailRequest request = new AccountVipTierUpdateController.EmailRequest();
        request.toAddresses = new List<String>{testUser.Email};
        request.subject = 'VIP Tier Change';
        request.body = 'Your VIP tier has been updated.';
        request.userNames = new List<String>{testUser.FirstName + ' ' + testUser.LastName};

        List<AccountVipTierUpdateController.EmailRequest> requests = new List<AccountVipTierUpdateController.EmailRequest>{request};

        Test.startTest();
        AccountVipTierUpdateController.sendEmailVipTierChange(requests);
        Test.stopTest();

        Integer expectedEmailCount = 1;
        Integer actualEmailCount = Limits.getEmailInvocations();
        System.assertEquals(expectedEmailCount, actualEmailCount, 'The number of emails sent should be 1.');
    }

    @isTest
    static void testSendEmailVipTierChange_MismatchedLists() {
        OrgWideEmailAddress orgWideEmail = [SELECT Id FROM OrgWideEmailAddress LIMIT 1];
        if (orgWideEmail == null) {
            System.debug('No Org-Wide Email Address found. Please create one in your org to run this test.');
            return;
        }

        User testUser = TestDataFactory.createTestUser();

        AccountVipTierUpdateController.EmailRequest request = new AccountVipTierUpdateController.EmailRequest();
        request.toAddresses = new List<String>{testUser.Email};
        request.subject = 'VIP Tier Change';
        request.body = 'Your VIP tier has been updated.';
        request.userNames = new List<String>{testUser.FirstName + ' ' + testUser.LastName, 'Extra User'};

        List<AccountVipTierUpdateController.EmailRequest> requests = new List<AccountVipTierUpdateController.EmailRequest>{request};

        Test.startTest();
        try {
            AccountVipTierUpdateController.sendEmailVipTierChange(requests);
            System.assert(false, 'Expected exception not thrown');
        } catch (AuraHandledException e) {
            System.assertEquals('The size of toAddresses and userNames lists must be the same.', e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void testSendEmailVipTierChange_NoOrgWideEmail() {
        User testUser = TestDataFactory.createTestUser();

        AccountVipTierUpdateController.EmailRequest request = new AccountVipTierUpdateController.EmailRequest();
        request.toAddresses = new List<String>{testUser.Email};
        request.subject = 'VIP Tier Change';
        request.body = 'Your VIP tier has been updated.';
        request.userNames = new List<String>{testUser.FirstName + ' ' + testUser.LastName};

        List<AccountVipTierUpdateController.EmailRequest> requests = new List<AccountVipTierUpdateController.EmailRequest>{request};

        Test.startTest();
        try {
            AccountVipTierUpdateController.sendEmailVipTierChange(requests);
            System.assert(false, 'Expected exception not thrown');
        } catch (AuraHandledException e) {
            System.assertEquals('Org-Wide Email Address not found', e.getMessage());
        }
        Test.stopTest();
    }
    /*
    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        
        // Create and insert a new user
        User u = new User(
            FirstName = 'Momen',
            LastName = 'Saifi',
            Email = 'momensaifi19@gmail.com',
            Username = 'momensaifi19@gmail.com' + System.currentTimeMillis(),
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = p.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert u;
*/
}
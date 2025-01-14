public class AccountCreationDemo {
    @AuraEnabled
    public static void createAccount() {
        try {
            // Create a new Account record
            Account newAccount = new Account();
            newAccount.Name = 'Test Account';
            newAccount.Industry = 'Technology';
            insert newAccount;

            // Log the success or perform other operations
            System.debug('Account created successfully: ' + newAccount.Id);
        } catch (Exception e) {
            System.debug('Error creating Account: ' + e.getMessage());
            throw new AuraHandledException('Failed to create Account.');
        }
    }
}
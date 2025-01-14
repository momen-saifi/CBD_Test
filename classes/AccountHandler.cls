public class AccountHandler {
    
     public static void insertAccount(Integer numAccounts) {
        List<Account> addAccounts = new List<Account>();
        
        Integer i = 1;
        
        while (i <= numAccounts) {
            Account newAccount = new Account(
                Name = 'Acme Inc ' + i,
                AccountNumber = 'A000' + i
            );
            addAccounts.add(newAccount);
            i++;
        }
        
       
        insert addAccounts;
    }
   
    public static Account insertNewAccount(String accountName) {
        try {
            if (String.isBlank(accountName)) {
                return null;
            }  
            Account newAccount = new Account();
            newAccount.Name = accountName;
            
            insert newAccount;
            
            return newAccount;
        } catch (DmlException e) {
          
            System.debug('An error occurred: ' + e.getMessage());
            return null;
        }
    }
}
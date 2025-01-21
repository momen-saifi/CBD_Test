public class CountContactHandler {
    public static void countcontactonaccount(List<Contact> conlist) {
        Set<Id> accId = new Set<Id>();
        for(Contact con: conlist){
            if(con.AccountId != null){
                accId.add(con.AccountId);
            }
        }
        
        if(accId != Null){
            List<Account> updateAccount = new List<Account>();
            List<Account> acclist =[SELECT Id,total_contact__c,(SELECT Id from Contacts) FROM Account WHERE Id IN: accId];
            if(acclist != Null){
                for(Account acc : acclist){
                    acc.total_contact__c = acc.Contacts.size();
                    updateAccount.add(acc);
                }
            }
            
            if(!updateAccount.IsEmpty()){
                Update updateAccount;
            }
        }
    }
}
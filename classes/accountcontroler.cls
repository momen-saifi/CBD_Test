public class accountcontroler {
    @AuraEnabled
    public static List<Account>getAccounts(){
        List<Account>acclist =New List<Account>();
        acclist=[Select Id,Name,Phone,	email__c from Account LIMIT 10];
        return accList;
    }
}
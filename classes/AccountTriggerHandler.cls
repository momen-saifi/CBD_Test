public class AccountTriggerHandler {
    Public static void findDuplicate(List<Account>annlist){
        for(Account acc: annlist){
            for(Account acc1: [select id,email__c from Account]) {
            if(acc.email__c==acc1.email__c){
             acc.addError('This is a duplicate email');   
            } 
        }
    }


  }
}
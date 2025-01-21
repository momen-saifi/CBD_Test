public class accounthandlerclass {
    public static void beforeUpdate(List<Account>newList){
        for(Account acc:newList){
        acc.Description ='Test description';

    }
        }
    public static void beforeInsert(List<Account>newList){
        for( Account acc : newList){
        for(Account acc1: [select id,email__c from Account]) {
            if(acc.email__c==acc1.email__c){
             acc.addError('This is a duplicate email');   
            }
        } 
    }
    }
    }
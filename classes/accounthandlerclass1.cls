public class accounthandlerclass1 {
    public static void beforeUpdate(List<Account>newList){
        for(Account acc:newList){
        acc.Description ='Test description';

    }
    }
    public static void beforeInsert(List<Account>newList){
         for(Account acc : newList){
        if( acc.Match_Billing_Address__c == True)
            acc.billingpostelcode__c = acc.shippingpostelcode__c;
       
       
    }
    }
    public static void updateRelatedopp(List <Account> accList,Map<Id,Account>oldMap){
        List<Opportunity>opplist = new list<Opportunity>();
        set<Id>accIds = new set<Id>();
        for(Account acc: acclist){
            if(acc.Active__c=='No' && oldMap.get(acc.Id).Active__c=='Yes'){
                accIds.add(acc.Id);
            }
        }
        
    }
    
}
public class AccountHandlerclass2 {
    public static void beforeInsert(List<Account>newList){
        for(Account acc: newList){
            if(acc.Industry !=null && acc.Industry=='Media'){
                acc.Rating = 'Hot';
            }
            
        }
        
    }
    public static void afterInsert(List<Account>newList){
        List<Opportunity> oppToBeInserted= new List<Opportunity>();
        for(Account acc: newList)
        {
            Opportunity opp= new Opportunity();
            Opp.Name=acc.Name;
            Opp.AccountId= acc.Id;
            Opp.StageName = 'Prospecting';
            Opp.CloseDate=System.Today();
            oppToBeInserted.add(Opp);
        }
        if(!oppToBeInserted.IsEmpty()){
            insert oppToBeInserted;
        }
    }
    public static void updatePhoneDescription(List<Account>newList,Map<Id,Account>oldmap){
        for(Account acc : newList){
            if(oldMap!=null && acc.phone!= oldMap.get(acc.Id).Phone){
                acc.Description='Phone is modified on account';
            }
            
        }
    }

}
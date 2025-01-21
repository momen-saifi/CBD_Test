public class CaseTriggerHandler {
    public static void populateLatestCase (List<Case> caseList){
        
        List<Account> accList =new List<Account>();
        for(Case cs : caseList){
            if(cs.AccountId != null){
                Account acc =new Account();
                acc.id =cs .AccountId;
                acc.latestcasenumber__c = cs.CaseNumber;
                accList.add(acc);
            }
        }
        if(!accList.isEmpty())
        update accList;
        
    }

}
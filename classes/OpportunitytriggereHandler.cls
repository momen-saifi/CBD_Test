public class OpportunitytriggereHandler {
    public static void populateLatestOppAmount(List<Opportunity>oppList){
        List<Account>acclist = new list<Account>();
        for(Opportunity opp :OppList){
            if(opp.Amount != null && opp.AccountId != null){
                Account acc = new Account();
                acc.Id = opp.AccountId;
                acc.Latestoppamount__c = opp.Amount;
                acclist.add(acc);
            }
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
    public static void CreatTask(List<Opportunity>oppList,Map<Id,Opportunity> OldMap){
        List<Task> tasklist = new List<Task>();
        for(Opportunity opp : oppList){
            if(opp.StageName!=oldMap.get(opp.Id).StageName){
                Task tsk = New Task();
                tsk.WhatId = opp.Id;
                tsk.Subject ='Demo';
                tsk.Priority='Normal';
                tsk.Status = 'Not Started';
                tsk.OwnerId=opp.OwnerId;
                taskList.add(tsk);
            }
 
        }
        if(!tasklist.isEmpty()){
            insert tasklist;
        }
        
    }
    

}
public class OpportunityTriggerHandlerT {
    public static void createTask(List<Opportunity> oppRec){
        List<Task> tList = new List<Task>();
        
        for(Opportunity opp : oppRec){
            if(opp.StageName == 'Closed Won'){
                Task tsk = new Task();
                tsk.WhatId = opp.Id;
                tsk.OwnerId = opp.OwnerId;
                tsk.Subject = 'Split the revenue';
                tsk.Priority = 'High';
                tsk.Status = 'Not Started';
                tList.add(tsk);
            }
        }
        
        if (!tList.isEmpty()) {
            insert tList;
        }
    }
 
    public static void updateOpportunity(List<Opportunity> opList, Map<Id, Opportunity> opMap) {
        for (Opportunity op : opList) {
            if (opMap.get(op.Id).StageName != op.StageName) {
                op.Amount = op.Probability * op.ExpectedRevenue;
                
            }
        }
    
}

}
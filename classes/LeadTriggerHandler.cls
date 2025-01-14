public class LeadTriggerHandler {
     public static void handleActivitiesAfterUpdate(List<Lead> newRecords){
        List<Task> taskListToInsert = new List<Task>();
        for(Lead leadRec : newRecords){
           
                Task taskRecord = new Task();
                taskRecord.Priority = 'High';
                taskRecord.OwnerId = leadRec.OwnerId;
                taskRecord.Description = 'Follow up with new Lead';
                taskRecord.Status = 'Not Started';
                taskRecord.Subject = 'Follow up';
                taskRecord.WhoId = leadRec.Id;
                taskListToInsert.add(taskRecord);
            
        }
        if(!taskListToInsert.isEmpty()){
            insert taskListToInsert;
        }
    }


}
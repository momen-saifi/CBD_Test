@isTest
public class OpportunityTriggerHandlerTestT {

    @isTest
    public static void testCreateTask() {
        List<Opportunity> oppList = new List<Opportunity>();
        
        for (Integer i = 0; i < 5; i++) {
            Opportunity opp = new Opportunity(
                Name = 'Test Opportunity ' + i,
                StageName = 'Closed Won',
                CloseDate = Date.today(),
                OwnerId = UserInfo.getUserId()
            );
            oppList.add(opp);
        }
        
        Test.startTest();
        insert oppList;
        Test.stopTest();
        
        List<Task> tasks = [SELECT Id, Subject, Priority, Status, WhatId FROM Task WHERE Subject = 'Split the revenue'];
        System.assertEquals(5, tasks.size(), 'Five tasks should have been created.');
        
        for (Task t : tasks) {
            System.assertEquals('High', t.Priority, 'Task priority should be High');
            System.assertEquals('Not Started', t.Status, 'Task status should be Not Started');
            System.assert(t.WhatId != null, 'Task WhatId should be populated');
        }
    }
}
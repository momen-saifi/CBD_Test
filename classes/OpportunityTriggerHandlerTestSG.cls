@isTest
public class OpportunityTriggerHandlerTestSG {
    @isTest
    public static void updateDescTest() {
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i = 1; i <= 5; i++) {
            Opportunity opp = new Opportunity();
            opp.Name = 'TestOpp' + i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today();
            opp.Amount = 200000;
            oppList.add(opp);
        }
        
        Test.startTest();
        insert oppList;
        Test.stopTest();
        
        List<Opportunity> updatedOppList = [SELECT Id, Description FROM Opportunity WHERE Id=:oppList[0].ID];
        
       
        
            
        System.assertEquals('Hot Opportunity', updatedOppList[0].Description);
            
        
    }
}
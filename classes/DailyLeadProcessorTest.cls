@isTest
public class DailyLeadProcessorTest {
    @isTest static void testDailyLeadProcessor() {
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(FirstName = 'Test', LastName = 'Lead' + i, Company = 'Test Company', LeadSource = null));
        }
        insert leads;
        
        String CRON_EXP = '0 0 0 * * ?'; 
        String jobId = System.schedule('Test DailyLeadProcessor', CRON_EXP, new DailyLeadProcessor());
        
        Test.startTest();
        DailyLeadProcessor processor = new DailyLeadProcessor();
        processor.execute(null); 
        Test.stopTest();
        
         List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        
        System.assertEquals(200, updatedLeads.size(), '200 Lead records should have been updated with LeadSource = Dreamforce');
    }
}
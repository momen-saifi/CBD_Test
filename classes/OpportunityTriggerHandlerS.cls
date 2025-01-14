public class OpportunityTriggerHandlerS {
    public static void createContact(List<Opportunity> oppRes){
        
        List<Contact> contactsToInsert = new List<Contact>();

    for (Opportunity opp : oppRes) {
        if (opp.StageName == 'Closed Won') {
            Contact newContact = new Contact();
            newContact.LastName = 'New Contact'; 
            newContact.AccountId = opp.AccountId; 
            
           
            newContact.Email = opp.Account.Email__c;
            newContact.Phone = opp.Account.Phone;
            
           
            
            contactsToInsert.add(newContact);
        }
    }

    if (!contactsToInsert.isEmpty()) {
        insert contactsToInsert;
    }
    }

}
public without sharing class AccountVipTierUpdateController {
       
    
    @InvocableMethod
    public static void sendEmailVipTierChange(List<EmailRequest> requests){
        List<Messaging.singleEmailMessage> emails=new List<Messaging.singleEmailMessage>();
        // Retrieve the Org-Wide Email Address ID
        OrgWideEmailAddress[] orgWideEmail= [Select Id, Address, DisplayName from OrgWideEmailAddress limit 1];
        if(orgWideEmail.isEmpty()){
            throw new AuraHandledException('Org-Wide Email Address not found');
        }
       
        for (EmailRequest request : requests) {
            if (request.toAddresses.size() != request.userNames.size()) {
                throw new AuraHandledException('The size of toAddresses and userNames lists must be the same.');
            }
            for (Integer i = 0; i < request.toAddresses.size(); i++) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setOrgWideEmailAddressId(orgWideEmail[0].Id);
                email.setToAddresses(new List<String>{request.toAddresses[i]});
                email.setSubject(request.subject);
                String personalizedBody = 'Hello ' + request.userNames[i] + ', \n\n' + request.body;
                System.debug('Email body: ' + personalizedBody);
                email.setPlainTextBody(personalizedBody);
                emails.add(email)
;
            }
            
        }
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }
    public class EmailRequest {
        @InvocableVariable
        public List<String> toAddresses;
        @InvocableVariable
        public String subject;
        @InvocableVariable
        public String body;
        @InvocableVariable
        public List<String> userNames;
    }
    
}
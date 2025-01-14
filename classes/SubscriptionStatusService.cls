@RestResource(urlMapping='/SubscriptionStatus/*')
global class SubscriptionStatusService {
    
    @HttpGet
    global static SubscriptionStatusResponse getSubscriptionStatus() {
        // Get the request parameters
        RestRequest req = RestContext.request;
        String username = req.headers.get('username');
        String orgId = req.headers.get('orgId');
        system.debug('username--->'+ username);
        system.debug('orgId--->'+ orgId);
        
        // Check if parameters are not null
        if (orgId == null || username == null) {
            RestContext.response.statusCode = 400; // Bad Request
            return new SubscriptionStatusResponse('Missing orgId or username parameter');
        }
        
        // Query the cbdsubscription object
       // CBDSubsciption__c subscription;
        /*try {
           // subscription = [SELECT Is_Subscriptin_Expired__c 
             //               FROM CBDSubsciption__c 
               //             WHERE Salesforce_ORG_ID__c = :orgId AND Salesforce_Username__c = :username
                 //           LIMIT 1];
        } catch (Exception e) {
            RestContext.response.statusCode = 500; // Internal Server Error
            return new SubscriptionStatusResponse('unsubscribed');
        }*/
        
        // Check if the subscription is expired
        String subscription= null;
        if (subscription != null) {
            return new SubscriptionStatusResponse('subscribed');
        } else {
            return new SubscriptionStatusResponse('unsubscribed');
        }
    }
    
    global class SubscriptionStatusResponse {
        public String status;
        
        public SubscriptionStatusResponse(String status) {
            this.status = status;
        }
    }
}
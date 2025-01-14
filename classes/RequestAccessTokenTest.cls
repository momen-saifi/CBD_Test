public with sharing class RequestAccessTokenTest {
    
    public class JSONWrapper
    {
        // here rows is the name of field in json this variable should be
        public string access_token ;
        public string refresh_token;
        public string instance_url ; 
    }

    //Method to request acess token for authenticated SF org
    public static JSONWrapper get(string authCode,String orgId) {
        
    
      //  App_Infos__c ap = DBUtils.getAppInfo();
        String clientId = '3MVG9GCMQoQ6rpzRe.V.cEI9gHZIjz1as0O3FiPB6aBz7cmCeik7cgJbu5A2hFO0ssOaVu0JH4sxOB__JTnks';
        String clientSecret = 'F91AF8BC926468784F0DFF5EC5E762E139873CABE3A387805E9B4706B365BA85';        
        String redirectionurl = 'https://oraqosoft7-dev-ed.develop.my.salesforce.com/apex/OauthDemoRedirectionTest';
        String authorizationCode =authCode;
        System.debug('redirectionurl: '+redirectionurl);
        String reqbody = 'client_id='+clientId+'&client_secret='+clientsecret+'&grant_type=authorization_code&code='+authorizationCode+'&redirect_uri='+redirectionurl;
        
       // SFDC_Org_Info__c orgInfo = DBUtils.getOrg(orgId);        
        //String urlPrefix = DBUtils.getUrl(orgInfo.Org_Type__c);
        
        HttpRequest req1 = new HttpRequest();    
        //req1.setTimeout(120000);
        req1.setHeader('Accept', 'application/json');
        req1.setHeader('Content-type', 'application/x-www-form-urlencoded');
        req1.setBody(reqbody);
        req1.setMethod('POST');
        // web server flow request
        req1.setEndpoint('https://login.salesforce.com'+'/services/oauth2/token');
        String response = '';
        JSONWrapper jsonDataWrapper = new JSONWrapper();
        try{
            Http h = new Http();
            HttpResponse httpResponse = h.send(req1);
            if (httpResponse.getStatusCode() == 200 ) {                
                response = JSON.serializePretty( JSON.deserializeUntyped(httpResponse.getBody()) );  
                jsonDataWrapper = (JSONWrapper)JSON.deserialize(response,JSONWrapper.class);
                
                // creating remote site settings dynamically                
              //  RemoteSetting.createRemoteSiteSettings(Jsondatawrapper.instance_url);
            } 
            else {  
                throw new CalloutException('{"errorDescription":"'+httpResponse.getBody()+'","error":"Unauthorized endpoint"}');  
            }             
        }
        catch( System.Exception e) {
            System.debug(e.getMessage());
            System.debug('ERROR: '+ e.getStackTraceString());  
            throw e;    
        }
        return Jsondatawrapper;
    }    
}
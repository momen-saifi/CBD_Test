public with sharing class OauthDemoRedirectionCtrlTest {
    public string  authId {get;set;}
    public RequestAccessTokenTest.JSONWrapper wrapperResponse{get;set;}
    public Boolean isAuthorize{get;set;}
    public String msg{get;set;}
    public String orgId;
    public OauthDemoRedirectionCtrlTest()
    {
        authId = ApexPages.currentPage().getParameters().get('code');
        orgId = ApexPages.currentPage().getParameters().get('state');
        
        System.debug('Received authId' + authId);
        System.debug('Received orgId' + orgId );
        
        
        orgId = orgId!=null?orgId.escapeHtml4():'';
        authId = authId!=null ? authId.escapeHtml4():'';
        isAuthorize = false;
        
        //System.debug(URL.getSalesforceBaseUrl().toExternalForm());
        // fetching access token on the basis of auth id.
        wrapperResponse = new RequestAccessTokenTest.JSONWrapper();
        try{
            wrapperResponse = RequestAccessTokenTest.get(authId.escapeHtml4(),orgId.escapeHtml4());
            isAuthorize = true;
            msg = 'Authorization have been completed!';
            System.debug('Authorization successful. Access Token: ' + wrapperResponse.access_token);
        }
        catch(Exception e){
            
            String error = e.getMessage();
            System.debug('Error occurred during authorization: ' + error);
         //   error = error.replace('error_description', 'errorDescription');
            error = error.indexOf('errorDescription')>=0?error:'{"errorDescription":"'+error+'"}';
            Auth_Wrap obj = (Auth_Wrap)JSON.deserialize(error, Auth_Wrap.class);
            msg = obj.errorDescription;
            System.debug('error description: ' + obj.errorDescription);
        }
    }
    
  /*  public PageReference redirectBack()
    {
        PageReference pageRedirect;
        //String orgRecordId = DBUtils.getOrgTemp().OrgRecordId__c;
        try {
            String recordId = orgId.escapeHtml4();
            SFDC_Org_Info__c orgauth = new SFDC_Org_Info__c();
            orgauth.Id = orgId.escapeHtml4();
            orgauth.AccessToken__c = wrapperResponse.access_token ;
            orgauth.RefreshToken__c = wrapperResponse.refresh_token ;
            orgauth.Instance_URL__c = wrapperResponse.instance_url ;        
            orgauth.Authorised__c = true;
            orgauth.Status__c= 'Authorized';
            orgauth.Authorized_Date__c = System.now();
            orgauth.AuthorizedBy__c= UserInfo.getName();
            SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.UPDATABLE, new SFDC_Org_Info__c[]{orgauth});
            update securityDecision.getRecords();
            System.debug('SFDC_Org_Info__c record updated successfully.');
            String appUrl = '/lightning/r/SFDC_Org_Info__c/' + recordId + '/view?authId=' + authId.escapeHtml4();
            //String appUrl = '/lightning/n/DevOps_Center?authId='+authId.escapeHtml4();
            pageRedirect = new PageReference(appUrl);
            System.debug('Redirecting to: ' + appUrl);
        } catch (Exception e) {
            new LogException()
                .log(e);
           System.debug('Error occurred during redirect: ' + e.getMessage());
        }
        return pageRedirect;
    }
    */
    public class Auth_Wrap{
        public String error;
        public String errorDescription;
    }
}
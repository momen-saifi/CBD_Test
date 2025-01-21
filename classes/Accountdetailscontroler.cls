public without sharing class Accountdetailscontroler {
     @AuraEnabled
    public static List<Account> getaccountsdetails(){
        List<Account>acclist =New List<Account>();
       acclist=[Select Id, Name, email__c from Account Limit 10];
        return acclist;
    }
    
    @AuraEnabled
    public static string deleteRecord(String recordID){
        try{
              List<Account>acclist =New List<Account>();
        acclist=[Select Id from Account where id=:recordID];
        account acc = new account();
        DELETE acclist;
        return 'Deleted successfully';
        }
       catch(System.DMLException e) {
            system.debug('error :'+e.getMessage());
           return e.getMessage();
        } 
      
    }
    
      @AuraEnabled
    public static String  sendEmail(List<string> Selectedemaillist){
        try{
            
            List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
            // List<String> address = new list<string>{'sani@hicglobalsolutions.com'};
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject('Oraqosoft Solutions');
            mail.setplaintextbody('Welcome toOraqosoft Solutions');
            mail.setToAddresses(Selectedemaillist);
            emailList.add(mail);
            
            if(!emailList.isEmpty()){
                Messaging.sendEmail(emailList);
            }	
            return 'Email send successfully';
        }
        catch(System.DMLException e) {
            system.debug('error :'+e.getMessage());
            return e.getMessage();
        } 
    }
     
    

     @AuraEnabled
    public static AccountDataTableWrapper getAccountData(Integer pageNumber, Integer pageSize) {
         
        //Offset for SOQL
        Integer offset = (pageNumber - 1) * pageSize;
         
        //Total Records
        Integer totalRecords = [SELECT COUNT() FROM Account];
        Integer recordEnd = pageSize * pageNumber;
 
        //Instance of Contact DataTable Wrapper Class
        AccountDataTableWrapper objDT =  new AccountDataTableWrapper();  
        objDT.pageSize = pageSize;
        objDT.pageNumber = pageNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.acclist = [SELECT Id, Name, email__c FROM Account ORDER BY Name LIMIT :pageSize OFFSET :offset];
        return objDT;
    }
     
    //Wrapper Class For Contact DataTable  
    public class AccountDataTableWrapper {
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public List<Account> acclist {get;set;}
    }
}
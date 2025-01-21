public class studentcontroler {
@AuraEnabled
    public static List<student__c>getStudents(){
        List<student__c>stdlist =new List<student__c>();
        stdlist=[Select ID,Name,email__c,student_phone_no__c,parent_phone_no__c from student__c Limit 10 ];
        
        return stdlist;
        
    }
}
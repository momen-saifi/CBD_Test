public class EmployeHandlerclass {
    public static void beforeDelete( List<employe__c>oldList){
        for(employe__c emp: oldList){
             if(emp.Active__c==True)  {
               emp.addError('Active employe can not be deleted');
                
            } 
            
        }
    }
    
}
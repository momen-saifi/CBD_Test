public class ParentHandlerclass {
    public static void afterInsert(List<Parent__c>newList){
          List<student__c>stuToBeInserted=new List<student__c>();
        for(Parent__c par : newList){
            Student__c stu= New Student__c();
            stu.Name = par.Name ;
            Stu.Id =par.id;
            stu.CITY__c ='KANPUR';
            stuToBeInserted.add(stu);
        
    }
        if(!stuToBeInserted.IsEmpty()){
            insert stuToBeInserted;
        }

}
}
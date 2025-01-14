public class DemoFor {
   
    @AuraEnabled
    public static void demo(){
         Integer t=2;
    Integer i=1;
    for (i=1; i<= 10; i++){
        
        System.debug('t *'+i+ '='+ t*i);
    }
    }

}
@isTest
public class AccountTriggerHandlerTest {
    @isTest
    public static void updateRatingTest(){
        List<Account> accList = new List<Account>();
        
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Industry = 'Energy';
            accList.add(acc);
        }
     	Test.startTest();
        insert accList;
        Test.stopTest();
        
        List<Account> updateAccList = [Select Id ,Rating from Account where id = :accList[0].id];
        System.assertEquals('Hot',updateAccList[0].Rating);
    }

}
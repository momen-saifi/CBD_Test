public class DemoFor {
    Integer t=10;
    Integer i=1;
    public void demo(){
    for (i=1; i<= 10; i++){
        
        System.debug('t *'+i+ '='+ t*i);
    }
    }
    public void demo1(){
        for(i=2; i<=10; i++ ){
            system.debug('t*'+i+'='+t*i);
        }
    }
    public  static void fatchAccount(){
        List<Account>Accountlist1 =[Select Id, Name from Account Limit 5];
        //system.debug('Accountlist1: '+ Accountlist1);
List<Contact> contactList = new List<Contact>();
        for(Account accountList : Accountlist1){
           // system.debug('accountList: '+ accountList);
            if(accountList.Name == 'Test2'){
                system.debug('accountList: '+ accountList);

            }
          for (Integer i = 1; i <= 5; i++) {
            Contact con = new Contact(
                FirstName = 'FirstName' + i,
                LastName = accountList.Name + '_Contact' + i,
                AccountId = accountList.Id
            );
            contactList.add(con);
        }
    }
    if (!contactList.isEmpty()) {
        insert contactList;
        System.debug('Inserted Contacts: ' + contactList);
    }

        }
    }
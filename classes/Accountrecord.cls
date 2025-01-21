public class Accountrecord {
    
    public List<Account> getaccountrecord(){
         map<Id,Account>accmap = new map<Id,Account>();
        
        List<Account>acclist = new list<Account>();
        acclist=[select Id,Name, email__c from Account limit 10];
        
        List<Account>newacc = new list<Account>();
        for(Account acc: acclist){
            newacc.add(acc);
            accmap.put(acc.id,acc);
            
          account accnt =   accmap.get(acc.id);
           // system.debug(newacc + 'this is newacc');
           // system.debug(accmap + 'this is accmap');
           // system.debug('This is acc' + acc);
            //system.debug('This is data in accmap' +accnt );
        }
        
        return newacc;
        
       
    }

}
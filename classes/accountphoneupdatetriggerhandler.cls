public class accountphoneupdatetriggerhandler {
    public static void updateAccDeceOnPhoneUpdate (List<Account>acclist, Map<Id,Account>oldAccMap){
        for(Account acc: acclist){
            if(acc.Phone != oldAccMap.get(acc.Id).Phone){
                acc.Description ='Phone is Updated! Old Value'+ oldAccMap.get(acc.Id).Phone + '& New Value:'+acc.Phone;
            }
        }
        
    }

}
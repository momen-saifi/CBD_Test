public class AccountTriggerHandler {
    public static void updateRating(List<Account> accList){
        for(Account acc : accList){
            if(acc.Industry == 'Media' || acc.Industry == 'Energy'){
                acc.Rating = 'Hot';
            }
        }
    }
}
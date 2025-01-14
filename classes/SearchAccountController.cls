public with sharing class SearchAccountController {
    public SearchAccountController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountData(String searchKey){
        String target = '%'+searchKey+'%';
        List<Account> accList= [Select Id, Name, AccountNumber From Account Where Name like :target ];
        return accList;
    }
}
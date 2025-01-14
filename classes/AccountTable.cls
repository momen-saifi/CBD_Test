public with sharing class AccountTable {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String searchKey) {
        if (String.isBlank(searchKey)) {
            return [SELECT Id, Name, Industry, Phone, Website FROM Account ORDER BY Name LIMIT 50];
        } else {
            String searchKeyVal = '%' + searchKey + '%';
            return [
                SELECT Id, Name, Industry, Phone, Website
                FROM Account
                WHERE Name LIKE :searchKeyVal OR Industry LIKE :searchKeyVal
                ORDER BY Name
            ];
        }
    }

    @AuraEnabled
    public static void deleteAccounts(List<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) {
            throw new AuraHandledException('Error: No valid Account Ids provided for deletion.');
        }

        Database.delete(accountIds, false);
    }

    @AuraEnabled
    public static void updateAccount(Account account) {
        if (account == null || String.isBlank(account.Id)) {
            throw new AuraHandledException('Error: No valid Account Id provided for update.');
        }

        Database.update(account, false);
    }

    @AuraEnabled(cacheable=false)
    public static List<Account> getRelatedContacts(List<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) {
            throw new AuraHandledException('Error: No valid Account Ids provided for retrieving related contacts.');
        }

        List<Account> accountsWithContacts = [
            SELECT Id, Name, (SELECT Id, Name, Email, Phone FROM Contacts)
            FROM Account 
            WHERE Id IN :accountIds
        ];
        return accountsWithContacts;
    }
}
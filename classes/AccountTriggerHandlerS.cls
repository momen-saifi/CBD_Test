public class AccountTriggerHandlerS {

    public static void updateBillingAddress(List<Account> accRec) {
        for (Account acc : accRec) {
            if (acc.BillingCity == 'Mumbai') {
                acc.BillingCity = 'Delhi';
            }
        }
    }

    public static void matchBillingAddress(List<Account> accRec) {
        for (Account acc : accRec) {
            if (acc.BillingPostalCode != acc.ShippingPostalCode) {
                acc.addError('Billing address postal code does not match with shipping address postal code.');
            }
        }
    }

    public static void updateEmail(List<Account> accRec) {
        Set<Id> accountIdSet = new Set<Id>();
        for (Account acc : accRec) {
            accountIdSet.add(acc.Id);
        }
        
        Map<Id, List<Contact>> accountContactsMap = new Map<Id, List<Contact>>();
        for (Contact con : [SELECT Id, AccountId, Email FROM Contact WHERE AccountId IN :accountIdSet]) {
            if (!accountContactsMap.containsKey(con.AccountId)) {
                accountContactsMap.put(con.AccountId, new List<Contact>());
            }
            accountContactsMap.get(con.AccountId).add(con);
        }
        
        List<Contact> contactsToUpdate = new List<Contact>();
        for (Account acc : accRec) {
            if (accountContactsMap.containsKey(acc.Id)) {
                for (Contact con : accountContactsMap.get(acc.Id)) {
                    if (con.Email != acc.Email__c) { 
                        con.Email = acc.Email__c;
                        contactsToUpdate.add(con);
                    }
                }
            }
        }
        
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }

    public static void updateMailingAddress(List<Account> accRec) {
        Set<Id> idSet = new Set<Id>();
        for (Account acc : accRec) {
            idSet.add(acc.Id);
        }
        
        Map<Id, List<Contact>> mapRec = new Map<Id, List<Contact>>();
        for (Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :idSet]) {
            if (!mapRec.containsKey(con.AccountId)) {
                mapRec.put(con.AccountId, new List<Contact>());
            }
            mapRec.get(con.AccountId).add(con);
        }
        
        List<Contact> contactsToUpdate = new List<Contact>();
        for (Account acc : accRec) {
            if (mapRec.containsKey(acc.Id)) {
                for (Contact c : mapRec.get(acc.Id)) {
                    c.MailingStreet = acc.BillingStreet;
                    c.MailingCity = acc.BillingCity;
                    c.MailingState = acc.BillingState;
                    c.MailingPostalCode = acc.BillingPostalCode;
                    c.MailingCountry = acc.BillingCountry;
                    contactsToUpdate.add(c);
                }
            }
        }
        
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }

    public static void updateContactName(List<Account> accRec) {
        Set<Id> idSet = new Set<Id>();
        for (Account acc : accRec) {
            idSet.add(acc.Id);
        }
        
        Map<Id, List<Contact>> mapRec = new Map<Id, List<Contact>>();
        for (Contact con : [SELECT Id, AccountId, LastName FROM Contact WHERE AccountId IN :idSet]) {
            if (!mapRec.containsKey(con.AccountId)) {
                mapRec.put(con.AccountId, new List<Contact>());
            }
            mapRec.get(con.AccountId).add(con);
        }
        
        List<Contact> contactsToUpdate = new List<Contact>();
        for (Account acc : accRec) {
            if (mapRec.containsKey(acc.Id)) {
                for (Contact c : mapRec.get(acc.Id)) {
                    c.LastName = acc.Name;
                    contactsToUpdate.add(c);
                }
            }
        }
        
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }

    public static void deleteContactAndOpportunity(List<Account> accRec) {
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : accRec) {
            accountIds.add(acc.Id);
        }
        
        List<Contact> contactsToDelete = [SELECT Id FROM Contact WHERE AccountId IN :accountIds];
        delete contactsToDelete;
        
        List<Opportunity> opportunitiesToDelete = [SELECT Id FROM Opportunity WHERE AccountId IN :accountIds];
        delete opportunitiesToDelete;
    }
}
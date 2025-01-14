public class ContactTriggerHandlerS {

    public static void updateLastName(List<Contact> conRecords) {
        for (Contact con : conRecords) {
            if (con.LastName == 'XYZ') {
                con.LastName = 'ABC';
            }
        }
    }
    
    public static void preventDuplicateRecord(List<Contact> conRecords) {
        Set<String> emailSet = new Set<String>();
        
        for (Contact con : conRecords) {
            if (con.Email != null) {
                emailSet.add(con.Email);
            }
        }
        
        Map<String, Contact> existingContactsMap = new Map<String, Contact>(
            [SELECT Id, Email FROM Contact WHERE Email IN :emailSet]
        );
        
        for (Contact con : conRecords) {
            if (con.Email != null && existingContactsMap.containsKey(con.Email)) {
                con.addError('A contact with this email already exists.');
            }
        }
    }
    
    public static void firstNameNotEqualLastName(List<Contact> conRecords) {
        for (Contact con : conRecords) {
            if (con.LastName == con.FirstName) {
                con.addError('firstName and lastName cannot be same');
            }
        }
    }
    
    public static void preventDuplicateRecord1(List<Contact> conRec) {
        Set<String> emailSet = new Set<String>();
        Set<String> phoneSet = new Set<String>();
        
        for (Contact con : conRec) {
            if (con.Email != null) {
                emailSet.add(con.Email);
            }
            if (con.Phone != null) {
                phoneSet.add(con.Phone);
            }
        }
        
        Set<String> existingEmails = new Set<String>();
        Set<String> existingPhones = new Set<String>();
        
        for (Contact existingContact : [
            SELECT Email, Phone FROM Contact WHERE Email IN :emailSet OR Phone IN :phoneSet
        ]) {
            existingEmails.add(existingContact.Email);
            existingPhones.add(existingContact.Phone);
        }
        
        for (Contact con : conRec) {
            if ((con.Email != null && existingEmails.contains(con.Email)) || 
                (con.Phone != null && existingPhones.contains(con.Phone))) {
                con.addError('A contact with this email or phone number already exists.');
            }
        }
    }
    
    public static void countAccountOfContact(List<Contact> conRec) {
        Set<Id> IdSet = new Set<Id>();
        
        for (Contact con : conRec) {
            IdSet.add(con.AccountId);
        }
        
        Map<Id, Integer> accountContactCountMap = new Map<Id, Integer>();
        
        for (AggregateResult ar : [
            SELECT AccountId, COUNT(Id) totalContacts
            FROM Contact
            WHERE AccountId IN :IdSet
            GROUP BY AccountId
        ]) {
            Id accountId = (Id)ar.get('AccountId');
            Integer totalContacts = (Integer)ar.get('totalContacts');
            accountContactCountMap.put(accountId, totalContacts);
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Contact con : conRec) {
            if (accountContactCountMap.containsKey(con.AccountId)) {
                Integer totalContacts = accountContactCountMap.get(con.AccountId);
                Account acc = new Account(Id = con.AccountId, 	Number_Of_Contacts__c = totalContacts);
                accountsToUpdate.add(acc);
            }
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
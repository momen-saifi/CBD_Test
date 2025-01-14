public class AddPrimaryContact implements Queueable {
    private Contact contact;
    private String stateAbbreviation;

    public AddPrimaryContact(Contact contact, String stateAbbreviation) {
        this.contact = contact;
        this.stateAbbreviation = stateAbbreviation;
    }

    public void execute(QueueableContext context) {
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :stateAbbreviation LIMIT 200];

        List<Contact> contactsToInsert = new List<Contact>();

        for (Account acc : accounts) {
            Contact clonedContact = contact.clone(false, false, false, false);
            clonedContact.AccountId = acc.Id;
            contactsToInsert.add(clonedContact);
        }

    
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}
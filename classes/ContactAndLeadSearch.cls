public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String name) {
        // Initialize the result list
        List<List<sObject>> searchResults = new List<List<sObject>>();

        // Perform SOSL search to find Contacts and Leads
        List<List<SObject>> searchList = [FIND :name IN ALL FIELDS RETURNING Contact(Id, Name), Lead(Id, Name)];

        // Extract Contacts and Leads from search results
        List<Contact> contacts = new List<Contact>();
        List<Lead> leads = new List<Lead>();

        for (List<SObject> searchResultsList : searchList) {
            for (SObject obj : searchResultsList) {
                if (obj instanceof Contact) {
                    contacts.add((Contact)obj);
                } else if (obj instanceof Lead) {
                    leads.add((Lead)obj);
                }
            }
        }

        // Add Contacts and Leads to the result list
        searchResults.add(contacts);
        searchResults.add(leads);

        // Return the list of lists containing Contacts and Leads
        return searchResults;
    }
}
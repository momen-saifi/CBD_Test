public class RandomContactFactory {
    
    // Public static method to generate contacts with unique first names based on the iterated number
    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String lastName) {
        List<Contact> contactsToGenerate = new List<Contact>();
        
        for (Integer i = 0; i < numberOfContacts; i++) {
            Contact newContact = new Contact(
                FirstName = 'Test ' + i,
                LastName = lastName
            );
            contactsToGenerate.add(newContact);
        }
        
        return contactsToGenerate;
    }
}
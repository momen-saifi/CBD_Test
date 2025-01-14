public class TestDataFactory {
    
    public static User createTestUser() {
       
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        
        // Create and insert a new user
        User u = new User(
            FirstName = 'Momen',
            LastName = 'Saifi',
            Email = 'momensaifi19@gmail.com',
            Username = 'momensaifi19@gmail.com' + System.currentTimeMillis(),
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = p.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert u;
        return u;
    }
}
public class CreateAccountAndUser {
    public static void createData() {
      
        Account ac = new Account();
        ac.Name = 'Momen Saifi C'; 
        insert ac;
        createUser();
        
    }
	
    
    public static void createUser() {
        List<Profile> p = [SELECT Id, Name FROM Profile WHERE Name = 'Standard User'];
        
        List<UserRole> uRole = [SELECT Id, Name FROM UserRole WHERE Name = 'CEO'];
        
        if (p.isEmpty() || uRole.isEmpty()) {
            System.debug('Profile or UserRole not found.');
            return;
        }
        
       
        User u = new User();
        u.FirstName = 'Manoj';
        u.LastName = '';
        u.Email = 'momen@gmail.com';
        u.Username = 'momen@gmail.com.' + System.currentTimeMillis(); 
        u.ProfileId = p[0].Id;
        u.UserRoleId = uRole[0].Id;


        insert u;
    }
}
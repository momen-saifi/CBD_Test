public class CreateAccountAnduser1 {
       
    public static void createAccount(){
        Account ac=new Account();
        ac.Name='Momen saifi';
        insert ac;
        createUser();
    } 
    
 @future
    public static void createUser(){
        
        List<Profile> p=[SELECT Id, Name FROM Profile WHERE Name = 'Standard User'];
        
        List<UserRole> uRole=[SELECT Id, Name FROM UserRole WHERE Name = 'CEO'];
        if (p.isEmpty() || uRole.isEmpty()) {
            System.debug('Profile or UserRole not found.');
            return;
        }
        User us=new User();
        us.FirstName='Momen';
        us.LastName='';
        us.Email='momensaifi@gmail.com';
        us.Username='momen@gmail.com'+ System.currentTimeMillis(); 
        us.ProfileId=p[0].Id;
        us.UserRoleId=uRole[0].Id;
        
        insert us;
    }

}
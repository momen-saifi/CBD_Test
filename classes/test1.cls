public class test1 {
    public static void demo(){
		Map<Id, List<Contact>> mapAcc = new Map<Id, List<Contact>>();	
		List<Account> accRec = [SELECT Id, (SELECT Id, LastName, Email FROM Contacts) FROM Account LIMIT 10];
		for (Account acc : accRec) {
    		List<Contact> contacts = new List<Contact>();
    		for (Contact con : acc.Contacts) {
				Contact c = new Contact();
            	c.Id = con.Id;
            	c.AccountId = acc.Id;
            	c.LastName = con.LastName;
            	c.Email = con.Email;
        		contacts.add(c);
    		}

    		mapAcc.put(acc.Id, contacts);
		}
	System.debug(mapAcc);
    }
}
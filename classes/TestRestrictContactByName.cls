@isTest
private class TestRestrictContactByName {

    @isTest
    static void testInvalidName() {
        // Try inserting a Contact with INVALIDNAME
        Contact myContact = new Contact(LastName = 'INVALIDNAME');
        
        // Start test execution
        Test.startTest();
        try {
            insert myContact;
            // The insert should fail due to the trigger adding an error
            System.assert(false, 'Expected DmlException was not thrown.');
        } catch (DmlException e) {
            // Verify the error message
            System.assertEquals('Cannot create contact with invalid last name.', e.getDmlMessage(0));
        }
        Test.stopTest();
    }
}
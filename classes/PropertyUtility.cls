public class PropertyUtility {
    public static void newListedProperties() {
        // Create a list to hold the properties
        List<Property__c> newPropList = new List<Property__c>();
        
        // Query to get properties listed in the last 30 days
        newPropList = [
            SELECT Id, Name, Broker__r.Email__c, Days_On_market__c 
            FROM Property__c 
            WHERE Days_On_market__c <=30
        ];
        
        // Iterate through the query results
        for(Property__c prop : newPropList) {
            // Concatenate property name and broker's email address
            String propEmail = prop.Name + ' : ' + prop.Broker__r.Email__c;
            
            // Print the concatenated string to the debug log
            System.debug(propEmail);
        }
    }
}
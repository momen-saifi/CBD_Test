public with sharing class ExternalDataFetcher1 {

    // Method to fetch data based on queryString and orgName
    public static List<MetadataComponentDependency> fetchDataFromAPI(String queryString, String orgId) {
        List<MetadataComponentDependency> resultList = new List<MetadataComponentDependency>();
        String newAccessToken = OAuthService.getAccessToken();

        try {
            // Make an HTTP request to the other org using the query string
            System.debug('Query String: ' + queryString);
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://oraqosoft7-dev-ed.develop.my.salesforce.com' + '/services/data/v62.0/tooling/query/?q=' + EncodingUtil.urlEncode(queryString, 'UTF-8'));
            req.setMethod('GET');
            req.setHeader('Authorization', 'Bearer ' + newAccessToken);
            req.setHeader('Content-Type', 'application/json');

            Http http = new Http();
            HttpResponse res = http.send(req);

            // Handle the response
            if (res.getStatusCode() == 200) {
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                System.debug('jsonResponse: ' + jsonResponse);
                List<Object> records = (List<Object>) jsonResponse.get('records');

              for (Object record : records) {
                Map<String, Object> recordMap = (Map<String, Object>) record;

                // Extract individual fields from the recordMap
                String Id = String.valueOf(recordMap.get('Id'));
                String MetadataComponentName = String.valueOf(recordMap.get('MetadataComponentName'));
                String MetadataComponentType = String.valueOf(recordMap.get('MetadataComponentType'));
                Map<String, Object> attributes = (Map<String, Object>) recordMap.get('attributes');
				System.debug('MetadataComponentType'+MetadataComponentType);
                // Create a new MetadataComponentDependency object
                MetadataComponentDependency recordData = new MetadataComponentDependency(Id, MetadataComponentName, MetadataComponentType, attributes);
                resultList.add(recordData);
            }
            } else {
                throw new DataFetchException('Failed to fetch data from org: ' + orgId + '. Status: ' + res.getStatus() + '. Body: ' + res.getBody());
            }
        } catch (DataFetchException e) {
            System.debug('DataFetchException: ' + e.getMessage());
            throw e;
        } catch (Exception e) {
            System.debug('General Exception while fetching data: ' + e.getMessage());
            throw new DataFetchException('Unable to fetch data for org: ' + orgId + '. Error: ' + e.getMessage());
        }

        return resultList; // Return the list of custom objects
    }

    public class DataFetchException extends Exception {}
}
public with sharing class OAuthAuthorizationController {

    @AuraEnabled
    public static String returnAccessToken() {
        String accessTokenUrl = '';
        String orgId = 'a0EdL000007vTxJUAU'; // Using provided orgId
        
        try {
            // Setting up hardcoded client ID and redirect URL for testing
            String clientId = '3MVG9GCMQoQ6rpzRe.V.cEI9gHZIjz1as0O3FiPB6aBz7cmCeik7cgJbu5A2hFO0ssOaVu0JH4sxOB__JTnks';
            String redirectUrl = 'https://oraqosoft7-dev-ed.develop.my.salesforce.com/apex/CBD__OauthDemoRedirection';
            String state = orgId;
            String codeVerifier = 'generatedCodeVerifier'; // You will generate this
            
            // Generating the code challenge
            Blob codeChallengeBlob = Crypto.generateDigest('SHA-256', Blob.valueOf(codeVerifier));
            String codeChallenge = EncodingUtil.base64Encode(codeChallengeBlob).replaceAll('[+/=]', ''); // Base64 URL-safe encoding
            
            String reqBody = 'https://login.salesforce.com/services/oauth2/authorize?response_type=code&display=popup&client_id=3MVG9GCMQoQ6rpzRe.V.cEI9gHZIjz1as0O3FiPB6aBz7cmCeik7cgJbu5A2hFO0ssOaVu0JH4sxOB__JTnks&redirect_uri=https://oraqosoft7-dev-ed.develop.my.salesforce.com/apex/CBD__OauthDemoRedirection&response_type=code&scope=api+web+refresh_token&state=a0JdL000000CZDJUA4&code_challenge='+codeChallenge+'&code_challenge_method=S256';

            System.debug('Request Body: ' + reqBody);

            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(reqBody);
            req.setMethod('GET');

            // Sending request and logging the response
            HttpResponse res = http.send(req);
            System.debug('Status Code: ' + res.getStatusCode());
            System.debug('Response Body: ' + res.getBody());

            // Check if redirection is received
            if (res.getStatusCode() == 302) {
                accessTokenUrl = res.getHeader('Location');
                System.debug('Access Token URL: ' + accessTokenUrl);
            } else {
                System.debug('Unexpected Status Code: ' + res.getStatusCode());
            }

        } catch (Exception e) {
            System.debug('Exception occurred: ' + e.getMessage());
        }

        return accessTokenUrl;
    }
}
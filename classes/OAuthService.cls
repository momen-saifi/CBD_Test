public with sharing  class OAuthService {

    public class AuthResponse {
        public String access_token;
        public String token_type;
        public String refresh_token;
        public Integer expires_in;
        public String scope;
        public String error;
    }

    public static String getAccessToken() {
        String endpoint = 'https://login.salesforce.com/services/oauth2/token';  
        String clientId = '3MVG9GCMQoQ6rpzRe.V.cEI9gHaj4ciuTfPNe3Vs1omqG5zXpfcm5Y3JrTCImjKbyKou_J5Pu4tevOJSD09uw';
        String clientSecret = '9EA40067584093F2CAF821CF6E8E6389BB469869FB5528E4361A9B3B399FE9A9';
        String username = 'momensaifi@gmail.com';
        String password = 'Momen@2003' + 'TUcL37pBG05O7nFRiCYqpverT';
        String grantType = 'password';

        String body = 'grant_type=' + grantType +
                      '&client_id=' + EncodingUtil.urlEncode(clientId, 'UTF-8') +
                      '&client_secret=' + EncodingUtil.urlEncode(clientSecret, 'UTF-8') +
                      '&username=' + EncodingUtil.urlEncode(username, 'UTF-8') +
                      '&password=' + EncodingUtil.urlEncode(password, 'UTF-8');

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setBody(body);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            AuthResponse authResponse = (AuthResponse) JSON.deserialize(res.getBody(), AuthResponse.class);
            System.debug('Access token: ' + authResponse.access_token);
            return authResponse.access_token;
        } else {
            System.debug('Error in getting access token: ' + res.getBody());
            return null; 
        }
    }
}
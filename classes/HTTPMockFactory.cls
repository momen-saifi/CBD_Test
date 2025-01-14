@isTest
public class HTTPMockFactory implements HttpCalloutMock {
    private Integer responseCode;

    public HTTPMockFactory(Integer code) {
        this.responseCode = code;
    }

    public HTTPResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(responseCode);
        res.setBody('Mock response body');
        return res;
    }
}
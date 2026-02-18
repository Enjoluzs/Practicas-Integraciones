public with sharing class TestCallout {

    public static void test() {

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:JSONPlaceholder/posts/1');
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);

        System.debug(res.getBody());

    }
}
public with sharing class ExternalPostService {
    public static void fetchAndStorePosts(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:JSONPlaceholder/posts');
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HttpResponse res;

        try{
            res = http.send(req);
            if(res.getStatusCode() == 200){
                List<ExternalPostWrapper> posts = 
                    (List<ExternalPostWrapper>)JSON.deserialize(
                        res.getBody(), 
                        List<ExternalPostWrapper>.class
                    );
                
                List<SLR_obj_externalPost__c> recordsToInsert = new List<SLR_obj_externalPost__c>();
                for(ExternalPostWrapper post : posts){
                    SLR_obj_externalPost__c record = new SLR_obj_externalPost__c();
                    record.SLR_fld_title__c = post.title;
                    record.SLR_fld_body__c = post.body;
                    record.SLR_fld_userId__c = post.userId;
                    record.SLR_fld_externalId__c = post.id;

                    recordsToInsert.add(record);
                }

                insert recordsToInsert;
                System.debug('Posts inserted successfully');

            } else {
                System.debug('ERROR STATUS: ' + res.getStatusCode());
            }

        } catch(Exception e) {
            System.debug('EXCEPTION: ' + e.getMessage());
        }

    }        
}


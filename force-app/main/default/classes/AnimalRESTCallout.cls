public class AnimalRESTCallout {
    public static HttpResponse getAnimal(Integer externalId) {
      Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + externalId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
       	return response;
    }
    
     public static Map<Integer,Animal__c> getAnimals(List<Integer> externalId) {
        Map<Integer,Animal__c> resultMap = new Map<Integer,Animal__c>();       
         for (Integer i : externalId) {
             HttpResponse response = getAnimal(i);
             Animal__c animal = AnimalResponse.getAnimal(response.getBody());
             resultMap.put(i,animal);
         }
        return resultMap;
    }
}
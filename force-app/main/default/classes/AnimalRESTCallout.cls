public class AnimalRESTCallout {
    public static HttpResponse getAnimal(Integer externalId) {
      Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + externalId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
       	return response;
    }
    
     public static Map<Integer,AnimalResponse> getAnimals(List<Integer> externalId) {
        Map<Integer,AnimalResponse> resultMap = new Map<Integer,AnimalResponse>();       
         for (Integer i : externalId) {
             HttpResponse response = getAnimal(i);
             AnimalResponse animalRes = (AnimalResponse) JSON.deserialize(response.getBody(), AnimalResponse.class);
             resultMap.put(i,animalRes);
         }
        return resultMap;
    }
}
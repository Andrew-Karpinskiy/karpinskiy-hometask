@RestResource(urlMapping='/Animals/*')
global with sharing class AnimalRestResource {
    @HttpGet
    global static void getAnimalById() {
        RestRequest request = RestContext.request;
        String animalId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        List<Animal__c> existingAnimals =  [SELECT Name, Eats__c, External_Id__c, Says__c FROM Animal__c WHERE Id =: animalId];
        RestResponse response = new RestResponse();
        
        if (existingAnimals.isEmpty() == true) {
            HttpResponse responseFromApi = AnimalRESTCallout.getAnimal(Integer.valueof(animalId));           
            Animal__c newAnimal = AnimalResponse.getAnimal(responseFromApi.getBody());
            if (newAnimal.Eats__c.length() != 0 && newAnimal.Says__c.length() != 0 && newAnimal.name.length() != 0) {
                insert newAnimal;
                response.responseBody = Blob.valueOf(JSON.serialize(newAnimal));
                System.debug('Received data from third party');
                System.debug(newAnimal);
            } else {
                System.debug('An animal with this id does not exist');
                response.responseBody = Blob.valueOf('An animal with this id does not exist');
            }
            
        } else {
            System.debug('Received data from database');
            System.debug(existingAnimals);
            response.responseBody = Blob.valueOf(JSON.serialize(existingAnimals));
        }
    }
}
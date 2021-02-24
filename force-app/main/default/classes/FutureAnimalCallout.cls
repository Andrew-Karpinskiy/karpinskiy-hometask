global class FutureAnimalCallout {
    
    @future(callout = true)
    public static void doAnimalRESTCallout(List<Integer> externalId) {
        
        Map<Integer,AnimalResponse> resultMap = AnimalRESTCallout.getAnimals(externalId);
        
        List<Animal__c> animalsToUpdate = [SELECT External_Id__c,Name, Eats__c, Says__c FROM Animal__c WHERE External_Id__c IN : resultMap.keySet()];
        for(Animal__c animal : animalsToUpdate) {
            AnimalResponse response = resultMap.get(animal.External_Id__c.intValue());
            animal.Eats__c = response.animal.eats;
            animal.Says__c = response.animal.says;
            animal.Name = response.animal.name;
        } 
        
        update animalsToUpdate;
    }
}
global class FutureAnimalCallout {
    
    @future(callout = true)
    public static void doAnimalRESTCallout(List<Integer> externalId) {
        
        Map<Integer,Animal__c> resultMap = AnimalRESTCallout.getAnimals(externalId);
        
        List<Animal__c> animalsToUpdate = [SELECT External_Id__c,Name, Eats__c, Says__c FROM Animal__c WHERE External_Id__c IN : resultMap.keySet()];
        for(Animal__c animal : animalsToUpdate) {
            Animal__c responseAnimal = resultMap.get(animal.External_Id__c.intValue());
            animal.Eats__c = responseAnimal.Eats__c;
            animal.Says__c = responseAnimal.Says__c;
            animal.Name = responseAnimal.name;
        } 
        
        update animalsToUpdate;
    }
}
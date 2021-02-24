public class AnimalTriggerHandler {
	List<Animal__c> newList = new List<Animal__c>();
    
    public AnimalTriggerHandler(List<Animal__c> newList) {
        this.newList = newList;
    }
    
    public void afterInsert() {
        List<Integer> externalId = new List<Integer>();
        for (Animal__c animal : newList) {
            externalId.add(animal.External_Id__c.intValue());
        }
        FutureAnimalCallout.doAnimalRESTCallout(externalId);
    }
}
trigger AnimalTrigger on Animal__c (after insert) {
    AnimalTriggerHandler handler = new AnimalTriggerHandler(Trigger.new);
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            handler.afterInsert();
        }
    }
}
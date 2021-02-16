trigger BookTrigger on Book__c (after insert) {
    if (Trigger.isAfter) {
        update  BookTriggerHelper.updateParentDateAndTime(Trigger.New); 
    }
}
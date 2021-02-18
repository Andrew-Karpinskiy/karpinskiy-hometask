public class MyBatchClass implements Database.Batchable<sObject>, Schedulable{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'Select Author__c From Book__c'
        );
    }
    
    public void execute(SchedulableContext ctx) {
        Database.executeBatch(new MyBatchClass());
    }
    
    public void execute(Database.BatchableContext bc, List<Book__c> books){
        Map<Id,Integer> numberOfChildren = new Map<Id, Integer>(); 
        for (Book__c b : books) {
            Id authorId = b.Author__c;
            if (numberOfChildren.containsKey(authorId)) {
                Integer amount = numberOfChildren.get(authorId) + 1;
                numberOfChildren.put(authorId,amount);
            } else {
                numberOfChildren.put(authorId,1);
            }
        } 
        List<Author__c> authors = [Select Number_of_children__c From Author__c Where Id In : numberOfChildren.keySet()];  
        for(Author__c a : authors) {
            a.Number_of_children__c = numberOfChildren.get(a.Id);
        }
        update authors;
    }
    
    public void finish(Database.BatchableContext bc){}
}
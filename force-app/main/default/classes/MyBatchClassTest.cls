@isTest
public class MyBatchClassTest {
    @testSetup static void testSetup() {
        Author__c author = new Author__c(Name = 'BatchTestAuthor');
        Publisher__c publisher = new Publisher__c(Name = 'BatchTestPublisher');
        insert author;
        insert publisher;
        List<Book__c> books = new List<Book__c>();
        for(Integer i = 0; i < 2; i++) {
            Book__c book = new Book__c(Name = 'BatchTestBook' + i);
            book.Author__c = author.Id;
            book.Publisher__c = publisher.Id;
            books.add(book);
        }   
        insert books;
    }
    
    @isTest public static void testSchedulerWork() {
        Test.startTest();
        MyBatchClass batch = new MyBatchClass();
        String sch = '0 0 0 18 2 ? 2024';
        String jobID = System.schedule('Scheduler', sch, batch);
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(0, ct.TimesTriggered); 
        System.assertEquals('2024-02-18 00:00:00', String.valueOf(ct.NextFireTime));   
        Test.stopTest();
    }
    
    @isTest public static void testBatchWork() {
        MyBatchClass batch = new MyBatchClass();
        Test.startTest();
        Id batchId = Database.executeBatch(batch);
        Test.stopTest();
        Author__c author = [Select Name,Number_of_children__c From Author__c Where Name = 'BatchTestAuthor' Limit 1];
        System.assertEquals(2, author.Number_of_children__c);
    }
}
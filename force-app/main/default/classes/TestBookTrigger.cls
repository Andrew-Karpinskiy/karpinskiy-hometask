@isTest
public class TestBookTrigger {    
     @isTest static void TestUpdateAuthorDateTimeField() {
        Integer numberOfBooksAndAuthors = 50;
        Publisher__c publisher = new Publisher__c(Name = 'TestPublisher');
        insert publisher;
         
        List<Author__c> authors = TestDataFactory.createAuthors(numberOfBooksAndAuthors);
        List<Book__c> books = TestDataFactory.createBooks(numberOfBooksAndAuthors);
        List<Book__c> booksForInsert = new List<Book__c>();
         
        for(Integer i = 0; i < numberOfBooksAndAuthors; i++) {
            Book__c book = books.get(i);
            book.Publisher__c = publisher.Id; 
            book.Author__c = authors.get(i).Id;
            booksForInsert.add(book);
         } 
         
       Test.startTest();
       Database.SaveResult[]  results = Database.insert(booksForInsert);
       Test.stopTest();
         
       List<Author__c> updatedAuthors = [Select Date_and_Time__c From Author__c Where Id In : authors];
         
       for(Integer i = 0; i < results.size(); i++) {
           System.assert(results[i].isSuccess());
           System.assertEquals(Datetime.now(),updatedAuthors[i].Date_and_Time__c);
       }  
    }
}
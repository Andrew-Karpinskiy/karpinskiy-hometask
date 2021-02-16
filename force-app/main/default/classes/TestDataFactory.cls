@isTest
public class TestDataFactory {
    public static List<Author__c> createAuthors(Integer numberOfAuthors) {
        List<Author__c> authors = new List<Author__c>();
        for (Integer i = 0; i < numberOfAuthors; i++) {
            Author__c author = new Author__c(Name = 'TestAuthor' + i);
            authors.add(author);
        }
        insert authors;
        return authors;
    }
    
    public static List<Book__c> createBooks(Integer numberOfBooks) {
        List<Book__c> books = new List<Book__c>();
        for (Integer i = 0; i < numberOfBooks; i++) {
            Book__c book = new 	Book__c(Name = 'TestBook' + i);
            books.add(book);
        }
        return books;
    }
}
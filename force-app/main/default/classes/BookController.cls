public class BookController {
    public String bookName {get; set;}
    public String bookFirstPublished {get; set;}
    public String bookGenre {get; set;}
    public String bookAuthor {get; set;}
    public String bookPublisherName {get; set;}
    
    public BookController() {
        Book__c book = [SELECT Name, First_Published__c, Genre__c, Author__r.Name, Publisher__r.Name FROM Book__c 
                				WHERE id =: ApexPages.currentPage().getParameters().get('id') ];
		bookName = book.Name;
        bookFirstPublished = String.valueOf(book.First_Published__c);
        bookGenre = book.Genre__c;
        bookAuthor = book.Author__r.Name;
        bookPublisherName = book.Publisher__r.Name; 
    }
}
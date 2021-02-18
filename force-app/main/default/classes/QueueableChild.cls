public class QueueableChild implements Queueable{
    private String bookName;
    private Id authorParent;
    private Id publisherParent;
    
    
    public QueueableChild(String bookName,Id authorParent, Id publisherParent) {
    	this.bookName = bookName;
        this.authorParent = authorParent;
        this.publisherParent = publisherParent;
    }
    
    public void execute(QueueableContext context) {
        Book__c book = new Book__c(Name = bookName, Author__c = authorParent, Publisher__c = publisherParent);
        insert book;
        System.debug(book.Name);
    }
}
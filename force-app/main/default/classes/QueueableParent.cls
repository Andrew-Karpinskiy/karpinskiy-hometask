public class QueueableParent implements Queueable{
    private String authorName;
    private String publisherName;
    private String bookName;
    private Id authorId;
    private Id publisherId;
      
    public QueueableParent(String authorName, String publisherName,String bookName) {
        this.authorName = authorName;
        this.publisherName = publisherName;
        this.bookName = bookName;
    }
    
    public QueueableParent(Id authorId, Id publisherId,String bookName) {
        this.authorId = authorId;
        this.publisherId = publisherId;
        this.bookName = bookName;
    }
    
    public void execute(QueueableContext context) {
        if (authorId == null && publisherId == null) {
            Author__c author = new Author__c(Name = authorName);
            Publisher__c publisher = new Publisher__c(Name = publisherName);
            
            insert publisher;
            insert author;
            
            System.debug(publisher.name);
            System.debug(author.name);
   
            System.enqueueJob(new QueueableParent(author.id,publisher.id,bookName));
        } else if(authorId != null && publisherId != null) { 
            Book__c book = new Book__c(Name = bookName, Author__c = authorId, Publisher__c = publisherId);
            insert book;
            
            System.debug(book.name);
        }
    }
}
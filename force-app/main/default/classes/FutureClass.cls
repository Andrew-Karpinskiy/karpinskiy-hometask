public class FutureClass { 
    @future
    public static void createAuthors(List<String> authorsNames) {
        List<Author__c> authors = new List<Author__c>();
        for (String str : authorsNames) {
            authors.add(new Author__c(Name = str));
        }
        insert authors;
        
        List<Author__c> insertedAuthor = [Select Name From Author__c Where Id In : authors];
        
        for (Author__c a : insertedAuthor) {
            System.debug(a.Name);
        }
        
    }
}
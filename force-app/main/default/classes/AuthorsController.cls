public with sharing class AuthorsController {
	@AuraEnabled
    public static void saveAuthor(Author__c author) {
      insert author;
    }
    
    @AuraEnabled
    public static List<Author__c> getAuthors() {
        return [SELECT Id, Name, Pen_Name__c, Phone_Number__c, Website__c, Email__c FROM Author__c];
    }
}
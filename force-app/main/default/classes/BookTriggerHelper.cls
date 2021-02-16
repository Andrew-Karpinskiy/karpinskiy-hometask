public class BookTriggerHelper {

    public static List<Author__c> updateParentDateAndTime(List<Book__c> books) {
        Set<String> authors = new Set<String>();
        for (Book__c b : books) {
            authors.add(b.Author__c);
        }
        List<Author__c> authorsToUpdate = [Select Name,Date_and_Time__c From Author__c Where Id In : authors];
        return setDateAndTime(authorsToUpdate);
    }

    public static List<Author__c> setDateAndTime(List<Author__c> authors) {
        List<Author__c> result = new List<Author__c>();
        for(Author__c a : authors) {
            a.Date_and_Time__c = Datetime.now();
        	result.add(a);
    	}
        return result;
    }
}
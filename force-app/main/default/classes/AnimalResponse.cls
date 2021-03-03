public class AnimalResponse {   
	public AnimalData animal;
    
    public class AnimalData {
		public Integer id;	
		public String name;	
		public String eats;	
		public String says;	
	}  
    
    public static Animal__c getAnimal(String JSONString) {
        AnimalResponse response = (AnimalResponse) JSON.deserialize(JSONString, AnimalResponse.class);
        Animal__c animal = new Animal__c();
        animal.Eats__c = response.animal.eats;
        animal.Says__c = response.animal.says;
        animal.Name = response.animal.name;
        return animal;
    }
}
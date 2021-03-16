public class SelectedAnimals{

	public List<Data> data;

	public class Data {
		public String Name;
		public String Eats;
		public String Says;
		public Integer ExternalId;
	}

	
	public static SelectedAnimals parse(String json) {
		return (SelectedAnimals) System.JSON.deserialize(json, SelectedAnimals.class);
	}
}
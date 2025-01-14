public class MetadataComponentDependency {
    public String Id;
    public String MetadataComponentName;
    public String MetadataComponentType;
    public Map<String, Object> attributes;

    // Constructor for initializing
    public MetadataComponentDependency(String Id, String MetadataComponentName, String MetadataComponentType, Map<String, Object> attributes) {
        this.Id = Id;
        this.MetadataComponentName = MetadataComponentName;
        this.MetadataComponentType = MetadataComponentType;
        this.attributes = attributes;
    }
}
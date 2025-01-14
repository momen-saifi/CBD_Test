public class TranscriptController {
    public String year { get; set; }
    public String student { get; set; }
    public String teacher { get; set; }
    public String school { get; set; }
    public String term { get; set; }
    public String course { get; set; }
    public String grade { get; set; }
    
    public TranscriptController() {
        year = '2023-2024'; // Example data
        student = 'Jason Ou';
        teacher = 'Jacqueline Grant';
        school = 'Hong Kong International School';
        term = 'Summer 2023-2024';
        course = 'Introduction to Legal Thinking';
        grade = '95.53%';
    }
}
public class TranscriptGradeReportController {
    public String AYear { get; set; }
    public String student { get; set; }
    public String teachers { get; set; }
    public String School { get; set; }
    public String Term { get; set; }
    public String Course { get; set; }
    public String Semester1Average { get; set; }

    public TranscriptGradeReportController() {
        // Fetch the data from your custom objects or other sources
        AYear = '2023-2024'; // Example data, replace with actual logic
        student = 'John Doe'; // Example data, replace with actual logic
        teachers = 'Jane Smith'; // Example data, replace with actual logic
        School = 'Global Online Academy'; // Example data, replace with actual logic
        Term = 'Fall'; // Example data, replace with actual logic
        Course = 'Mathematics'; // Example data, replace with actual logic
        Semester1Average = 'A'; // Example data, replace with actual logic
    }

    public void getReportDetails() {
        // This method can be used to perform any additional data fetching or processing
    }
}
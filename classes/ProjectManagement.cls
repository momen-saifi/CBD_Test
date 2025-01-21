public with sharing class ProjectManagement {
    /**
     * Represents a Project with essential details.
     */
    public class Project {
        @AuraEnabled public String projectId;
        @AuraEnabled public String projectName;
        @AuraEnabled public Date startDate;
        @AuraEnabled public Date endDate;
        @AuraEnabled public Decimal budget;

        public Project(String projectId, String projectName, Date startDate, Date endDate, Decimal budget) {
            this.projectId = projectId;
            this.projectName = projectName;
            this.startDate = startDate;
            this.endDate = endDate;
            this.budget = budget;
        }
    }

    private static Map<String, Project> projects = new Map<String, Project>();

    /**
     * Adds a new project to the system.
     */
    public static void addProject(String projectId, String projectName, Date startDate, Date endDate, Decimal budget) {
        if (projects.containsKey(projectId)) {
            throw new IllegalArgumentException('Project with this ID already exists.');
        }
        projects.put(projectId, new Project(projectId, projectName, startDate, endDate, budget));
    }

    /**
     * Updates the details of an existing project.
     */
    public static void updateProject(String projectId, String projectName, Date startDate, Date endDate, Decimal budget) {
        if (!projects.containsKey(projectId)) {
            throw new IllegalArgumentException('Project with this ID does not exist.');
        }
        projects.put(projectId, new Project(projectId, projectName, startDate, endDate, budget));
    }

    /**
     * Removes a project from the system by its ID.
     */
    public static void removeProject(String projectId) {
        if (!projects.containsKey(projectId)) {
            throw new IllegalArgumentException('Project with this ID does not exist.');
        }
        projects.remove(projectId);
    }

    /**
     * Retrieves a project's details by its ID.
     */
    public static Project getProject(String projectId) {
        if (!projects.containsKey(projectId)) {
            throw new IllegalArgumentException('Project with this ID does not exist.');
        }
        return projects.get(projectId);
    }

    /**
     * Retrieves all projects in the system.
     */
    public static List<Project> getAllProjects() {
        return projects.values();
    }

    /**
     * Calculates the total budget of all projects.
     */
    public static Decimal calculateTotalBudget() {
        Decimal totalBudget = 0;
        for (Project proj : projects.values()) {
            totalBudget += proj.budget;
        }
        return totalBudget;
    }

    /**
     * Retrieves projects that fall within a specific date range.
     */
    public static List<Project> getProjectsByDateRange(Date startDate, Date endDate) {
        List<Project> dateRangeProjects = new List<Project>();
        for (Project proj : projects.values()) {
            if (proj.startDate >= startDate && proj.endDate <= endDate) {
                dateRangeProjects.add(proj);
            }
        }
        return dateRangeProjects;
    }

    /**
     * Checks if a project is currently active based on today's date.
     */
    public static Boolean isProjectActive(String projectId) {
        if (!projects.containsKey(projectId)) {
            throw new IllegalArgumentException('Project with this ID does not exist.');
        }
        Project proj = projects.get(projectId);
        Date today = Date.today();
        return (proj.startDate <= today && proj.endDate >= today);
    }
}
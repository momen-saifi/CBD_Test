@isTest
public class ProjectManagementTest {
    @isTest
    static void testAddProject() {
        ProjectManagement.addProject('P1', 'Project Alpha', Date.today(), Date.today().addDays(30), 50000);
        System.assertEquals('Project Alpha', ProjectManagement.getProject('P1').projectName);
    }

    @isTest
    static void testAddDuplicateProject() {
        ProjectManagement.addProject('P2', 'Project Beta', Date.today(), Date.today().addDays(60), 75000);
        try {
            ProjectManagement.addProject('P2', 'Duplicate Project', Date.today(), Date.today().addDays(60), 75000);
            System.assert(false, 'Expected exception for duplicate project was not thrown.');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Project with this ID already exists.', e.getMessage());
        }
    }

    @isTest
    static void testUpdateProject() {
        ProjectManagement.addProject('P3', 'Project Gamma', Date.today(), Date.today().addDays(90), 100000);
        ProjectManagement.updateProject('P3', 'Project Gamma Updated', Date.today(), Date.today().addDays(90), 110000);
        System.assertEquals('Project Gamma Updated', ProjectManagement.getProject('P3').projectName);
    }

    @isTest
    static void testRemoveProject() {
        ProjectManagement.addProject('P4', 'Project Delta', Date.today(), Date.today().addDays(120), 200000);
        ProjectManagement.removeProject('P4');
        try {
            ProjectManagement.getProject('P4');
            System.assert(false, 'Expected exception for non-existent project was not thrown.');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Project with this ID does not exist.', e.getMessage());
        }
    }

    @isTest
    static void testCalculateTotalBudget() {
        ProjectManagement.addProject('P5', 'Project Epsilon', Date.today(), Date.today().addDays(150), 300000);
        ProjectManagement.addProject('P6', 'Project Zeta', Date.today(), Date.today().addDays(180), 400000);
        System.assertEquals(700000, ProjectManagement.calculateTotalBudget());
    }

    @isTest
    static void testGetProjectsByDateRange() {
        ProjectManagement.addProject('P7', 'Project Eta', Date.today(), Date.today().addDays(90), 150000);
        ProjectManagement.addProject('P8', 'Project Theta', Date.today().addDays(100), Date.today().addDays(200), 250000);

        List<ProjectManagement.Project> rangeProjects = ProjectManagement.getProjectsByDateRange(Date.today(), Date.today().addDays(150));
        System.assertEquals(1, rangeProjects.size());
    }

    @isTest
    static void testIsProjectActive() {
        ProjectManagement.addProject('P9', 'Project Iota', Date.today().addDays(-10), Date.today().addDays(20), 50000);
        System.assertEquals(true, ProjectManagement.isProjectActive('P9'));

        ProjectManagement.addProject('P10', 'Project Kappa', Date.today().addDays(30), Date.today().addDays(60), 100000);
        System.assertEquals(false, ProjectManagement.isProjectActive('P10'));
    }
}
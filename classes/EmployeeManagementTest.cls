@isTest
public class EmployeeManagementTest {
    @isTest
    static void testAddEmployee() {
        EmployeeManagement.addEmployee('1', 'John Doe', 5000, 'IT');
        System.assertEquals('John Doe', EmployeeManagement.getEmployee('1').name);
    }
//modife by vikash .
    @isTest
    static void testAddDuplicateEmployee() {
        EmployeeManagement.addEmployee('2', 'Jane Smith', 6000, 'HR');
        try {
            EmployeeManagement.addEmployee('2', 'Duplicate Jane', 7000, 'HR');
            System.assert(false, 'Expected exception for duplicate employee was not thrown.');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Employee with this ID already exists.', e.getMessage());
        }
    }

    @isTest
    static void testUpdateEmployee() {
        EmployeeManagement.addEmployee('3', 'Mark Lee', 7000, 'Finance');
        EmployeeManagement.updateEmployee('3', 'Mark Lee Updated', 7500, 'Finance');
        System.assertEquals('Mark Lee Updated', EmployeeManagement.getEmployee('3').name);
    }

    @isTest
    static void testRemoveEmployee() {
        EmployeeManagement.addEmployee('4', 'Anna Bell', 4000, 'Marketing');
        EmployeeManagement.removeEmployee('4');
        try {
            EmployeeManagement.getEmployee('4');
            System.assert(false, 'Expected exception for non-existent employee was not thrown.');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Employee with this ID does not exist.', e.getMessage());
        }
    }

    @isTest
    static void testCalculateTotalSalary() {
        EmployeeManagement.addEmployee('5', 'Alice', 3000, 'IT');
        EmployeeManagement.addEmployee('6', 'Bob', 3500, 'IT');
        System.assertEquals(6500, EmployeeManagement.calculateTotalSalary());
    }

    @isTest
    static void testGetEmployeesByDepartment() {
        EmployeeManagement.addEmployee('7', 'Charlie', 4500, 'HR');
        EmployeeManagement.addEmployee('8', 'Diana', 5000, 'HR');
        EmployeeManagement.addEmployee('9', 'Eve', 5500, 'IT');

        List<EmployeeManagement.Employee> hrEmployees = EmployeeManagement.getEmployeesByDepartment('HR');
        System.assertEquals(2, hrEmployees.size());
    }

    @isTest
    static void testEdgeCases() {
        // No employees initially
        System.assertEquals(0, EmployeeManagement.getAllEmployees().size(), 'Initial employees list should be empty.');

        // Add and check count
        EmployeeManagement.addEmployee('10', 'Sam', 4500, 'Operations');
        System.assertEquals(1, EmployeeManagement.getAllEmployees().size());
    }
}
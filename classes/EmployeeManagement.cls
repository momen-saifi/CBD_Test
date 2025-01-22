public with sharing class EmployeeManagement {
    /**
     * Represents an Employee record with basic details.
     */
    ////vishu upadhyay.
    public class Employee {
        @AuraEnabled public String employeeId;
        @AuraEnabled public String name;
        @AuraEnabled public Decimal salary;
        @AuraEnabled public String department;

        public Employee(String employeeId, String name, Decimal salary, String department) {
            this.employeeId = employeeId;
            this.name = name;
            this.salary = salary;
            this.department = department;
        }
    }

    private static Map<String, Employee> employees = new Map<String, Employee>();

    /**
     * Adds a new employee.
     */
    public static void addEmployee(String employeeId, String name, Decimal salary, String department) {
        if (employees.containsKey(employeeId)) {
            throw new IllegalArgumentException('Employee with this ID already exists.');
        }
        employees.put(employeeId, new Employee(employeeId, name, salary, department));
    }

    /**
     * Updates an existing employee's details.
     */
    public static void updateEmployee(String employeeId, String name, Decimal salary, String department) {
        if (!employees.containsKey(employeeId)) {
            throw new IllegalArgumentException('Employee with this ID does not exist.');
        }
        employees.put(employeeId, new Employee(employeeId, name, salary, department));
    }

    /**
     * Removes an employee by ID.
     */
    public static void removeEmployee(String employeeId) {
        if (!employees.containsKey(employeeId)) {
            throw new IllegalArgumentException('Employee with this ID does not exist.');
        }
        employees.remove(employeeId);
    }

    /**
     * Retrieves an employee's details by ID.
     */
    public static Employee getEmployee(String employeeId) {
        if (!employees.containsKey(employeeId)) {
            throw new IllegalArgumentException('Employee with this ID does not exist.');
        }
        return employees.get(employeeId);
    }

    /**
     * Retrieves all employees.
     */
    public static List<Employee> getAllEmployees() {
        return employees.values();
    }

    /**
     * Calculates the total salary expense for all employees.
     */
    public static Decimal calculateTotalSalary() {
        Decimal totalSalary = 0;
        for (Employee emp : employees.values()) {
            totalSalary += emp.salary;
        }
        return totalSalary;
    }
    //my name is vishu

    /**
     * Retrieves employees in a specific department.
     */
    public static List<Employee> getEmployeesByDepartment(String department) {
        List<Employee> deptEmployees = new List<Employee>();
        for (Employee emp : employees.values()) {
            if (emp.department == department) {
                deptEmployees.add(emp);
            }
        }
        return deptEmployees;
    }
    ///vikash upadhyay 123456789087876868768 vishu123456
    
}
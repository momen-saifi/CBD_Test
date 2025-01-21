public class MathOperationsfunction {
public Integer performOperation(Integer num1, Integer num2, String operation) {
        if (operation.equalsIgnoreCase('add')) {
            Integer sum = num1 + num2; 
            return sum;
        } else if (operation.equalsIgnoreCase('subtract')) {
            Integer subtract = num1 - num2;
            return subtract; 
        } else if (operation.equalsIgnoreCase('multiply')) {
            Integer multiply = num1 * num2;
            return multiply;
        } else {
            return null; 
        }
    }
}
@isTest
public class CalculatorTests {
    
    @isTest
    static void testDivideByZero() {
        // Ensure the divide method throws an exception when dividing by zero
        try {
            Calculator.divide(10, 0);
            System.assert(false, 'Expected CalculatorException was not thrown');
        } catch (Calculator.CalculatorException e) {
            System.assertEquals('You still can\'t divide by zero', e.getMessage());
        }
    }
    
    @isTest
    static void testDivideNegativeResult() {
        // Ensure the divide method throws an exception when the result is negative
        try {
            Calculator.divide(-10, 1);
            System.assert(false, 'Expected CalculatorException was not thrown');
        } catch (Calculator.CalculatorException e) {
            System.assert(e.getMessage().contains('Division returned a negative value'));
        }
    }
}
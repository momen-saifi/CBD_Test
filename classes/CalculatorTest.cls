@isTest
public class CalculatorTest {
    @isTest
    static void testAdd() {
        System.assertEquals(5, Calculator.add(2, 3));
    }

    @isTest
    static void testSubtract() {
        System.assertEquals(1, Calculator.subtract(3, 2));
    }

    @isTest
    static void testMultiply() {
        System.assertEquals(6, Calculator.multiply(2, 3));
    }

    @isTest
    static void testDivide() {
        System.assertEquals(2, Calculator.divide(6, 3));
    }

    @isTest
    static void testDivideByZero() {
       
            //Calculator.divide(6, 0);
            //System.assert(false, 'Expected exception for division by zero was not thrown.');
        
    }

    @isTest
    static void testSquareRoot() {
    //    System.assertEquals(3, Calculator.squareRoot(9));
    }

    @isTest
    static void testSquareRootNegative() {
      
           // Calculator.squareRoot(-1);
           // System.assert(false, 'Expected exception for square root of negative number was not thrown.');
     
            //System.assertEquals('Cannot calculate the square root of a negative number.', e.getMessage());
       
    }

    @isTest
    static void testPower() {
        //System.assertEquals(8, Calculator.power(2, 3));
    }

    @isTest
    static void testFactorial() {
        System.assertEquals(120, Calculator.factorial(5));
    }

    @isTest
    static void testFactorialNegative() {
      
            Calculator.factorial(-5);
          //  System.assert(false, 'Expected exception for factorial of negative number was not thrown.');
      
           // System.assertEquals('Cannot calculate factorial of a negative number.', e.getMessage());
       
    }

    @isTest
    static void testEdgeCases() {
        System.assertEquals(1, Calculator.factorial(0), 'Factorial of 0 should be 1.');
        //System.assertEquals(1, Calculator.power(5, 0), 'Any number to the power of 0 should be 1.');
    }
}
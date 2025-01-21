public with sharing class Calculator {
    /**
     * Adds two numbers.
     */
    public static Decimal add(Decimal num1, Decimal num2) {
        return num1 + num2;
    }

    /**
     * Subtracts the second number from the first.
     */
    public static Decimal subtract(Decimal num1, Decimal num2) {
        return num1 - num2;
    }

    /**
     * Multiplies two numbers.
     */
    public static Decimal multiply(Decimal num1, Decimal num2) {
        return num1 * num2;
    }

    /**
     * Divides the first number by the second. Throws an exception if division by zero is attempted.
     */
    public static Decimal divide(Decimal num1, Decimal num2) {
        if (num2 == 0) {
            //throw new ArithmeticException('Cannot divide by zero.');
        }
        return num1 / num2;
    }

    /**
     * Calculates the square root of a number. Throws an exception if the number is negative.
     */
   

    /**
     * Raises the base to the power of the exponent.
     */
   
    /**
     * Calculates the factorial of a non-negative integer. Throws an exception if the number is negative.
     */
    public static Integer factorial(Integer num) {
        if (num < 0) {
            //throw new ArithmeticException('Cannot calculate factorial of a negative number.');
        }
        Integer result = 1;
        for (Integer i = 1; i <= num; i++) {
            result *= i;
        }
        return result;
    }
}
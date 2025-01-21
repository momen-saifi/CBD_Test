public class NumberChecker {
 public static String checkNumber(Integer num) {
        if (num > 0) {
            return 'Positive';
        } else if (num < 0) {
            return 'Negative'; 
        } else {
            return 'Zero';
        }
    }
}
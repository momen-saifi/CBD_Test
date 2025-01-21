public class Sumofnaturalnumbers {
public static Integer calculateSumLoop(Integer N) {
        Integer sum = 0; 
        for (Integer i = 1; i <= N; i++) {
            sum += i ; 
        }
        return sum;
    }
}
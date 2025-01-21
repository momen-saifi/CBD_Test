public class OddEvenCounter {
public static Map<String, Integer> countOddEven(List<Integer> numbers) {
        Integer oddCount = 0; 
        Integer evenCount = 0; 
        for (Integer num : numbers) {
            if ((num / 2) * 2 == num) {
                evenCount++;
            } else {
                oddCount++; 
            }
        }
        Map<String, Integer> result = new Map<String, Integer>();
        result.put('Odd', oddCount); 
        result.put('Even', evenCount);
        return result;
    }
}
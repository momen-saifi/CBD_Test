public class DynamicFilterFromNaturalLanguage {

    private static final Map<String, Integer> numberWordsMap = new Map<String, Integer> {
        'zero' => 0, 'one' => 1, 'two' => 2, 'three' => 3, 'four' => 4, 'five' => 5,
        'six' => 6, 'seven' => 7, 'eight' => 8, 'nine' => 9, 'ten' => 10,
        'eleven' => 11, 'twelve' => 12, 'thirteen' => 13, 'fourteen' => 14,
        'fifteen' => 15, 'sixteen' => 16, 'seventeen' => 17, 'eighteen' => 18, 'nineteen' => 19,
        'twenty' => 20, 'thirty' => 30, 'forty' => 40, 'fifty' => 50, 'sixty' => 60,
        'seventy' => 70, 'eighty' => 80, 'ninety' => 90, 'hundred' => 100
    };

    public static String generateFilterFromNaturalLanguage(String naturalLanguageInput) {
        if (String.isEmpty(naturalLanguageInput)) {
            throw new IllegalArgumentException('Input cannot be empty');
        }

        String filterCriteria = '';
        DateTime referenceDate = System.now();
        String action = null;
        String userName = null;
        Integer amount = 0;
        String timeUnit = 'days';
        String section = null;
        String comparisonOperator = null;

        action = extractAction(naturalLanguageInput);

        userName = extractUserName(naturalLanguageInput);


   Map<String, Object> result = extractDateFromInput(naturalLanguageInput, comparisonOperator);

 comparisonOperator = (String) result.get('comparisonOperator');
DAte filterDate = (Date) result.get('filterDate');    

        section = determineSection(naturalLanguageInput);

        filterCriteria = buildFilterCriteria(action, userName, filterDate, section, comparisonOperator);

        return filterCriteria;
    }

    private static String extractAction(String input) {
        Set<String> actionKeywords = new Set<String> {
            'modified', 'changed', 'updated', 'altered', 'amended', 'created', 'added', 'new', 
            'inserted', 'deleted', 'removed', 'dropped', 'discarded', 'erased', 'viewed', 'accessed', 
            'opened', 'checked', 'approved', 'confirmed', 'accepted', 'authorized', 'rejected', 
            'denied', 'disapproved', 'declined', 'failed', 'error', 'unsuccessful', 'cancelled', 
            'completed', 'finished', 'done', 'closed', 'assigned', 'delegated', 'allocated'
        };

        for (String keyword : actionKeywords) {
            if (input.toLowerCase().contains(keyword)) {
                return keyword.capitalize();
            }
        }
        return null;
    }

    private static String extractUserName(String input) {
        if (input.toLowerCase().contains('by')) {
            Integer byIndex = input.toLowerCase().indexOf('by') + 3;
            String remainingString = input.substring(byIndex).trim();
            Integer spaceIndex = remainingString.indexOf(' ');

            if (spaceIndex != -1) {
                return remainingString.substring(0, spaceIndex);
            } else {
                return remainingString;
            }
        }
        return null;
    }

    public static Map<String, Object> extractDateFromInput(String input, String comparisonOperator) {
    Map<String, Object> result = new Map<String, Object>();

    String opp = extractDateOperator(input);
    if (opp == null) {
        if (input.contains('>') || input.contains('<') || input.contains('==') || input.contains('!=')) {
            comparisonOperator = extractComparisonOperator(input);
        }
    } else {
        comparisonOperator = opp; 
    }

    Map<String, Object> dateResult = getDateFromInput(input, comparisonOperator);

    String extractedComparisonOperator = (String) dateResult.get('comparisonOperator');
    Date filterDateString = (Date) dateResult.get('filterDate');

    if (extractedComparisonOperator == null) {
        extractedComparisonOperator = comparisonOperator;
    }

    result.put('comparisonOperator', extractedComparisonOperator);
    result.put('filterDate', filterDateString); // Store the date as a string

    return result;
}

    private static String extractComparisonOperator(String input) {
        if (input.contains('>')) return '>';
        if (input.contains('<')) return '<';
        if (input.contains('==')) return '==';
        if (input.contains('!=')) return '!=';

        return '=';
    }

    private static String determineSection(String input) {
        Map<String, String> sectionKeywords = new Map<String, String> {
            'apex class' => 'Apex Class', 'apex trigger' => 'Apex Trigger', 'flow' => 'Flows', 
            'workflow' => 'Workflow Rule', 'process builder' => 'Process Builders', 
            'validation rule' => 'Validation Rules', 'custom object' => 'Custom Objects',
            'static resource' => 'Static Resource', 'lightning component' => 'Lightning Components', 
            'manage users' => 'Manage Users', 'custom metadata' => 'Custom Metadata Types', 
            'permission set group' => 'Permission Set Group', 'field dependency' => 'Field Dependencies',
            'approval process' => 'Approval Process', 'sharing defaults' => 'Sharing Defaults',
            'customize accounts' => 'Customize Accounts', 'customize contacts' => 'Customize Contacts'
        };

        for (String keyword : sectionKeywords.keySet()) {
            if (input.toLowerCase().contains(keyword)) {
                return sectionKeywords.get(keyword);
            }
        }
        return null;
    }

    private static String buildFilterCriteria(String action, String userName, Date filterDate, String section, String comparisonOperator) {
        String filterCriteria = '';
        Boolean firstCondition = true;

        if (action != null) {
            filterCriteria += 'Action = ' + action;
            firstCondition = false;
        }

        if (userName != null) {
            if (!firstCondition) filterCriteria += ' AND ';

            filterCriteria += 'User = ' + userName;
            firstCondition = false;
        }

        if (filterDate != null) {
            if (!firstCondition) filterCriteria += ' AND ';
            filterCriteria += 'Date ' + comparisonOperator + ' ' + filterDate;
            firstCondition = false;
        }


        if (section != null) {
            if (!firstCondition) filterCriteria += ' AND ';
            filterCriteria += 'Section = ' + section;
            
            
        }
        System.debug('filterCriteria' + filterCriteria);

        return filterCriteria;
    }
private static String extractDateOperator(String input) {
    Map<String, String> operatorMap = new Map<String, String> {
        'greater than' => '>', 
        'less than' => '<', 
        'equal to' => '==', 
        'not equal to' => '!='
    };

    for (String key : operatorMap.keySet()) {
        if (input.toLowerCase().contains(key)) {
            return operatorMap.get(key);
        }
    }

    return null;
}

    private static Integer extractNumberOrWord(String input) {
        Pattern pattern = Pattern.compile('\\d+');
        Matcher matcher = pattern.matcher(input);

        if (matcher.find()) {
            return Integer.valueOf(matcher.group());
        }

        for (String word : numberWordsMap.keySet()) {
            if (input.contains(word)) {
                return numberWordsMap.get(word);
            }
        }

        throw new IllegalArgumentException('No valid number found in the input');
    }
public static Map<String, Object> getDateFromInput(String userInput, String comparisonOperator) {
    userInput = userInput.toLowerCase();
    Date filterDate;

    if (userInput.contains('after') && userInput.contains('days')) {
        comparisonOperator = '>';
        Integer days = extractNumberOrWord(userInput);
        filterDate = Date.today().addDays(days);

    } else if (userInput.contains('before') && userInput.contains('days')) {
        comparisonOperator = '<';
        Integer days = extractNumberOrWord(userInput);
        filterDate = Date.today().addDays(-days);

    } else if (userInput.contains('next') && userInput.contains('days')) {
        comparisonOperator = '>';
        Integer days = extractNumberOrWord(userInput);
        filterDate = Date.today().addDays(days);

    } else if (userInput.contains('last') && userInput.contains('months')) {
        comparisonOperator = '<';
        Integer months = extractNumberOrWord(userInput);
        filterDate = Date.today().addMonths(-months);

    } else if (userInput.contains('on') || userInput.contains('equals')) {
        filterDate = extractDate(userInput);

    } else {
        throw new IllegalArgumentException('Invalid date prompt');
    }

    Map<String, Object> result = new Map<String, Object>();
    result.put('comparisonOperator', comparisonOperator);
    result.put('filterDate', filterDate);

    return result;
}

    private static Date extractDate(String input) {
        Pattern pattern = Pattern.compile('\\d{4}-\\d{2}-\\d{2}');
        Matcher matcher = pattern.matcher(input);

        if (matcher.find()) {
            return Date.valueOf(matcher.group());
        } else {
            throw new IllegalArgumentException('No valid date found in the input');
        }
    }
}
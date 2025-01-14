public class SK_GenericDataTableCmpController{
    //*******Constants*******************
    private static final String DATE_DATATYPE = 'DATE';
    private static final String DATETIME_DATATYPE = 'DATETIME';
    private static final String CURRENCY_DATATYPE = 'CURRENCY';
    private static final String PARENT_RELATIONSHIP = 'REFERENCE';
    //new code starts------------------
    //Method to fetch all account related record when user clicks on tabs
    //Parameter - objectname (String), allAccountIds seperated by comma (String), allRecords (TRUE OR FALSE)
    //return - json to create table on UI (String)
    @AuraEnabled
    public static string getAllRelatedRecords(string objAPIname, List<String> FieldsAPINameList, List<String> columnLabelsList, string sortColumns, string filterCriteria, string hyperLinkFieldName, string recordsLimit, String orgName){
        system.debug('*******Organization Name: ' + orgName);
        system.debug('*******objAPIname:' + objAPIname + '*******FieldsAPINameList:' + FieldsAPINameList + '*******filterCriteria:' + filterCriteria);

        string queryString = '';
        List<String> columnLabelList = new List<String>();
        List<String> FieldAPINameList = new List<String>();
        Map<String, String> fieldToFieldTypeMap = new Map<String, String>();
        datasetForTable dataSet = new datasetForTable();
        String HyperLinkField = '';

        string fieldQuery = '';
        string objectApiName = '';
        string fieldApiName = '';
        string sortingOrderBy = '';
        string whereClause = '';
        string limitString = '';

        // Variables to store Section information
        String sectionVariable = '';
        String sectionValueVariable = '';

        if (objAPIname != null && objAPIname != ''){
            objectApiName = objAPIname.trim();
            if (hyperLinkFieldName != null && hyperLinkFieldName != ''){
                HyperLinkField = hyperLinkFieldName.trim();
            }
            if (FieldsAPINameList.size() > 0){
                for (string ss : FieldsAPINameList){
                    if (ss != null && ss != ''){
                        fieldQuery = fieldQuery + ' , ' + ss.trim();
                        FieldAPINameList.add(ss.trim());
                    }
                }
            }

            // Check for Section in the filterCriteria and extract it
            if (filterCriteria != null && filterCriteria != ''){
                // Use regex to find and extract Section clause (handling extra spaces around '=' and quotes)
                Pattern sectionPattern = Pattern.compile('\\bSection\\s*=\\s*\'([^\']+)\''); // Matches "Section = 'value'"
                Matcher sectionMatcher = sectionPattern.matcher(filterCriteria);

                if (sectionMatcher.find()){
                    String sectionClause = sectionMatcher.group(0); // Extract the entire "Section = 'value'" clause
                    sectionValueVariable = sectionMatcher.group(1); // Extract only the value inside the quotes

                    sectionVariable = 'Section';  // Store the variable name 'Section'
                    system.debug('Section Clause found: ' + sectionClause);
                    system.debug('Section Value found: ' + sectionValueVariable);

                    // Remove the Section clause from filterCriteria
                    filterCriteria = filterCriteria.replace(sectionClause, '').trim();

                    // Clean up filterCriteria if it leaves trailing or leading 'AND' or extra spaces
                    filterCriteria = filterCriteria.replaceAll('AND\\s*$', '').trim(); // Remove trailing 'AND'
                    filterCriteria = filterCriteria.replaceAll('^AND\\s*', '').trim(); // Remove leading 'AND'
                }

                whereClause = (filterCriteria != null && filterCriteria != '') ? ' where ' + filterCriteria : '';
            }

            // Handle limit
            if (recordsLimit != null && recordsLimit != '' && recordsLimit != '0'){
                limitString = ' LIMIT ' + integer.valueof(recordsLimit);
            } else{
                limitString = ' LIMIT 9000';
            }
        }

        // Log section details for verification
        system.debug('Section: ' + sectionVariable);
        system.debug('Section Value: ' + sectionValueVariable);

        // Prepare the final query string
        queryString = 'select id ' + fieldQuery + ' from ' + objectApiName + whereClause + sortingOrderBy + limitString;

        // Log query string for debugging
        system.debug('Final Query String: ' + queryString);//Section to generate dynamic query ends-------------------
        System.debug(queryString);
        //Section to find columns label start-------------------
        if (columnLabelsList.size() > 0){
            for (string ss : columnLabelsList){
                if (ss != null && ss != ''){
                    columnLabelList.add(ss.trim());
                }
            }
        }
        //Section to find coumns label ends--------------------
        //Section to find field and their field type map starts------------
        fieldToFieldTypeMap = generateFieldTypeMap(objectApiName, FieldAPINameList);
        system.debug('***********fieldToFieldTypeMap:' + fieldToFieldTypeMap);
        //Section to find field and their field type map ends------------
        system.debug('***********queryString:' + queryString);
        system.debug('***********FieldAPINameList:' + FieldAPINameList);
        system.debug('***********columnLabelsList:' + columnLabelsList);


        list<sobject> sbList = new List<sobject>();
        if (queryString != null && queryString != ''){
            try{
                sbList = database.query(queryString);
            } catch (exception ex){
                system.debug('****Exception while query the related records.' + ex.getmessage());
                return 'MALFORMED SOQL STRING';
            }
        }
        //generating the dataset in order to display on UI
        // Assuming 'section' and 'sectionValue' are already defined somewhere in your method
        // Generating the dataset in order to display on UI
        list<list<String>> dataValues = new list<list<String>>();
        list<list<String>> columnsLabels = new list<list<String>>();

        if (sbList.size() > 0){
            for (sobject sb : sbList){
                // Initialize a flag to determine if we should add this record's values
                Boolean shouldAddRecord = false;

                list<String> fieldvalues = new List<String>();
                for (String ss : FieldAPINameList){
                    try{
                        string colValue;

                        //system.debug('******column API Name .' + ss);
                        if (ss.contains('.')){
                            List<string> splitedFields = ss.split('\\.');
                            //  system.debug('****splitedFields .' + splitedFields);
                            if (sb.getSobject(splitedFields[0]) != null && splitedFields[1] != null){
                                //    system.debug('******colValue describe .' + sb.getSobject(splitedFields[0]));
                                colValue = (String) sb.getSobject(splitedFields[0]).get(splitedFields[1]);
                            }
                        } else{
                            if (sb.get(ss) != null){
                                colValue = string.valueof(sb.get(ss));
                                if (fieldToFieldTypeMap.get(ss) != null){
                                    if (fieldToFieldTypeMap.get(ss) == DATE_DATATYPE || fieldToFieldTypeMap.get(ss) == DATETIME_DATATYPE){
                                        try{
                                            colValue = colValue.split(' ')[0];
                                            List<String> dateColumns = colValue.split('-');
                                            integer year = integer.valueof(dateColumns[0]);
                                            integer month = integer.valueof(dateColumns[1]);
                                            integer day = integer.valueof(dateColumns[2]);
                                            date myDate = date.newInstance(year, month, day);
                                            // system.debug('************myDate:' + myDate);
                                            colValue = myDate.format();
                                        } catch (exception ex){
                                            //              system.debug('******column is not of date or datetime datatype:' + ex.getmessage());
                                        }
                                    } else if (fieldToFieldTypeMap.get(ss) == CURRENCY_DATATYPE){
                                        String currencyIso = UserInfo.isMultiCurrencyOrganization() ? (String) sb.get('CurrencyIsoCode') : UserInfo.getDefaultCurrency();
                                        colValue = GetCurrencySymbolFromISO(currencyIso) + Decimal.valueof(colValue).format();
                                    }
                                }
                            }
                        }

                        system.debug('******colValue .' + colValue);
                        if (colValue == null || colValue == ''){
                            fieldvalues.add('');
                        } else{
                            // Check for hyperlink field and modify colValue if needed
                            if (ss.equalsIgnoreCase(HyperLinkField)){
                                colValue = '<a href=\'/' + sb.get('id') + '\' target=\'_blank\'>' + colValue + '</a>';
                            }
                            fieldvalues.add(string.valueof(colValue));

                            // Filter condition based on your requirements
                            System.debug(sectionValueVariable);
                            System.debug(sectionVariable);
                            if (sectionValueVariable.equals('All') || ( ss.equals(sectionVariable) && colValue.equals(sectionValueVariable))){
                                shouldAddRecord = true; // Mark that this record matches the filter


                            }
                        }
                    } catch (exception ex){
                        fieldvalues.add('');
                        system.debug('*******Error in some Field API Name.' + ex.getmessage());
                    }
                }

                // Add field values only if the record meets the filtering condition
                if (shouldAddRecord){
                    dataValues.add(fieldvalues);
                }
            }
        }

        if (columnLabelList.size() > 0){
            for (String ss : columnLabelList){
                columnsLabels.add(new List<String>{ ss });
            }
        }

        dataSet.data = dataValues;
        dataSet.columns = columnsLabels;
        string jsondata = JSON.serialize(dataSet);
        system.debug('*****jsondata:' + jsondata);
        return jsondata;
    }

    //new code  ends-----------------
    //method to generate field and their field type map
    public static Map<String, String> generateFieldTypeMap(string objectApiName, List<String> FieldAPINameList){
        Map<String, String> returnMap = new Map<String, String>();
        if (objectApiName != null && objectApiName != ''){
            Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectApiName).getdescribe().fields.getMap();
            for (String ss : FieldAPINameList){
                if (ss.contains('.')){
                    returnMap.put(ss, PARENT_RELATIONSHIP);
                } else{
                    returnMap.put(ss, string.valueof(fieldMap.get(ss).getDescribe().getType()));
                }
            }
        }
        return returnMap;
    }

    //method to return currency symbol
    public static String GetCurrencySymbolFromISO(String Iso){
        String currencySymbol = ('USD' == Iso ? '$' : ('CAD' == Iso ? '$' : ('EUR' == Iso ? '€' : ('GBP' == Iso ? '£' : ('JPY' == Iso ? '¥' : ('KRW' == Iso ? '₩' : ('CNY' == Iso ? '元' : 
                                '')))))));
        return currencySymbol;
    }

    public class datasetForTable{
        public List<List<String>> columns;
        public List<List<String>> data;

    }

}
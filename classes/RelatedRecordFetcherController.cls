public with sharing class RelatedRecordFetcherController {

    @AuraEnabled(cacheable=true)
    public static String fetchRelatedRecords(String objAPIname, List<String> FieldsAPINameList, List<String> columnLabelsList, String filterCriteria, String hyperLinkFieldName, String recordsLimit, String orgId) {
        System.debug('Organization Name: ' + orgId);
        System.debug('objAPIname: ' + objAPIname + ', FieldsAPINameList: ' + FieldsAPINameList + ', filterCriteria: ' + filterCriteria);

        String queryString = '';
        List<String> columnLabelList = new List<String>();
        datasetForTable dataSet = new datasetForTable();

        String fieldQuery = '';
        String objectApiName = '';
        String whereClause = '';
        String limitString = '';

        if (objAPIname != null && objAPIname != '') {
            objectApiName = objAPIname.trim();
            if (FieldsAPINameList.size() > 0) {
                for (String ss : FieldsAPINameList) {
                    if (ss != null && ss != '') {
                        fieldQuery += ', ' + ss.trim();
                    }
                }
            }
            if (filterCriteria != null && filterCriteria != '') {
                whereClause = ' WHERE ' + filterCriteria;
            }
            if (recordsLimit != null && recordsLimit != '' && recordsLimit != '0') {
                limitString = ' LIMIT ' + Integer.valueOf(recordsLimit);
            } else {
                limitString = ' LIMIT 10';
            }
        }

        queryString = 'SELECT Id ' + fieldQuery + ' FROM ' + objectApiName + whereClause + limitString;

        List<MetadataComponentDependency> sbList = new List<MetadataComponentDependency>();
        if (queryString != null && queryString != '') {
            try {
                sbList = ExternalDataFetcher1.fetchDataFromAPI(queryString, orgId);
            } catch (Exception ex) {
                System.debug('Exception while querying the related records: ' + ex.getMessage());
                return 'MALFORMED SOQL STRING';
            }
        }

        // Prepare column labels
        if (columnLabelsList.size() > 0) {
            for (string ss : columnLabelsList) {
                if (ss != null && ss != '') {
                    columnLabelList.add(ss.trim());
                }
            }
        }

        // Generating the dataset to display on UI (only including the necessary fields)
        List<List<String>> dataValues = new List<List<String>>();
        List<List<String>> columnsLabels = new List<List<String>>();
        
        if (sbList.size() > 0) {
            for (MetadataComponentDependency sb : sbList) {
                List<String> fieldValues = new List<String>();

                // Only include required fields: Id, MetadataComponentName, MetadataComponentType
                try {
                    String colValue = '';

                    // Process Id
                    if (FieldsAPINameList.contains('Id')) {
                        colValue = sb.Id;
                        fieldValues.add(colValue);
                    }

                    // Process MetadataComponentName
                    if (FieldsAPINameList.contains('MetadataComponentName')) {
                        colValue = sb.MetadataComponentName;
                        fieldValues.add(colValue);
                    }

                    // Process MetadataComponentType
                    if (FieldsAPINameList.contains('MetadataComponentType')) {
                        colValue = sb.MetadataComponentType;
                        fieldValues.add(colValue);
                    }

                } catch (Exception ex) {
                    fieldValues.add('');
                    System.debug('Error in processing field: ' + ex.getMessage());
                }

                dataValues.add(fieldValues);
            }
        }

        // Adding the column labels to the dataset
        if (columnLabelList.size() > 0) {
            for (String ss : columnLabelList) {
                columnsLabels.add(new List<String>{ ss });
            }
        }

        dataSet.data = dataValues;
        dataSet.columns = columnsLabels; // Adding columns labels
        String jsondata = JSON.serialize(dataSet);
        System.debug('jsondata: ' + jsondata);
        return jsondata;
    }

    public class datasetForTable {
        public List<List<String>> columns;
        public List<List<String>> data;
    }
}
({
    doInit: function(component, event, helper) {
        console.log('doInit of SK_GenericDataTable component called');

        var orgName = component.get('v.orgName');
        component.set('v.orgName', orgName); 

        console.log('Organization Name:', orgName);

        helper.callToServer(
            component,
            "c.getAllRelatedRecords",
            function(response) {
                if (response === 'MALFORMED SOQL STRING') {
                    alert('Some problem with dynamic SOQL query.');
                } else {
                    var tableData = response.replace(/(&quot\;)/g, "\"")
                                            .replace(/(&lt\;)/g, '<')
                                            .replace(/(&gt\;)/g, '>')
                                            .replace(/(&#39\;)/g, '\'')
                                            .replace(/(&amp\;)/g, '&');
                    var jsonData = JSON.parse(tableData);

                    // Rendering jQuery DataTable
                    setTimeout(function() {
                        var tableHeaders = "";
                        $.each(jsonData.columns, function(i, val) {
                            tableHeaders += "<th>" + val + "</th>";
                        });
                        $("#tableDiv").empty().append('<table id="displayTable" class="display" cellspacing="0" width="100%"><thead><tr>' + tableHeaders + '</tr></thead><tbody></tbody></table>');

                        // Populate table body
                        var tableBody = "";
                        $.each(jsonData.data, function(i, row) {
                            tableBody += "<tr>";
                            $.each(row, function(j, cell) {
                                tableBody += "<td>" + cell + "</td>";
                            });
                            tableBody += "</tr>";
                        });
                        $("#displayTable tbody").append(tableBody);

                        // Initialize DataTable with additional options
                        $("#displayTable").DataTable({
                            
                            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]], 
                            pageLength: 10, 
                            paging: true,  
                            searching: true, 
                            ordering: true,  
                            info: true,  
                            lengthChange: true 
                            
                        });
                    }, 100);
                }
            },
            {
                objAPIname: component.get('v.objAPIname'),
                FieldsAPINameList: component.get('v.fieldsAPINameList'),
                columnLabelsList: component.get('v.columnsLabelList'),
                sortColumns: component.get('v.sortingOrder'),
                filterCriteria: component.get('v.filterCriteria'),
                hyperLinkFieldName: component.get('v.linkField'),
                recordsLimit: component.get('v.recordsLimit'),
                orgName: orgName
            }
        );
    },

    showSpinner: function(component, event, helper) {
        var spinner = component.find("spinner");
        $A.util.removeClass(spinner, "slds-hide");
    },

    hideSpinner: function(component, event, helper) {
        var spinner = component.find("spinner");
        $A.util.addClass(spinner, "slds-hide");
    },

    exportToExcel: function(component, event, helper) {
        // Retrieve all rows in the DataTable (current table data)
        var tableData = $('#displayTable').DataTable().rows().data().toArray();
        var csvContent = "data:text/csv;charset=utf-8,";
    
        // Create header row from table
        var headers = $('#displayTable thead th').map(function() {
            return $(this).text();
        }).get().join(",") + "\n";
    
        csvContent += headers;
    
        // Create data rows for the table
        tableData.forEach(function(rowArray) {
            var row = rowArray.join(",");
            csvContent += row + "\n";
        });
    
        // Fetch the complete JSON data (assuming jsonData is available)
        var jsonData = component.get('v.jsonData');  // Ensure the JSON data is stored in the component
        if (jsonData) {
            csvContent += "\n\nComplete JSON Data\n";
            // Add JSON keys as headers
            var jsonHeaders = Object.keys(jsonData[0]).join(",") + "\n";  // Assuming jsonData is an array of objects
            csvContent += jsonHeaders;
    
            // Add JSON values for each record
            jsonData.forEach(function(record) {
                var jsonRow = Object.values(record).join(",");
                csvContent += jsonRow + "\n";
            });
        }
    
        // Encode the CSV content and trigger download
        var encodedUri = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", "table_data_with_json.csv");  // Name the CSV file
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
    ,
})
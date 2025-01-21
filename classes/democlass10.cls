public class democlass10 {
    
  // https://citizensbank-commercial--commops.sandbox.lightning.force.com/secur/frontdoor.jsp?sid=00D6C0000009yBP!AQwAQM1QJhjFtq_aE4y1feS2Hjk9Ynt52wj6YYxZmIaIJBqt_zzrUmXo8n5ZPw9XVpUfhpWIEKww9P5Nbldf8X8ixMr93Ivy
//
	/*Description:	Add new field called *Closer* field ( make it a Lookup to User (Users ) to and put it on the Commercial Loan Closing Doc QCA Page Layout under the Workpackage ID.  There is a field called Loan Closer that cannot be used as it looks up to the CONTACTS table. 

When opening a new QCA Key Field case record type/page layout automatically put it into * Assigned * status and have the Case Owner be the name of the Closer from the parent case. (Right now when a new Key field error case is opened it is assigned to the CML QCA Team Analyst queue). If no closer is selected on parent case , then pop up a message telling user to "To automatically assign the case, please select a closer Closer on the parent case in order to open an error . " 

Field should be editable for the below permission sets for the Commercial Loan Closing Doc QCA Page Layout : 
* CML QCA Team Analyst
* LendingOps Admin Users

Field is read only for the below permission sets
* CML QCA Users, CML QCA Users [R]
* LendingOps Users [R] */

             /*method caused the error : qcaKeyFieldValidation      -Error Line no:2133
test class method failed: testQcaKeyFieldValidation -failed line no: 1396

 1m 20s


System.DmlException: Insert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, Users having CML QCA Users permission set can only select Agree- Waiting, Agree- Made Update, Disagree – No Update, and Disagree - Made Update status values: []


i did the changes you asked for still i am getting this error

i think we need to bypass the validation rule in apex on the basis of permission set i see there is on permission set condition in the logic 
Description:	* CASE Object: ACH Requests Case field and page layout Updates*
* Add *NEW* field named *Cover Sheet Notes,* (Text 500-character limit) this should be *added to the notes* on the generated cover sheet
* Add *NEW* field named *Trace Number* (Text 15-character limit), this field drives the template to use. If null, the w/o trace template should be used. If provided, w/ trace number template should be used (Template stories have been updated to reflect this. 

* *Reason* field updates
** Move existing return Reasons under category Return to display under reversal, Make Reason *mandatory* .
** *Add* the following to the REASON DROPDOWN MENU for return category:
*** Account Closed
*** Account NSF
*** Name is a Match
*** Missing Date of Death
*** Missing Indemnification

*CONTACTS Object*

New Contact Record Type is needed to be able to pull all contacts that are financial institution. A new record type is the best way to do it without disrupting processes that use the other record types (clone the CS Ticketing Contact record type/layout)
* 
* * Record Type Name: *ACH Financial institution*
** Permissions: Add as available to the “ACH Ops Service Cloud User” permission set, as well as “OPS Partners” profile if they have the role of “ACH Ops”
** If contact record type is *ACH Financial institution,* default Company Name to *ACH Financial institutions* (In QA ID is 0018I00000jZisUQAS / ID in Production is 0015a00003NhsTIAAZ) 
** Add New Fields under a section labeled *Financial Institution Information* 
*** Financial Institution Name (data type = text(250) )
*** Financial Institution Phone (data type = Phone)
*** Financial Institution Fax  (data type = Phone)
*** Financial Institution Email (data type = email) 




*/                                            
 



}
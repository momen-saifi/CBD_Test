({
	doInit : function(component, event, helper) {
        // pageination
         var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value"); 
        helper.getacclist(component, pageNumber, pageSize);
        //getaccount
        var action=component.get("c.getaccountsdetails");
        action.setCallback(this,function(response){
            var acclist = response.getReturnValue();
             component.set("v.acclist",acclist);
        });
        $A.enqueueAction(action);
        },
    
    deleteAccountRecord: function(component,event,helper) {
            console.log('deleted called@@@@');
        var selectedItem = event.currentTarget;
        
        var recordid = selectedItem.getAttribute("data-record"); 
        var action=component.get("c.deleteRecord");
        
        action.setParams({
            recordID : recordid
        });
        action.setCallback(this,function(response){
            
             var state = response.getState();
            console.log('state value@@@@@@',state);
            console.log('retunr value@@@@@@', response.getReturnValue());
            if(state == 'SUCCESS') {
            component.set("v.errorMsg",response.getReturnValue());
            }
            else{
                component.set("v.errorMsg",' Something went wrong ');

            }
            window.setTimeout(
                $A.getCallback(function() {
                    component.set('v.errorMsg', '');
                }), 3000
            );
            
        });
        
        $A.enqueueAction(action);
              
    },
     updateStatus: function(component,event,helper) {
            
         var selectedItem = event.currentTarget;
       var recordid = selectedItem.getAttribute("data-record");
         console.log('recordid@@@@',recordid);
         component.set("v.recordId",recordid);
         component.set("v.showModal",true);
              
    },
     closePopup: function(component,event,helper) {
                  component.set("v.showModal",false);

     },
    handleSuccess: function(component,event,helper) {
        alert('Update successfully');
        component.set("v.showModal",false);
     //   $A.get('e.force:refreshView').fire();
        
    },
    SendEmail: function(component,event,helper) {
        
        // apex method to send email 
         var emaillist = component.get("v.Emaillist");
         var action=component.get("c.sendEmail");
        
        action.setParams({
            Selectedemaillist : emaillist
        });
        action.setCallback(this,function(response){
            
             var state = response.getState();
            console.log('state value@@@@@@',state);
            console.log('retunr value@@@@@@', response.getReturnValue());
            if(state == 'SUCCESS') {
            component.set("v.errorMsg",response.getReturnValue());
                 //  $A.get('e.force:refreshView').fire();
            }
            else{
                component.set("v.errorMsg",' Something went wrong ');

            }
            window.setTimeout(
                $A.getCallback(function() {
                    component.set('v.errorMsg', '');
                }), 3000
            );
            
        });
        
        $A.enqueueAction(action);
        
    },
     onchangeData: function(component,event,helper) {
        // apex method to send email 
         var selectedItem = event.currentTarget;
         console.log('selectedItem@@@@',selectedItem);
         var email = selectedItem.getAttribute("data-record");
         var emaillist = component.get("v.Emaillist");
         if(email){
             emaillist.push(email);
             component.set("v.Emaillist",emaillist); 
             
         }
           
         console.log("Emaillist",component.get("v.Emaillist"));
    },
    selectAll: function(component,event,helper) {
        
        console.log('selecy all ');
        var acclist = component.get('v.acclist');
        
        var emailist = component.get("v.Emaillist");
        for( var i=0;i<acclist.length;i++){
            if(acclist[i].email__c){
            emailist.push(acclist[i].email__c);
            }
            
        }
        component.set('v.Emaillist',emailist);
               
        
    },
    // pageination
     handleNext: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber++;
        helper.getacclist(component, pageNumber, pageSize);
    },
     
    handlePrev: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber--;
        helper.getacclist(component, pageNumber, pageSize);
    },
     
    onSelectChange: function(component, event, helper) {
        var page = 1
        var pageSize = component.find("pageSize").get("v.value");
        helper.getacclist(component, page, pageSize);
    },


})
({
	doInit : function(component, event, helper) {
        var action =component.get("c.getAccounts");
        action.setcallback (this,function(response){
            var state = response.getstate();
            if(state=== "SUCCESS"){
                
                component.set("v.acclist",response.getReturnValue());
            }
            
            
        }),
                           
        $A.enqueueAction(action);                   
                           
	}
})
({
	doInit : function(component, event, helper) {
		var action=component.get("c.getAccounts");
        action.setCallback(this,function(response){
            component.set("v.acclist",response.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})
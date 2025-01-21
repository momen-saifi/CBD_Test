({
	doInit : function(component, event, helper) {
		var action =component.get ("c.getStudents");
        action.setCallback(this,function(response){
component.set("v.stdlist",response.getReturnValue());
        }),
            $A.enqueueAction(action);
	}
})
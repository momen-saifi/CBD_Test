({
    getContactData : function(component, event, helper) {
        var action = component.get("c.getCon");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === 'SUCCESS') {
                component.set("v.getConList", response.getReturnValue());
            } else {
                console.error('Failed with state: ' + state);
            }
        });
        $A.enqueueAction(action);
    }
})
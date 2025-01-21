({
	doAction: function(component, event, helper) {
        var inputCmp = component.find ("inputCmp");
        var value = inputCmp.get("v.value");
        if(isNaN(value)){
            inputCmp.set("v.errors",
                         [{message:"input not a number:"+ value}]);
        } else {
            //clear error
            inputCmp.set("v.errors",null);
        }
        
        
	}
})
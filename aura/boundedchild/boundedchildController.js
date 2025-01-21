({
	updatechild : function(component, event, helper) {
        component.set("v.childvar","updated child value");
		
	},
  onchildVarChange  : function(component, event, helper) {
      consol.log("Child value has changed");
      consol.log("old value:"+event.getParam("oldvalue"));
      consol.log("new value:"+event.getParam("value"));
      
		
	}

})
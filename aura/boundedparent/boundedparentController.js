({
	updateparent : function(component, event, helper) {
		component.set("v.parentvar","Update Parent value");
	},
 onparentvarChange: function(component, event, helper) {
		 consol.log("parent value has changed");
      consol.log("old value:"+event.getParam("oldvalue"));
      consol.log("new value:"+event.getParam("value"));
	}    
})
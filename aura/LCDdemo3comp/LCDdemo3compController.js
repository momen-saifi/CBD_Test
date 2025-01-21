({
	doInit : function(component, event, helper) {
        component .set ("v.message1","button clicked");
        component.set("v.message2","button clicked");
		
	},
    
    handleclick : function(component, event, helper){
        component.set ("v.message1","button clicked");
    },
    anotherhandleclick: function(component,event,helper){
        component.set("v.message2","Another button clicked");
    }

})
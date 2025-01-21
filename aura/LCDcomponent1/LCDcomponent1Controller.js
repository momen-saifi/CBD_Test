({
doInit : function(component, event, helper) {
		component.set("v.var1","demo value from component controller")
        component.set("v.userdata",{
            'myString1': 'stringvalue',
            'myInteger1': 2021
        })
	}
})
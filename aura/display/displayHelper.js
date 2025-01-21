({
	 updateCurrentTime : function(component) {
        
        let currentTime = new Date();
        
        currentTime = currentTime.toLocaleTimeString();

        component.set("v.getCurrentTime", currentTime);

        // Call the same function again after 1 second
        setTimeout(function() {
            this.updateCurrentTime(component);
        }.bind(this), 1000);
    }
})
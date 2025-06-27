({
	helperMethod : function(component, event) {
		// component.set("v.Message", "Button Clicked");
		var msg = event.getSource().get("v.label");
        console.log(msg);
        
        if(msg == 'Change Message1') component.set("v.Message1", 'First Button Clicked');
        else component.set('v.Message2', 'Second Button Clicked');
	}
})
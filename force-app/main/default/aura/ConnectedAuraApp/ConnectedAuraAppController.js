({
	handleOpenModal : function(component, event, helper) {
		var visibility = component.get('v.visible');
		component.set('v.visible', !visibility);
	}
})
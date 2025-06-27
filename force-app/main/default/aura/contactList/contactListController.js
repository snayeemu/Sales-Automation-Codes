({
	doInit : function(component, event, helper) {
        component.set('v.Columns', [
            {label:"Name", fieldName:"Name", type:"text"},
            {label: 'Email', fieldName: 'Email', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'text'},
            {label: 'Account Name', fieldName: 'AccountName', type: 'text'},
        ]);
            
		var action = component.get('c.getContacts');
        action.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                var contacts = response.getReturnValue();
                contacts.forEach(cont => cont.AccountName = cont.Account.Name);
            	component.set('v.contacts', contacts);
            }
        })
        $A.enqueueAction(action);
	}
})
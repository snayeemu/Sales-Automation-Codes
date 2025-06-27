({
	doInit : function(component, event, helper) {
        component.set("v.Columns", [
            {label:"Name", fieldName:"Name", type:"text"},
            {label:"Owner Name", fieldName:"OwnerName", type:"text"},
            {label: 'Phone Number', fieldName: 'Phone', type: 'text'},
        ]);
        
		var action = component.get('c.getAccounts');
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
            	var accounts = response.getReturnValue();
            accounts.forEach(acc =>{acc.OwnerName = acc.Owner.Name});
                component.set('v.accList', accounts);
            }
        })
        $A.enqueueAction(action);
	}
})
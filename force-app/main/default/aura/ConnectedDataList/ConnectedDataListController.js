({
	doInit : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Contact Name', fieldName: 'Contact_Name__c', type: 'text'},
            {label: 'Account Name', fieldName: 'Account_Name__c', type: 'text'},
            {label: 'Opportunity Name', fieldName: 'Opportunity_Name__c', type: 'text'},
        ]);
		var action = component.get('c.getConnections');
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                //console.log(JSON.stringify(response.getReturnValue()));
                component.set('v.connectedData', response.getReturnValue());
            }
        })
        $A.enqueueAction(action);
	}
})
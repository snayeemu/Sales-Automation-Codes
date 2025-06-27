({
	doInit : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Opportunity Name', fieldName: 'Name', type: 'text'},
            {label: 'Account Name', fieldName: 'AccountName', type: 'text'},
            {label: 'Opportunity Stage', fieldName: 'StageName', type: 'text'},
        ])
		var action = component.get('c.getOpportunities');
        action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                var opportunities = response.getReturnValue();
                opportunities.forEach(opportunity => opportunity.AccountName = opportunity.Account.Name);
            	component.set('v.opportunities', opportunities);
            }
        })
        $A.enqueueAction(action);
	}
})
({
    handleClose : function(component, event, helper) {
        console.log(component.get('v.connectedData'));
        component.set('v.contactId', '');
        component.set('v.accountId', '');
        component.set('v.opportunityId', '');
        component.set('v.existingRecord', []);
        component.set('v.visible', false);
    },
    handleContactChange : function(component, event, helper){
        component.set('v.existingRecord', []);
        component.set('v.contactId', '');
        component.set('v.contactName', '');
        // component.set('v.accountId', '');
        var selectedContactId = event.dq.value[0];
        if(selectedContactId){
            var action = component.get('c.getContact');
            action.setParams({contactId: selectedContactId});
            action.setCallback(this, function(response){
                if(response.getState() === 'SUCCESS'){
                    var contactInfo = response.getReturnValue();
                    component.set('v.contactId', contactInfo.Id);
                    component.set('v.contactName', contactInfo.Name);
                    
                    if(contactInfo.Id){
                        var isConnectionExistAction = component.get('c.isConnectionExist');
                        isConnectionExistAction.setParams({contactId: contactInfo.Id});
                        isConnectionExistAction.setCallback(this, function(response){
                            if(response.getState() === 'SUCCESS'){
                                console.log('Inside Existing Success');
                                var existingConnection = response.getReturnValue();
                                component.set('v.existingRecord', existingConnection);
                                console.log(component.get('v.existingRecord'));
                                component.set('v.accountId', existingConnection.Account__c);
                            }
                        })
                        $A.enqueueAction(isConnectionExistAction);
                    }

                }
            })
            $A.enqueueAction(action);
        }
    },
    handleAccountChange : function(component, event, helper){
        component.set('v.accountId', '');
        component.set('v.accountName', '');
        var selectedAccountId = event.dq.value[0];
        console.log(selectedAccountId);
        if(selectedAccountId){
            var action = component.get('c.getAccount');
            action.setParams({accId: selectedAccountId});
            action.setCallback(this, function(response){
                if(response.getState() === 'SUCCESS'){
                    var accountInfo = response.getReturnValue();
                    component.set('v.accountId', accountInfo.Id);
                    component.set('v.accountName', accountInfo.Name);
                }
            })
            $A.enqueueAction(action);
        }
    },
    handleOpportunityChange : function(component, event, helper){
        component.set('v.opportunityId', '');
        component.set('v.opportunityName', '');
        var selectedOpportunityId = event.dq.value[0];
        console.log(selectedOpportunityId);
        if(selectedOpportunityId){
            var action = component.get('c.getOpportunity');
            action.setParams({oppId: selectedOpportunityId});
            action.setCallback(this, function(response){
                if(response.getState() === 'SUCCESS'){
                    var opportunityInfo = response.getReturnValue();
                    component.set('v.opportunityId', opportunityInfo.Id);
                    component.set('v.opportunityName', opportunityInfo.Name);
                    console.log(component.get('v.opportunityId'), component.get('v.opportunityName'));
                }
            })
            $A.enqueueAction(action);
        }
    },

    handleSave : function(component, event, helper){
        var contactId = component.get('v.contactId');
        var contactName = component.get('v.contactName');
        var accountId = component.get('v.accountId');
        var accountName = component.get('v.accountName');
        var opportunityId = component.get('v.opportunityId');
        var opportunityName = component.get('v.opportunityName');
        var existingRecord = component.get('v.existingRecord');
        console.log('called');
        var count = 0;
        if(accountId) count += 1;
        if(contactId) count += 1;
        if(opportunityId) count += 1;

        if(count < 2) {
            var toastEvent = $A.get("e.force:showToast");
            if(toastEvent){
                toastEvent.setParams({
                    mode: 'dismissible',
                    message: 'At least fill two field to make a connection.',
                });
                toastEvent.fire();
            }
            else
                alert('At least fill two field to make a connection!');
        }
        else{
            if(existingRecord.length){
                console.log('Inside Update');

                var action = component.get('c.updateConnectedRecord');
                action.setParams({contactId: contactId, opportunityId: opportunityId, opportunityName: opportunityName});
                action.setCallback(this, function(response){
                    if(response.getState() === 'SUCCESS'){
                        // var action2 = component.get('c.getConnections');
                        // action2.setCallback(this, function(response){
                        //     if(response.getState() === 'SUCCESS'){
                        //         //console.log(JSON.stringify(response.getReturnValue()));
                        //         component.set('v.connectedData', response.getReturnValue());
                        //         console.log(component.get('v.connectedData'));
                        //     }
                        // })
                        // $A.enqueueAction(action2);
                        alert('Connection Updated Successfully');
                    }
                });
                $A.enqueueAction(action);
            }
            else{
                console.log('Inside Create');

                var action = component.get('c.createConnectedRecord');
                action.setParams({contactId: contactId, accountId: accountId, opportunityId: opportunityId,contactName: contactName, accountName: accountName, opportunityName: opportunityName});
                action.setCallback(this, function(response){
                    if(response.getState() === 'SUCCESS'){
                        alert('Connection Created Successfully');
                    }
                });
                $A.enqueueAction(action);
            }
            component.set('v.contactId', '');
            component.set('v.accountId', '');
            component.set('v.opportunityId', '');
            component.set('v.existingRecord', []);

            var appEvent = $A.get("e.c:ConnectedDataUpdatedEvent");
            appEvent.fire();
            component.set('v.visible', false);
        }
    }
})
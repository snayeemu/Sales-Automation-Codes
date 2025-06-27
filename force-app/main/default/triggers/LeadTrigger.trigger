trigger LeadTrigger on Lead (after insert, after update, before update, before insert) {
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore){
        User nayeem = [Select Id from User where Email = 'snayeemu2@gmail.com'];
        User jubayer = [Select Id from User where Email = 'snayeemu2+user3@gmail.com'];

        List<Lead> newLeads = Trigger.new;
        
        for(Lead ld: newLeads){
            if(ld.Country == 'North America') ld.OwnerId = nayeem.Id;
            else if(ld.Country == 'UAE') ld.OwnerId = jubayer.Id;
        }
    }

    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter){
        Set<Id> leadIds = new Set<Id>();
        for (Lead l : Trigger.new) {
                leadIds.add(l.Id);
        }
        LeadSummaryController_VF.sendHighPriorityLeadEmail(leadIds);
    }
}
trigger LeadTrigger on Lead (after insert, after update) {
    Set<Id> leadIds = new Set<Id>();
    for (Lead l : Trigger.new) {
            leadIds.add(l.Id);
    }
    LeadSummaryController_VF.sendHighPriorityLeadEmail(leadIds);
}
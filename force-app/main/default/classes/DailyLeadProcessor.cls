public with sharing class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Lead> leads = new List<Lead>([select Id from Lead where LeadSource = Null]);
        for(Lead ld: leads){
            ld.LeadSource = 'Dreamforce';
        }
        update leads;
    }
}
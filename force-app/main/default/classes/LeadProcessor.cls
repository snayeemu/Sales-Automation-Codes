public with sharing class LeadProcessor implements Database.Batchable<SObject>, Database.Stateful {
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id from Lead');
    }
    public void execute(Database.BatchableContext bc, List<Lead> leads){
        for(Lead ld: leads){
            ld.LeadSource = 'Dreamforce';
            recordsProcessed += 1;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. 🔥');
    }
}
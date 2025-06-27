trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> tasks = new List<Task>();
    for(Opportunity opp : trigger.new){
        if(opp.StageName == 'Closed Won'){
            Task newTask = new Task();
            newTask.Subject = 'Follow Up Test Task';
            newTask.WhatId = opp.id;
            tasks.add(newTask);
        }
    }
    if(tasks.size() > 0)
    	upsert tasks;
}
public class OpportunityController {
	@AuraEnabled
    public static List<Opportunity> getOpportunities(){
        return [select id, name, stageName, Account.Name from opportunity limit 10];
    }
}
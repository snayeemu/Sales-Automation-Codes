public with sharing class TeamController {
    @AuraEnabled(cacheable=true)
    public static Decimal getBaseSalary(){
        try {
            Basic_Salary__c settings = Basic_Salary__c.getOrgDefaults();
            return settings.Basic_Salary__c;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static list<Team__c> getFirstTenTeams(){
        try {
            return [select name, Player_Name__c, Position__c, Individual_Salary__c from Team__c limit 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static Team__c getTeam(ID recordId){
        try {
            return [select name, Player_Name__c, Position__c, Individual_Salary__c, Category__c, Country_Name__c from Team__c where ID = :recordID];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    // This functionality is handled with JS, so we don't need this function anymore. 
    /* @AuraEnabled
    public static team__c insertTeam(ID teamId){
        try {
            team__c targetTeam = [select id, Category__c from team__c where id = :teamId];
            String category = targetTeam.Category__c;
            Decimal baseSalary = getBaseSalary();
            targetTeam.Individual_Salary__c = baseSalary * ((category == 'A') ? 1.9 : (category == 'B') ? 1.5 : (category == 'C') ? 1.2 : 1.0);
            update targetTeam;
            return targetTeam;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    } */
}
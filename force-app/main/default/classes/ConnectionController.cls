public class ConnectionController {
	@AuraEnabled
    public static List<Connected_Data__c> getConnections(){
        return [select Account__c, Account_Name__c, Contact__c, Contact_Name__c, Opportunity__c, Opportunity_Name__c from Connected_Data__c 
                order by LastModifiedDate Desc limit 10];
    }
    @AuraEnabled
    public static Contact getContact(Id contactId){
        return [select id, name from contact where Id = :contactId];
    }

    @AuraEnabled
    public static Account getAccount(Id accId){
        try {
            return [Select Id, Name from Account where Id = :accId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static Opportunity getOpportunity(Id oppId){
        try {
            return [Select Id, Name from Opportunity where Id = :oppId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static Connected_Data__c isConnectionExist(Id contactId){
        try {
            return [select Account__c, Account_Name__c from Connected_Data__c where Contact__c = :contactId limit 1];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void updateConnectedRecord(Id contactId, Id opportunityId, String opportunityName){
        try {
            Connected_Data__c connection = [select id from Connected_Data__c where Contact__c = :contactId limit 1];
            connection.Opportunity__c = opportunityId;
            connection.Opportunity_Name__c = opportunityName;
            update connection;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static void createConnectedRecord(Id contactId, Id accountId, Id opportunityId, String contactName, String accountName, String opportunityName){
        try {
            System.debug('Called');
            Connected_Data__c connection = new Connected_Data__c();
            connection.Contact__c = contactId;
            connection.Contact_Name__c = contactName;
            connection.Account__c = accountId;
            connection.Account_Name__c = accountName;
            connection.Opportunity__c = opportunityId;
            connection.Opportunity_Name__c = opportunityName;
            insert connection;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
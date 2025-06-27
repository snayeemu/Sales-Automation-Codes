public with sharing class AccountProcessor {
    
    @future
    public static void countContacts(List<Id> accountIds){
        List<account> accounts = new List<Account>([Select Id, (select Id from Contacts) from Account where Id in :accountIds]);
        Integer count = 0;
        for(Account acc: accounts){
            count = 0;
            for(Contact cont: acc.Contacts){
                count += 1;
            }
            acc.Number_Of_Contacts__c = count;
        }
        update accounts;
    }
}
public class ContactTriggerHelper {
    public static void changeParentAccountRatingToCold(List<Contact> contacts){
        List<Id> parentAccountId = new List<Id>();
        for(Contact cont: contacts) parentAccountId.add(cont.AccountId);
        List<Account> accounts = [Select rating from Account where id in :parentAccountId];
        List<Account> updatedAccounts = new List<Account>();
        
        for(Account acc: accounts) {
            acc.Rating = 'Cold';
            updatedAccounts.add(acc);
        }
        AccountTriggerDispatcher.flag = True;
        update updatedAccounts; 
    }
}
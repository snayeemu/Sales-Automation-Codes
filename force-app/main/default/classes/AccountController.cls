public class AccountController {
    @AuraEnabled
    public static List<Account> getAccounts(){
        return [select Id, Name, Phone, Owner.Name from Account Limit 10];
    }
}
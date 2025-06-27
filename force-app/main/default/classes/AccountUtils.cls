public with sharing class AccountUtils {
    public static List<Account> accountsByState(String givenState){
        List<Account> accounts = new List<Account>([Select Id from Account where BillingState = :givenState]);
        return accounts;
    }
}
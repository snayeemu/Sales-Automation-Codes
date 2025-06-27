public with sharing class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accounts) {
        for(Account ac: accounts) {
            ac.ShippingState = ac.BillingState;
        }
    }
}
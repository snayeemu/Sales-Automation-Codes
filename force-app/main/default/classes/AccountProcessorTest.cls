/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AccountProcessorTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < 10; i++) {
            Account acc = new Account(Name = 'Test Account ' + i);
            accounts.add(acc);
        }
        System.debug(accounts);
        insert accounts;
    }

    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test
        List<Id> accountIds = new List<Id>();
        List<Account> accounts = new List<Account>([select id, Name from Account]);
        for(Account acc: accounts) accountIds.add(acc.Id);
        System.debug(accountIds);
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();
        assert.areEqual(0, accounts[0].Number_Of_Contacts__c);
    }
}
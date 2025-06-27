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
private class AddPrimaryContactTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for(Integer i = 1; i <= 100; i++) {
            if(i <= 50){
                Account acc = new Account(name = 'Testing NY ' + i, BillingCountry = 'United States', BillingState = 'NY');
                accounts.add(acc);
            }
            else {
                Account acc = new Account(name = 'Testing CA ' + i, BillingCountry = 'United States', BillingState = 'CA');
                accounts.add(acc);
            }
        }
        insert accounts;
    }

    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test 
        Contact cont = new Contact(lastName = 'Contact for CA');
        AddPrimaryContact addPrimaryObj = new AddPrimaryContact(cont, 'CA');
        Test.startTest();
        System.enqueueJob(addPrimaryObj);
        Test.stopTest();
        Assert.areEqual(50, [select count() from Contact]);
    }
}
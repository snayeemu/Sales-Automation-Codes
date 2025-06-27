@isTest//(seeAllData = True)
public class accountHelperTest {
    @TestSetup
    static void makeData(){
     	Account acc = new Account(name = 'Test Account');
        //accounts.add(acc);
        //insert accounts;
        insert acc;   
    }
	@isTest
    static void createContactWithAccountsLastName_test(){
        list<Account> accounts = new list<Account>([select id, Name from account]);
        System.debug(accounts);
        Test.startTest();
        AccountTriggerHelper.createContactWithAccountsLastName(accounts);
        Test.stopTest();
        List<contact> contacts = new List<contact>([select id from Contact]);
        system.debug(contacts);
        System.assertEquals(contacts.size() > 0, True);
    }
    @isTest
    static void changeChildContactsName_test(){
		list<Account> accounts = new list<Account>([select id from account]);
        
        accounts[0].Name = 'Test Account 2';
        update accounts;
    }
}
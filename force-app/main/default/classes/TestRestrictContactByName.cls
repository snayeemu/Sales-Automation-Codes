@isTest
public class TestRestrictContactByName {
	@isTest
    static void RestrictContactByName_test(){
        Contact c = new Contact(LastName = 'INVALIDNAME ');
        Test.startTest();
        insert c;
        Test.stopTest();
        Assert.areEqual(0, [Select count() from Contact]);
    }
}
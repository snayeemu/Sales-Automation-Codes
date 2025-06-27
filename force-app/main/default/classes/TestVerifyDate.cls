@isTest
public class TestVerifyDate {
	@isTest
    static void CheckDates_Test(){
        Date output1;
        Date output2;
        Test.startTest();
        output1 = VerifyDate.CheckDates(date.valueOf('2025-06-24'), date.valueOf('2025-06-25'));
        output2 = VerifyDate.CheckDates(date.valueOf('2025-06-24'), date.valueOf('2028-06-25'));
        Test.stopTest();
        assert.areEqual(date.valueOf('2025-06-25'), output1);
        assert.areEqual(date.valueOf('2025-06-30'), output2);
    }
}
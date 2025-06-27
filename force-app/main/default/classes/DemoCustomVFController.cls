public with sharing class DemoCustomVFController {
    public List<Contact> contactList {get; set;}
    public String acFuncString {get; set;}
    public String acFuncParam {get; set;}
    
    public DemoCustomVFController() {
        contactList = [
            Select Id, FirstName, LastName, CreatedDate, Name
            FROM Contact
            LIMIT 10
        ];
    }
    
    public PageReference myActionFunc() {
        acFuncString = UserInfo.getName();
        return null;
    }
    
    public PageReference myActionFuncParam() {
        return null;
    }
}
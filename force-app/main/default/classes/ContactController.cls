public class ContactController {
    @AuraEnabled
    public static List<Contact> getContacts(){
        return [select name, email, phone, Account.Name from contact limit 10];
    }
}
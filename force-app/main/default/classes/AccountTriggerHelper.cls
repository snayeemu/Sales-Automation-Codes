public class AccountTriggerHelper {
    public static void createContactWithAccountsLastName(List<Account> accounts) {
        List<Contact> conts = new List<Contact>();
        for(Account acc: accounts){
            Contact c = new Contact();
            c.LastName = acc.Name;
            c.AccountId = acc.Id;
            conts.add(c);
        }
        insert conts; 
    }
    
    public static void changeChildContactsName(List<Account> accounts){
        List<Contact> updatedContacts = new List<Contact>();
            List<Contact> contacts = [Select lastName, Account.Name from Contact where AccountId in :accounts];
            for(Contact cont: contacts){
                cont.lastName = cont.Account.Name;
                updatedContacts.add(cont);
            }
        update updatedContacts;
    }
}
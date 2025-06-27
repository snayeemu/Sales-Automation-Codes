public with sharing class AddPrimaryContact implements Queueable {
    Contact cont;
    String stateName;
    List<Account> accounts;
    public AddPrimaryContact(Contact cont, String stateName) {
        this.cont = cont;
        this.stateName = stateName;
    }

    public void execute(QueueableContext context){
        this.accounts = new List<Account>([Select Id from account where BillingState = :stateName]);
        System.Debug(this.accounts);
        List<Contact> contacts = new List<Contact>();
        for(Account acc: this.accounts) {
            Contact cloneContact = this.cont.clone(False, True);
            cloneContact.AccountId = acc.Id;
            contacts.add(cloneContact);
        }
        system.debug(contacts);
        insert contacts;
    }
}
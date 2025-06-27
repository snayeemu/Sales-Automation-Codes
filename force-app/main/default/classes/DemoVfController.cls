public with sharing class DemoVfController {
	public final Contact cont;
    
    public DemoVfController(ApexPages.StandardController stdController) {
        cont = (Contact) stdController.getRecord();
    }
    
    public String getSomeValue() {
        return 'This is from controller extension ' + cont.LastName;
    }
}
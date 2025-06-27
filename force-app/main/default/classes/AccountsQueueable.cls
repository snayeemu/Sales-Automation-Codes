public class AccountsQueueable implements Queueable {
    public List<Account> accounts;
    
    public AccountsQueueable(List<Account> accounts){
        this.accounts = accounts;
    }
    
    public void execute(QueueableContext context){
        System.debug('Queueable Executed!');
        Id jobId = context.getJobId();
        System.debug(jobId);
        AsyncApexJob jobInfo = [Select status, numberOfErrors from AsyncApexJob where Id = :jobId];
    }
}
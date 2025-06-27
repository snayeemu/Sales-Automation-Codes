trigger invAccountTrigger on Account (before insert,before update, after insert, after update) {
    AccountTriggerDispatcher.dispatch(Trigger.OperationType);
}
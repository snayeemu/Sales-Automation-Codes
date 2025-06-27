trigger ContactTrigger on Contact (before insert, before update, after insert, after update) {
    ContactTriggerDispatcher.dispatch(Trigger.OperationType);
}
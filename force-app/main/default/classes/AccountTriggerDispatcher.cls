public class AccountTriggerDispatcher {
    public static Boolean flag = false;

    public static void dispatch(System.TriggerOperation operationType){
        
        if(!flag)
        switch on operationType{
            WHEN BEFORE_INSERT{
            }
            WHEN AFTER_INSERT{
               AccountTriggerHelper.createContactWithAccountsLastName(Trigger.New);
            }
            WHEN BEFORE_UPDATE{
                
            }
            WHEN AFTER_UPDATE{
                AccountTriggerHelper.changeChildContactsName(Trigger.New);
                
            }
            WHEN BEFORE_DELETE{
                
            }
            WHEN AFTER_DELETE{
                
            }
            WHEN AFTER_UNDELETE{
                
            }
            WHEN ELSE{
                
            }
        }
    }
}
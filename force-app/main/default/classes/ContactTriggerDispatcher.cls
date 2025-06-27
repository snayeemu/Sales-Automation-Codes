public class ContactTriggerDispatcher {
    public static Boolean flag = false;
    
	public static void dispatch(System.TriggerOperation operationType){
        if(!flag)
            switch on operationType{
                WHEN BEFORE_INSERT{
                }
                WHEN AFTER_INSERT{
                   
                }
                WHEN BEFORE_UPDATE{
                    
                }
                WHEN AFTER_UPDATE{
                    ContactTriggerHelper.changeParentAccountRatingToCold(Trigger.New);
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
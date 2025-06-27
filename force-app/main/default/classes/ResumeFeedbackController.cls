public with sharing class ResumeFeedbackController {
    @AuraEnabled
    public static void submitFeedback(String rating, String feedback){
        try {
            Resume_Feedback__c newFeedback = new Resume_Feedback__c(rating__c = rating, feedback__c = feedback);
            insert newFeedback;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
public with sharing class LeadSummaryController_VF {
    public Lead acc {get; set; }
    private Id leadIds;
    public Boolean sendEmail {get; private set;}

    public static PageReference sendPdfEmail(Lead ld) {
        Id leadOwnerId = ld.Owner.Id;
        PageReference pdfPage = Page.SendHighPriorityLeadDetailsPDF;
        pdfPage.getParameters().put('id', ld.Id);
        Blob pdfBlob = pdfPage.getContentAsPDF();

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('High Priority Lead Assigned');
        mail.setPlainTextBody('Please find attached the summary document for this high priority lead ' + ld.Name + '.');
        mail.setTargetObjectId(leadOwnerId);

        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('LeadSummary.pdf');
        attachment.setBody(pdfBlob);
        attachment.setContentType('application/pdf');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });

        mail.setSaveAsActivity(false);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});

        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Email sent successfully.'));
        return null;
    }
}
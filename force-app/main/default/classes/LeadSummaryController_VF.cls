public with sharing class LeadSummaryController_VF {

    // Use @future to run this in a separate, asynchronous transaction.
    // This is required for sending emails from a trigger.
    @future
    public static void sendHighPriorityLeadEmail(Set<Id> leadIds) {

        // Query for all necessary lead information in bulk.
        // It's crucial to include all fields needed for the email, including the owner's details.
        List<Lead> leadsToSend = [
            SELECT Id, Name, Company, Email, Phone, Description, Owner.Name, Owner.Id
            FROM Lead
            WHERE Id IN :leadIds
        ];

        if (leadsToSend.isEmpty()) {
            return; // No leads to process
        }

        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();

        // Loop through each lead and construct a personalized email.
        for (Lead l : leadsToSend) {
            // Skip sending an email if the owner is not an active user (e.g., a queue).
            if (l.OwnerId == null || !String.valueOf(l.OwnerId).startsWith('005')) {
                continue;
            }
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            // Set the recipient to the Lead Owner.
            mail.setTargetObjectId(l.Owner.Id);

            // Do not save an activity for this notification email.
            mail.setSaveAsActivity(false);
            
            // Set a dynamic and informative subject line.
            mail.setSubject('New High-Priority Lead Assigned: ' + l.Name + ' from ' + l.Company);

            // Construct the full URL to the Lead record.
            String leadRecordUrl = System.URL.getOrgDomainUrl().toExternalForm() + '/' + l.Id;

            // --- Enhanced HTML Body (No PDF Attachment) ---
            // All important information is now directly in the email body.
            String htmlBody = '<html>' +
                '<body style="font-family: Arial, sans-serif; font-size: 14px; color: #333;">' +
                '<h2>New High-Priority Lead Assignment</h2>' +
                '<p>Dear ' + l.Owner.Name + ',</p>' +
                '<p>A new high-priority lead has been assigned to you. Please review the details below and take prompt action.</p>' +
                '<table style="width: 100%; border-collapse: collapse; margin-bottom: 20px;" border="1">' +
                '<tr><td style="padding: 8px; background-color: #f2f2f2;"><strong>Lead Name:</strong></td><td style="padding: 8px;">' + l.Name + '</td></tr>' +
                '<tr><td style="padding: 8px; background-color: #f2f2f2;"><strong>Company:</strong></td><td style="padding: 8px;">' + (l.Company != null ? l.Company : 'N/A') + '</td></tr>' +
                '<tr><td style="padding: 8px; background-color: #f2f2f2;"><strong>Email:</strong></td><td style="padding: 8px;">' + (l.Email != null ? l.Email : 'N/A') + '</td></tr>' +
                '<tr><td style="padding: 8px; background-color: #f2f2f2;"><strong>Phone:</strong></td><td style="padding: 8px;">' + (l.Phone != null ? l.Phone : 'N/A') + '</td></tr>' +
                '<tr><td style="padding: 8px; background-color: #f2f2f2;"><strong>Description:</strong></td><td style="padding: 8px;">' + (l.Description != null ? l.Description : 'N/A') + '</td></tr>' +
                '</table>' +
                '<a href="' + leadRecordUrl + '" style="background-color: #0070d2; color: white; padding: 10px 15px; text-decoration: none; border-radius: 4px; display: inline-block;">View Lead in Salesforce</a>' +
                '<hr style="margin-top: 30px; border-top: 1px solid #ccc;"/>' +
                '<p style="font-size: 12px; color: #888;">This is an automated notification from your Salesforce system.</p>' +
                '</body></html>';
            mail.setHtmlBody(htmlBody);

            // Add the fully constructed email to our list.
            emailsToSend.add(mail);
        }

        // Send all prepared emails in a single callout to conserve limits.
        if (!emailsToSend.isEmpty()) {
            try {
                Messaging.sendEmail(emailsToSend);
            } catch (Exception e) {
                // In a real-world scenario, you would add more robust error logging here.
                System.debug('Error sending high-priority lead emails: ' + e.getMessage());
            }
        }
    }
}
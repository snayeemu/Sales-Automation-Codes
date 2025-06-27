trigger StudentTrigger on Student__c (after insert, after update, before insert, before update) {
    if(trigger.isInsert || trigger.isUpdate) {
        if(trigger.isAfter && trigger.isInsert){
            List<Id> schoolIds = new List<Id>();
            for(Student__c st: Trigger.new){
                schoolIds.add(st.School__c);
            }
            List<School__c> schools = new List<School__c>([Select Id, (Select Id from Students__r) from School__c where Id in :schoolIds]);
            Integer count = 0;
            
            for(School__c sch: schools){
                count = 0;
                for(Student__c st: sch.Students__r){
                    count++;
                }
                sch.Total_Number_of_Students__c = count;
            }
            update schools;  
        }
        if(trigger.isBefore){
            List<Student__c> students = new List<Student__c>();
        
            for(Student__c st: Trigger.new){
                students.add(st);
            }
            for(Student__c st: students){
                if(st.Email__c == Null) {
                    String lowerCaseName = st.Name.toLowerCase();
                    String[] splited = lowerCaseName.Split(' ');
                    st.Email__c = String.join(splited, '') + '@gmail.com';
                    //system.debug('condition true');
                }
                System.debug(st);
            }
        }
    }  
}
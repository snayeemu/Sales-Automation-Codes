public class FillEmptyEmail {
	   @InvocableMethod(label = 'Fill Empty Email of Student Recods')
        public static void fillEmails(){
            List<Student__c> students = new List<Student__c>([select Name, Email__c from Student__c where Email__c = null]);
            for(Student__c st: students){
                String lowerCaseName = st.Name.toLowerCase();
                String[] splited = lowerCaseName.Split(' ');
                st.Email__c = String.join(splited, '') + '@gmail.com';
            }
            if(!students.isEmpty())
            	update students;
        }
}
global class automation {
    
    global class InputParameters {
       @InvocableVariable(required=true)
       global string playerName;
        
       @InvocableVariable()
        global string category;
        
        @InvocableVariable()
        global string position;
        
        @InvocableVariable()
        global string country;
  }
    
    global class TeamOutputs {
        @InvocableVariable()
        global Id teamId;
        
        @InvocableVariable()
        global string name;
    }
    
    @InvocableMethod(label='Create New Team' description='This apex class will create new Team and will be called from a flow' category='Team__c')
    public static list<TeamOutputs> createTeam(list<InputParameters> inputs){
        Team__c newTeam = new Team__c();
		Basic_Salary__c cs = Basic_Salary__c.getInstance();
        Decimal basicSalary = cs.Basic_Salary__c;
        
        for(InputParameters inp: inputs){
            newTeam.Player_Name__c = inp.playerName;
            newTeam.Category__c = inp.category;
            newTeam.Position__c = inp.position;
            newTeam.Country_Name__c = inp.country;
            
           	if(inp.category == 'A'){
                newTeam.Individual_Salary__c = basicSalary * 1.9;
            }else if(inp.category == 'B'){
                newTeam.Individual_Salary__c = basicSalary * 1.5;            
            }else if(inp.category == 'C'){
                newTeam.Individual_Salary__c = basicSalary * 1.2;
            }else if(inp.category == 'D'){
                newTeam.Individual_Salary__c = basicSalary;
            }
            insert newTeam; 
        }
        
		
        TeamOutputs output = new TeamOutputs();
        output.teamId = newTeam.Id;
        output.name = newTeam.Player_Name__c;
        list<TeamOutputs> outputs = new list<TeamOutputs>();
        outputs.add(output);
        return outputs;
    }
}
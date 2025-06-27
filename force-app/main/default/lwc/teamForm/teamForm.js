import getBaseSalary from '@salesforce/apex/TeamController.getBaseSalary';
import { LightningElement, track } from 'lwc';
import Toast from 'lightning/toast';

export default class TeamForm extends LightningElement {
    fields = ['Player_Name__c', 'Country_Name__c', 'Position__c', 'Category__c'];
    baseSalary;
    visible = true;


    handleSubmit = (event) => {
        event.preventDefault();

        const fields = event.detail.fields;
        const category = fields?.Category__c;
        getBaseSalary().then(result => {
            try {
                this.baseSalary = result;
                console.log(this.baseSalary);
                
                const multiplier = (category == 'A') ? 1.9 : (category == 'B') ? 1.5 : (category == 'C') ? 1.2 : 1.0;
                fields['Individual_Salary__c'] = this.baseSalary * multiplier;
                console.log(fields);
                
                this.template.querySelector('lightning-record-form').submit(fields);
            } catch (error) {
                console.log(error);
            }
        }).catch(e => console.log(e));
    }

    handleSuccess(event) {
        this.visible = false;
        this.template.querySelector('lightning-record-form').recordId = null;

        Toast.show({
            label: 'Created Successfully',
            message: `New Team Created Successfully`,
            mode: 'dismissible',
            variant: 'success'
        }, this);

        setTimeout(() => {
            this.visible = true;
        }, 0);
    }
}
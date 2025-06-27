import { LightningElement } from 'lwc';

export default class TeamFormWrapper extends LightningElement {
    visible = true;
    formId = Date.now();

    handleOnFormSubmitted = (event) => {
        this.visible = false;
        this.formId = Date.now();
        console.log(this.formId);
        this.visible = true;
    }
}
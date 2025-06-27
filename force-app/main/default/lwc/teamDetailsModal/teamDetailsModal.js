import { LightningElement, api } from 'lwc';
import LightningModal from 'lightning/modal';
import getTeam from '@salesforce/apex/TeamController.getTeam';


export default class TeamDetailsModal extends LightningModal  {
    @api content;

    handleOkay() {
        this.close('okay');
    }
}
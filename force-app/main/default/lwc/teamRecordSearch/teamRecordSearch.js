import getTeam from '@salesforce/apex/TeamController.getTeam';
import TeamDetailsModal from 'c/teamDetailsModal';
import { LightningElement } from 'lwc';

export default class TeamRecordSearch extends LightningElement {
    selectedRecordId;

    matchingInfo = {
        primaryField: { fieldPath: 'Name', mode: 'startsWith' },
        additionalFields: [{ fieldPath: 'Player_Name__c' }],
    };

    handleChange = (event) => {
        this.selectedRecordId = event.detail.recordId;

        if(!this.selectedRecordId)
            this.handleSearch();
    }

    handleSearch = () => {
        
        const searchEvent = new  CustomEvent('searchevent', {
            detail: this.selectedRecordId
        })
        this.dispatchEvent(searchEvent);
        console.log('child called');
        
    }
}
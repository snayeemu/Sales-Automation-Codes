import getFirstTenTeams from '@salesforce/apex/TeamController.getFirstTenTeams';
import getTeam from '@salesforce/apex/TeamController.getTeam';
import TeamDetailsModal from 'c/teamDetailsModal';
// import TeamDetailsModal from 'c/teamDetailsModal';

import { LightningElement, track, wire } from 'lwc';

export default class TeamList extends LightningElement {
    @track teams = [];
    visible = false;
    recordData;

    tenTeamsGetter = () => {
        getFirstTenTeams().then(res => {
            this.teams = res;
        }).catch(e => console.log(e));
    }

    connectedCallback() {
        this.tenTeamsGetter()
    }

    handleShowModal = async (event) => {
        event.preventDefault();
        const id = event.currentTarget.dataset.id;
        console.log(id);
        

        getTeam({recordId : id}).then(data => {
            this.recordData = data;

            TeamDetailsModal.open({
                // `label` is not included here in this example.
                // it is set on lightning-modal-header instead
                size: 'small',
                description: 'Accessible description of modal\'s purpose',
                content: data || {},
            });

            console.log(this.recordData);
            }).catch(e => console.log(e));
    }

    handleSearchEvent = (event) => {
        console.log(event.detail);
        
        if(event.detail)
            getTeam({recordId: event.detail}).then(data => {
                console.log(JSON.stringify(data));
                this.teams = [data];
            }).catch(e => console.log(e))
        else
            {
                console.log(JSON.stringify(event.detail));
                this.tenTeamsGetter();
            }

        console.log('Parent called');
        
    }
}
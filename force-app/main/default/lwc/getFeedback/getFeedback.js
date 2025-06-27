import submitFeedback from '@salesforce/apex/ResumeFeedbackController.submitFeedback';
import { LightningElement, track } from 'lwc';

export default class GetFeedback extends LightningElement {
    rating = 5;
    @track review = '';
    handleRatingChange = (event) => {
        this.rating = event.target.value;
    }

    handleFeedbackChange = (event) => {
        this.review = event.target.value;
    }

    handleSubmit = (event) => {
        event.preventDefault();
        console.log('submit');
        submitFeedback({rating: this.rating, feedback: this.review}).then(res => {
            this.review = '';
            alert('Submitted Successfully')
        });
    }
}
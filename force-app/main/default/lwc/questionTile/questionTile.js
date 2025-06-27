import { LightningElement, api } from 'lwc';

export default class QuestionTile extends LightningElement {
    @api question;
    @api questionNumber;

    handleClick = (event) => {
        const answer = new CustomEvent('answered', {
            detail: {answer: event.currentTarget.label}
        })
        this.dispatchEvent(answer);
    }
}
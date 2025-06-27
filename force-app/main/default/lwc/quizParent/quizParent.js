import { LightningElement, track } from 'lwc';
import Toast from 'lightning/toast';

export default class QuizParent extends LightningElement {
    quizStyles = ``;
    @track questions = [
        {
            id: 1,
            question: 'What is the capital of France?',
            options: ['Paris', 'London', 'Berlin', 'Madrid'],
            answer: 'Paris'
        },
        {
            id: 2,
            question: 'Which language runs in a web browser?',
            options: ['Java', 'C', 'Python', 'JavaScript'],
            answer: 'JavaScript'
        },
        {
            id: 3,
            question: 'Who wrote "Hamlet"?',
            options: ['Tolstoy', 'Shakespeare', 'Hemingway', 'Austen'],
            answer: 'Shakespeare'
        },
        {
            id: 4,
            question: 'What is the boiling point of water at sea level?',
            options: ['90°C', '100°C', '110°C', '120°C'],
            answer: '100°C'
        },
        {
            id: 5,
            question: 'Which planet is known as the Red Planet?',
            options: ['Earth', 'Jupiter', 'Mars', 'Saturn'],
            answer: 'Mars'
        },
        {
            id: 6,
            question: 'What does HTML stand for?',
            options: [
                'HyperText Markup Language',
                'HighText Machine Language',
                'Hyperloop Machine Language',
                'Hyperlink and Text Markup Language'
            ],
            answer: 'HyperText Markup Language'
        },
        {
            id: 7,
            question: 'Which company developed the Windows OS?',
            options: ['Apple', 'IBM', 'Microsoft', 'Intel'],
            answer: 'Microsoft'
        },
        {
            id: 8,
            question: 'What is 9 + 10?',
            options: ['19', '21', '18', '20'],
            answer: '19'
        },
        {
            id: 9,
            question: 'Which gas do plants absorb from the atmosphere?',
            options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
            answer: 'Carbon Dioxide'
        },
        {
            id: 10,
            question: 'Who painted the Mona Lisa?',
            options: ['Vincent Van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Michelangelo'],
            answer: 'Leonardo da Vinci'
        }
    ];
    @track answeredQuestionNumbers = {};
    @track marks = {obtainedMarks: 0, attempted: Object.keys(this.answeredQuestionNumbers).length};


    handleAnswer = (event) => {
            const selectedAnswer = event.detail?.answer;
            const questionNumber = event.currentTarget.dataset.questionNumber;
            // console.log(JSON.stringify(this.questions[questionNumber].answer));
            
            if (this.questions[questionNumber].answer === selectedAnswer && !this.answeredQuestionNumbers[questionNumber]){
                this.marks.obtainedMarks++;
                this.marks.attempted++;
                this.answeredQuestionNumbers[questionNumber] = true;
                console.log(this.marks.obtainedMarks, JSON.stringify(this.answeredQuestionNumbers));

                Toast.show({
                label: 'Correct Answer',
                mode: 'dismissible',
                variant: 'success'
                }, this);

                this.template.querySelector(`[data-id="${questionNumber}"]`).classList.add('attempted-quiz-success');
                
            }
            else if(this.questions[questionNumber].answer !== selectedAnswer && !this.answeredQuestionNumbers[questionNumber]){
                this.answeredQuestionNumbers[questionNumber] = true;
                this.marks.attempted++;
                console.log('Wrong answer');

                Toast.show({
                label: `Answer is: ${this.questions[questionNumber].answer}`,
                mode: 'dismissible',
                variant: 'error'
                }, this);

                this.template.querySelector(`[data-id="${questionNumber}"]`).classList.add('attempted-quiz-error');
            }
            else if(this.answeredQuestionNumbers[questionNumber]){
                Toast.show({
                label: `Already attempted`,
                mode: 'dismissible',
                variant: 'warning'
                }, this);
            }
    }
}
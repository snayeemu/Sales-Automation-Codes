import { LightningElement } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import profile from '@salesforce/resourceUrl/profilePic';
import FontAwesome from '@salesforce/resourceUrl/FontAwesome';

export default class Resume extends LightningElement {
    profilePic = profile;
    
    // Guard to prevent animations from running on every re-render
    animationsInitialized = false;

    renderedCallback() {
        // Run animations only once after the component has rendered
        if (this.animationsInitialized) {
            return;
        }
        this.animationsInitialized = true;

        // Use Promise.all to load all styles before running animations
        Promise.all([
            // NOTE: The path inside the zip file must be correct
            loadStyle(this, FontAwesome + '/FontAwesome/css/all.min.css')
        ])
        .then(() => {
            console.log('All styles loaded successfully');
            this.animateSkills();
        })
        .catch(error => {
            console.error('Error loading static resources', error);
        });
    }

    animateSkills() {
        // Animate the linear progress bars
        const skillBars = this.template.querySelectorAll('.skills-prog .bar');
        skillBars.forEach((bar, index) => {
            const percentage = bar.closest('li').dataset.percent;
            // The staggered delay is handled with setTimeout
            setTimeout(() => {
                // Setting the width triggers the CSS transition in the .css file
                bar.style.width = percentage + '%';
            }, index * 150);
        });

        // Animate the circular SVG progress bars
        const softSkills = this.template.querySelectorAll('.skills-soft li');
        softSkills.forEach((skill, index) => {
            const circle = skill.querySelector('.cbar');
            const textElement = skill.querySelector('small');
            const percentage = skill.dataset.percent;

            if (circle) {
                const radius = circle.r.baseVal.value;
                const circumference = 2 * Math.PI * radius;
                const offset = circumference * (1 - percentage / 100);

                setTimeout(() => {
                    // Setting the offset triggers the CSS transition
                    circle.style.strokeDashoffset = offset;
                    // Animate the counter text
                    this.animateCounter(textElement, 0, percentage, 1000);
                }, index * 150);
            }
        });
    }

    /**
     * Animates a number counter from a start to an end value.
     * @param {HTMLElement} element The HTML element to update.
     * @param {number} start The starting number.
     * @param {number} end The ending number.
     * @param {number} duration The animation duration in milliseconds.
     */
    animateCounter(element, start, end, duration) {
        let startTime = null;

        const step = (timestamp) => {
            if (!startTime) startTime = timestamp;
            const progress = Math.min((timestamp - startTime) / duration, 1);
            const currentValue = Math.floor(progress * (end - start) + start);
            element.textContent = currentValue + '%';
            if (progress < 1) {
                window.requestAnimationFrame(step);
            }
        };

        window.requestAnimationFrame(step);
    }
}
import { LightningElement,track,api } from 'lwc';
import getWaiting from '@salesforce/apex/CSTQueueController.getWaiting';

export default class CSTQueueCSTInfo extends LightningElement {

    @track waiting;

    timeIntervalInstance;


    
    get waitingStatus() {
        // waiting has the items in order
        // queuemuber has the potential item to show 
        // but queuenumber might be worng as the list changes
        console.log('Inside waitingStatus');
        
        // if we have nothing in the waiitng queue then return
        if (this.waiting === undefined)
            return '';

        // if the quenumber is too large then reset
        console.log('Length of waiting');
        console.log(this.waiting.length);

        return this.waiting.length;
    }




    disconnectedCallback() {
        clearInterval(this.timeIntervalInstance);
    }
    

    connectedCallback() {
        console.log('Inside connectedCallback');

        var parentThis = this;
        this.timeIntervalInstance = setInterval(function()  {
            console.log('Inside setInterval');
            parentThis.queuenumber = parentThis.queuenumber + 1;
            console.log(parentThis.queuenumber);
            console.log('Ending  setInterval');


            getWaiting()
            .then(result => {
                // eslint-disable-next-line no-console
                console.log('In getWaiting results');
                // eslint-disable-next-line no-console
                console.log(result);
                parentThis.waiting = result.map((waitingItem, index) => {
                    return {
                        item: waitingItem,
                       index: index
                    }
                })           
                console.log(parentThis.waiting);
            })
            .catch(error => {
                // eslint-disable-next-line no-console
                console.log('Error In getAnnouncing');
                parentThis.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading getWaiting details',
                        message: reduceErrors(error).join(', '),
                        variant: 'error'
                    })
                );
            });        
        // eslint-disable-next-line no-console
        console.log('Finished In getWaiting');
    }, 5000);
}
       
}
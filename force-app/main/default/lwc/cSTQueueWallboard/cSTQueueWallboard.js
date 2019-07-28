import { LightningElement,track,api } from 'lwc';
import getAnnouncing from '@salesforce/apex/CSTQueueController.getAnnouncing';

export default class CSTQueueWallboard extends LightningElement {

    @track announcing;

    timeIntervalInstance;

    @api
    queuenumber = 0;
    
    get getPositionToDisplay() {
        // waiting has the items in order
        // queuemuber has the potential item to show 
        // but queuenumber might be worng as the list changes
        console.log('Inside getPositionToDisplay');
        
        // if we have nothing in the waiitng queue then return
        if (this.announcing === undefined)
            return '';

        // if the quenumber is too large then reset
        console.log('Length of waiting');
        console.log(this.announcing.length);
        console.log('queuenumber');
        console.log(this.queuenumber);
        if (this.queuenumber+1 > this.announcing.length)
            {
                console.log('reset queuenumber');
                this.queuenumber = 0;
            }


        console.log('showing new queueposition');
        return this.announcing[this.queuenumber].item.QueuePosition__c;
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


            getAnnouncing()
            .then(result => {
                // eslint-disable-next-line no-console
                console.log('In getAnnouncing results');
                // eslint-disable-next-line no-console
                console.log(result);
                parentThis.announcing = result.map((announceItem, index) => {
                    return {
                        item: announceItem,
                       index: index
                    }
                })           
                console.log(parentThis.announcing);
            })
            .catch(error => {
                // eslint-disable-next-line no-console
                console.log('Error In getAnnouncing');
                parentThis.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading getAnnouncing details',
                        message: reduceErrors(error).join(', '),
                        variant: 'error'
                    })
                );
            });        
        // eslint-disable-next-line no-console
        console.log('Finished In getAnnouncing');
    }, 5000);
}
       
}
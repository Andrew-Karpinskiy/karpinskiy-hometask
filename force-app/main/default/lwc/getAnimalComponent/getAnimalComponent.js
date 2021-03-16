import { LightningElement, track, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAnimalFromStartToEndId from '@salesforce/apex/AnimalController.getAnimalFromStartToEndId';
export default class GetAnimalComponent extends LightningElement {

    @track startId;
    @track endId;
    @api receivedData;

    changeHandler(event) {
        if (event.target.name == 'startId') {
            this.startId = event.target.value;
        } else if (event.target.name == 'endId') {
            this.endId = event.target.value;
        }
    }

    handleClick(event) {
        if (this.startId > 0 && this.endId > 0) {
            getAnimalFromStartToEndId({
                startId: this.startId,
                endId: this.endId
            })
                .then(res => {
                    this.receivedData = res;
                })
                .catch(error => {
                    const evt = new ShowToastEvent({
                        title: "Error!",
                        message: 'Cant get animals!',
                        variant: 'error'
                    });
                    this.dispatchEvent(evt);
                });
        }
    }
}
import { LightningElement, wire, api, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Animal__c.Name';
import SAYS_FIELD from '@salesforce/schema/Animal__c.Says__c';
import EATS_FIELD from '@salesforce/schema/Animal__c.Eats__c';
import EXTERNALID_FIELD from '@salesforce/schema/Animal__c.External_Id__c';
import saveAnimals from '@salesforce/apex/AnimalController.saveAnimals';

const COLUMNS = [
    { label: 'Animal Name', fieldName: NAME_FIELD.fieldApiName},
    { label: 'Eats', fieldName: EATS_FIELD.fieldApiName, type: 'text' },
    { label: 'Says', fieldName: SAYS_FIELD.fieldApiName, type: 'text' },
    { label: 'External Id', fieldName: EXTERNALID_FIELD.fieldApiName, type: 'text' }
];


export default class AnimalTable extends LightningElement {
    @api animals; 
    columns = COLUMNS;

    saveSelected(event) {
        let selectedRows = this.template.querySelector('lightning-datatable').getSelectedRows();

        let animalsArray = {
            data: []
        };
        
        if (selectedRows.length > 0) {
            for(let i in selectedRows) {    
                let item = selectedRows[i];   
                animalsArray.data.push({ 
                    "Name" : item.Name,
                    "Eats"  : item.Eats__c,
                    "Says"       : item.Says__c,
                    "ExternalId" : item.External_Id__c
                });
            } 
    
            saveAnimals({
                jsonInput: JSON.stringify(animalsArray)
            })
                .then(res => {
                    const evt = new ShowToastEvent({
                        title: "Sucsess!",
                        message:  res,
                        variant: 'success'
                    });
                    this.dispatchEvent(evt);
                })
                .catch(error => {
                    const evt = new ShowToastEvent({
                        title: "Error!",
                        message: 'Cant save animals to database!',
                        variant: 'error'
                    });
                    this.dispatchEvent(evt);
                }); 
        }        
    }
}
({
   displayHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Pen name', fieldName: 'Pen_Name__c', type: 'text'},
            {label: 'Phone number', fieldName: 'Phone_Number__c', type: 'text'},
            {label: 'Website', fieldName: 'Website__c', type: 'text'},
            {label: 'Email', fieldName: 'Email__c', type: 'text'}
        ]);  
            
        var action = component.get("c.getAuthors");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.authList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }  
});
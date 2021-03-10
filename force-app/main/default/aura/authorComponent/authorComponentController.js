({
    clickCreate: function(component, event, helper) {
        let newAuthor = component.get("v.newAuthor");
        
        let action = component.get("c.saveAuthor");
        action.setParams({
            "author": newAuthor
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log("New Author created!");
            }
        });
        $A.enqueueAction(action); 
    }
})
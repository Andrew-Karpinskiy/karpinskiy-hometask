({
   createAuthor: function(component, author) {
        let action = component.get("c.saveAuthor");
        action.setParams({
            "author": author
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log("New Author created!");
            }
        });
        $A.enqueueAction(action);
    },

})
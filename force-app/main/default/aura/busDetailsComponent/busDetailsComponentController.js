({        
    busComponentEvent: function(component, event, helper){ 
        component.set("v.busrecordId",event.getParam("busRecordId"));
    },
    
    handleSuccess: function(component, event, helper){
        const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "message": "Successfully Saved",
            "type": "success",
        });
        toastEvent.fire();
    },
    
    handleError: function(component, event, helper){
        const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "message": "Failed to Save Records",
            "type": "error",
        });
        toastEvent.fire();
    }
})
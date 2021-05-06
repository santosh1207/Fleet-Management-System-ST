({
    doInit: function (component, event, helper) {
        var action=component.get('c.getAllBusRecords');
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                for(var i=0; i<response.getReturnValue().length; i++){
                    response.getReturnValue()[i].License_Plate__c = 'License Plate #' + response.getReturnValue()[i].License_Plate__c;
                }
                component.set("v.busList",response.getReturnValue());
            }else if(state==="ERROR"){
                console.error(response.getError());
            }
        });
        $A.enqueueAction(action);
    },
    
    handleData: function(component, event, helper){
        var busList = [];
        busList = component.get("v.busList");
        for(var i = 0; i < busList.length; i++){
            if(busList[i].Id == event.currentTarget.getAttribute("data-Id")){
               busList[i].class = 'selected'; 
            }
            else{
                busList[i].class = 'notSelected';
            }
        }
        component.set("v.busList", busList);
        
        var appEvent = $A.get("e.c:FleetManagementSystemEvent"); 
        appEvent.setParams({
            "busRecordId" : event.currentTarget.getAttribute("data-Id"),
        });
        appEvent.fire(); 	
    }
})
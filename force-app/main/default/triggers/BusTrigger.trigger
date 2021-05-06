trigger BusTrigger on Bus__c (before insert, before update) {
    
    if(trigger.isBefore && trigger.isInsert){
    	BusTriggerHandler.insertResaleValue(trigger.new);    
    }
    
    if(trigger.isBefore && trigger.isUpdate){
    	BusTriggerHandler.updateResaleValue(trigger.oldMap, trigger.newMap);	    
    }
}
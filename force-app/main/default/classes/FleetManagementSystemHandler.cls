public class FleetManagementSystemHandler {
    
    @AuraEnabled
    public static List<Bus__c> getAllBusRecords(){
        return [
        	SELECT Bus_Image__c, Odometer_Reading__c, Year__c, 
            	   Name, License_Plate__c
            FROM Bus__c
            ORDER BY LastModifiedDate DESC
        ];
    }
}
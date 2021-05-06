@isTest
public class FleetManagementSystemHandlerTest {

    @isTest
    static void testAllBusRecords(){
    	Bus__c testBus1 = new Bus__c(
        	Name = 'Test Bus 1',
            Maximum_Capacity__c = '24',
            Odometer_Reading__c = 90000,
            Year__c = '2010'
        );
        insert testBus1;
        
        Bus__c testBus2 = new Bus__c(
        	Name = 'Test Bus 2',
            Maximum_Capacity__c = '36',
            Odometer_Reading__c = 50000,
            Year__c = '2000'
        );
        insert testBus2;
        
        Test.startTest();
        List<Bus__c> busList = FleetManagementSystemHandler.getAllBusRecords();
        Test.stopTest();
        
        System.assertEquals(false, busList.isEmpty());
    }
}
@isTest
public class BusMaintanenceBatchJobTest {

    @testsetup
    static void setup(){
        List<Bus__c> busList = new List<Bus__c>();
        List<Garage__c> garageList = new List<Garage__c>();
        
    	Bus__c testBus1 = new Bus__c(
        	Name = 'Test Bus 1',
            Maximum_Capacity__c = '60',
            Odometer_Reading__c = 10000,
            Year__c = '2000'
        );
        busList.add(testBus1);
        
        Bus__c testBus2 = new Bus__c(
        	Name = 'Test Bus 2',
            Maximum_Capacity__c = '60',
            Odometer_Reading__c = 20000,
            Year__c = '2005'
        );
        busList.add(testBus2);
        
        Bus__c testBus3 = new Bus__c(
        	Name = 'Test Bus 3',
            Maximum_Capacity__c = '60',
            Odometer_Reading__c = 30000,
            Year__c = '2010'
        );
        busList.add(testBus3);
        
        Garage__c testGarage1 = new Garage__c(
            Location_City__c = 'San Diego',
            Location__Latitude__s = 32.7157,
       		Location__Longitude__s = 117.1611
        );
        garageList.add(testGarage1);
        
        Garage__c testGarage2 = new Garage__c(
            Location_City__c = 'LA',
            Location__Latitude__s = 34.0522,
            Location__Longitude__s = 118.2437
        );
        garageList.add(testGarage2);
        
        Garage__c testGarage3 = new Garage__c(
            Location_City__c = 'New York',
            Location__Latitude__s = 40.7128,
            Location__Longitude__s = 74.0060
        );
        garageList.add(testGarage3);
        
        insert busList;
        insert garageList;
    }
    
    @isTest
    static void testServiceRequired(){
        List<Bus__c> busList = [SELECT Id, Name, Last_Ping_Location__Latitude__s,Last_Ping_Location__Longitude__s,
                          	     	   Next_Service_Odometer_Reading__c
            			  		FROM Bus__c
                         	   ];
        for(Bus__c bus : busList){
            if(bus.Name == 'Test Bus 1'){
        		bus.Odometer_Reading__c = 15100;
        		bus.Last_Ping_Location__Latitude__s = 33.1192;
        		bus.Last_Ping_Location__Longitude__s = 117.0864;    
            }
            if(bus.Name == 'Test Bus 2'){
        		bus.Odometer_Reading__c = 26000;
        		bus.Last_Ping_Location__Latitude__s = 34.28056;
        		bus.Last_Ping_Location__Longitude__s = 119.2945;
            }
            if(bus.Name == 'Test Bus 3'){
        		bus.Odometer_Reading__c = 35550;
        		bus.Last_Ping_Location__Latitude__s = 40.7357;
        		bus.Last_Ping_Location__Longitude__s = 74.1724;
            }
        }
        update busList;
        
        Test.startTest();
        Database.executeBatch(new BusMaintanenceBatchJob());
        Test.stopTest();
        
        List<Maintenance__c> maintenanceList = [SELECT Id, Bus__c, Schedule_Date_Time__c, 
                                                       Schedule_Reason__c, Garage__c
                                                FROM Maintenance__c];
        
        Bus__c updatedBus = [SELECT Next_Service_Odometer_Reading__c, Last_Ping_Location__c FROM Bus__c WHERE Name = 'Test Bus 1']; 
        
        System.assertEquals(3, maintenanceList.size());
        System.assertEquals(20000, updatedBus.Next_Service_Odometer_Reading__c);
		System.assertEquals([SELECT Id FROM Garage__c WHERE Location_City__c = 'San Diego'].Id, [SELECT Id, Garage__c FROM Maintenance__c WHERE Bus__c =: updatedBus.Id].Garage__c);
    }
}
public class BusTriggerHandler {
    
    public static String BUS_CURRENT_STATUS = 'Ready for Use';
    
    public static void insertResaleValue(List<Bus__c> busRecords){
        for(Bus__c newBus : busRecords){
            if(newBus.Current_Status__c == BUS_CURRENT_STATUS){
            	newBus.Resale_Value__c = calculateResalePrice(newBus.Maximum_Capacity__c, 
                                                          	  newBus.Has_AC__c, 
                                                          	  newBus.Year__c, 
                                                          	  newBus.Odometer_Reading__c
                                                         	 );
            }
            newBus.Next_Service_Odometer_Reading__c = newBus.Odometer_Reading__c + 5000;
    	}
	}    
    
    public static void updateResaleValue(Map<Id, Bus__c> oldMap, Map<Id, Bus__c> newMap){
        for(Bus__c newBusRecord : newMap.values()){
       		Bus__c oldBusRecord = oldMap.get(newBusRecord.Id);
            if(newValuesUpdated(oldBusRecord, newBusRecord) && 
            	newBusRecord.Current_Status__c == BUS_CURRENT_STATUS){
            	newBusRecord.Resale_Value__c = calculateResalePrice(newBusRecord.Maximum_Capacity__c, 
                                     								newBusRecord.Has_AC__c, 
                                     								newBusRecord.Year__c, 
                                     								newBusRecord.Odometer_Reading__c
                                    						   	   );    
            }
        }    
    }
    
    private static Boolean newValuesUpdated(Bus__c oldBusRecord, Bus__c newBusRecord){
    	return (oldBusRecord.Maximum_Capacity__c != newBusRecord.Maximum_Capacity__c ||
                oldBusRecord.Has_AC__c != newBusRecord.Has_AC__c || 
                oldBusRecord.Year__c != newBusRecord.Year__c ||
                oldBusRecord.Odometer_Reading__c != newBusRecord.Odometer_Reading__c ||
                oldBusRecord.Current_Status__c != newBusRecord.Current_Status__c
               );          
    }
    
    private static Decimal calculateResalePrice(String capcity, Boolean hasAC, String year, Decimal odoMeterReading){
    	Decimal startingPrice = 0.00;
        Bus_Setting__mdt busCustomSetting = getBusSettings(capcity);
        if(busCustomSetting != null){
            if(capcity == busCustomSetting.Maximum_Capacity__c){
                startingPrice = busCustomSetting.Selling_Price__c;   
            }
            if(hasAC){
                startingPrice += startingPrice * 3 / 100;    
            }
            if(year != '' && Integer.valueOf(year) <= 1972){
                 startingPrice += startingPrice * 34 /100;	
            }
            if(odoMeterReading != null && odoMeterReading > 100000){
                startingPrice -=  (odoMeterReading - 100000) * 0.1;
            }
        }
        return startingPrice;
    }
    
    private static Bus_Setting__mdt getBusSettings(String capcity){
        if(capcity != null){
        	return [
            	SELECT Maximum_Capacity__c, Selling_Price__c 
            	FROM Bus_Setting__mdt 
            	WHERE Maximum_Capacity__c =: capcity
    		];    
        }
        return null;
    }
}
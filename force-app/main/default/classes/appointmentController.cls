public with sharing class appointmentController {
    @AuraEnabled(cacheable = true)
    public static List<Appointment_Slot__c> checkAvailability(Date appointmentDate)
    {
        return [SELECT Appointment_Date__c, Start_Time__c, End_Time__c, isActive__c FROM Appointment_Slot__c WHERE isActive__c = true];
        
    }

    
}
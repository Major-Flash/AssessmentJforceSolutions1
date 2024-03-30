public with sharing class AppointmentDetailTriggerHandler {
    public static void handleBeforeInsert(List<Appointment_Detail__c> newDetails) {
        Set<Date> appointmentDates = new Set<Date>();

        // Collect all Appointment_Date__c values from Appointment_slot__c records
        for (Appointment_Slot__c slot : [SELECT Id, Appointment_Date__c, Start_Time__c, End_Time__c, isActive__c FROM Appointment_Slot__c WHERE isActive__c = true]) {
            appointmentDates.add(slot.Appointment_Date__c);
        }

        for (Appointment_Detail__c detail : newDetails) {
            
            if (!appointmentDates.contains(detail.Date__c)) {          // Check if the Appointment_Date__c matches any of the Appointment_Date__c values in Appointment_slot__c
                
                detail.Date__c.addError('No Appointment Slot is available on selected date');
            }
        }
    }

}
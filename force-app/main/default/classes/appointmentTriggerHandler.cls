public with sharing class appointmentTriggerHandler {
    @AuraEnabled(cacheable = true)
    public static void handleDuplicateTimeslot(List<Appointment_Detail__c> newAppointments) {
        Set<DateTime> isTime = new Set<DateTime>();
        for (Appointment_Detail__c appointment : newAppointments) { 
            isTime.add(appointment.Appointment_Date_And_Time__c);
        }
        
        Map<DateTime, Integer> duplicateTimeslots = new Map<DateTime, Integer>(); //to check duplicate date and time slot
        for (Appointment_Detail__c existingAppointment : [SELECT Appointment_Date_And_Time__c FROM Appointment_Detail__c WHERE Appointment_Date_And_Time__c IN :isTime]) {
            duplicateTimeslots.put(existingAppointment.Appointment_Date_And_Time__c, 1); //this is to fetch existing data
        }

        for (Appointment_Detail__c newAppointment : newAppointments) {
            if (duplicateTimeslots.containsKey(newAppointment.Appointment_Date_And_Time__c)) {
                newAppointment.addError('Time slot is already appointed.');
            }
        }
    }

}
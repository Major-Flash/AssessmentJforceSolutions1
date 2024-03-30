public class AppointmentSlotProcessor {
   public static void processAppointmentSlots(List<Appointment_Detail__c> newDetails) {
        Map<Date, List<Time>> appointmentSlots = new Map<Date, List<Time>>();

        // Collect all appointment slots from Appointment_slot__c records
        for (Appointment_Slot__c slot : [SELECT Appointment_Date__c, Start_Time__c, End_Time__c, isActive__c FROM Appointment_Slot__c WHERE isActive__c = true]) {
            Date slotDate = slot.Appointment_Date__c;
            if (!appointmentSlots.containsKey(slotDate)) {
                appointmentSlots.put(slotDate, new List<Time>());
            }
            appointmentSlots.get(slotDate).add(slot.Start_Time__c);
            appointmentSlots.get(slotDate).add(slot.End_Time__c);
        }

        // Iterate through the Appointment_Detail__c records being inserted
        for (Appointment_Detail__c detail : newDetails) {
            // Split Appointment_Date_And_Time__c into Date__c and Time__c
            Datetime appointmentDateTime = detail.Appointment_Date_And_Time__c;
            Date detailDate = appointmentDateTime.date();
            Time detailTime = appointmentDateTime.time();

            // Check if the Date is in the appointment slots
            if (!appointmentSlots.containsKey(detailDate)) {
                detail.addError('No appointment slot exists for this date');
                continue;
            }

            // Check if the Time is within the appointment slot times
            List<Time> slotTimes = appointmentSlots.get(detailDate);
            Time startTime = slotTimes[0];
            Time endTime = slotTimes[1]; 

            if (detailTime < startTime || detailTime > endTime) {
                detail.addError('Appointment time must be between Start Time and End Time');
            }
        }
    }

}
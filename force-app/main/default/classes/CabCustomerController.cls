public with sharing class CabCustomerController {
    public CabCustomerController() {

    }
    @AuraEnabled(cacheable=true)

    public static Boolean validateCredentials(String username, String password){
        
        boolean result;
        if(username == null && password == null){
            result = false;

        }
        List<Cab_customer__c> con_List =[SELECT Id, Username__c, Password__c FROM Cab_Customer__c where Username__c =: username Limit 1];
        if(con_List.size() == 0){
                 result = false;
             }else {
                if (con_List[0].Password__c==password) {
                    result=true;
                    
                }else {
                    result=false;

                }
             }
             return result;

        
    }
}
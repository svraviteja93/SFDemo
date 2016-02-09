trigger DeleteResult on Enquiry_Name__c(before insert) {
 
 Matched_Result__c[] existingResultList = [select Id from Matched_Result__c];
 
 for(Matched_Result__c existingResult : existingResultList ){
        try{
        delete existingResult;
        }catch (system.Dmlexception e) {
            system.debug (e);
        }
    }
 
}
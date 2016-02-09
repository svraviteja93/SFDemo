public with sharing class flatSearchController {
 public list <Flat__c> flt {get;set;}  
   public string searchstring {get;set;}  
   public flatSearchController(ApexPages.StandardController controller) {  
   }  
   public void search(){  
     string searchquery='select Name__c,id from Flat__c where Name__c like \'%'+searchstring+'%\' Limit 20';  
     flt= Database.query(searchquery);  
   }  
   public void clear(){  
   flt.clear();  
   }  
}

/* 
public with sharing class flatSearchController {
    

    
 public list <Flat__c> flt {get;set;}  
     public string flatTypeString {get;set;} 
     public string furnishString {get;set;} 
     public string RentString {get;set;} 
   public flatSearchController(ApexPages.StandardController controller) {  
   }  
   public void search(){  
     //string searchquery='select Name__c,id from Enquiry_Name__c where Name__c like \'%'+searchstring+'%\' Limit 20';  
     string searchquery='select Name__c,id from Flat__c where Flat_Types__c =: flatTypeString AND Furnishing__c =:furnishString AND Rent__c =: RentString  Limit 20';  
     flt= Database.query(searchquery);  
   }  
   public void clear(){  
   flt.clear();  
   }  
    
}
*/
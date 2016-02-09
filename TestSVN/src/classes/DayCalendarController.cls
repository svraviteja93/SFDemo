public class DayCalendarController {
	Date startDate = Date.newInstance(2015, 1, 1);
    Date endDate = Date.newInstance(2015, 12, 31);
	Integer noOfDays = startDate.daysBetween(endDate);
     List<Date> dates = new List<Date>();
    
    public List<Contact> getList(){
        return [Select Name, Id,Contact_Color__c From Contact];
    }
  
    
    
    
    
    
     public PageReference pageLoad() {
          
         //Get Dates from 1st Jan to 31st December
         for(Integer i =0; i<noOfDays+1; i++){
             System.debug('+++++++++++++DATE+++++++++++++++++++'+(startDate+i));
             dates.add((startDate+i));
         }
        
         
        //Get Leaves
        for(Leave__c leave :[select Id, From_Date__c, To_Date__c, Contact__c from Leave__c]){
            DateTime startDT = leave.From_Date__c;
            DateTime endDT = leave.To_Date__c;
           
            String contactFName = [select FirstName from Contact where Id = :leave.Contact__c].FirstName;
            String contactLName = [select LastName from Contact where Id = :leave.Contact__c].LastName;
            String contactColor = [select OtherCity from Contact where Id = :leave.Contact__c].OtherCity;
            
        }
         
    System.debug('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<No Of Days>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+dates.size());
    System.debug('**************************************testing********************');
         return null;
     }
    
        
		public List<Date> getDate(){
        return dates;
    }
}
public class CalendarController {
     public List<Contact> getList(){
        return [Select Name, Id,Contact_Color__c From Contact];
    }
    
    
   public String selectedGCMLevel{get;set;}
    public String selectedLocation{get;set;}
    
    public Boolean includeMyEvents {get;set;}
    public list<calEvent> events {get;set;}
    
    
    
    
    String[] holidays = new List<String>();

    //The calendar plugin is expecting dates is a certain format. We can use this string to get it formated correctly
    String dtFormat = 'EEE, d MMM yyyy HH:mm:ss u';
    
    
    	
    
    
    public PageReference pageLoad() {
        events = new list<calEvent>();
        
        //Get Contact's Birthdays
        for(Contact cont : [select Id, Birthdate, FirstName, LastName from Contact where Birthdate != null]){
            //here we need to replace the birth year with the current year so that it will show up on this years calendar
            DateTime startDT = datetime.newInstance(Date.Today().Year(),cont.Birthdate.Month(), cont.Birthdate.Day());
            calEvent bday = new calEvent();
            
            bday.title = cont.FirstName + ' ' + cont.LastName + '\'s Birthday!';
            bday.allDay = true;
            bday.startString = startDT.format(dtFormat);
            //Because this is an all day event that only spans one day, we can leave the send date null
            bday.endString = '';
            bday.url = '/' + cont.Id;
            bday.className = 'event-birthday';
            events.add(bday);
        }
        
        
        
        //Get Leaves
        for(Leave__c leave :[select Id, From_Date__c, To_Date__c, Contact__c from Leave__c]){
            DateTime startDT = leave.From_Date__c;
            DateTime endDT = leave.To_Date__c;
            calEvent leaveEvent = new calEvent();
            
            String contactFName = [select FirstName from Contact where Id = :leave.Contact__c].FirstName;
            String contactLName = [select LastName from Contact where Id = :leave.Contact__c].LastName;
            String contactColor = [select OtherCity from Contact where Id = :leave.Contact__c].OtherCity;
          
            leaveEvent.title = contactFName +' '+contactLName+ ' is on LEAVE!';
            leaveEvent.allDay = true;
            leaveEvent.startString = startDT.format(dtFormat);
            leaveEvent.endString = endDT.format(dtFormat);
            leaveEvent.url = '/'+leave.Id;
            leaveEvent.className = 'event-leave';
            events.add(leaveEvent);
            
            
            
        }
        
        //Getting Public Holidays
        for(Public_Holiday__c pHoliday : [select Id, Date__c, Name from Public_Holiday__c]){
             DateTime startDT = pHoliday.Date__c;
            DateTime startDate = pHoliday.Date__c;
            
            //---collects public holiday dates
            String dateOutput = startDate.format('dd/MM/yyyy');
            System.debug('dateOutput: '+dateOutput);
            holidays.add(dateOutput);
            
            DateTime endDT = pHoliday.Date__c;
            calEvent pHolidayEvent = new calEvent();
            
            pHolidayEvent.title =  pHoliday.Name;
            pHolidayEvent.startString = startDT.format(dtFormat);
            pHolidayEvent.endString = endDT.format(dtFormat);
            pHolidayEvent.allDay = true;
            pHolidayEvent.url = '/'+pHoliday.Id;
            pHolidayEvent.className = 'event-holiday';
            events.add(pHolidayEvent);
        
            
    }
        
        return null;
         
    }
   
    public String[] getHolidays(){
        return holidays;
    }
    
    
    
    
   //For Filtered Results
    public void filterResults(){
		events = new list<calEvent>();
        
        //Get Contact's Birthdays
        for(Contact cont : [select Id, Birthdate, FirstName, LastName from Contact where Birthdate != null AND GCM_LEVEL__c =:selectedGCMLevel AND Location__c =: selectedLocation]){
            //here we need to replace the birth year with the current year so that it will show up on this years calendar
            DateTime startDT = datetime.newInstance(Date.Today().Year(),cont.Birthdate.Month(), cont.Birthdate.Day());
            calEvent bday = new calEvent();
            
            bday.title = cont.FirstName + ' ' + cont.LastName + '\'s Birthday!';
            bday.allDay = true;
            bday.startString = startDT.format(dtFormat);
            //Because this is an all day event that only spans one day, we can leave the send date null
            bday.endString = '';
            bday.url = '/' + cont.Id;
            bday.className = 'event-birthday';
            events.add(bday);
        }
        
        //Get Leaves
        for(Contact contact : [select Id, FirstName, LastName, (select Id, From_Date__c, To_Date__c from Leaves__r) from Contact where Location__c =: selectedLocation and GCM_LEVEL__c =:selectedGCMLevel ])
        {
            For(Leave__c lv : contact.Leaves__r)   
            {
        
            DateTime startDT = lv.From_Date__c;
            DateTime endDT = lv.To_Date__c;
            calEvent leaveEvent = new calEvent();
            
            leaveEvent.title = contact.FirstName +' '+contact.LastName+ ' is on LEAVE!';
            leaveEvent.allDay = true;
            leaveEvent.startString = startDT.format(dtFormat);
            leaveEvent.endString = endDT.format(dtFormat);
            leaveEvent.url = '/'+lv.Id;
            leaveEvent.className = 'event-leave';
            events.add(leaveEvent);
            
            }
            
        }
        
        //Getting Public Holidays
        for(Public_Holiday__c pHoliday : [select Id, Date__c, Name from Public_Holiday__c]){
             DateTime startDT = pHoliday.Date__c;
            DateTime startDate = pHoliday.Date__c;
            
            //---collects public holiday dates
            String dateOutput = startDate.format('dd/MM/yyyy');
            System.debug('dateOutput: '+dateOutput);
            holidays.add(dateOutput);
            
            DateTime endDT = pHoliday.Date__c;
            calEvent pHolidayEvent = new calEvent();
            
            pHolidayEvent.title =  pHoliday.Name;
            pHolidayEvent.startString = startDT.format(dtFormat);
            pHolidayEvent.endString = endDT.format(dtFormat);
            pHolidayEvent.allDay = true;
            pHolidayEvent.url = '/'+pHoliday.Id;
            pHolidayEvent.className = 'event-holiday';
            events.add(pHolidayEvent);
        
            
    }
        
    }
  
    
    
    //Class to hold calendar event data
    public class calEvent{
        public String title {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;set;}
        public String endString {get;set;}
        public String url {get;set;}
        public String className {get;set;}
        public String contactColor {get;set;}
    }
}
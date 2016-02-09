public class leaverecord
{
    public Date d1 {get;set;}
    public Date d2 {get;set;}
    
    public leaverecord()
    {
       
    }
    
    public static list<Integer> getWeek(){
          list<Integer> week = new list<Integer>();
         Date d1 = date.newInstance(2015,01,01);
        Date d2 = d1.Adddays(365);
         while(d1 < d2)
        {
            Datetime dt1 = DateTime.newInstance(d1, Time.newInstance(0, 0, 0, 0));
            string dayOfWeek = dt1.format('EEEE');
            if(dayOfWeek != 'Sunday'&& dayOfWeek != 'Saturday') {
                Integer week1 = Integer.valueOf(dt1.formatGmt('w')); 
               week.add(week1);
            }
           
           
          	d1 = d1.Adddays(1);
        }
        return week;
        
    }
    public static List<Integer> getMonth(){
        list<Integer> mon = new list<Integer>();
         Date d1 = date.newInstance(2015,01,01);
        Date d2 = d1.Adddays(365);
        
       
        while(d1 < d2)
        {
            Datetime dt1 = DateTime.newInstance(d1, Time.newInstance(0, 0, 0, 0));
            string dayOfWeek = dt1.format('EEEE');
			if(dayOfWeek != 'Sunday'&& dayOfWeek != 'Saturday')   
            mon.add(d1.Month());
          	d1 = d1.Adddays(1);
        }
        return mon;
    }    
     public static List<Integer> getOnlyDate(){
          list<Integer> date1 = new list<Integer>();
         Date d1 = date.newInstance(2015,01,01);
        Date d2 = d1.Adddays(365);
        
       
        while(d1 < d2)
        {
            Datetime dt1 = DateTime.newInstance(d1, Time.newInstance(0, 0, 0, 0));
            string dayOfWeek = dt1.format('EEEE');
			if(dayOfWeek != 'Sunday'&& dayOfWeek != 'Saturday')   
            date1.add(d1.Day());
          	d1 = d1.Adddays(1);
        }
        return date1;
     }
    public static List<Contact> getContacts ()
    {
        List<Contact> con = [select Id, Name, (select Id, From_Date__c, To_Date__c, No_of_Days__c from Leaves__r) from Contact];
        return con;
    } 
   
    public static Set<String> getmydates ()
    {
        Date d1 = date.newInstance(2015,01,01);
        Date d2 = d1.Adddays(365);
        Set<String> monthYearSet = new Set<String>();
       
        while(d1 < d2)
        {	 
            Datetime dt1 = DateTime.newInstance(d1, Time.newInstance(0, 0, 0, 0));
            string dayOfWeek = dt1.format('EEEE');
			if(dayOfWeek != 'Sunday'&& dayOfWeek != 'Saturday')            
            monthYearSet.add(d1.Month() + '/' + d1.day() + '/' + d1.Year());
          
            Integer week = Integer.valueOf(dt1.formatGmt('w'));
            System.debug('XXXXX: '+week);
           
            d1 = d1.Adddays(1);
        }
        
      
        //System.Debug('================' + monthYearSet);
        return monthYearSet;
    } 
    public static map<id,list<string>> getleaves ()
    {
       map<id,list<string>> daySet = new map<id,list<string>>();
       
       for(Contact cont : [select Id, FirstName, LastName, (select Id, From_Date__c, To_Date__c from Leaves__r) from Contact])
       {
           list<String> st = new list<String>();
            For(Leave__c l1 : cont.Leaves__r)   
            {
                Date sd = l1.From_Date__c;
                Date ed = l1.To_Date__c.addDays(1);    
                
                while(sd < ed)
                {
                    st.add(sd.Month() + '/' + sd.day() + '/' + sd.Year());
                    sd = sd.Adddays(1);
                }     
                //System.Debug('DD================' + daySet);  
            }
            daySet.put(cont.id,st);  
        }
        return daySet;
    }
   
    
    public static List<string> getHolidays(){
        
        Set<String> removeDups = new Set<String>();
        list<String> pHoliday = new list<String>();
        list<String> pHoliday_noDups = new list<String>();
        
        list<String> weekend = new List<string>();
        Date d1 = date.newInstance(2015,01,01);
        Date d2 = d1.Adddays(185);
        
        for(Public_Holiday__c pHolidays : [select Id, Date__c, Name from Public_Holiday__c ]){
             Date startDT = pHolidays.Date__c;
            pHoliday.add(startDT.month()+'/'+startDT.day()+'/'+startDT.year());
            
        }
        
        while(d1 < d2)
        {
            Datetime dt1 = DateTime.newInstance(d1, Time.newInstance(0, 0, 0, 0));
            string dayOfWeek = dt1.format('EEEE');
            
           
            if(dayOfWeek.equals('Saturday') || dayOfWeek.equals('Sunday') ){
                
                pHoliday.add(dt1.Month() + '/' + dt1.day() + '/' + dt1.Year());
                //system.debug('KKKKK'+dt1.Month());
                
           }
            
          d1 = d1.Adddays(1);   
        }
        
        //System.debug('cccccccccccccccccccccccccccccccccccccccccc'+pHoliday);
        removeDups.addAll(pHoliday);
        pHoliday_noDups.addAll(removeDups);
       return pHoliday_noDups;
        
     }
  
}
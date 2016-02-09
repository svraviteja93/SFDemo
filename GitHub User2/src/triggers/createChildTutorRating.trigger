trigger createChildTutorRating on Tutor__c (after insert) {
 List<Tutor_Rating__c> tutorRatings = new List<Tutor_Rating__c>();
 
         //For each Tutor processed by the trigger, add a new 
        //tutorRating record for the specified Tutor Name. 
           //Note that Trigger.New is a list of all the new Tutors
        //that are being created. 
    
    for (Tutor__c newTutor: Trigger.New){
        if (newTutor.Name__c !=null){
           /* tutorRatings.add(new Tutor_Rating__c(
                        //fields names
                        Tutor_Name1__c = newTutor.id
                        ));*/
                        
                  Tutor_Rating__c rating = new Tutor_Rating__c();
                  rating.Tutor_Name1__c = newTutor.id;
                  System.debug(newTutor.id);
                  tutorRatings.add(rating);      
                        
        }
    }
    insert tutorRatings;
 }
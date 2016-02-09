@isTest 
public class TestTutor {
    static testMethod void insertNewTutor() {
       
       Tutor__c tutorToCreate = new Tutor__c();
       
       // Do you recognize these fields?
       tutorToCreate.Email__c = 'sfdc-dreamer@gmail.com';
       tutorToCreate.Experiance__c  = 5;
       tutorToCreate.Gender__c     = 'Female';
       tutorToCreate.Name__c  = 'David';
       tutorToCreate.Salary__c    = 250;
       

      
       insert tutorToCreate;
    }
}
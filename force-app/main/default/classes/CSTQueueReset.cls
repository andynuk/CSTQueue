global with sharing class CSTQueueReset {

	@InvocableMethod
    public static void doCSTQueueReset() {
        
        
         QueueCounter__c CSTCount = [select Name, QueueNumber__c from QueueCounter__c 
                                WHERE Name = 'CST' LIMIT 1];


        CSTCount.QueueNumber__c = 1;
        upsert CSTCount;

    }
}
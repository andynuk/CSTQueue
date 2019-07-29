global with sharing class CSTQueueIncrement {

	@InvocableMethod
    public static List<List<Decimal>> doCSTIncrement() {
        
        
         QueueCounter__c CSTCount = [select Name, QueueNumber__c from QueueCounter__c 
                                WHERE Name = 'CST' LIMIT 1];

        Decimal result = 1;

        // it may be that this is a new implementation and we have no QueueCounter setting
        if (CSTCount == null)
        {
            QueueCounter__c newCSTCount = new QueueCounter__c();
            newCSTCount.Name = 'CST';
            newCSTCount.QueueNumber__c = 1;
            upsert newCSTCount;
        }
        else {
            CSTCount.QueueNumber__c = CSTCount.QueueNumber__c + 1;
            upsert CSTCount;
            result = CSTCount.QueueNumber__c;
        }

        // flows require a list of list!!
        List<Decimal> listofDecimal = new List<Decimal>();
        listofDecimal.add(result);
        List<List<Decimal>> ListofDecimals = new List<List<Decimal>>();
        ListofDecimals.add(listofDecimal);
        return ListofDecimals;         

    }
}
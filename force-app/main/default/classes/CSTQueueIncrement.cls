global with sharing class CSTQueueIncrement {

	@InvocableMethod
    public static List<List<Decimal>> doCSTIncrement() {
        
        
         QueueCounter__c CSTCount = [select Name, QueueNumber__c from QueueCounter__c 
                                WHERE Name = 'CST' LIMIT 1];


        CSTCount.QueueNumber__c = CSTCount.QueueNumber__c + 1;
        upsert CSTCount;

        Decimal result = CSTCount.QueueNumber__c;
        List<Decimal> listofDecimal = new List<Decimal>();
        listofDecimal.add(result);



        List<List<Decimal>> ListofDecimals = new List<List<Decimal>>();

        ListofDecimals.add(listofDecimal);
      

        return ListofDecimals;         

    }
}
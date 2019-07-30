public without sharing class CSTQueueController {

    @AuraEnabled(cacheable=false)
    public static List<CST_Queue__c> getAnnouncing() {
        List<CST_Queue__c> announcing = [SELECT  QueuePosition__c  FROM CST_Queue__c Where Status__c='Announce' ORDER BY QueuePosition__c ASC];
        return announcing;
        }
}

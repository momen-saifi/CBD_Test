global class ScheduleableExample implements Schedulable {
    global void execute(SchedulableContext context) {
        List<Contact> conList = [SELECT Id, Name FROM Contact];
        
        for(Contact c : conList) {
            c.Status__c = 'Closed';
        }
        update conList;
    }
}
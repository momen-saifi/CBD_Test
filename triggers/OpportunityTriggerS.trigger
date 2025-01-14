trigger OpportunityTriggerS on Opportunity (after insert) {
    if(Trigger.isAfter && Trigger.isInsert ){
        OpportunityTriggerHandlerS.createContact(Trigger.new);
    }

}
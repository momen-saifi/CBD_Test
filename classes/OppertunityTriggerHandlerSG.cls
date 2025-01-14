public class OppertunityTriggerHandlerSG {
    public static void updateDescription(List<Opportunity> oppRec){
        for(Opportunity opp : oppRec){
            if(opp.Amount != null && opp.Amount >= 100000 && opp.Amount <= 500000){
                opp.Description = 'Hot Opportunity';
            }
        } 
    }
}
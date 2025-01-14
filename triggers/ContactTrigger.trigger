trigger ContactTrigger on Contact (before insert,before update,after insert, after update) {
    /*for(Contact con : Trigger.new){
        if(String.isBlank(con.Department)){
            con.Department='Testing';
        }
        if(String.isBlank(con.MobilePhone)){
            con.MobilePhone.addError('Mobile number is Mandatory');
        }

    }
        
     for(Contact con : Trigger.new){
        System.debug('Contact Department new values'+ con.Department);
     }
    
     for(Contact con : Trigger.old){
        System.debug('Contact Department old values'+ con.Department);
     }*/
    for(Contact con : trigger.new){
     //   if(con.Department == 'Testing'){
        if(trigger.oldmap.get(con.id).department != trigger.newmap.get(con.id).department){
            System.debug('Trigger fires');
            con.LeadSource = 'Web';
        }
    }
    
        
        
        
        
}
public class contactrecord {
    
    public  list<contact> getcontactrecord(){
        map<id,contact>conmap = new map<id,contact>();
        list<contact>conlist = new list<contact>();
        conlist= [select id,Name,Phone,	Email from contact limit 10];
        list<contact>newconlist =new list<contact>();
        for(contact con :conlist){
            newconlist.add(con);
            conmap.put(con.id,con);
          contact   cont = conmap.get(con.id);
            //system.debug('this data is newconlist ' + newconlist);
           // system.debug('this data is for conmap ' + conmap);
           system.debug('this data we get from conmap ' + cont);
            
        }
        
        return newconlist;
    }

}
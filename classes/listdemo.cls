public class listdemo {
    public void listmethod(){
        List<string>strlist=new List<string>();
        List<string>strList2=new List<string>();
        strList.add('India');
        strList.add('USA');
        strlist.add(1,'UK');
        strlist2.add('PUNJAB');
        strlist2.addall(strlist);
        system.debug('strlist =>'+strlist);
        system.debug('strlist2=>'+strlist2);    
            
    }
}
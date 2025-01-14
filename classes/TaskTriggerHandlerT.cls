public class TaskTriggerHandlerT {
    public static void updatePriority(List<Task> taskRec){
        for(Task tsk : taskRec){
            tsk.Priority = 'High';
        }
    }
}
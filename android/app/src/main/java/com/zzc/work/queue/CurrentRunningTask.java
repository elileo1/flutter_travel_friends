package com.zzc.work.queue;

/**
 * create by elileo on 2019/1/10
 */
public class CurrentRunningTask {
    private static ITask sCurrentShowingTask;

    public static void setCurrentShowingTask(ITask task){
        sCurrentShowingTask = task;
    }

    public static void removeCurrentShowingTask(){
        sCurrentShowingTask = null;
    }

    public static ITask getCurrentShowingTask(){
        return sCurrentShowingTask;
    }

    public static boolean getCurrentTaskStatus(){
        return sCurrentShowingTask != null && sCurrentShowingTask.getStatus();
    }
}

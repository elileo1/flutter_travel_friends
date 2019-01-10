package com.zzc.work.queue;

import android.support.annotation.NonNull;

import java.lang.ref.WeakReference;
import java.util.concurrent.PriorityBlockingQueue;

/**
 * create by elileo on 2019/1/10
 */
public class BaseTask implements ITask {
    private static final String TAG = BaseTask.class.getSimpleName();
    private TaskPriority mTaskPriority = TaskPriority.DEFAULT;
    private int mSequence;
    private boolean mTaskStatus = false;
    protected WeakReference<BlockTaskQueue> taskQueue;
    protected int mDuration;
    private PriorityBlockingQueue<Integer> blockQueue; //任务时间不确定队列

    public BaseTask() {
        taskQueue = new WeakReference<>(BlockTaskQueue.getInstance());
        blockQueue = new PriorityBlockingQueue<>();
    }

    @Override
    public void enqueue() {
        TaskScheduler.getInstance().enqueue(this);
    }

    @Override
    public void doTask() {
        mTaskStatus = true;
        CurrentRunningTask.setCurrentShowingTask(this);
    }

    @Override
    public void finishTask() {
        this.mTaskStatus = false;
        this.taskQueue.get().remove(this);
        CurrentRunningTask.removeCurrentShowingTask();
    }

    @Override
    public ITask setPriority(TaskPriority taskPriority) {
        this.mTaskPriority = taskPriority;
        return this;
    }

    @Override
    public TaskPriority getPriority() {
        return mTaskPriority;
    }

    @Override
    public void setSequence(int sequence) {
        this.mSequence = sequence;
    }

    @Override
    public int getSequence() {
        return mSequence;
    }

    @Override
    public boolean getStatus() {
        return mTaskStatus;
    }

    @Override
    public ITask setDuration(int duration) {
        this.mDuration = duration;
        return this;
    }

    @Override
    public int getDuration() {
        return mDuration;
    }

    @Override
    public void blockTask() throws Exception {
        blockQueue.take(); //如果队列里面没数据，就会一直阻塞
    }

    @Override
    public void unBlock() {
        blockQueue.add(1); //往里面随便添加一个数据，阻塞就会解除
    }

    @Override
    public int compareTo(@NonNull ITask another) {
        final TaskPriority me = this.getPriority();
        final TaskPriority it = another.getPriority();
        return me == it ? this.getSequence() - another.getSequence() :
                it.ordinal() - me.ordinal();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("task name : ");
        sb.append(getClass().getSimpleName());
        sb.append(" sequence : ");
        sb.append(mSequence);
        sb.append(" TaskPriority : ");
        sb.append(mTaskPriority);
        return  sb.toString();
    }
}

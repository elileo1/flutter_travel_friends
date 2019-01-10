package com.zzc.work.queue;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.PriorityBlockingQueue;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * create by elileo on 2019/1/10
 */
public class BlockTaskQueue {
    private static final String TAG = BlockTaskQueue.class.getSimpleName();
    private AtomicInteger mAtomicInteger = new AtomicInteger();
    //阻塞队列
    private BlockingQueue<ITask> mTaskQueue = new PriorityBlockingQueue<>();

    private BlockTaskQueue(){

    }

    private static class BlockTaskQueueHolder{
        private final static BlockTaskQueue INSTANCE = new BlockTaskQueue();
    }

    public static BlockTaskQueue getInstance(){
        return BlockTaskQueueHolder.INSTANCE;
    }

    public <T extends ITask> int add(T task){
        if(!mTaskQueue.contains(task)){
            task.setSequence(mAtomicInteger.incrementAndGet());
            mTaskQueue.add(task);
        }
        return mTaskQueue.size();
    }

    public <T extends ITask> void remove(T task){
        if(mTaskQueue.contains(task)){
            mTaskQueue.remove(task);
        }
        if(mTaskQueue.size() == 0){
            mAtomicInteger.set(0);
        }
    }

    public ITask poll(){
        return mTaskQueue.poll();
    }

    public ITask take() throws InterruptedException{
        return mTaskQueue.take();
    }

    public void clear(){
        mTaskQueue.clear();
    }

    public int getSize(){
        return mTaskQueue.size();
    }
}

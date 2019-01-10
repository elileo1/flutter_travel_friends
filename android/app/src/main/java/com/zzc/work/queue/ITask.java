package com.zzc.work.queue;

/**
 * create by elileo on 2019/1/10
 */
public interface ITask extends Comparable<ITask>{
    //任务插入队列
    void enqueue();

    //执行任务
    void doTask();

    //任务结束
    void finishTask();

    //设置任务优先级
    ITask setPriority(TaskPriority taskPriority);

    //获取任务优先级
    TaskPriority getPriority();

    //当任务优先级一致时，按照插入顺序， 先入先出
    void setSequence(int sequence);

    //获取入队次序
    int getSequence();

    //任务状态， 标记未完成还是已完成
    boolean getStatus();

    //设置每个任务执行时间， 在任务执行时间确定情况下
    ITask setDuration(int duration);

    //获取任务执行时间
    int getDuration();

    //阻塞任务队列， 在任务时间不确定情况下
    void blockTask() throws Exception;

    //接触阻塞任务队列
    void unBlock();
}

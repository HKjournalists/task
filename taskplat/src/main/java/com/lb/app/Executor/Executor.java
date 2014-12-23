package com.lb.app.Executor;

import org.quartz.JobExecutionContext;

public interface Executor {

	public void execute(JobExecutionContext context);
}

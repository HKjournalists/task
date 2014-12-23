package com.asiainfo.aiga.runTask.thread;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.runTask.bo.AigaRunTask;
import com.asiainfo.aiga.runTask.dao.IAigaRunTaskDAO;
import com.asiainfo.aiga.userCase.caseTrans.CaseHttpSend;

public class RunTaskThread implements Runnable{

	private static Thread thread ;
	private IAigaRunTaskDAO aigaRunTaskDAO;
	private CaseHttpSend caseHttpSend;
	
	public void setAigaRunTaskDAO(IAigaRunTaskDAO aigaRunTaskDAO) {
		this.aigaRunTaskDAO = aigaRunTaskDAO;
	}

	public void setCaseHttpSend(CaseHttpSend caseHttpSend) {
		this.caseHttpSend = caseHttpSend;
	}


	@Override
	public void run() {
		// TODO Auto-generated method stub
		while(true){
			AigaRunTask aigaRunTaskTemp = null;
			try {
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaRunTask.class);
				criteria.add(Restrictions.eq("taskStatus", "2"));
				AigaRunTask[] aigaRunTasks = aigaRunTaskDAO.getRunTaskByCriteria(criteria);
				for(AigaRunTask aigaRunTask :aigaRunTasks){
					aigaRunTaskTemp = aigaRunTask;
					aigaRunTaskTemp.setTaskStatus("21");
					aigaRunTaskDAO.saveOrUpdate(aigaRunTaskTemp);
					caseHttpSend.sendCase(aigaRunTaskTemp.getTaskId());
				}
				thread.sleep(2000);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				if(aigaRunTaskTemp!=null){
					aigaRunTaskTemp.setTaskStatus("5");
					try {
						aigaRunTaskDAO.saveOrUpdate(aigaRunTaskTemp);
					} catch (Exception e1) {
						// TODO Auto-generated catch block
						System.out.println("更改执行任务状态失败");
						e1.printStackTrace();
					}
				}
				System.out.println("执行任务进程出现错误,"+e.getMessage());
				e.printStackTrace();
			}
		}
	}

	public void initMethod()throws Exception{
		thread = new Thread(this);
		thread.start();
	}
	
	public void destroyMethod()throws Exception{
		thread.stop();
	}
}

package com.asiainfo.csc.matrix.factory;

import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.csc.matrix.common.interfaces.IAlmMatrixFun;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmHisStakeholderDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmHisWorkflowCaseDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmHisWorkorderDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmScheduleDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmStakeholderDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmTopoViewDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkflowCaseDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkflowDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkflowDrivingDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkflowTemplateDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkorderDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmSubReqValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmHisStakeholderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmHisWorkorderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmScheduleSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmStakeholderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmTopoViewSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowCaseSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowDrivingSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowTemplateSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkorderSV;

public class BusiFactory {
	public static IAlmScheduleSV getAlmScheduleSV(){
		return (IAlmScheduleSV)ServiceFactory.getService("com.asiainfo.csc.matrix.service.AlmScheduleSV",IAlmScheduleSV.class);
	}
	
	public static IAlmScheduleDao getAlmScheduleDao(){
		return (IAlmScheduleDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmScheduleDao",IAlmScheduleDao.class);
	}
	
	public static IAlmWorkorderSV getAlmWorkorderSV(){
		return (IAlmWorkorderSV)ServiceFactory.getService("com.asiainfo.csc.matrix.service.AlmWorkorderSV",IAlmWorkorderSV.class);
	}
	
	public static IAlmWorkorderDao getAlmWorkorderDao(){
		return (IAlmWorkorderDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmWorkorderDao",IAlmWorkorderDao.class);
	}
	
	public static IAlmWorkflowSV getAlmWorkflowSV(){
		return (IAlmWorkflowSV)ServiceFactory.getService("com.asiainfo.csc.matrix.service.AlmWorkflowSV",IAlmWorkflowSV.class);
	}
	
	public static IAlmWorkflowDao getAlmWorkflowDao(){
		return (IAlmWorkflowDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmWorkflowDao",IAlmWorkflowDao.class);
	}
	
	public static IAlmTopoViewSV getAlmTopoViewSV(){
		return (IAlmTopoViewSV)ServiceFactory.getService("com.asiainfo.csc.matrix.service.AlmTopoViewSV",IAlmTopoViewSV.class);
	}
	
	public static IAlmTopoViewDao getAlmTopoViewDao(){
		return (IAlmTopoViewDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmTopoViewDao",IAlmTopoViewDao.class);
	}
	
	public static IAlmWorkflowCaseSV getAlmWorkflowCaseSV(){
		return (IAlmWorkflowCaseSV)ServiceFactory.getService("com.asiainfo.csc.matrix.service.AlmWorkflowCaseSV",IAlmWorkflowCaseSV.class);
	}

	public static IAlmWorkflowCaseDao getAlmWorkflowCaseDao(){
		return (IAlmWorkflowCaseDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmWorkflowCaseDao",IAlmWorkflowCaseDao.class);
	}
	
	public static IAlmStakeholderSV getAlmStakeholderSV(){
		return (IAlmStakeholderSV)ServiceFactory.getService("com.asiainfo.csc.matrix.service.AlmStakeholderSV",IAlmStakeholderSV.class);
	}
	
	public static IAlmStakeholderDao getAlmStakeholderDao(){
		return (IAlmStakeholderDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmStakeholderDao",IAlmStakeholderDao.class);
	}
		
	public static IAlmWorkflowDrivingSV getAlmWorkflowDrivingSV(){
		return (IAlmWorkflowDrivingSV)ServiceFactory.getService("com.asiainfo.csc.matrix.service.AlmWorkflowDrivingSV",IAlmWorkflowDrivingSV.class);
	}
	
	public static IAlmWorkflowDrivingDao getAlmWorkflowDrivingDao(){
		return (IAlmWorkflowDrivingDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmWorkflowDrivingDao",IAlmWorkflowDrivingDao.class);
	}
	
	public static IAlmWorkflowTemplateSV getAlmWorkflowTemplateSV(){
		return (IAlmWorkflowTemplateSV)ServiceFactory.getService("com.asiainfo.csc.matrix.service.AlmWorkflowTemplateSV",IAlmWorkflowTemplateSV.class);
	}
	
	public static IAlmWorkflowTemplateDao getAlmWorkflowTemplateDao(){
		return (IAlmWorkflowTemplateDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmWorkflowTemplateDao",IAlmWorkflowTemplateDao.class);
	}
	
	public static IAlmHisStakeholderSV getAlmHisStakeholderSV(){
		return (IAlmHisStakeholderSV)ServiceFactory.getService(IAlmHisStakeholderSV.class);
	}
	
	public static IAlmHisStakeholderDao getAlmHisStakeholderDao(){
		return (IAlmHisStakeholderDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmHisStakeholderDao",IAlmHisStakeholderDao.class);
	}
	
	public static IAlmHisWorkflowCaseDao getAlmHisWorkflowCaseDao(){
		return (IAlmHisWorkflowCaseDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmHisWorkflowCaseDao",IAlmHisWorkflowCaseDao.class);
	}
	
	public static IAlmHisWorkorderSV getAlmHisWorkorderSV(){
		return (IAlmHisWorkorderSV)ServiceFactory.getService(IAlmHisWorkorderSV.class);
	}
	
	public static IAlmHisWorkorderDao getAlmHisWorkorderDao(){
		return (IAlmHisWorkorderDao)ServiceFactory.getService("com.asiainfo.csc.matrix.dao.AlmHisWorkorderDao",IAlmHisWorkorderDao.class);
	}

	public static IAlmMatrixFun getAlmMatrixFun(){
		return (IAlmMatrixFun)ServiceFactory.getService(IAlmMatrixFun.class);
	}
	
	public static IBOAlmSubReqValue getAlmSunReqSV(){
		//com.asiainfo.csc.matrix.ivalues.IBOAlmSubReqValue
		return (IBOAlmSubReqValue)ServiceFactory.getService("com.asiainfo.csc.matrix.ivalues.IBOAlmSubReqValue",IAlmHisWorkorderDao.class);
	}
}

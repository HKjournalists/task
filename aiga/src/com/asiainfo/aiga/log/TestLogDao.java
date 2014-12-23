package com.asiainfo.aiga.log;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.asiainfo.aiga.log.bo.AigaLogElement;
import com.asiainfo.aiga.log.bo.AigaLogStep;
import com.asiainfo.aiga.log.bo.AigaLogTestCase;
import com.asiainfo.aiga.log.dao.IAigaLogDao;

public class TestLogDao {

	/**
	 * @param args
	 */
	public static void main(String[] args)throws Exception {
		// TODO Auto-generated method stub
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
		IAigaLogDao aigaLogDao = (IAigaLogDao)applicationContext.getBean("logDao");
//		AigaLogElement aigaLogElement = new AigaLogElement();
//		aigaLogElement.setElementArgument("222");
//		aigaLogElement.setElementMethod("22323");
//		aigaLogElement.setElementValue("123123");
//		List<AigaLogElement> set = new ArrayList<AigaLogElement>();
//		set.add(aigaLogElement);
//		
//		AigaLogStep aigaLogStep = new AigaLogStep();
//		aigaLogStep.setResult("1");
//		aigaLogStep.setStepName("2");
//		aigaLogStep.setAigaLogElements(set);
//		List<AigaLogStep> set2 = new ArrayList<AigaLogStep>();
//		set2.add(aigaLogStep);
//		
//		AigaLogTestCase aigaLogTestCase = new AigaLogTestCase();
//		aigaLogTestCase.setErrInfo("123");
//		aigaLogTestCase.setLogInfo("123");
//		aigaLogTestCase.setRunId(1);
//		aigaLogTestCase.setCaseId(1);
//		aigaLogTestCase.setAigaLogSteps(set2);
//		aigaLogDao.saveLog(aigaLogTestCase);
		
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaLogTestCase.class);
		criteria.add(Restrictions.eq("runId", 46));
		AigaLogTestCase[] aigaLogTestCases = aigaLogDao.getLog(criteria);
		for(AigaLogTestCase aigaLogTestCase : aigaLogTestCases){
			for(AigaLogStep logStep : aigaLogTestCase.getAigaLogSteps()){
				System.out.println(logStep.getResult());
			}
		}
	}

}

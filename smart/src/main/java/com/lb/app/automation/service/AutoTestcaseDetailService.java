package com.lb.app.automation.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lb.app.automation.dao.IAutoTestcaseDao;
import com.lb.app.automation.dao.IAutoTestcaseDetailDao;
import com.lb.app.automation.model.AutoTestcaseDetail;

@Service
public class AutoTestcaseDetailService {

	final private static Log log = LogFactory.getLog(AutoTestcaseService.class);

	@Autowired
	IAutoTestcaseDao testcaseDao;
	
	@Autowired
	IAutoTestcaseDetailDao testcasedetailDao;
	
	public List<AutoTestcaseDetail> saveOrUpdate(List<AutoTestcaseDetail> testcases){
		for(AutoTestcaseDetail t: testcases){
			if(!StringUtils.isEmpty(t.getTestcaseid()))
				t.setTestcase(testcaseDao.get(t.getTestcaseid()));
			if(StringUtils.isEmpty(t.getNo()))
				testcasedetailDao.create(t);
			else
				testcasedetailDao.update(t);
		}
		return testcases;
	}
	
	public List<AutoTestcaseDetail> load(String testcaseid){
		
		
		List<AutoTestcaseDetail> testcases = testcasedetailDao.findbyCriteria(Restrictions.eq("testcase", testcaseDao.get(testcaseid)));
		for(AutoTestcaseDetail t : testcases){
			t.setTestcaseid(t.getTestcase().getTestcaseid());
		}
		return testcases;
	}
	
	public void destroy(List<AutoTestcaseDetail> testcases){
		for(AutoTestcaseDetail t: testcases){
			testcasedetailDao.delete(t);
		}
	}
}

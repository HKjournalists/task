package com.lb.app.automation.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;

import com.lb.app.automation.model.AutoScriptDetail;
import com.lb.app.automation.model.AutoTestcaseDetail;
import com.lb.app.automation.service.AutoTestcaseDetailService;

@Service
public class TestcaseDetailAction {
	final private static Log log = LogFactory.getLog(TestcaseDetailAction.class);

	@Autowired
	AutoTestcaseDetailService testcasedetailService;
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_READ)
	public List<AutoTestcaseDetail> load(String testcaseid) {
		return testcasedetailService.load(testcaseid);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public List<AutoTestcaseDetail> saveOrUpdate(List<AutoTestcaseDetail> testcases){
		return testcasedetailService.saveOrUpdate(testcases);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public void  destroy(List<AutoTestcaseDetail> testcases){
		testcasedetailService.destroy(testcases);
	}
}

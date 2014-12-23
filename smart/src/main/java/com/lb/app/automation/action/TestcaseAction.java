package com.lb.app.automation.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;

import com.lb.app.automation.model.AutoScript;
import com.lb.app.automation.model.AutoTestcase;
import com.lb.app.automation.service.AutoTestcaseService;

@Service
public class TestcaseAction {

	final private static Log log = LogFactory.getLog(TestcaseAction.class);

	@Autowired
	AutoTestcaseService testcaseService;
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_READ)
	public List<AutoTestcase> load(String submoduleid) {
		return testcaseService.load(submoduleid);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public List<AutoTestcase> saveOrUpdate(List<AutoTestcase> testcases){
		return testcaseService.saveOrUpdate(testcases);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public void destroy(List<AutoTestcase> testcases){
		testcaseService.destroy(testcases);
	}
}

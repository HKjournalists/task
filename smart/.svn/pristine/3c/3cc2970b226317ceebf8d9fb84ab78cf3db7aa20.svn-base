package com.lb.app.automation.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;

import com.lb.app.automation.model.AutoRule;
import com.lb.app.automation.service.AutoRuleService;

@Service
public class RuleAction {

	final private static Log log = LogFactory.getLog(RuleAction.class);


	@Autowired
	AutoRuleService ruleService;
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_READ)
	public List<AutoRule> load(String name) {
		return ruleService.load(name);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public List<AutoRule> saveOrUpdate(List<AutoRule> rules){
		return ruleService.saveOrUpdate(rules);
	}
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public void destroy(List<AutoRule> rules){
		ruleService.destroy(rules);
	}
}

package com.lb.app.automation.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;

import com.lb.app.automation.model.AutoAction;
import com.lb.app.automation.model.AutoKeyword;
import com.lb.app.automation.service.AutoActionService;


@Service
public class ActionAction {

	final private static Log log = LogFactory.getLog(ActionAction.class);


	@Autowired
	AutoActionService actionService;
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_READ)
	public List<AutoAction> load(String name) {
		return actionService.load(name);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public List<AutoAction> saveOrUpdate(List<AutoAction> actions){
		return actionService.saveOrUpdate(actions);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public void destroy(List<AutoAction> rules){
		actionService.destroy(rules);
	}
}

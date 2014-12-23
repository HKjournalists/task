package com.lb.app.automation.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;

import com.lb.app.automation.model.AutoScriptDetail;
import com.lb.app.automation.service.AutoScriptDetailService;

@Service
public class ScriptDetailAction {
	final private static Log log = LogFactory.getLog(ScriptDetailAction.class);

	@Autowired
	AutoScriptDetailService scriptdetailService;
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_READ)
	public List<AutoScriptDetail> load(String scriptid) {
		return scriptdetailService.load(scriptid);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public List<AutoScriptDetail> saveOrUpdate(List<AutoScriptDetail> scripts){
		return scriptdetailService.saveOrUpdate(scripts);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public void  destroy(List<AutoScriptDetail> scripts){
		scriptdetailService.destroy(scripts);
	}
}

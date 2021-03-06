package com.lb.app.automation.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;
import ch.ralscha.extdirectspring.bean.ExtDirectStoreReadRequest;

import com.lb.app.automation.exception.AssociatiedDestroySubModuleException;
import com.lb.app.automation.model.AutoSubModule;
import com.lb.app.automation.service.AutoModuleService;
import com.lb.app.automation.service.AutoSubModuleService;
import com.lb.app.common.tree.Node;
import com.lb.app.privilege.action.UserAction;
import com.lb.app.privilege.model.Sys_Role;

@Service
public class CaseManageAction {

	final private static Log log = LogFactory.getLog(CaseManageAction.class);
	
	@Autowired
	AutoModuleService autoModuleService;
	@Autowired
	AutoSubModuleService autoSubModuleService;
	
	@ExtDirectMethod(value = ExtDirectMethodType.SIMPLE_NAMED)
	public String createModule(@RequestParam(value = "name") String name) {
		return autoModuleService.createModule(name);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.SIMPLE_NAMED)
	public String createSubModule(@RequestParam("name")String name, 
			@RequestParam("module_id")String module_id){
		return autoSubModuleService.createSubModule(name, module_id);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.SIMPLE_NAMED)
	public void deleteModuleOrSubModule(@RequestParam("id")String id) throws AssociatiedDestroySubModuleException{
		 if( id.startsWith("MOD"))
			 autoModuleService.deleteModule(id);
		 if( id.startsWith("SMD"))
			 autoSubModuleService.deleteSubModule(id);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.SIMPLE_NAMED)
	public void updateModuleOrSubModule(@RequestParam("id")String id, @RequestParam("name")String name){
		 if( id.startsWith("MOD"))
			 autoModuleService.updateModule(id, name);
		 if( id.startsWith("SMD"))
			 autoSubModuleService.updateSubModule(id, name);
	}

	@ExtDirectMethod(value = ExtDirectMethodType.TREE_LOAD)
	public List<Node> getTree(@RequestParam(value = "id", required = false) String id,
		@RequestParam(value = "type", required = false, defaultValue = "defaultValue") String type) {
		return autoModuleService.getTree(id, type);
	}
	
	
	
	
}

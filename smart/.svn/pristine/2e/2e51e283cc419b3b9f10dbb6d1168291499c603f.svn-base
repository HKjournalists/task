package com.lb.app.automation.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lb.app.automation.action.TestcaseDetailAction;
import com.lb.app.automation.dao.IAutoScriptDao;
import com.lb.app.automation.dao.IAutoScriptDetailDao;
import com.lb.app.automation.dao.IAutoSubModuleDao;
import com.lb.app.automation.model.AutoScript;
import com.lb.app.automation.model.AutoScriptDetail;
import com.lb.app.automation.model.AutoTestcase;


@Service
public class AutoScriptService {

	final private static Log log = LogFactory.getLog(AutoScriptService.class);

	@Autowired
	IAutoScriptDao scriptDao;
	@Autowired
	IAutoSubModuleDao submoduleDao;
	@Autowired
	IAutoScriptDetailDao scriptDetailDao;
	
	@Autowired
	AutoTestcaseService testcaseService;
	@Autowired
	AutoBatchDetailService batchdetailService;
	
	public List<AutoScript> saveOrUpdate(List<AutoScript> scripts){
		for(AutoScript k: scripts){
			if(!StringUtils.isEmpty(k.getSubmoduleid()))
				k.setSubmodule(submoduleDao.get(k.getSubmoduleid()));
			if(StringUtils.isEmpty(k.getScriptid()))
				scriptDao.create(k);
			else
				scriptDao.update(k);
		}
		return scripts;
	}
	
	public List<AutoScript> load(String submodule_id){
		
		List<AutoScript> scripts = scriptDao.findbyCriteria(Restrictions.eq("submodule", submoduleDao.get(submodule_id)));
		for(AutoScript s : scripts){
			s.setSubmoduleid(s.getSubmodule().getSubmoduleid());
		}
		return scripts;
	}
	
	public void destroy(List<AutoScript> scripts){
		
		for(AutoScript s : scripts){
			List<AutoTestcase> cases = testcaseService.loadByScriptid(s);
			if(cases.size() > 0)
				testcaseService.destroy(cases);
			batchdetailService.destroyByScript(s);
		}
		
		List<AutoScriptDetail> details = scriptDetailDao.findbyCriteria(Restrictions.in("script", scripts));
		for(AutoScriptDetail d : details)
			scriptDetailDao.delete(d);
		
		
		
		for(AutoScript s: scripts){
			scriptDao.delete(s);
		}
	}
	
	public List<AutoScript> getScriptByIds(String ids){
		return scriptDao.findbyCriteria(Restrictions.in("scriptid", ids.split(",")));
	}
}

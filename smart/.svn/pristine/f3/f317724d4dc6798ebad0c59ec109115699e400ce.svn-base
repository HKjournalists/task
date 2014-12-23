package com.lb.app.automation.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lb.app.automation.dao.IAutoKeywordDao;
import com.lb.app.automation.dao.IAutoScriptDao;
import com.lb.app.automation.dao.IAutoScriptDetailDao;
import com.lb.app.automation.dao.IAutoSubModuleDao;
import com.lb.app.automation.model.AutoScript;
import com.lb.app.automation.model.AutoScriptDetail;


@Service
public class AutoScriptDetailService {

	final private static Log log = LogFactory.getLog(AutoScriptDetailService.class);

	@Autowired
	IAutoScriptDetailDao scriptDetailDao;
	
	@Autowired
	IAutoScriptDao scriptDao;
	
	@Autowired
	IAutoKeywordDao keywordDao;
	
	public List<AutoScriptDetail> saveOrUpdate(List<AutoScriptDetail> scripts){
		for(AutoScriptDetail k: scripts){
			if(!StringUtils.isEmpty(k.getScriptid()))
				k.setScript(scriptDao.get(k.getScriptid()));
			if(!StringUtils.isEmpty(k.getKeywordid())){
				k.setKeyword(keywordDao.get(k.getKeywordid()));
				k.setKeywordsubmoduleid(k.getKeyword().getSubmodule().getSubmoduleid());
			}
			
			
			if(StringUtils.isEmpty(k.getScriptdetailid()))
				scriptDetailDao.create(k);
			else
				scriptDetailDao.update(k);
		}
		return scripts;
	}
	
	public List<AutoScriptDetail> load(String scriptid){
		List<AutoScriptDetail> script_details = scriptDetailDao.findbyCriteria(Restrictions.eq("script", scriptDao.get(scriptid)));
		for(AutoScriptDetail s : script_details){
			s.setKeywordid(s.getKeyword().getKeywordid());
			s.setScriptid(s.getScript().getScriptid());
		}
		return script_details;
	}
	
	public void destroy(List<AutoScriptDetail> scripts){
		for(AutoScriptDetail s: scripts){
			scriptDetailDao.delete(s);
		}
	}
}

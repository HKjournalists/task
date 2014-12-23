package com.lb.app.automation.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lb.app.automation.dao.IAutoRuleDao;
import com.lb.app.automation.model.AutoKeywordDetail;
import com.lb.app.automation.model.AutoRule;

@Service
public class AutoRuleService {
	
	final private static Log log = LogFactory.getLog(AutoRuleService.class);

	@Autowired
	IAutoRuleDao autoRuleDao;
	
	public List<AutoRule> saveOrUpdate(List<AutoRule> rules){
		for(AutoRule r: rules){
			if(StringUtils.isEmpty(r.getRuleid()))
				autoRuleDao.create(r);
			else
				autoRuleDao.update(r);
		}
		return rules;
	}
	
	public List<AutoRule> load(String name){
		return autoRuleDao.findbyCriteria(Restrictions.like("operation", "%" + name + "%"));
	}
	
	public void destroy( List<AutoRule> rules){
		for(AutoRule rule : rules)
			autoRuleDao.delete(rule);
	}
}

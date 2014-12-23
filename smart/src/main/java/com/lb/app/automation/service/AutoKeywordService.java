package com.lb.app.automation.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lb.app.automation.dao.IAutoKeywordDao;
import com.lb.app.automation.dao.IAutoKeywordDetailDao;
import com.lb.app.automation.dao.IAutoScriptDetailDao;
import com.lb.app.automation.dao.IAutoSubModuleDao;
import com.lb.app.automation.exception.AssociatiedDestroyKeywordException;
import com.lb.app.automation.model.AutoKeyword;
import com.lb.app.automation.model.AutoKeywordDetail;


@Service
public class AutoKeywordService {

	
	final private static Log log = LogFactory.getLog(AutoKeywordService.class);

	@Autowired
	IAutoKeywordDao keywordDao;
	@Autowired
	IAutoKeywordDetailDao keywordDetailDao;
	@Autowired
	IAutoSubModuleDao submoduleDao;
	@Autowired
	IAutoScriptDetailDao scriptDetailDao;
	
	public List<AutoKeyword> saveOrUpdate(List<AutoKeyword> keywords){
		log.info("service: autokeyword save...");
		for(AutoKeyword k: keywords){
			if(!StringUtils.isEmpty(k.getSubmodule_id()))
				k.setSubmodule(submoduleDao.get(k.getSubmodule_id()));
			if(StringUtils.isEmpty(k.getKeywordid()))
				keywordDao.create(k);
			else
				keywordDao.update(k);
		}
		return keywords;
	}
	
	public List<AutoKeyword> load(String submodule_id){
		
		List<AutoKeyword> keywords = keywordDao.findbyCriteria(Restrictions.eq("submodule", submoduleDao.get(submodule_id)));
		for(AutoKeyword kw : keywords){
			kw.setSubmodule_id(kw.getSubmodule().getSubmoduleid());
		}
		return keywords;
	}
	
	public void destroy(List<AutoKeyword> keywords) throws AssociatiedDestroyKeywordException{
		
		for(AutoKeyword k: keywords){
			if (scriptDetailDao.findbyCriteria(Restrictions.eq("keyword", k)).size() > 0)
				throw new AssociatiedDestroyKeywordException();
		}
		List<AutoKeywordDetail> keyword_details = keywordDetailDao.findbyCriteria(Restrictions.in("keyword", keywords));
		for(AutoKeywordDetail d :keyword_details)
			keywordDetailDao.delete(d);
		
		for(AutoKeyword k: keywords){
			keywordDao.delete(k);
		}
		
	}
}

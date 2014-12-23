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
import com.lb.app.automation.model.AutoKeywordDetail;
import com.lb.app.automation.model.AutoScriptDetail;

@Service
public class AutoKeywordDetailService {
	final private static Log log = LogFactory.getLog(AutoKeywordService.class);

	@Autowired
	IAutoKeywordDetailDao keywordDetailDao;
	
	@Autowired
	IAutoKeywordDao keywordDao;
	
	@Autowired
	IAutoScriptDetailDao scriptDetailDao;
	
	public List<AutoKeywordDetail> saveOrUpdate(List<AutoKeywordDetail> keywords){
		for(AutoKeywordDetail k: keywords){
			k.setKeyword(keywordDao.get(k.getKeywordid()));
			
			if(StringUtils.isEmpty(k.getKeyworddetailid()))
					keywordDetailDao.create(k);
			else
				keywordDetailDao.update(k);
		}
		return keywords;
	}
	
	public List<AutoKeywordDetail> load(String keywordid){
		List<AutoKeywordDetail> details = keywordDetailDao.findbyCriteria(Restrictions.eq("keyword", keywordDao.get(keywordid)));
		for(AutoKeywordDetail d : details)
			d.setKeywordid(d.getKeyword().getKeywordid());
		return details;
	}
	
	public void destroy( List<AutoKeywordDetail> keyworddetails){
		for(AutoKeywordDetail detail : keyworddetails)
			keywordDetailDao.delete(detail);
	}
	
	public List<AutoKeywordDetail> loadByScriptID(String scriptid){
		return keywordDetailDao.queryByScriptid(scriptid);
	}
}

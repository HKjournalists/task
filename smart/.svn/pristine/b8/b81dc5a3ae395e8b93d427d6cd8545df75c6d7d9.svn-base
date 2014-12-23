package com.lb.app.automation.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;

import com.lb.app.automation.model.AutoKeyword;
import com.lb.app.automation.model.AutoKeywordDetail;
import com.lb.app.automation.service.AutoKeywordDetailService;

@Service
public class KeywordDetailAction {

	final private static Log log = LogFactory.getLog(KeywordDetailAction.class);


	@Autowired
	AutoKeywordDetailService keywordDetailService;
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_READ)
	public List<AutoKeywordDetail> loadKeywordDetails( String keywordid) {
		return keywordDetailService.load(keywordid);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public List<AutoKeywordDetail> saveOrUpdateKeywordDetails(List<AutoKeywordDetail> keyworddetails){
		return keywordDetailService.saveOrUpdate(keyworddetails);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public void  destroyKeywordDetails(List<AutoKeywordDetail> keywords){
		keywordDetailService.destroy(keywords);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_READ)
	public List<AutoKeywordDetail> loadKeywordDetailsByScriptid(String scriptid) {
		return keywordDetailService.loadByScriptID(scriptid);
	}
}

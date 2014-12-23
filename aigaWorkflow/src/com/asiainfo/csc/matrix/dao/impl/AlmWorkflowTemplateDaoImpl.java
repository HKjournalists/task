package com.asiainfo.csc.matrix.dao.impl;

import java.util.Map;

import com.asiainfo.csc.matrix.bo.BOAlmWorkflowTemplateEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkflowTemplateDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowTemplateValue;

public class AlmWorkflowTemplateDaoImpl implements IAlmWorkflowTemplateDao {

	
	public IBOAlmWorkflowTemplateValue[] getAlmWorkflowTemplateByCondition(
			String condition, Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BOAlmWorkflowTemplateEngine.getBeans(condition,paramter);
	}

}

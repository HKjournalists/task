package com.lb.app.automation.dao;

import java.util.List;

import com.lb.app.automation.model.AutoKeywordDetail;
import com.lb.app.common.dao.IGenericDAO;

public interface IAutoKeywordDetailDao extends IGenericDAO<AutoKeywordDetail>{
	public List<AutoKeywordDetail> queryByScriptid(String scriptid);
}

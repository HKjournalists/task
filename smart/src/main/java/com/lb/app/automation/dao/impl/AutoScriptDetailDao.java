package com.lb.app.automation.dao.impl;

import org.springframework.stereotype.Repository;

import com.lb.app.automation.dao.IAutoScriptDetailDao;
import com.lb.app.automation.model.AutoScriptDetail;
import com.lb.app.common.dao.impl.GenericDAO;

@Repository
public class AutoScriptDetailDao extends GenericDAO<AutoScriptDetail> implements IAutoScriptDetailDao{

}

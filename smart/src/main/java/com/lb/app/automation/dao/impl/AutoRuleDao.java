package com.lb.app.automation.dao.impl;

import org.springframework.stereotype.Repository;

import com.lb.app.automation.dao.IAutoRuleDao;
import com.lb.app.automation.model.AutoRule;
import com.lb.app.common.dao.impl.GenericDAO;

@Repository
public class AutoRuleDao extends GenericDAO<AutoRule> implements IAutoRuleDao{

}

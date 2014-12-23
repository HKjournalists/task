package com.lb.app.automation.dao.impl;

import org.springframework.stereotype.Repository;

import com.lb.app.automation.dao.IAutoScriptDao;
import com.lb.app.automation.model.AutoScript;
import com.lb.app.common.dao.impl.GenericDAO;

@Repository
public class AutoScriptDao extends GenericDAO<AutoScript> implements IAutoScriptDao{

}

package com.lb.app.automation.dao.impl;

import org.springframework.stereotype.Repository;

import com.lb.app.automation.dao.IAutoBatchDetailDao;
import com.lb.app.automation.model.AutoBatchDetail;
import com.lb.app.common.dao.impl.GenericDAO;

@Repository
public class AutoBatchDetailDao extends GenericDAO<AutoBatchDetail> implements IAutoBatchDetailDao{

}

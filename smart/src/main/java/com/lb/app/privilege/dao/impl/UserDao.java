package com.lb.app.privilege.dao.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import com.lb.app.common.dao.impl.GenericDAO;
import com.lb.app.privilege.dao.IUserDao;
import com.lb.app.privilege.model.Sys_User;

@Repository
public class UserDao extends GenericDAO<Sys_User> implements IUserDao{

	final private static Log log = LogFactory.getLog(UserDao.class);

}
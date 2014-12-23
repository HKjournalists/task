package com.lb.app.privilege.dao.impl;

import org.springframework.stereotype.Repository;

import com.lb.app.common.dao.impl.GenericDAO;
import com.lb.app.privilege.dao.IRoleDao;
import com.lb.app.privilege.model.Sys_Role;

@Repository
public class RoleDao extends GenericDAO<Sys_Role> implements IRoleDao{

}
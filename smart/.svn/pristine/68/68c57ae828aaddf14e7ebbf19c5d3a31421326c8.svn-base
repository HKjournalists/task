package com.lb.app.privilege.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lb.app.privilege.action.RoleAction;
import com.lb.app.privilege.dao.IRoleDao;
import com.lb.app.privilege.model.Sys_Role;


@Service
@Transactional
public class RoleService {

	final private static Log log = LogFactory.getLog(RoleAction.class);

	@Autowired
	IRoleDao roleDao;
	
	public List<Sys_Role> load(String name) {
		log.info("service: role load...");
		//return roleDao.findbyCriteria(Restrictions.like("name", "%" + name + "%"));
		Conjunction con = Restrictions.conjunction();
		if(!StringUtils.isEmpty(name))
			con.add(Restrictions.like("name", "%" + name + "%"));
		return roleDao.findbyCriteria(con);
	}
	
	public List<Sys_Role> saveOrUpdate(List<Sys_Role> roles){
		log.info("service: role save...");
		for(Sys_Role r: roles){
			log.info(r.getRoleid());
			roleDao.saveOrUpdate(r);
		}
		return roles;
	}
	
	public void destory(List<Sys_Role> roles){
		log.info("service: role destory...");
		log.info(roles.size());
		for(Sys_Role r: roles){
			roleDao.delete(r);
		}
		
	}
	
	
}

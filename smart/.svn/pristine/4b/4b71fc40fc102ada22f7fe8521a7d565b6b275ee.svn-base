package com.lb.app.privilege.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Restrictions;
import org.hibernate.internal.util.StringHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lb.app.common.utils.MD5Util;
import com.lb.app.privilege.dao.IRoleDao;
import com.lb.app.privilege.dao.IUserDao;
import com.lb.app.privilege.model.Sys_Role;
import com.lb.app.privilege.model.Sys_User;


@Service
@Transactional
public class UserService {
	
	final private static Log log = LogFactory.getLog(UserService.class);

	@Autowired
	IUserDao userDao;
	@Autowired
	IRoleDao roleDao;
	
	public List<Sys_User> load(String username, String realname, String department, String manager) {
		
		Conjunction con = Restrictions.conjunction();
		if(!StringUtils.isEmpty(username))
			con.add(Restrictions.like("username", "%" + username + "%"));
		if(!StringUtils.isEmpty(realname))
			con.add(Restrictions.like("realname", "%" + realname + "%"));
		if(!StringUtils.isEmpty(department))
			con.add(Restrictions.like("department", "%" + department + "%"));
		if(!StringUtils.isEmpty(manager))
			con.add(Restrictions.like("manager", "%" + manager + "%"));
			
		return userDao.findbyCriteria(con);
	}
	
	
	public List<Sys_User> createOrUpdate(List<Sys_User> users) {
		for(Sys_User user : users){
			
			String roleids = user.getRoleids();
			log.info(roleids);
			if(!StringUtils.isEmpty(roleids)){
				
				ArrayList<Long> role_list = new ArrayList<Long>();
				for(String rid:roleids.split(","))
					role_list.add(Long.valueOf(rid));
				List<Sys_Role> roles = roleDao.findbyCriteria(Restrictions.in("roleid", role_list.toArray(new Long[role_list.size()])));
				if(user.getRoles()==null)
					user.setRoles(new HashSet<Sys_Role>());
				for (Sys_Role r : roles)
					user.getRoles().add(r);
			}
			if(user.getUserid()==0){
				user.setPassword(MD5Util.string2MD5(user.getPassword()));
			}
			
			userDao.saveOrUpdate(user);
		}
	    return users;
	}
	
	
	public void destroy(List<Sys_User> users){
		for(Sys_User user : users)
			userDao.delete(user);
	}
	
	
	public Sys_User checkUser(String username, String password){
		
		List<Sys_User> users = userDao.findbyCriteria(Restrictions.eq("username", username));
		if (users.size() <= 0)
			return null;
		Sys_User user = users.get(0);
		if(user.getPassword().equals(MD5Util.string2MD5(password)) || user.getPassword().equals(password)){
			return user;
		}else
			return null;
	}
}

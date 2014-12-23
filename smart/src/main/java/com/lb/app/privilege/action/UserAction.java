package com.lb.app.privilege.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;
import ch.ralscha.extdirectspring.bean.ExtDirectStoreReadRequest;

import com.lb.app.privilege.model.Sys_Role;
import com.lb.app.privilege.model.Sys_User;
import com.lb.app.privilege.service.UserService;

@Service
public class UserAction {
	
	final private static Log log = LogFactory.getLog(UserAction.class);

	@Autowired
	UserService userService;
	
    public void user(HttpServletRequest request, HttpServletResponse response) throws IOException {
    }
    
    
    @ExtDirectMethod(value = ExtDirectMethodType.STORE_READ)
    public List<Sys_User> load(ExtDirectStoreReadRequest request){
    	
    	String username = (String)request.getParams().get("username");
    	String realname = (String)request.getParams().get("realname");
    	String department = (String)request.getParams().get("department");
    	String manager = (String)request.getParams().get("manager");
    	List<Sys_User> users = userService.load(username, realname, department, manager);
    	for(Sys_User u : users){
    		ArrayList<String> user_role_id_list = new ArrayList<String>();
    		
    		for(Sys_Role r : u.getRoles()){
    			user_role_id_list.add(String.valueOf(r.getRoleid()));
    		}
    		String roleIds = StringUtils.arrayToCommaDelimitedString(user_role_id_list.toArray(new String[user_role_id_list.size()]));
    		log.info(roleIds);
    		u.setRoleids(roleIds);
    	}
    	return users;
    	
    }
    
    
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public List<Sys_User> createOrUpdate(List<Sys_User> users) {
		return userService.createOrUpdate(users);
	}
	
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public void destroy(List<Sys_User> users){
		userService.destroy(users);
	}
}

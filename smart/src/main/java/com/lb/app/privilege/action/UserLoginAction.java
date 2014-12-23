package com.lb.app.privilege.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lb.app.privilege.model.Sys_User;
import com.lb.app.privilege.service.UserService;

@Controller
@RequestMapping("/userlogin")
public class UserLoginAction {

	@Autowired
	UserService userService;
	
	@RequestMapping("/login")
	public @ResponseBody Map login(
			@RequestParam("username")String username, 
			@RequestParam("password") String password,
			HttpSession session){
		
		Map<String, String> map = new HashMap<String, String>();
		Sys_User user = userService.checkUser(username, password);
		
		if (user == null){
			map.put("result", "false");
			map.put("message", "用户不存在或者密码，请尝试重新登录.");
			map.put("event", "login");
		}else{
			session.setAttribute("user", user);
			map.put("result", "true");
			map.put("message", "登录成功");
			map.put("event", "login");
		}
		
		return map;
	}
	@RequestMapping("/logout")
	public @ResponseBody Map logout(HttpSession session){
		
		session.setAttribute("user", null);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "true");
		map.put("message", "登出成功");
		map.put("event", "login");
		return map;
	}
			
}

package com.asiainfo.aiga.common.client;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.client.service.IRecieveClientConfigSV;

@Controller
public class RecivevClientConfig {

	@Resource(name="recieveClientConfigSV")
	private IRecieveClientConfigSV clientConfigSV;
	
	@RequestMapping("/sendConfig.do")
	public void recieveConfig(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		String ip = request.getParameter("Ip");
		String port = request.getParameter("Port");
		String nickName = request.getParameter("NickName");
		String uuid = request.getParameter("Id");
		
		ServletInputStream inputStream = request.getInputStream();
		BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
		String temp = "";
		String pathMap = "";
		while ((temp = reader.readLine()) != null) {
			System.out.println(temp);
			pathMap+=temp;
		}
		
		System.out.println("IP:"+ip+"\nport:"+port+"\npath:"+pathMap+"\nnickName:"+nickName);
		clientConfigSV.saveRecieveClientConfig(ip, port, pathMap, nickName, uuid);
	}
}

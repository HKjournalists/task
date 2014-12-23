package com.asiainfo.csc.attach.web;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.CustomProperty;
import com.ai.appframe2.web.HttpUtil;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeDefValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachTypeConfigSV;
import com.asiainfo.csc.attach.service.interfaces.IAttachTypeDefSV;

public class AttachTypeConfigAction extends BaseAction {

	public void getAttachTypeConfig(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONObject cp = new JSONObject();
		try {
			String zone = request.getParameter("zone");
			String column = request.getParameter("column");

			IAttachTypeConfigSV configSV = (IAttachTypeConfigSV) ServiceFactory
					.getService(IAttachTypeConfigSV.class);
			String html = configSV.getAttachTypeConfigHtml(zone, column);
			cp.put("html", html);
		} catch (Exception e) {
			e.printStackTrace();
			cp.put("success", false);
			cp.put("message", e.getCause());
		} finally {
			response.setContentType("application/Json;charset=UTF-8");
			response.getWriter().write(URLEncoder.encode(cp.toString(),"UTF-8"));
		}
	}
	
	public void checkAttachType(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONObject cp = new JSONObject();
		try {
			String zone = request.getParameter("zone");
			String xml = new String(request.getParameter("xml").getBytes("iso8859-1"),"utf-8");
			String hasSelectedTypeId = request.getParameter("hasSelectedTypeId");
			
			IAttachTypeConfigSV configSV = (IAttachTypeConfigSV) ServiceFactory
					.getService(IAttachTypeConfigSV.class);
			Map<String, String> rtv = configSV.checkAttachTypeConfig(zone, xml, hasSelectedTypeId);
			cp.put("isEqual", rtv.get("isEqual"));
			cp.put("noTypeName", rtv.get("noTypeName"));
			cp.put("checkAttType", rtv.get("checkAttType"));
			cp.put("checkAttTypeName", rtv.get("checkAttTypeName"));
			cp.put("noType", rtv.get("noType"));
			cp.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			cp.put("success", false);
			cp.put("message", e.getCause());
		} finally {
			response.setContentType("application/Json;charset=UTF-8");
			response.getWriter().write(URLEncoder.encode(cp.toString(),"UTF-8"));
		}
	}
	
	public void getAttachTypeName(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONObject cp = new JSONObject();
		try {
			String attTypeId = request.getParameter("attTypeId");
			IAttachTypeDefSV defSV = (IAttachTypeDefSV)ServiceFactory.getService(IAttachTypeDefSV.class);
			IBOAttachTypeDefValue checkAttTypeValue = defSV.getAttachTypeDefById(attTypeId);
			cp.put("attTypeName", checkAttTypeValue.getAttTypeName());
			cp.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			cp.put("success", false);
			cp.put("message", e.getCause());
		} finally {
			response.setContentType("application/Json;charset=UTF-8");
			response.getWriter().write(URLEncoder.encode(cp.toString(),"UTF-8"));
		}
	}
}

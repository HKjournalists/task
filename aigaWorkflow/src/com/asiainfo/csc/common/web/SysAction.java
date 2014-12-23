package com.asiainfo.csc.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.CustomProperty;
import com.ai.appframe2.web.HttpUtil;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.attach.ivalues.IBOQueryAttPackValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachService;
import com.asiainfo.csc.common.define.OrgRole;
import com.asiainfo.csc.common.service.interfaces.IPermissionSV;
import com.asiainfo.csc.matrix.common.ConstDefine;

public class SysAction extends BaseAction{
	
	public void queryDepartNameByStaffId(HttpServletRequest request,HttpServletResponse response)
	{
		try{
			String staffId=	request.getParameter("staffId");
			
			IPermissionSV ipsv = (IPermissionSV)ServiceFactory.getService(IPermissionSV.class);
			OrgRole or = ipsv.getOrgRole(Long.parseLong(staffId));
			String orgName = ipsv.getOrgName(or.getOrgid());
			CustomProperty cp = CustomProperty.getInstance();
			cp.set("orgName", orgName);
			HttpUtil.showInfo(response, cp);
		}catch(Exception e)
		{
			e.printStackTrace();
			StringBuffer sb = new StringBuffer();
			sb.append("在通知查询数据时出错：" + e.getMessage());
		}
	}
}

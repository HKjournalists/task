package com.ai.filter;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.SessionManager;
import com.ai.appframe2.common.Util;
import com.ai.appframe2.privilege.LoginException;
import com.ai.appframe2.privilege.UserInfoInterface;
import com.ai.appframe2.privilege.UserManager;
import com.ai.appframe2.privilege.UserManagerFactory;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.BaseServer;
import com.ai.secframe.bo.orgmodel.SysLoginLogBean;
import com.ai.secframe.common.ConstantExceptionDesc;
import com.ai.secframe.common.Constants;
import com.ai.secframe.forbusi.interfaces.ILoginOK;
import com.ai.secframe.forbusi.interfaces.IPassword;
import com.ai.secframe.forbusi.interfaces.IUserSessionInfoSet;
import com.ai.secframe.ivalues.orgmodel.IDistrictValue;
import com.ai.secframe.ivalues.orgmodel.ISysEmployeeValue;
import com.ai.secframe.ivalues.orgmodel.ISysLoginLogValue;
import com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue;
import com.ai.secframe.ivalues.orgmodel.ISysStaffOrgRelatValue;
import com.ai.secframe.ivalues.orgmodel.ISysStaffValue;
import com.ai.secframe.service.orgmodel.interfaces.IDistrictInfo;
import com.ai.secframe.service.orgmodel.interfaces.ISysEmployee;
import com.ai.secframe.service.orgmodel.interfaces.ISysLoginLog;
import com.ai.secframe.service.orgmodel.interfaces.ISysOrganize;
import com.ai.secframe.service.orgmodel.interfaces.ISysStaff;
import com.ai.secframe.service.orgmodel.interfaces.ISysStaffOrgRelat;
import com.ai.secframe.util.SecframePropertisInfo;
import com.asiainfo.csc.common.define.WorkFlowParam;

public class LoginFilter implements Filter {
	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
		login(servletRequest, servletResponse);
		// if( request.getRequestURL().indexOf( "index.html" ) != -1 ){
		// response.sendRedirect( request.getContextPath() +
		// "/uwfe/MainFrame.jsp" );
		// }
		filterChain.doFilter(servletRequest, servletResponse);
		// response.sendRedirect(request.getRequestURL().toString());
	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
	}

	public void login(ServletRequest servletRequest, ServletResponse servletResponse) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		request.getSession().getServletContext().setAttribute("WORKFLOWPARAM", WorkFlowParam.getInstance());
		String code = null;
		// ***********OA系统单点登录校验代码start*************************
		String uidCode = request.getParameter("uid");
		try {
			code = uidCode;
		} catch (Exception e1) {
			code = null;
		}
		// ***********OA系统单点登录校验代码end*************************
		if (code != null && !code.equals("")) {
			SessionManager.setContextName(request.getContextPath());
			SessionManager.setRequest(request);
			// 获取userinfo信息
			UserInfoInterface userInfo = null;
			String serialID = (String) request.getSession().getAttribute(BaseServer.WBS_USER_ATTR);
			if (StringUtils.isNotBlank(serialID)) { // 检查是否登录
				try {
					userInfo = BaseServer.getCurUser(request);
					if (!userInfo.getCode().equals(code)) {
						userInfo = null;
					}
				} catch (Exception ex) {
					throw new ServletException(ex);
				}
			}

			if (userInfo == null || userInfo.getCode() == null || userInfo.getCode().equals("")) {
				try {
					userInfo = ((UserManager) Class.forName(ServiceManager.getUserManagerImplClass()).newInstance()).getBlankUserInfo();
					IDistrictInfo objDistSRV = (IDistrictInfo) ServiceFactory.getService(Constants.SERVICE_DISTRICTINFO);
					ISysStaff staffSv = (ISysStaff) ServiceFactory.getService(Constants.SERVICE_SYS_STAFF);
					ISysStaffValue staffValue = staffSv.getSysStaffByCode(code);
					if (staffValue == null) {
						// 用户不存在
						throw new LoginException(ConstantExceptionDesc.USER_LOGIN_USERNOTFOUND);
					} else {
						if (staffValue.getState() == 0) {
							// 用户已经失效
							throw new LoginException(ConstantExceptionDesc.USER_LOGIN_EXPIREDATEERROR);
						}

						long nowDateLong = Util.getSysDate().getTime();
						// System.out.println(md5.getMD5ofStr("password"));
						IPassword ipass = (IPassword) Class.forName(SecframePropertisInfo.PASSWORD_IMPL).newInstance();

						// if( !staffValue.getPassword().equals(
						// ipass.getPassword( passWord ) ) ){
						// throw new LoginException(
						// ConstantExceptionDesc.USER_LOGIN_PWDERROR );
						// }
						String strLockFlag = staffValue.getLockFlag();
						// 用户被锁定
						if (strLockFlag != null && strLockFlag.equals("Y")) {
							throw new LoginException(ConstantExceptionDesc.USER_LOGIN_LOCKED); // 登录失败--用户被锁定
						}

						// /登录失败－－用户id已经失效
						// if( staffValue.getPasswordValidDate() != null &&
						// nowDateLong >
						// (staffValue.getExpireDate().getTime())){
						// throw new LoginException(
						// ConstantExceptionDesc.USER_LOGIN_EFFECTDATEERROR );
						// }
						// if(staffValue.getBandType()>0){
						// ISysStaffIpmacBand band = (ISysStaffIpmacBand)
						// ServiceFactory.getService(
						// Constants.SERVICE_SYS_STAFF_IPMAC_BAND );
						// boolean flag = band.checkBand(
						// staffValue.getStaffId(), ipAddr, macAddr );
						// if(!flag){
						// throw new
						// LoginException("你的IP"+ipAddr+"和MAC："+macAddr+"与数据库绑定的地址和IP不符");
						// }
						// }
						// 密码是否过期判断 ，判断当前日期是否大于密码生效日期后的90天,如果密码允许时间为-1，则密码永不过期
						long psw_valid_days = staffValue.getPasswdValidDays();
						if (staffValue.getPasswdValidDays() != -1) {
							// 判断是否过期
							if (psw_valid_days <= 0)
								psw_valid_days = 90;
							if (nowDateLong > (staffValue.getPasswordValidDate().getTime() + psw_valid_days * 24 * 60 * 60 * 1000))
								throw new LoginException(ConstantExceptionDesc.USER_LOGIN_EFFECTDATEERROR);
						}
						// 登陆成功
						long alarmsDay = 0;
						// 判断是否要进行修改密码提醒,如果提醒时间不为-1 ，则到期了就提醒
						if (staffValue.getChgPasswdAlarmDays() != -1) {
							// 计算密码还有几天过期
							// long allow_day =
							// (user.getPasswordValidDate().getTime()
							// + psw_valid_days * 24 * 60 * 60 * 1000 -
							// nowDateLong)
							// / (24L * 60 * 60 * 1000);
							long allow_day = (nowDateLong - staffValue.getPasswordValidDate().getTime()) / (24L * 60 * 60 * 1000);
							// 如果alarmsDay>=0 需要提醒
							alarmsDay = allow_day - staffValue.getChgPasswdAlarmDays();
						}
					}

					ISysEmployee employeeSv = (ISysEmployee) ServiceFactory.getService(Constants.SERVICE_SYS_EMPLOYEE);
					ISysEmployeeValue employeeValue = employeeSv.getSysEmployeeById(staffValue.getEmployeeId());
					if (employeeValue == null || employeeValue.getEmployeeId() <= 0) {
						throw new LoginException(ConstantExceptionDesc.USER_LOGIN_EMPLOYEE_ERROR);
					}
					ISysStaffOrgRelat relateSv = (ISysStaffOrgRelat) ServiceFactory.getService(Constants.SERVICE_SYS_STAFF_ORG_RELAT);
					ISysStaffOrgRelatValue relateValue = relateSv.querySysStaffOrgBaseRelatByStaffId(staffValue.getStaffId());
					if (relateValue == null || relateValue.getOrganizeId() <= 0 || staffValue.getState() == 0) {
						throw new LoginException(ConstantExceptionDesc.USER_LOGIN_ORGRELATE_ERROR);
					}

					ISysOrganize organizeSv = (ISysOrganize) ServiceFactory.getService(Constants.SERVICE_SYS_ORGANIZE);

					ISysOrganizeValue organizeValue = organizeSv.getSysOrganizeById(relateValue.getOrganizeId());
					if (organizeValue == null || organizeValue.getOrganizeId() <= 0 || organizeValue.getState() == 0) {
						throw new LoginException(ConstantExceptionDesc.USER_LOGIN_ORG_ERROR);
					}

					userInfo.setCode(staffValue.getCode());
					userInfo.setName(employeeValue.getEmployeeName());
					userInfo.setOrgId(organizeValue.getOrganizeId());
					userInfo.setOrgName(organizeValue.getOrganizeName());
					userInfo.setID(staffValue.getStaffId());
					userInfo.setIP(BaseServer.getIpAddr(request));
					userInfo.setDomainId(1);

					IDistrictValue objDist = objDistSRV.getDist(organizeValue.getOrganizeId());
					if (objDist != null) {
						userInfo.set(Constants.PARE_DIST_ID, objDist.getPareDistId());
						userInfo.set(Constants.DISTRICT_ID, objDist.getDistrictId());
						userInfo.set(Constants.CITY_ID, objDist.getDistrictId());
						userInfo.set(Constants.COUNTY_ID, String.valueOf(organizeValue.getCountyId()));
						userInfo.set(Constants.REGION_ID, objDist.getRegionId());
					}

					/** *回调业务系统，设置业务系统扩展的一些属性在session里面** */
					IUserSessionInfoSet userSet = (IUserSessionInfoSet) Class.forName(SecframePropertisInfo.USER_SESSION_INFO_SET_IMPL).newInstance();
					userSet.setUserInfo(userInfo);
					/** *回调业务系统，设置业务系统扩展的一些属性在session里面** */
					// ********************************* 设置登陆相关的信息
					SysLoginLogBean loginLogValue = new SysLoginLogBean();
					loginLogValue.setStaffCode(code);
					loginLogValue.setSessionId(request.getSession().getId());
					loginLogValue.setMac("undifine");
					loginLogValue.setIp(BaseServer.getIpAddr(request));
					loginLogValue.setLoginDate(new Timestamp(System.currentTimeMillis()));
					loginLogValue.setState(1);
					ISysLoginLog sysLoginLog = (ISysLoginLog) ServiceFactory.getService(Constants.SERVICE_SYS_LOGIN_LOG);
					sysLoginLog.saveSysLoginLog(new ISysLoginLogValue[] { loginLogValue });
					userInfo.set(Constants.LOGIN_LOG_ID, new Long(loginLogValue.getLogId()));
					// ************************** 设置登陆相关的信息
					/** 回调业务系统，通知成功登陆信息，一般短信通知* */
					ILoginOK loginOk = (ILoginOK) Class.forName(SecframePropertisInfo.USER_LOGIN_OK_IMPL).newInstance();
					loginOk.notifyBusi(userInfo);
					/** 回调业务系统，通知成功登陆信息，一般短信通知* */
					UserManagerFactory.getUserManager().setLogined(userInfo);
					userInfo.setIP(BaseServer.getIpAddr(request));
					userInfo.setSessionID(request.getSession().getId());
					request.getSession().setAttribute(BaseServer.WBS_USER_ATTR, userInfo.getSerialID());
					SessionManager.setUser(userInfo);
					// return user;
				} catch (Exception e) {
					if (e instanceof LoginException) {
						throw new ServletException(e);
					} else {
						throw new ServletException(e);
					}
				}
			}
		}
	}
}

package com.ai.secframe.web;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ai.appframe2.privilege.LoginException;
import com.ai.appframe2.privilege.UserInfoInterface;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.HttpUtil;
import com.ai.frame.loginmgr.AbstractUserManagerImpl;
import com.ai.secframe.common.Constants;
import com.ai.secframe.common.UserInfo;
import com.ai.secframe.ivalues.orgmodel.ISysLoginLogValue;
import com.ai.secframe.service.orgmodel.interfaces.ISysLoginLog;
import com.ai.secframe.service.pubapi.interfaces.ISysLogin;

public class UserManagerDefaultImpl
    extends AbstractUserManagerImpl{
  private static transient Log log = LogFactory.getLog( UserManagerDefaultImpl.class );
  public void changePassword( String userCode, String oldPassword, String newPassword ) throws LoginException{
    try{
      ISysLogin sysLogin = (ISysLogin) ServiceFactory.getService( Constants.SERVICE_SYS_LOGIN, ISysLogin.class );
       sysLogin.changePassword( userCode, oldPassword, newPassword );
    }catch( Exception e ){
      log.error( "修改密码出错！",e );
      String strErrMsg;
      if( e.getCause() != null )
        strErrMsg = e.getCause().getMessage();
      else
        strErrMsg = e.getMessage();
      throw new LoginException( strErrMsg );
    }
  }

  public UserInfoInterface loginIn( String userCode, String oldPassword, long domainId,int curLoginNum, HttpServletRequest request )
    throws Exception{
    try{

      ISysLogin sysLogin = (ISysLogin) ServiceFactory.getService( Constants.SERVICE_SYS_LOGIN, ISysLogin.class );
      return sysLogin.loginIn( userCode, oldPassword, curLoginNum, HttpUtil.getParameter( request, "MAC_ADDR" ),  request .getRemoteAddr(), request.getSession().getId() );// hxx
     
    
    }catch( Exception e ){
      log.error("登陆失败", e );
      throw e;
    }
  }


  public List getUserMenuNodeList( String pStaffCode, String pFuncType,long domain) throws Exception{
    try{
      ISysLogin sysLogin = (ISysLogin) ServiceFactory.getService( Constants.SERVICE_SYS_LOGIN, ISysLogin.class );
      return sysLogin.getUserMenuNodeList( pStaffCode, pFuncType );
    }catch( Exception e ){
      log.error( "获取用户菜单失败:操作员工号:"+pStaffCode + " 类型："+pFuncType, e );
      throw e;
    }
  }

  public void loginOut( UserInfoInterface pUser ) throws LoginException{
    super.loginOut( pUser );
    try{
      ISysLogin sysLogin = (ISysLogin) ServiceFactory.getService( Constants.SERVICE_SYS_LOGIN, ISysLogin.class );
      sysLogin.loginOut( pUser );
    }catch( Exception e ){
      log.error( "用户注销失败" ,e );
      
    }
  }

  public void loginOut( String sessionId ) throws LoginException{
	    try{
	     super.loginOut( sessionId );  
	     ISysLoginLog sysLoginLog = (ISysLoginLog) ServiceFactory.getService( Constants.SERVICE_SYS_LOGIN_LOG, ISysLoginLog.class );
	     ISysLoginLogValue[] loginLogValue = sysLoginLog.getSysLoginLogByLogSessionId( sessionId );
	     if ((null != loginLogValue) && (loginLogValue.length > 0))
	     {
	       for( int i = 0; i < loginLogValue.length; i++ ){
	              loginLogValue[i].setLogoutDate( new Timestamp( System.currentTimeMillis() ) );
	              loginLogValue[i].setState( 0 );
	       }
	          sysLoginLog.saveSysLoginLog( loginLogValue );
	     }
	      
	      }catch( Exception e ){
	      log.error("用户系统超时自动注销失败",e );
	    }
	  }


  public UserInfoInterface getBlankUserInfo(){
    
    return new UserInfo();
  }

  

}

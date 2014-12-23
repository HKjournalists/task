package com.lb.app.Executor;

import org.quartz.JobExecutionContext;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public class SSHExecutor implements Executor {

	//ssh服务器的ip地址
    private String ip;
    //ssh服务器的登入端口
    private int port;
    //ssh服务器的登入用户名
    private String user;
    //ssh服务器的登入密码
    private String password;
	
    private Session session;
    
	public void execute(JobExecutionContext context) {
		this.ip = context.getMergedJobDataMap().getString("ip");
		this.port = context.getMergedJobDataMap().getInt("port");
		this.user = context.getMergedJobDataMap().getString("user");
		this.password = context.getMergedJobDataMap().getString("password");
		
		
		
		JSch jsch = new JSch();
        try {
			session = jsch.getSession(user, ip, port);
			session.setPassword(password);
			
			 
			 
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       
		
	}

}

package com.lb.app.Executor;

import org.quartz.JobExecutionContext;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public class SSHExecutor implements Executor {

	//ssh��������ip��ַ
    private String ip;
    //ssh�������ĵ���˿�
    private int port;
    //ssh�������ĵ����û���
    private String user;
    //ssh�������ĵ�������
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

package com.asiainfo.aiga.userCase.caseTrans;

import java.io.IOException;

public class CaseHttpListener {

	private CaseHttpTrans caseHttpTrans;
	
	public void setCaseHttpTrans(CaseHttpTrans caseHttpTrans) {
		this.caseHttpTrans = caseHttpTrans;
	}

	public void initMethod(){
		try {
			caseHttpTrans.startService();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("启动用例服务失败");
			e.printStackTrace();
		}
	}
	
	public void destoryMethod(){
		try {
			caseHttpTrans.stopService();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("停止用例服务失败");
			e.printStackTrace();
		}
	}
}


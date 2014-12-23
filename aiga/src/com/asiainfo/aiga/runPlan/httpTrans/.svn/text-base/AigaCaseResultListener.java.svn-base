package com.asiainfo.aiga.runPlan.httpTrans;

public class AigaCaseResultListener {

	private CaseResultHttp caseResultHttp;
	
	public void setCaseResultHttp(CaseResultHttp caseResultHttp) {
		this.caseResultHttp = caseResultHttp;
	}

	public void destoryMethod() {
		// TODO Auto-generated method stub
		try {
			caseResultHttp.stopService();
		}catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("停止用例结果服务错误");
			e.printStackTrace();
		}
	}

	public void initMethod() {
		// TODO Auto-generated method stub
		try {
			caseResultHttp.startService();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("启动用力结果服务失败");
			e.printStackTrace();
		}
	}
}

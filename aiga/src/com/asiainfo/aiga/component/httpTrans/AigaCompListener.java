package com.asiainfo.aiga.component.httpTrans;

public class AigaCompListener{

	private AigaComponentHttp aigaComponentHttp;
	
	public void setAigaComponentHttp(AigaComponentHttp aigaComponentHttp) {
		this.aigaComponentHttp = aigaComponentHttp;
	}

	public void destoryMethod() {
		// TODO Auto-generated method stub
		try {
			aigaComponentHttp.stopService();
		}catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("ֹͣ����������");
			e.printStackTrace();
		}
	}

	public void initMethod() {
		// TODO Auto-generated method stub
		try {
			aigaComponentHttp.startService();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("�����������ʧ��");
			e.printStackTrace();
		}
	}

	
}

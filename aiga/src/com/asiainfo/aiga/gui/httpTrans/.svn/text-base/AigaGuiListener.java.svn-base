package com.asiainfo.aiga.gui.httpTrans;

public class AigaGuiListener{

	private AigaGuiHttp aigaGuiHttp;
	
	public void setAigaGuiHttp(AigaGuiHttp aigaGuiHttp) {
		this.aigaGuiHttp = aigaGuiHttp;
	}

	public void destoryMethod() {
		// TODO Auto-generated method stub
		try {
			aigaGuiHttp.stopService();
		}catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("停止控件服务错误");
			e.printStackTrace();
		}
	}

	public void initMethod() {
		// TODO Auto-generated method stub
		try {
			aigaGuiHttp.startService();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("启动控件服务失败");
			e.printStackTrace();
		}
	}

	
}

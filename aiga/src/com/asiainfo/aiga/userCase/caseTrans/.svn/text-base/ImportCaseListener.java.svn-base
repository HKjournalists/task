package com.asiainfo.aiga.userCase.caseTrans;

import java.io.IOException;

public class ImportCaseListener {
	
	private ImportCaseTrans importCaseTrans;
	
	public void setImportCaseTrans(ImportCaseTrans importCaseTrans) {
		this.importCaseTrans = importCaseTrans;
	}

	public void initMethod(){
		try {
			importCaseTrans.startService();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("启动用例导入服务失败");
			e.printStackTrace();
		}
	}
	
	public void destoryMethod(){
		try {
			importCaseTrans.stopService();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("停止用例导入服务失败");
			e.printStackTrace();
		}
	}
}

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
			System.out.println("���������������ʧ��");
			e.printStackTrace();
		}
	}
	
	public void destoryMethod(){
		try {
			importCaseTrans.stopService();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("ֹͣ�����������ʧ��");
			e.printStackTrace();
		}
	}
}

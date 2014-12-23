package com.asiainfo.aiga.component.service;

import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.component.bo.AigaComponent;
import com.asiainfo.aiga.component.bo.extend.AigaInstComponent;

public interface IAigaComponentSV {

	public void saveAigaComponent(AigaComponent aValue)throws Exception;
	
	public void deleteAigaComponent(AigaComponent aValue)throws Exception;
	public AigaComponent[] getAigaComponentByParentId(Integer parentId,Class clazz)throws Exception;
	
	public void saveTransCompJson(String json)throws Exception;
	public AigaComponent[] getAigaComponentBySql(String querySql)throws Exception;
	public void saveCompFolder(String folderName,String compId)throws Exception;
	public void editCompFolder(String folderName,String compId)throws Exception;
	public void deleteCompFolder(String folderName,String compId)throws Exception;
	
	public AigaInstComponent[] getUnApprovalComp(String staff)throws Exception;
	
	public void saveApprovalComp(AigaInstComponent aigaComponent)throws Exception;
	
	public void saveBatchApprovalComp(String compIds,AigaUser currentUser)throws Exception;
}

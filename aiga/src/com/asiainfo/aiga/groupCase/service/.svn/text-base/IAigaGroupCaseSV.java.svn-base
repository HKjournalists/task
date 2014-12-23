package com.asiainfo.aiga.groupCase.service;

import java.util.List;
import java.util.Set;

import org.apache.commons.fileupload.FileItem;

import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.groupCase.bo.AigaGroupCase;

public interface IAigaGroupCaseSV {

	public AigaGroupCase[] getGroupCase(Integer caseId)throws Exception;
	
	public void saveGroupCase(AigaGroupCase aValue, AigaUser user)throws Exception;

	public void saveGroupCaseByChange(AigaGroupCase aValue,String contentsType, String subTaskTag, AigaUser user)throws Exception;
	
	public AigaGroupCase[] getGroupCaseByParentId(Integer parentId)throws Exception;
	
	public AigaGroupCase[] getGroupCaseListByChangeId(String changeId)throws Exception;
	
	public AigaGroupCase[] getGroupCaseListBySubTaskTag(String subTaskTag)throws Exception;

	public AigaGroupCase[] getGroupCaseListBySubTaskId(String subTaskId)throws Exception;
	//public AigaGroupCase[] getGroupCaseTreeBySubType(String subType)throws Exception;

	public AigaGroupCase[] getGroupCaseTreeByTaskTag(String taskTag)throws Exception;
	
	//public AigaGroupCase[] getGroupCaseByChildrenId(Integer childrenId)throws Exception;
	
	public AigaGroupCase[] getGroupCaseTreeByChildrenNodeIdList(Set<Integer> childrenNodeIdList)throws Exception;
	
	public void saveGroupCaseForExcel(List<FileItem> fileItems, String subTaskId, String subType, AigaUser user)throws Exception;
}

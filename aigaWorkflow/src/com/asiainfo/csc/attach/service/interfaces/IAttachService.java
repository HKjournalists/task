package com.asiainfo.csc.attach.service.interfaces;

import java.util.HashMap;
import java.util.Map;

import com.asiainfo.csc.attach.bo.BODocTemplateBean;
import com.asiainfo.csc.attach.dao.FTPAgent;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeValue;
import com.asiainfo.csc.attach.ivalues.IBOAttachValue;
import com.asiainfo.csc.attach.ivalues.IBODocTempTreeValue;
import com.asiainfo.csc.attach.ivalues.IBODocTemplateValue;
import com.asiainfo.csc.attach.ivalues.IBOPackageValue;
import com.asiainfo.csc.attach.ivalues.IBOQueryAttPackValue;



public interface IAttachService {

	public IBOAttachValue newAttach(IBOAttachValue valueAttach) throws Exception;
	
	public IBOPackageValue[] getAttPackage(String condition, Map params) throws Exception;

	public void saveAttach(IBOAttachValue valueAttach) throws Exception;
	
	public IBOAttachValue[] queryAllAttach() throws Exception;
	
	public void saveNewPackage(IBOPackageValue[] valuePackages) throws Exception;
	//dxp-保存 文档模板表 信息 
	public void saveDocTemp(BODocTemplateBean[] valueDocTemps) throws Exception;
	//dxp-先查找，找到后删除。 再保存。
	public void saveDocTempTree(String tempNO,String tempName, String parentNO,String parentName) throws Exception;
	
	//dxp-再保存  doc-temp-tree 目录新建结构。 
	public void saveTempTreeData(String sonTreeNO,String sonTreeName, String parentTreeNO,String parentTreeName) throws Exception;
	
	public IBOQueryAttPackValue[] queryQueryAttPack(String objNo, String type) throws Exception;
	
	public IBOQueryAttPackValue[] queryQueryAttPackByCon(String condition, HashMap Map) throws Exception;
	
	public void delPackage(IBOPackageValue[] valuePackages) throws Exception;
	
	public IBOQueryAttPackValue[] queryQueryAttPackByIds(String ids) throws Exception;
	
	public IBOAttachValue[] queryBOAttachByIds(String ids) throws Exception;
	
	public int queryAttachCount(String attName, String submitter_tag, String startdate, String enddate) throws Exception;
	
	public IBOAttachValue[] queryAttach(String attName, String submitter_tag, String startdate, String enddate, int startIndex, int endIndex) throws Exception;
	
	public IBOAttachValue[] queryAttach(String attName, String submitter_tag, String startdate, String enddate) throws Exception;
	
	public IBOAttachValue[] queryAttachByName(String attName,String submitterTag) throws Exception;

	//dxp-版本模板树的 查找。 根据父亲NO
	public IBODocTempTreeValue[] queryDocTempTree(String parentNO) throws Exception;
	
	//dxp-版本模板树的 删除。 根据 nodeNO
	public void delDocTempTree(String nodeNO) throws Exception;
	
	//dxp-根据 文档模板  模板版本编号  TEMP_VERSION_NO 查出 相应的模板
	public IBODocTemplateValue queryDocTemp(String tempVerNO) throws Exception;
	
	//dxp-根据模板中的角色信息， 查出是否包含相应的 staffId 
	//public boolean hasRightByRole(String staffId,String roles) throws Exception;
	
	//dxp- 删除该文档模板  tree FTP文件
	public void delTempAndFileAndTree(BODocTemplateBean docTemp,FTPAgent ftpagent) throws Exception;
	
	public IBOAttachTypeValue[] getAttType()throws Exception;
	
	public IBOQueryAttPackValue[] queryPackageByAttId(String attId)throws Exception;
	
	public IBOAttachValue[] queryAttachById(String attachId)throws Exception;
	
	public String getAttachTypePars(String attTypeIds) throws Exception;
	
	public IBOQueryAttPackValue[] queryQueryAttPackNew(String objNo, String type) throws Exception;
	
	public Map<String,String> checkHasFile(String objNo,String type,String submitTag,String attName)throws Exception;
 }

package com.asiainfo.csc.attach.service.impl;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.attach.bo.BOAttachBean;
import com.asiainfo.csc.attach.bo.BODocTempTreeBean;
import com.asiainfo.csc.attach.bo.BODocTempTreeEngine;
import com.asiainfo.csc.attach.bo.BODocTemplateBean;
import com.asiainfo.csc.attach.bo.BOQueryAttPackBean;
import com.asiainfo.csc.attach.dao.FTPAgent;
import com.asiainfo.csc.attach.dao.interfaces.IAttachDao;
import com.asiainfo.csc.attach.dao.interfaces.IAttachTypeDefDao;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeDefValue;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeValue;
import com.asiainfo.csc.attach.ivalues.IBOAttachValue;
import com.asiainfo.csc.attach.ivalues.IBODocTempTreeValue;
import com.asiainfo.csc.attach.ivalues.IBODocTemplateValue;
import com.asiainfo.csc.attach.ivalues.IBOPackageValue;
import com.asiainfo.csc.attach.ivalues.IBOQueryAttPackValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachService;

public class AttachServiceImpl implements IAttachService {

	IAttachDao iAttachDao = (IAttachDao) ServiceFactory
			.getService(IAttachDao.class);

	public IBOAttachValue newAttach(IBOAttachValue valueAttach)
			throws Exception {
		return iAttachDao.newAttach(valueAttach);
	}

	public IBOPackageValue[] getAttPackage(String condition, Map params)
			throws Exception {
		IBOPackageValue[] retVals = iAttachDao.getAttPackage(condition, params);
		return retVals;
	}

	public void saveAttach(IBOAttachValue valueAttach) throws Exception {
		iAttachDao.saveAttach(valueAttach);
	}

	public IBOAttachValue[] queryAllAttach() throws Exception {
		return iAttachDao.queryAllAttach();
	}

	public void saveNewPackage(IBOPackageValue[] valuesPackage)
			throws Exception {
		iAttachDao.saveNewPackage(valuesPackage);
	}

	public void saveDocTemp(BODocTemplateBean[] valueDocTemps) throws Exception {
		iAttachDao.saveDocTemp(valueDocTemps);
	}

	public void saveDocTempTree(String tempNO, String tempName,
			String parentNO, String parentName) throws Exception {
		// 先根据tempNO查找
		Criteria criteria = new Criteria();
		criteria.addEqual(IBODocTempTreeValue.S_NodeNo, tempNO);
		criteria.addEqual(IBODocTempTreeValue.S_IsDocTemp, "1");
		BODocTempTreeBean[] tempTrees = iAttachDao.queryDocTempTree(criteria);
		// 删除这个树 记录
		if (tempTrees.length > 0) {
			for (int i = 0; i < tempTrees.length; i++) {
				tempTrees[i].delete();
				iAttachDao
						.saveDocTempTree(new BODocTempTreeBean[] { tempTrees[i] });
			}
		}
		// 重新保存一条记录
		BODocTempTreeBean docTempValue = new BODocTempTreeBean();
		docTempValue.setDocTempTreeId(BODocTempTreeEngine.getNewId()
				.longValue());
		docTempValue.setNodeNo(tempNO);
		docTempValue.setNodeName(tempName);
		docTempValue.setParentNodeNo(parentNO);
		docTempValue.setParentNodeName(parentName);
		docTempValue.setIsDocTemp(1);
		iAttachDao.saveDocTempTree(new BODocTempTreeBean[] { docTempValue });
	}

	public void saveTempTreeData(String sonTreeNO, String sonTreeName,
			String parentTreeNO, String parentTreeName) throws Exception {
		BODocTempTreeBean docTempValue = new BODocTempTreeBean();
		docTempValue.setDocTempTreeId(BODocTempTreeEngine.getNewId()
				.longValue());
		docTempValue.setNodeNo(sonTreeNO);
		docTempValue.setNodeName(sonTreeName);
		docTempValue.setParentNodeNo(parentTreeNO);
		docTempValue.setParentNodeName(parentTreeName);
		docTempValue.setIsDocTemp(0);
		iAttachDao.saveDocTempTree(new BODocTempTreeBean[] { docTempValue });
	}

	public IBOQueryAttPackValue[] queryQueryAttPack(String objNo, String type)
			throws Exception {

		StringBuffer condition = new StringBuffer();

		condition.append("obj_no='" + objNo + "'");

		IBOQueryAttPackValue[] values = iAttachDao.queryQueryAttPack(condition
				.toString());

		return values;
	}

	public void delPackage(IBOPackageValue[] valuePackages) throws Exception {
		iAttachDao.delPackage(valuePackages);
	}

	public IBOQueryAttPackValue[] queryPackageByAttId(String attId)
			throws Exception {
		String condition = "att_id =" + attId;
		return iAttachDao.queryQueryAttPack(condition);
	}

	public IBOQueryAttPackValue[] queryQueryAttPackByIds(String ids)
			throws Exception {
		String condition = "att_pack_id in (" + ids + ")";
		return iAttachDao.queryQueryAttPack(condition);
	}

	public IBOAttachValue[] queryAttach(String attName, String submitter_tag,
			String startdate, String enddate, int startIndex, int endIndex)
			throws Exception {
		Criteria criteria = new Criteria();
		if (StringUtils.isNotBlank(attName)) {
			criteria.addLIKE(IBOAttachValue.S_AttName, "%" + attName + "%");
		}
		if (StringUtils.isNotBlank(submitter_tag)) {
			criteria.addEqual(IBOAttachValue.S_SubmitterTag, submitter_tag);
		}
		if (StringUtils.isNotBlank(startdate)) {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date beginDate = formatter.parse(startdate);
			criteria.addGREATERThan(IBOAttachValue.S_SubmitTime, new Timestamp(
					beginDate.getTime()));
		}
		if (StringUtils.isNotBlank(enddate)) {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date endDate = formatter.parse(enddate);
			criteria.addLESSThan(IBOAttachValue.S_SubmitTime, new Timestamp(
					endDate.getTime()));
		}
		return iAttachDao.queryAttach(criteria, startIndex, endIndex);
	}

	public IBOAttachValue[] queryAttachByName(String attName,
			String submitterTag) throws Exception {
		Criteria criteria = new Criteria();
		if (StringUtils.isNotBlank(attName)) {
			criteria.addEqual(IBOAttachValue.S_AttName, attName);
			criteria.addEqual(IBOAttachValue.S_SubmitterTag, submitterTag);
			criteria.addDescendingOrderByColumn(IBOAttachValue.S_SubmitTime);
		}
		return iAttachDao.queryAttach(criteria);
	}

	public IBOAttachValue[] queryAttach(String attName, String submitter_tag,
			String startdate, String enddate) throws Exception {
		Criteria criteria = new Criteria();
		if (StringUtils.isNotBlank(attName)) {
			criteria.addLIKE(IBOAttachValue.S_AttName, "%" + attName + "%");
		}
		if (StringUtils.isNotBlank(submitter_tag)) {
			criteria.addEqual(IBOAttachValue.S_SubmitterTag, submitter_tag);
		}
		if (StringUtils.isNotBlank(startdate)) {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date beginDate = formatter.parse(startdate);
			criteria.addGREATERThan(IBOAttachValue.S_SubmitTime, new Timestamp(
					beginDate.getTime()));
		}
		if (StringUtils.isNotBlank(enddate)) {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date endDate = formatter.parse(enddate);
			criteria.addLESSThan(IBOAttachValue.S_SubmitTime, new Timestamp(
					endDate.getTime()));
		}
		return iAttachDao.queryAttach(criteria);
	}

	public IBODocTempTreeValue[] queryDocTempTree(String parentNO)
			throws Exception {
		Criteria criteria = new Criteria();
		if (StringUtils.isNotBlank(parentNO)) {
			criteria.addEqual(IBODocTempTreeValue.S_ParentNodeNo, parentNO);
			criteria
					.addAscendingOrderByColumn(IBODocTempTreeValue.S_DocTempTreeId);
		}

		return iAttachDao.queryDocTempTree(criteria);
	}

	public void delDocTempTree(String nodeNO) throws Exception {
		Criteria criteria = new Criteria();
		if (StringUtils.isNotBlank(nodeNO)) {
			criteria.addEqual(IBODocTempTreeValue.S_NodeNo, nodeNO);
			criteria.addEqual(IBODocTempTreeValue.S_IsDocTemp, 0);
			criteria
					.addAscendingOrderByColumn(IBODocTempTreeValue.S_DocTempTreeId);
		}

		BODocTempTreeBean tempTree = iAttachDao.queryDocTempTree(criteria)[0];

		// 删除这个树 记录
		tempTree.delete();
		iAttachDao.saveDocTempTree(new BODocTempTreeBean[] { tempTree });
	}

	public IBODocTemplateValue queryDocTemp(String tempVerNO) throws Exception {
		Criteria criteria = new Criteria();
		if (StringUtils.isNotBlank(tempVerNO)) {
			criteria.addEqual(IBODocTemplateValue.S_TempVersionNo, tempVerNO);
		}
		IBODocTemplateValue[] docTemp = iAttachDao.queryDocTemp(criteria);
		if (docTemp.length == 0) {
			return null;
		}
		return docTemp[0];
	}

	/*
	 * public boolean hasRightByRole(String staffId,String roles) throws
	 * Exception{ IBOStaffRoleAuthorValue[] staffRoleAuthors =
	 * this.queryStaffRoleAuthorByRoles(roles); for (int i = 0; i <
	 * staffRoleAuthors.length; i++) {
	 * if(staffId.equals(String.valueOf(staffRoleAuthors[i].getStaffId()))){
	 * return true; } } return false; }
	 * 
	 * public IBOStaffRoleAuthorValue[] queryStaffRoleAuthorByRoles(String
	 * roles) throws Exception{ String condition = "role_id in ("+roles+")";
	 * return
	 * AttachDaoFactory.getFactory().getInstance().queryStaffRoleAuthorByRoles(condition,
	 * null); }
	 */

	public void delTempAndFileAndTree(BODocTemplateBean docTemp,
			FTPAgent ftpagent) throws Exception {
		// FTPAgent 暂时删除不去 维护 ftp 上的目录及其文件信息
		String ftpFileName = docTemp.getTempPath() + "/"
				+ docTemp.getTempFtpName();
		ftpagent.deleteFile(ftpFileName);
		ftpagent.closeServer();

		String nodeNO = docTemp.getTempVersionNo();

		// 删除 模板树的信息
		Criteria criteria = new Criteria();
		if (StringUtils.isNotBlank(nodeNO)) {
			criteria.addEqual(IBODocTempTreeValue.S_NodeNo, nodeNO);
			criteria.addEqual(IBODocTempTreeValue.S_IsDocTemp, 1);
			criteria
					.addAscendingOrderByColumn(IBODocTempTreeValue.S_DocTempTreeId);
		}
		BODocTempTreeBean tempTree = iAttachDao.queryDocTempTree(criteria)[0];
		// 删除这个树 记录
		tempTree.delete();
		iAttachDao.saveDocTempTree(new BODocTempTreeBean[] { tempTree });

		// 删除 文档模板信息
		docTemp.delete();
		iAttachDao.saveDocTemp(new BODocTemplateBean[] { docTemp });
	}

	public int queryAttachCount(String attName, String submitter_tag,
			String startdate, String enddate) throws Exception {
		Criteria criteria = new Criteria();
		if (StringUtils.isNotBlank(attName)) {
			criteria.addLIKE(IBOAttachValue.S_AttName, "%" + attName + "%");
		}
		if (StringUtils.isNotBlank(submitter_tag)) {
			criteria.addEqual(IBOAttachValue.S_SubmitterTag, submitter_tag);
		}
		if (StringUtils.isNotBlank(startdate)) {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date beginDate = formatter.parse(startdate);
			criteria.addGREATERThan(IBOAttachValue.S_SubmitTime, new Timestamp(
					beginDate.getTime()));
		}
		if (StringUtils.isNotBlank(enddate)) {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date endDate = formatter.parse(enddate);
			criteria.addLESSThan(IBOAttachValue.S_SubmitTime, new Timestamp(
					endDate.getTime()));
		}
		return iAttachDao.queryAttachCount(criteria);
	}

	public IBOAttachValue[] queryBOAttachByIds(String ids) throws Exception {
		String condition = "att_id in (" + ids + ") order by att_id desc";
		return iAttachDao.queryBOAttach(condition);
	}

	public IBOAttachTypeValue[] getAttType() throws Exception {
		// TODO Auto-generated method stub
		return iAttachDao.getAttachType();
	}

	// public WorkflowInfo getWorkflowInfo(String objectTypeId, String objectId)
	// throws Exception{
	//	
	// long[] workflowIDs =
	// ComframeClient.getDefaultComframeClient().getWorkflowsByWorkflowObjectId(objectTypeId,
	// objectId);
	//		
	// return
	// ComframeClient.getDefaultComframeClient().getWorkflowInfo(workflowIDs[0]);
	// }

	// public TaskInfo getTaskInfo(String objectTypeId, String objectId, String
	// taskTag) throws Exception{
	//		
	// TaskInfo[] taskInfos =
	// ComframeClient.getDefaultComframeClient().getTaskInfosByWorkflowObjectId(objectTypeId,
	// objectId);
	// if(taskInfos == null || taskInfos.length == 0 || taskInfos[0] == null ||
	// taskTag == null){
	// return null;
	// }
	// for(int i = 0; i < taskInfos.length; i++){
	// if(taskTag.equals(taskInfos[i].getTaskTag())){
	// return taskInfos[i];
	// }
	// }
	// return null;
	// }
	public IBOAttachValue[] queryAttachById(String attachId) throws Exception {
		Criteria sql = new Criteria();
		sql.addEqual(BOAttachBean.S_AttId, attachId);
		return iAttachDao.queryAttach(sql);
	}

	public IBOQueryAttPackValue[] queryQueryAttPackByCon(String condition,
			HashMap Map) throws Exception {
		return iAttachDao.queryQueryAttPack(condition, Map);
	}

	
	public String getAttachTypePars(String attTypeIds) throws Exception {
		if (attTypeIds != null && !attTypeIds.trim().equals("")) {
			String condition = "ATT_TYPE_ID in(" + attTypeIds + ")";
			String typeNames = "";
			IAttachTypeDefDao defDao = (IAttachTypeDefDao) ServiceFactory
					.getService(IAttachTypeDefDao.class);
			IBOAttachTypeDefValue[] attTypes = defDao.getAttachTypeDef(
					condition, null);
			for (IBOAttachTypeDefValue attType : attTypes) {
				typeNames += attType.getAttTypeName() + ",";
			}
			if(typeNames.equals(""))
				return "";
			else
				return typeNames.substring(0, typeNames.length() - 1);
		}
		return "";
	}

	
	public IBOQueryAttPackValue[] queryQueryAttPackNew(String objNo, String type)
			throws Exception {
		// TODO Auto-generated method stub
		StringBuffer condition = new StringBuffer();

		condition.append("obj_no='" + objNo + "'");

		IBOQueryAttPackValue[] values = iAttachDao.queryQueryAttPack(condition
				.toString());

		for (IBOQueryAttPackValue value : values) {
			String attName = this.getAttachTypePars(value.getAttType());
			value.setAttTypeName(attName);
		}
		return values;
	}

	
	public Map<String, String> checkHasFile(String objNo, String type,
			String submitTag, String attName) throws Exception {
		// TODO Auto-generated method stub
		Map<String,String> rtv = new HashMap<String, String>();
		if (StringUtils.isNotBlank(objNo) && StringUtils.isNotBlank(type)
				&& StringUtils.isNotBlank(submitTag)
				&& StringUtils.isNotBlank(attName)) {
			
			Criteria sql = new Criteria();
			sql.addEqual(BOQueryAttPackBean.S_ObjNo, objNo);
			sql.addEqual(BOQueryAttPackBean.S_ObjType, type);
			sql.addEqual(BOQueryAttPackBean.S_SubmitterTag, submitTag);
			sql.addEqual(BOQueryAttPackBean.S_AttName, attName);
			
			IBOQueryAttPackValue[] attPackValues = iAttachDao.queryQueryAttPack(sql.toString(), sql.getParameters());
			if(attPackValues.length>1)
				throw new Exception("检测到附件"+attName+"重复");
			if(attPackValues.length==1){
				rtv.put("isRepeat", "Y");
			}else if(attPackValues.length==0){
				rtv.put("isRepeat", "N");
			}
		}else{
			throw new Exception("缺少参数");
		}
		return rtv;
	}
}

package com.asiainfo.csc.common.service.impl;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.SessionManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.ITreeNodeInfo;
import com.ai.appframe2.util.SortTreeNode;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.bo.BOTreeReqFunctionPointsBean;
import com.asiainfo.csc.common.bo.BOWorkorderListBean;
import com.asiainfo.csc.common.dao.interfaces.IWorkorderDao;
import com.asiainfo.csc.common.define.OperateParam;
import com.asiainfo.csc.common.ivalues.IBOWorkorderListValue;
import com.asiainfo.csc.common.ivalues.IBOWorkorderValue;
import com.asiainfo.csc.common.service.interfaces.IWorkorderSV;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public class WorkorderSVImpl implements IWorkorderSV {

	private OperateParam op = new OperateParam();

	private IWorkorderDao iwd = (IWorkorderDao) ServiceFactory
			.getService(IWorkorderDao.class);

	public IBOWorkorderListValue[] queryWorkorderList(long staffId,
			String status, int start, int end,String property,String direction) throws Exception {
		try {
			Criteria sql = new Criteria();
			String[] statuStrings = status.split(",");
			int[] statusInt = new int[statuStrings.length]; 
			
			for(int i =0;i<statuStrings.length;i++)
			{
				statusInt[i] = Integer.valueOf(statuStrings[i]);
			}
			sql.addIn(BOWorkorderListBean.S_Status, statusInt);
			sql.addEqual(BOWorkorderListBean.S_ExecStaffId, staffId);
			String condition = null;
			if(property!=null){
				char[] proChars =property.toCharArray();
				StringBuffer propertyBuffer = new StringBuffer();
				for(char ch : proChars){
					if(Character.isUpperCase(ch)){
						propertyBuffer.append("_"+Character.toLowerCase(ch));
					}else{
						propertyBuffer.append(ch);
					}
				}
				condition = " order by "+propertyBuffer.toString()+" "+direction+" ";
			}else{
				condition = " order by create_time desc";
			}
			IBOWorkorderListValue[] listValues = iwd.queryWorkorderList(sql.toString()+condition, sql.getParameters(),start,end);
			return listValues;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("查询工单列表方法中出错，错误在SV层，queryWorkorderList函数");
		}
	}

	public int countWorkorderList(String staffId, String status) throws Exception {
		try {
			Criteria sql = new Criteria();
			String[] statuStrings = status.split(",");
			int[] statusInt = new int[statuStrings.length]; 
			
			for(int i =0;i<statuStrings.length;i++)
			{
				statusInt[i] = Integer.valueOf(statuStrings[i]);
			}
			sql.addIn(BOWorkorderListBean.S_Status, statusInt);
			sql.addEqual(BOWorkorderListBean.S_ExecStaffId, staffId);
			return iwd.countWorkorderList(sql.toString(), sql.getParameters());
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("计数工单列表方法中出错，错误在SV层，countWorkorderList函数");
		}
	}

	public IBOWorkorderListValue[] queryHisWorkorderList(String objId,
			String objType, int start, int end) throws Exception {
		try {
			Criteria sql = new Criteria();
			sql.addEqual(IBOWorkorderValue.S_ObjId, Long.parseLong(objId));
			sql.addEqual(IBOWorkorderValue.S_ObjType, objType);
			sql.addDescendingOrderByColumn(IBOWorkorderValue.S_OrderId);
			return iwd.queryWorkorderList(sql.toString(), sql.getParameters(),
					start, end);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("查询工单列表方法中出错，错误在SV层，queryWorkorder函数");
		}
	}

	public IBOWorkorderValue[] queryWorkorder(Criteria sql) throws Exception {
		try {
			return iwd.getWorkorders(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("查询工单方法中出错，错误在SV层，queryWorkorder函数");
		}
	}

	public int countHisWorkorderList(String objId, String objType)
			throws Exception {
		try {
			Criteria sql = new Criteria();
			sql.addEqual(IBOWorkorderValue.S_ObjId, Long.parseLong(objId));
			sql.addEqual(IBOWorkorderValue.S_ObjType, objType);
			return iwd.countWorkorderList(sql.toString(), sql.getParameters());
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("计数工单列表方法中出错，错误在SV层，countWorkorder函数");
		}
	}

	public IBOWorkorderListValue getWorkOrderListByOrderId(Long orderId)
			throws Exception {
		try {
			Criteria sql = new Criteria();
			sql.addEqual(IBOWorkorderListValue.S_OrderId, orderId);
			return iwd.queryWorkorderListById(sql.toString(), sql
					.getParameters())[0];
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(
					"计数工单列表方法中出错，错误在SV层，getWorkOrderListByOrderId函数");
		}
	}
	
	public IBOWorkorderListValue[] getWorkOrderListByCon(String condition, Map params,int start,int end) throws Exception {
		return iwd.queryWorkorderList(condition, params, start, end);
	}
	
	public void saveWorkorder(IBOWorkorderValue value) throws Exception {
		iwd.saveWorkorder(value);
	}

	
	public int countDoWorkorderList(long staffId, String status)
			throws Exception {
		int count = 0;
		String condition = "(exec_staff_id="
				+ staffId
				+ " or (exec_staff_no in (select sr.code from sys_role sr where sr.role_id in "
				+ "(select ssra.role_id from sys_staff_role_author ssra where ssra.staff_id = "
				+ staffId
				+ ")) "
				+ " and group_name in (select sug.group_name from sys_user_group_relate sugr,sys_user_group sug where sugr.group_id=sug.group_id and sugr.staff_id="
				+ staffId
				+ ")))"
				+ "and (status='1' or status='2' or status='6') and order_type!='3' order by create_time DESC";
		count = iwd.countWorkorderList(condition, null);
		return count;
	}

	
	public IBOWorkorderListValue[] queryDoWorkorderList(long staffId,
			String status, int start, int end) throws Exception {
		IBOWorkorderListValue[] wlValue = null;
		String condition = "(exec_staff_id="
				+ staffId
				+ " or (exec_staff_no in (select sr.code from sys_role sr where sr.role_id in "
				+ "(select ssra.role_id from sys_staff_role_author ssra where ssra.staff_id = "
				+ staffId
				+ ")) "
				+ " and group_name in (select sug.group_name from sys_user_group_relate sugr,sys_user_group sug where sugr.group_id=sug.group_id and sugr.staff_id="
				+ staffId
				+ ")))"
				+ "and (status='1' or status='2' or status='4') and order_type!='1' and not(link_no_type='sign' and parent_vm_task_id is null) order by create_time DESC";
		wlValue = iwd.queryWorkorderList(condition, null, start, end);
		return wlValue;
	}

	
	public IBOWorkorderListValue[] queryWaitDiscussOrder(int start, int end)
			throws Exception {
		IBOWorkorderListValue[] wlValue = null;
		String condition = "status='4' and status_step in(3,4) and order_type='2' and not(link_no_type='sign' and parent_vm_task_id is null) order by create_time DESC";
		wlValue = iwd.queryWorkorderList(condition, null, start, end);
		return wlValue;
	}

	
	public int countWaitDiscussOrder() throws Exception {
		int count = 0;
		String condition = "status='4' and status_step in(3,4) and order_type='2' and not(link_no_type='sign' and parent_vm_task_id is null) order by create_time DESC";
		count = iwd.countWorkorderList(condition, null);
		return count;
	}

	@SuppressWarnings("finally")
	public IBOWorkorderListValue[] getDiscussRelaOrder() throws Exception {
		IBOWorkorderListValue[] retVals = null;
		try {
			String condition = "";
			retVals = iwd.queryWorkorderList(null, null, -1, -1);
			for (int i = 0; i < retVals.length; i++) {
				retVals[i].setExecStaffId(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("查询工单方法中出错，错误在SV层，queryWorkorder函数");
		} finally {
			return retVals;
		}
	}

	public IBOWorkorderValue[] getWorkorder(String condition, Map params)
			throws Exception {
		return iwd.getWorkorder(condition, params);
	}

	
	public IBOWorkorderListValue[] queryWorkorderList(String orderType,
			String submitter, String objName, String phaseId, String linkId,
			String beginctime, String endctime, String staffId,
			int $startrowindex, int $endrowindex) throws Exception {
		Criteria criteria = getCriteria(orderType, submitter, objName, phaseId,
				linkId, beginctime, endctime);
		String condition = " and order_id in(select distinct sh.order_id from alm_workorder_list sh where sh.exec_staff_id="
				+ staffId + ")";
		if (criteria.toString().equals("")) {
			return iwd.queryWorkorderList("1=1" + condition
					+ " order by create_time DESC", criteria.getParameters(),
					$startrowindex, $endrowindex);
		} else {
			return iwd.queryWorkorderList(criteria.toString() + condition
					+ " order by create_time DESC", criteria.getParameters(),
					$startrowindex, $endrowindex);
		}
	}

	
	public int queryWorkorderListCount(String orderType, String submitter,
			String objName, String phaseId, String linkId, String beginctime,
			String endctime, String staffId) throws Exception {
		Criteria criteria = getCriteria(orderType, submitter, objName, phaseId,
				linkId, beginctime, endctime);
		String condition = " and obj_id in(select distinct sh.obj_id from alm_stakeholder sh where sh.stdholder_staff_id="
				+ staffId + ")";
		if (criteria.toString().equals("")) {
			return iwd.countWorkorderList("1=1" + condition, criteria
					.getParameters());
		} else {
			return iwd.countWorkorderList(criteria.toString() + condition,
					criteria.getParameters());
		}
	}

	public Criteria getCriteria(String objType, String staffId,
			String objName, String phaseId, String linkId, String beginctime,
			String endctime) throws Exception {
		Criteria criteria = new Criteria();
		if (StringUtils.isNotBlank(objType)) {
			criteria.addEqual(IBOWorkorderListValue.S_ObjType, objType);
		}
		if (StringUtils.isNotBlank(staffId)) {
			criteria.addEqual(IBOWorkorderListValue.S_ExecStaffId,staffId);
		}
		if (StringUtils.isNotBlank(objName)) {
			criteria.addLIKE(IBOWorkorderListValue.S_ObjName, "%" + objName
					+ "%");
		}
		if (StringUtils.isNotBlank(phaseId) && (!"-1".equals(phaseId))) {
			criteria.addEqual(IBOWorkorderListValue.S_PhaseId, phaseId);
		}
		if (StringUtils.isNotBlank(linkId) && (!"-1".equals(linkId))) {
			criteria.addEqual(IBOWorkorderListValue.S_LinkId, linkId);
		}
		if (StringUtils.isNotBlank(beginctime) && StringUtils.isBlank(endctime)) {
			try {
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Date begindate = formatter.parse(beginctime);
				criteria.addGREATEREqual(IBOAlmWorkorderValue.S_CreateTime,
						new Timestamp(begindate.getTime()));
			} catch (ParseException e) {
				throw e;
			}
		} else if (StringUtils.isNotBlank(endctime)
				&& StringUtils.isBlank(beginctime)) {
			try {
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Date enddate = formatter.parse(endctime);
				criteria.addLESSEqual(IBOAlmWorkorderValue.S_CreateTime,
						new Timestamp(enddate.getTime()));
			} catch (ParseException e) {
				throw e;
			}
		} else if (StringUtils.isNotBlank(beginctime)
				&& StringUtils.isNotBlank(endctime)) {
			try {
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Date begindate = formatter.parse(beginctime);
				Date enddate = formatter.parse(endctime);
				criteria.addGREATEREqual(IBOAlmWorkorderValue.S_CreateTime,
						new Timestamp(begindate.getTime()));
				criteria.addLESSEqual(IBOAlmWorkorderValue.S_CreateTime,
						new Timestamp(enddate.getTime()));
			} catch (ParseException e) {
				throw e;
			}
		}
		return criteria;
	}

	
	public BOTreeReqFunctionPointsBean[] queryReqFunctionPointSetTree(
			String objId, String objType, int $startrowindex, int $endrowindex)
			throws Exception {
		IBOWorkorderListValue[] workOrderLists = null;
		if(objId!=null&&!objId.equals(""))
			workOrderLists = iwd.queryReqFunctionPointSetTree(objId, objType);

		List<BOTreeReqFunctionPointsBean> resultList = new ArrayList<BOTreeReqFunctionPointsBean>();
		if (workOrderLists != null && workOrderLists.length > 0) {
			for (IBOWorkorderListValue wol : workOrderLists) {
				BOTreeReqFunctionPointsBean treeData = new BOTreeReqFunctionPointsBean();
				treeData.setOrderId(wol.getOrderId());
				treeData.setVmTaskName(wol.getVmTaskName());
				treeData.setObjName("[需求]"+wol.getObjName());
				treeData.setM_parentId(0L);
				treeData.setM_id(wol.getOrderId());
				treeData.setEmployeeName(wol.getEmployeeName());
				treeData.setStatus(wol.getStatus());
				treeData.setStatusStep(Long.valueOf(wol.getStatus()));
				treeData.setCreateTime(wol.getCreateTime());
				treeData.setFinishTime(wol.getFinishTime());
				treeData.setCond(wol.getCond());
				treeData.setOpinion(wol.getOpinion());
				treeData.setObjId(wol.getObjId());
				treeData.setLinkId(wol.getLinkId());
				resultList.add(treeData);
				
				IBOWorkorderListValue[] wlvs = iwd
						.FunctionPointSetByReqIdAndLinkId(treeData.getObjId(),
								treeData.getLinkId());

				if (wlvs != null && wlvs.length > 0) {
					for (IBOWorkorderListValue wlv : wlvs) {
						BOTreeReqFunctionPointsBean childData = new BOTreeReqFunctionPointsBean();

						childData.setOrderId(wlv.getOrderId());
						childData.setVmTaskName(wlv.getVmTaskName());
						childData.setObjName("[版本]"+wlv.getObjName());
						childData.setEmployeeName(wlv.getEmployeeName());
						childData.setStatus(wlv.getStatus());
						childData.setStatusStep(Long.valueOf(wlv.getStatus()));
						childData.setCreateTime(wlv.getCreateTime());
						childData.setFinishTime(wlv.getFinishTime());
						childData.setCond(wlv.getCond());
						childData.setOpinion(wlv.getOpinion());
						childData.setM_parentId(wol.getOrderId());
						childData.setM_id(-wlv.getOrderId());
						resultList.add(childData);
					}
				}
			}
		}
		ITreeNodeInfo[] itreeNodeInfo = resultList
				.toArray(new BOTreeReqFunctionPointsBean[resultList.size()]);
		BOTreeReqFunctionPointsBean[] rfp = (BOTreeReqFunctionPointsBean[]) SortTreeNode
				.buildTree(itreeNodeInfo).toArrayOfData(
						new BOTreeReqFunctionPointsBean[0]);

		return rfp;
	}
	
	public BOTreeReqFunctionPointsBean[] queryAlmVerTree(
			String objId, String objType, int $startrowindex, int $endrowindex)
			throws Exception {
		IBOWorkorderListValue[] workOrderLists = null;
		if(objId!=null&&!objId.equals(""))
			workOrderLists = iwd.queryAlmVerTree(objId, objType);

		List<BOTreeReqFunctionPointsBean> resultList = new ArrayList<BOTreeReqFunctionPointsBean>();
		if (workOrderLists != null && workOrderLists.length > 0) {
			for (IBOWorkorderListValue wol : workOrderLists) {
				BOTreeReqFunctionPointsBean treeData = new BOTreeReqFunctionPointsBean();
				treeData.setOrderId(wol.getOrderId());
				treeData.setVmTaskName(wol.getVmTaskName());
				treeData.setObjName("[版本]"+wol.getObjName());
				treeData.setM_parentId(0L);
				treeData.setM_id(wol.getOrderId());
				treeData.setEmployeeName(wol.getEmployeeName());
				treeData.setStatus(wol.getStatus());
				treeData.setStatusStep(Long.valueOf(wol.getStatus()));
				treeData.setCreateTime(wol.getCreateTime());
				treeData.setFinishTime(wol.getFinishTime());
				treeData.setCond(wol.getCond());
				treeData.setOpinion(wol.getOpinion());
				treeData.setObjId(wol.getObjId());
				treeData.setLinkId(wol.getLinkId());
				resultList.add(treeData);
			}
		}
		ITreeNodeInfo[] itreeNodeInfo = resultList
				.toArray(new BOTreeReqFunctionPointsBean[resultList.size()]);
		BOTreeReqFunctionPointsBean[] rfp = (BOTreeReqFunctionPointsBean[]) SortTreeNode
				.buildTree(itreeNodeInfo).toArrayOfData(
						new BOTreeReqFunctionPointsBean[0]);

		return rfp;
	}

	
	public int queryReqFunctionPointSetTreeCount(String objId, String objType) {
		return 0;
	}
	
	public IBOWorkorderListValue[] getDoWorkorderListTree(String userGroup,
			long staffId, String status, int start, int end) throws Exception {
		IBOWorkorderListValue[] workOrderLists = null;
		String groupCon = " and ((m.obj_id in(select req_id from alm_requisition_extend are where are.usergroup_id=" + userGroup + ") and m.obj_type=1) or m.obj_type!=1)";
		if(userGroup == null || "".equals(userGroup)) {
			groupCon = "";
		}
		String condition = "(exec_staff_id="
				+ staffId
				+ " or (exec_staff_no in (select sr.code from sys_role sr where sr.role_id in "
				+ "(select ssra.role_id from sys_staff_role_author ssra where ssra.staff_id = "
				+ staffId
				+ ")) "
				+ " and group_name in (select sug.group_name from sys_user_group_relate sugr,sys_user_group sug where sugr.group_id=sug.group_id and sugr.staff_id="
				+ staffId
				+ ")))"
				+ "and (status='1' or status='2' or status='4') and order_type!='1' and not(link_no_type='sign' and parent_vm_task_id is null) " +
					groupCon + " order by m.obj_type desc,create_time DESC";
		workOrderLists = iwd.queryWorkorderList(condition, null, start, end);
		
		return workOrderLists;
	}
	
	public boolean isInArray(IBOWorkorderListValue order, IBOWorkorderListValue[] orderAry) throws Exception {
		for(IBOWorkorderListValue orderAryElem: orderAry) {
			if(order.getOrderId() == orderAryElem.getOrderId()) {
				return true;
			}
		}
		return false;
	}
	
	public IBOWorkorderListValue[] queryWorkOrder(String phaseName,
			String linkNo, String type, String status, String objName,
			int startindex, int endindex) throws Exception {
		IBOWorkorderListValue[] value = null;
		long userId = SessionManager.getUser().getID();
		String staffId = String.valueOf(userId);
		boolean ismgr = false;
		Criteria criteria = new Criteria();
		String condition = " 1=1 ";
		if (StringUtils.isNotBlank(phaseName)) {
			criteria.addEqual(IBOWorkorderListValue.S_PhaseId, phaseName);
		}
		if (StringUtils.isNotBlank(linkNo)) {
			criteria.addEqual(IBOWorkorderListValue.S_LinkNo, linkNo);
		}
		if (StringUtils.isNotBlank(type)) {
			criteria.addEqual(IBOWorkorderListValue.S_ObjType, type);
		}
		if (StringUtils.isNotBlank(status)) {
			criteria.addEqual(IBOWorkorderListValue.S_Status, status);
		}
		if (StringUtils.isNotBlank(objName)) {
			criteria.addLIKE(IBOWorkorderListValue.S_ObjName, "%" + objName + "%");
		}
		if(SessionManager.getUser().getID() == 1) {
			ismgr = true;
		}
		// 不是管理人
		if (ismgr == false) {
			condition += " and order_id in ( select a.order_id from alm_workorder a where a.exec_staff_id='"
					+ staffId + "' and  a.order_type<>'3' )";
		}
		if (criteria.toString().equals("")) {

			try {
				value = iwd.queryWorkorderList(condition + " order by m.create_time desc", null,
						startindex, endindex);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			try {
				value = iwd.queryWorkorderList(condition + " and "
						+ criteria.toString() + " order by m.create_time desc", criteria.getParameters(),
						startindex, endindex);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return value;
	}
	
	public int getWorkOrderCount(String phaseName, String linkNo, String type,
			String status, String objName) throws Exception {
		long userId = SessionManager.getUser().getID();
		String staffId = String.valueOf(userId);
		Criteria criteria = new Criteria();
		String condition = "1=1";
		int count = 0;
		boolean ismgr = false;
		if (StringUtils.isNotBlank(phaseName)) {
			criteria.addEqual(IBOWorkorderListValue.S_PhaseId, phaseName);
		}
		if (StringUtils.isNotBlank(linkNo)) {
			criteria.addLIKE(IBOWorkorderListValue.S_LinkNo, linkNo);
		}
		if (StringUtils.isNotBlank(type)) {
			criteria.addEqual(IBOWorkorderListValue.S_ObjType, type);
		}
		if (StringUtils.isNotBlank(status)) {
			criteria.addEqual(IBOWorkorderListValue.S_Status, status);
		}
		if (StringUtils.isNotBlank(objName)) {
			criteria.addLIKE(IBOWorkorderListValue.S_ObjName, "%" + objName + "%");
		}
		if(SessionManager.getUser().getID() == 1) {
			ismgr = true;
		}
		// 不是管理人
		if (ismgr == false) {
			condition += " and order_id in ( select a.order_id from alm_workorder a where a.exec_staff_id='"
					+ staffId + "' and  a.order_type<>'3' )";
		}
		if (criteria.toString().equals("")) {
			try {
				count = iwd.countWorkorderList(condition, null);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			try {
				count = iwd.countWorkorderList(condition + " and "
						+ criteria.toString(), criteria.getParameters());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	
	public IBOWorkorderListValue[] queryWorkorderList(long staffId,
			String status) throws Exception {
		Criteria sql = new Criteria();
		String[] statuStrings = status.split(",");
		int[] statusInt = new int[statuStrings.length]; 
		
		for(int i =0;i<statuStrings.length;i++)
		{
			statusInt[i] = Integer.valueOf(statuStrings[i]);
		}
		sql.addIn(BOWorkorderListBean.S_Status, statusInt);
		sql.addEqual(BOWorkorderListBean.S_ExecStaffId, staffId);
		IBOWorkorderListValue[] listValues = iwd.queryWorkorderListById(sql.toString()+" order by create_time desc", sql.getParameters());
		return listValues;
	}
	
	
	public IBOWorkorderListValue[] getHisToryTrack(
			String objId, String objType)
			throws Exception {
		IBOWorkorderListValue[] workOrderLists = null;
		if(objId!=null&&!objId.equals(""))
			workOrderLists = iwd.queryWorklistBySql(objId, objType);
		return workOrderLists;
	}

	@Override
	public int getWorkOrderListByConCount(String condition, Map params)
			throws Exception {
		// TODO Auto-generated method stub
		return iwd.queryWorkorderListCount(condition, params);
	}
}

package com.asiainfo.csc.common.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ai.appframe2.common.SessionManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.ivalues.IBOOrganizeValue;
import com.asiainfo.csc.common.ivalues.IBOStaffRoleOrgDistViewValue;
import com.asiainfo.csc.common.service.interfaces.IStaffRoleOrgDistSV;
import com.asiainfo.csc.common.service.interfaces.ISysParamSV;
import com.asiainfo.csc.common.util.Tree;
import com.asiainfo.csc.common.util.ZTree;
import com.asiainfo.csc.common.web.TreeStaffSelect;

public class StaffSelectTree extends ZTree {

	private final static transient Log log = LogFactory
			.getLog(TreeStaffSelect.class);
	private IStaffRoleOrgDistSV iStaffRoleOrgDistSV = (IStaffRoleOrgDistSV) ServiceFactory
			.getService(IStaffRoleOrgDistSV.class);
	private ISysParamSV spsv = (ISysParamSV) ServiceFactory
			.getService(ISysParamSV.class);

	private String roleCode = null;
	private long cur_userId = 0;
	private long parentOrgId = 0;
	private String chooseType = null;
	private String projectCode = null;
	private IBOStaffRoleOrgDistViewValue[] staffs = null;
	private long rootNodeId = 0;
	private Map<Long, String> OrgMap = new HashMap<Long, String>();
	private Map<Long, List<IBOOrganizeValue>> nodeOrg = new HashMap<Long, List<IBOOrganizeValue>>();
	int i=2;
	@Override
	public List<Tree> setTreeChild(HttpServletRequest request, Tree parentTree)
			throws Exception {
		// TODO Auto-generated method stub
		String parent_NO=parentTree.getValue();
		if(parent_NO==null){
	  		return null;
	  	}
		List<IBOOrganizeValue> list=nodeOrg.get(Long.valueOf(parent_NO));
		List<Tree> trees = new ArrayList<Tree>();
		if(list!=null&&list.size()>0&&list.get(0)!=null){
			for(IBOOrganizeValue value:list){
				Tree childNode = new Tree();
				childNode.setId(i++);
				childNode.setValue(String.valueOf(value.getOrganizeId()));
				childNode.setText(value.getOrganizeName());
				childNode.setExpanded(false);
				childNode.setLeaf(false);
				if(OrgMap.get(value.getOrganizeId())!=null){
					childNode.setType(OrgMap.get(value.getOrganizeId()));
				}else{
					childNode.setType("-1");
				}
				if(nodeOrg.get(value.getOrganizeId())==null){
					childNode.setLeaf(true);
				}
				trees.add(childNode);
			}
		}
		return trees;
	}

	@Override
	public Tree setTreeRoot(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		this.init(request);
		Tree node = new Tree();
		node.setValue("-1");
		node.setText("组织结构");
		node.setType("-1");
		node.setLeaf(false);
		node.setExpanded(false);
		node.setId(1);
		return node;
	}

	public void init(ServletRequest req) throws Exception {
		if (roleCode == null) {
			if (req.getParameter("roleCode") != null) {
				roleCode = req.getParameter("roleCode").toString();
			} else {
				roleCode = "-1";
			}
		}
		if (cur_userId == 0) {
			if (req.getParameter("cur_userId") != null) {
				cur_userId = Long.parseLong(req.getParameter("cur_userId")
						.toString());
			} else {
				cur_userId = -1;
			}
		}
		if (parentOrgId == 0) {
			if (req.getParameter("parentOrgId") != null) {
				parentOrgId = Long.parseLong(req.getParameter("parentOrgId")
						.toString());
			} else {
				parentOrgId = -1;
			}
		}
		if (projectCode == null) {
			if (req.getParameter("projectCode") != null) {
				projectCode = req.getParameter("projectCode").toString();
			} else {
				projectCode = "-1";
			}
		}
		if (chooseType == null) {
			if (req.getParameter("chooseType") != null
					&& !"undefind".equals(req.getParameter("chooseType")
							.toString())) {
				chooseType = req.getParameter("chooseType").toString();
			} else {
				chooseType = "user";
			}
		}
		if (staffs == null) {
			this.getStaffs();
		}
		if (rootNodeId == 0) {
			this.getRootNodeId();
		}
	}

	private void getStaffs() throws Exception
	   {
		   	try {
		   		Criteria sql=new Criteria();
		   		if(cur_userId!=-1){
	   				sql.addEqual(IBOStaffRoleOrgDistViewValue.S_StaffId, cur_userId);
	   				IBOStaffRoleOrgDistViewValue[] viewValue=iStaffRoleOrgDistSV.queryStaffRoleViewByCondition(sql.toString(), sql.getParameters());
	   				sql.clear();
	   				if(!"".equals(viewValue[0].getDistrictId())&&viewValue[0].getDistrictId()!=0){
	   					sql.addEqual(IBOStaffRoleOrgDistViewValue.S_DistrictId, viewValue[0].getDistrictId());
	   				}
	   			}else{
	   				if(chooseType.equals("user")){
	   					sql.addIsNull(IBOStaffRoleOrgDistViewValue.S_DistrictId);
	   					if(!"-1".equals(roleCode)){
	   		   				sql.addEqual(IBOStaffRoleOrgDistViewValue.S_RoleCode, roleCode);
	   		   			}
	   				}else if(chooseType.equals("sign")){
	   					
	   				}
	   			}
		   		if(!"-1".equals(roleCode)){
		   			sql.addEqual(IBOStaffRoleOrgDistViewValue.S_RoleCode, roleCode);
		   		}
		   		
		   		if(!"-1".equals(projectCode)){
		   			String[] projectCodeString=projectCode.split(";");
		   			int[] groupIds=new int[projectCodeString.length];
		   			for(int i=0;i<projectCodeString.length;i++){
		   				groupIds[i]=Integer.parseInt(projectCodeString[i]);
		   			}
		   			sql.addIn(IBOStaffRoleOrgDistViewValue.S_GroupId,groupIds);
		   		}
		   		
		   		String conditionString = sql.toString();
		   		if(parentOrgId!=-1){
		   			sql.addEqual(IBOStaffRoleOrgDistViewValue.S_OrganizeId, parentOrgId);
		   			
		   			if(conditionString.equals(""))
		   			{
		   				conditionString = "1=1 " + " and organize_id in (Select  a.organize_id" +
		   						" From sys_organize a  " +
		   						"Start With a.organize_id = "+parentOrgId+" Connect By" +
		   						" Prior a.organize_id=a.parent_organize_id)";
		   			}
		   			else {
		   				conditionString = conditionString + " and organize_id in (Select  a.organize_id " +
						" From sys_organize a  " +
						"Start With a.organize_id = "+parentOrgId+" Connect By" +
						" Prior a.organize_id=a.parent_organize_id)";
					}
		   			
		   		}
		   		
		   		staffs =iStaffRoleOrgDistSV.queryStaffRoleViewByCondition(conditionString, sql.getParameters());
		   		log.debug("符合条件的员工数:"+staffs.length);
	   			for(IBOStaffRoleOrgDistViewValue value:staffs){
	   				if(OrgMap.get(value.getOrganizeId())==null){
	   					OrgMap.put(value.getOrganizeId(), String.valueOf(value.getStaffId()));
	   				}else{
	   					String staffId=(String) OrgMap.get(value.getOrganizeId());
	   					if(staffId.indexOf(String.valueOf(value.getStaffId()))==-1){
	   						OrgMap.put(value.getOrganizeId(), staffId+","+String.valueOf(value.getStaffId()));
	   					}
	   				}
	   			}
		   		
			} catch (Exception e){
		    	e.printStackTrace();
		    }
	   }
	
//	private void getRootNodeId()throws Exception{
//		long rnStart=System.currentTimeMillis();// 当前时间对应的毫秒数	
//		System.out.println("rootNode开始= "+rnStart);
//		
//		if(staffs!=null&&staffs.length>0&&staffs[0]!=null){
//			List<Long> parentOrgLists=new ArrayList<Long>();
//			for(IBOStaffRoleOrgDistViewValue value:staffs){
//				if(OrgMap.get(value.getParentOrganizeId())==null){
//					if(!parentOrgLists.contains(value.getParentOrganizeId())){
//						parentOrgLists.add(value.getParentOrganizeId());
//					}
//				}
//				this.addListToNodeOrg(value.getOrganizeId(),false);
//			}
//			long s111=System.currentTimeMillis();// 当前时间对应的毫秒数	
//			System.out.println("第1阶段= "+s111);
//			Criteria sql=new Criteria();
//			while(parentOrgLists.size()>1){
//				Collections.sort(parentOrgLists);
//				long orgId=parentOrgLists.get(parentOrgLists.size()-1);
//				sql.clear();
//				sql.addEqual(IBOOrganizeValue.S_OrganizeId,orgId);
//				IBOOrganizeValue[] organizeValue=iStaffRoleOrgDistSV.queryOrganizeVlaueByCondition(sql.toString(), sql.getParameters());
//				parentOrgLists.remove(orgId);
//				if(!parentOrgLists.contains(organizeValue[0].getParentOrganizeId())){
//					parentOrgLists.add(organizeValue[0].getParentOrganizeId());
//				}
//				this.addListToNodeOrg(orgId,false);	
//			}
//			long s222=System.currentTimeMillis();// 当前时间对应的毫秒数	
//			System.out.println("第2阶段= "+s222);
//			if(rootNodeId!=2){
//				rootNodeId=(Long) parentOrgLists.get(0);
//			}
//			this.addListToNodeOrg(rootNodeId,true);
//		}
//		long s333=System.currentTimeMillis();// 当前时间对应的毫秒数	
//		System.out.println("第3阶段= "+s333);
//		log.debug("父节点ID："+rootNodeId);
//	}
	
	private void getRootNodeId()throws Exception{
		long rnStart=System.currentTimeMillis();// 当前时间对应的毫秒数	
		System.out.println("rootNode开始= "+rnStart);

		if(staffs!=null&&staffs.length>0&&staffs[0]!=null){
			List<Long> orgList = new ArrayList<Long>();
			
			List<Long> parentOrgLists=new ArrayList<Long>();
			for(IBOStaffRoleOrgDistViewValue value:staffs){
				if(OrgMap.get(value.getParentOrganizeId())==null){
					if(!parentOrgLists.contains(value.getParentOrganizeId())){
						parentOrgLists.add(value.getParentOrganizeId());
					}
				}
				if(!orgList.contains(value.getOrganizeId())){
					orgList.add(value.getOrganizeId());
				}
//				this.addListToNodeOrg(value.getOrganizeId(),false);
			}
			
//			for(int i =0; i<orgList.size();i++)
//			{
//				this.addListToNodeOrg((Long) orgList.get(i),false);
//			}
			
			this.addOrglistToNodeOrg(orgList,false);//根据人员所属组织，画结构树
			
			long s111=System.currentTimeMillis();// 当前时间对应的毫秒数	
			System.out.println("第1阶段= "+s111);
			Criteria sql=new Criteria();
			while(parentOrgLists.size()>1){
				Collections.sort(parentOrgLists);
				long orgId=parentOrgLists.get(parentOrgLists.size()-1);
				sql.clear();
				sql.addEqual(IBOOrganizeValue.S_OrganizeId,orgId);
				IBOOrganizeValue[] organizeValue=iStaffRoleOrgDistSV.queryOrganizeVlaueByCondition(sql.toString(), sql.getParameters());
				parentOrgLists.remove(orgId);
				if(!parentOrgLists.contains(organizeValue[0].getParentOrganizeId())){
					parentOrgLists.add(organizeValue[0].getParentOrganizeId());
				}
				this.addListToNodeOrg(orgId,false);	
			}
			long s222=System.currentTimeMillis();// 当前时间对应的毫秒数	
			System.out.println("第2阶段= "+s222);
			if(rootNodeId!=2){
				rootNodeId=(Long) parentOrgLists.get(0);
			}
			this.addListToNodeOrg(rootNodeId,true);
		}
		long s333=System.currentTimeMillis();// 当前时间对应的毫秒数	
		System.out.println("结束= "+s333);
		log.debug("父节点ID："+rootNodeId);
//		for(long mapKey:nodeOrg.keySet()){
//			System.out.print(mapKey+"===========");
//			List<IBOOrganizeValue> slist=nodeOrg.get(mapKey);
//			for(IBOOrganizeValue value:slist){
//				System.out.print(value.getOrganizeId());
//			}
//			System.out.println();
//		}
	}
	
	private void addListToNodeOrg(long orgId,boolean isRootNode)throws Exception{
		Criteria sql=new Criteria();
		sql.addEqual(IBOOrganizeValue.S_OrganizeId,orgId);
		IBOOrganizeValue[] organizeValue=iStaffRoleOrgDistSV.queryOrganizeVlaueByCondition(sql.toString(), sql.getParameters());
		List<IBOOrganizeValue> list=(nodeOrg.get(organizeValue[0].getParentOrganizeId())==null)?new ArrayList<IBOOrganizeValue>():nodeOrg.get(organizeValue[0].getParentOrganizeId());
		if(!this.isNodeOrg(list,orgId)&&isRootNode){
			list.add(organizeValue[0]);
			nodeOrg.remove(-1L);
			nodeOrg.put(-1L, list);
		}else if(!this.isNodeOrg(list,orgId)&&!isRootNode){
			list.add(organizeValue[0]);
			nodeOrg.remove(organizeValue[0].getParentOrganizeId());
			nodeOrg.put(organizeValue[0].getParentOrganizeId(), list);
			
		}
	}
	
	
	private void addOrglistToNodeOrg(List orgList,boolean isRootNode)throws Exception{
		Criteria sql=new Criteria();
		sql.addIn(IBOOrganizeValue.S_OrganizeId, orgList);
		IBOOrganizeValue[] organizeValue=iStaffRoleOrgDistSV.queryOrganizeVlaueByCondition(sql.toString(), sql.getParameters());

		for(int i= 0; i<organizeValue.length; i++)
		{
			List<IBOOrganizeValue> list=(nodeOrg.get(organizeValue[i].getParentOrganizeId())==null)?new ArrayList<IBOOrganizeValue>():nodeOrg.get(organizeValue[i].getParentOrganizeId());
			if(!this.isNodeOrg(list,organizeValue[i].getOrganizeId())&&isRootNode){
				list.add(organizeValue[i]);
				nodeOrg.remove(-1L);
				nodeOrg.put(-1L, list);
			}else if(!this.isNodeOrg(list,organizeValue[i].getOrganizeId())&&!isRootNode){
				list.add(organizeValue[i]);
				nodeOrg.remove(organizeValue[i].getParentOrganizeId());
				nodeOrg.put(organizeValue[i].getParentOrganizeId(), list);
				
			}
		}
	}
	
	
	
	private boolean isNodeOrg(List<IBOOrganizeValue> list,long orgId){
		boolean isHave=false;
		for(IBOOrganizeValue value:list){
			if(value.getOrganizeId()==orgId){
				isHave=true;
				return isHave;
			}
		}
		return isHave;
	}
//	public static void main(String[] args)throws Exception{
//		TreeStaffSelect tss=new TreeStaffSelect();
//		tss.getStaffs();
//		tss.getRootNodeId();
//		//tss.getRootNode();
//		System.out.println(tss.RootNodeId); 
//	}
	
}
package com.asiainfo.csc.common.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ai.appframe2.common.SessionManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.appframe2.web.tag.dbtree.AIDBTreeNode;
import com.ai.appframe2.web.tag.dbtree.AIDBTreeNodeInterface;
import com.ai.appframe2.web.tag.dbtree.DBTreeNewDataModelInterface;
import com.asiainfo.csc.common.ivalues.IBOOrganizeValue;
import com.asiainfo.csc.common.ivalues.IBOStaffRoleOrgDistViewValue;
import com.asiainfo.csc.common.service.interfaces.IStaffRoleOrgDistSV;
import com.asiainfo.csc.common.service.interfaces.ISysParamSV;

public class TreeStaffSelect implements DBTreeNewDataModelInterface {
	private final static transient Log log = LogFactory.getLog(TreeStaffSelect.class);
	private IStaffRoleOrgDistSV iStaffRoleOrgDistSV=(IStaffRoleOrgDistSV)ServiceFactory.getService(IStaffRoleOrgDistSV.class);
	private ISysParamSV spsv = (ISysParamSV)ServiceFactory.getService(ISysParamSV.class);
	
	private String roleCode=null;
	private long cur_userId = 0;
	private long parentOrgId = 0;
	private String chooseType=null;
	private String projectCode = null;
	private IBOStaffRoleOrgDistViewValue[] staffs=null;
	private long rootNodeId=0;
	private Map<Long,String> OrgMap=new HashMap<Long,String>();
	private Map<Long,List<IBOOrganizeValue>> nodeOrg=new HashMap<Long,List<IBOOrganizeValue>>();
	
	public void getChildren(AIDBTreeNodeInterface parentNode, int deepCnt)
			throws Exception {
	  	addChildNodeByParentNode(parentNode);
	}
	
	public AIDBTreeNodeInterface getRootNode() {
		AIDBTreeNode node = new AIDBTreeNode();
		node.setValue("-1");
		node.setLabel("组织结构");
		node.setUserObj("-1");
//		try {
//			if(rootNodeId!=0){
//				List<IBOOrganizeValue> list=nodeOrg.get(-1L);
//				for(IBOOrganizeValue value:list){
//					AIDBTreeNode childNode = new AIDBTreeNode();
//					childNode.setValue(String.valueOf(value.getOrganizeId()));
//					childNode.setLabel(value.getOrganizeName());
//					if(OrgMap.get(value.getOrganizeId())!=null){
//						childNode.setUserObj(OrgMap.get(value.getOrganizeId()));
//					}else{
//						childNode.setUserObj("-1");
//					}
//				}
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		List<AIDBTreeNode> list;
//		try {
//			list = node.getChildren();
//			for(AIDBTreeNode lists:list){
//				System.out.println(lists.getLabel());
//				for(Object nodes:lists.getChildren()){
//					System.out.println(((AIDBTreeNode)nodes).getLabel());
//				}
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return node;
	}

	private void addChildNodeByParentNode(AIDBTreeNodeInterface parentNode)throws Exception{
		String parent_NO=parentNode.getValue();
		if(parent_NO==null){
	  		return;
	  	}
		List<IBOOrganizeValue> list=nodeOrg.get(Long.valueOf(parent_NO));
		if(list!=null&&list.size()>0&&list.get(0)!=null){
			for(IBOOrganizeValue value:list){
				AIDBTreeNode childNode = new AIDBTreeNode();
				childNode.setValue(String.valueOf(value.getOrganizeId()));
				childNode.setLabel(value.getOrganizeName());
				if(OrgMap.get(value.getOrganizeId())!=null){
					childNode.setUserObj(OrgMap.get(value.getOrganizeId()));
				}else{
					childNode.setUserObj("-1");
				}
				if(nodeOrg.get(value.getOrganizeId())==null){
					childNode.setLeaf(true);
				}
				parentNode.addChild(childNode);
			}
		}
	} 
	
	public void init(ServletRequest req) throws Exception {
		if(roleCode == null){
			  if(req.getAttribute("roleCode") != null){
				  roleCode = req.getAttribute("roleCode").toString();
			  }else{
				  roleCode="-1";
			  }
		}
		if (cur_userId == 0){
			  if(req.getAttribute("cur_userId") != null){
				  cur_userId = Long.parseLong(req.getAttribute("cur_userId").toString());
			  }else{
				  cur_userId=-1;
			  }
		}
		if(parentOrgId==0){
			 if(req.getAttribute("parentOrgId") != null){
				 parentOrgId = Long.parseLong(req.getAttribute("parentOrgId").toString());
			  }else{
				  parentOrgId=-1;
			  }
		}
		if(projectCode == null){
			if(req.getAttribute("projectCode")!=null){
				projectCode = req.getAttribute("projectCode").toString();
			}else{
				projectCode="-1";
			}
		}
		if(chooseType==null){
			if(req.getAttribute("chooseType")!=null&&!"undefind".equals(req.getAttribute("chooseType").toString())){
				chooseType = req.getAttribute("chooseType").toString();
			}else{
				chooseType="user";
			}
		}
		if(staffs == null){
			this.getStaffs();
		}
		if(rootNodeId==0){
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
		   		if(parentOrgId!=-1){
		   			sql.addEqual(IBOStaffRoleOrgDistViewValue.S_ParentOrganizeId, parentOrgId);
		   		}
		   		if(!"-1".equals(projectCode)){
		   			String[] projectCodeString=projectCode.split(";");
		   			int[] groupIds=new int[projectCodeString.length];
		   			for(int i=0;i<projectCodeString.length;i++){
		   				groupIds[i]=Integer.parseInt(projectCodeString[i]);
		   			}
		   			sql.addIn(IBOStaffRoleOrgDistViewValue.S_GroupId,groupIds);
		   		}
		   		staffs =iStaffRoleOrgDistSV.queryStaffRoleViewByCondition(sql.toString(), sql.getParameters());
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
	
	private void getRootNodeId()throws Exception{
		if(staffs!=null&&staffs.length>0&&staffs[0]!=null){
			List<Long> parentOrgLists=new ArrayList<Long>();
			for(IBOStaffRoleOrgDistViewValue value:staffs){
				if(OrgMap.get(value.getParentOrganizeId())==null){
					if(!parentOrgLists.contains(value.getParentOrganizeId())){
						parentOrgLists.add(value.getParentOrganizeId());
					}
				}
				this.addListToNodeOrg(value.getOrganizeId(),false);
			}
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
			if(rootNodeId!=2){
				rootNodeId=(Long) parentOrgLists.get(0);
			}
			this.addListToNodeOrg(rootNodeId,true);
		}
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
		long curStaff = SessionManager.getUser().getID();
		String condition = "organize_id=(select ssor.organize_id from sys_staff_org_relat ssor where ssor.staff_id="+ curStaff +")";
		IBOOrganizeValue[] staffOrg = iStaffRoleOrgDistSV.queryOrganizeVlaueByCondition(condition, null);
		String staffOrgCode = staffOrg[0].getCode();
		if(staffOrgCode.length() > 2) {
			staffOrgCode = staffOrgCode.substring(0,2);
		}
		Criteria sql=new Criteria();
		sql.addEqual(IBOOrganizeValue.S_OrganizeId,orgId);
		IBOOrganizeValue[] organizeValue=iStaffRoleOrgDistSV.queryOrganizeVlaueByCondition(sql.toString(), sql.getParameters());
		List<IBOOrganizeValue> list=(nodeOrg.get(organizeValue[0].getParentOrganizeId())==null)?new ArrayList<IBOOrganizeValue>():nodeOrg.get(organizeValue[0].getParentOrganizeId());
		if(!this.isNodeOrg(list,orgId)&&isRootNode){
			list.add(organizeValue[0]);
			nodeOrg.remove(-1L);
			nodeOrg.put(-1L, list);
		}else if(!this.isNodeOrg(list,orgId)&&!isRootNode){
			String tempCode = organizeValue[0].getCode();
			if(staffOrgCode.length() == 2 && tempCode.length() >= 2 && staffOrgCode.substring(0, 1).equals("B") 
					&& tempCode.substring(0, 1).equals("B") && !tempCode.substring(0, 2).equals(staffOrgCode)) {
				
			} else {
				list.add(organizeValue[0]);
				nodeOrg.remove(organizeValue[0].getParentOrganizeId());
				nodeOrg.put(organizeValue[0].getParentOrganizeId(), list);
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

package com.asiainfo.csc.common.web;

import java.util.*;

import javax.servlet.*;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.tag.dbtree.*;
import com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue;
import com.asiainfo.csc.common.ivalues.IBOStaffProjectViewValue;
import com.asiainfo.csc.common.ivalues.IBOSysParamValue;
import com.asiainfo.csc.common.service.interfaces.IStaffProjectViewSV;
import com.asiainfo.csc.common.service.interfaces.ISysParamSV;


public class TreeSelectStaff implements DBTreeNewDataModelInterface {
   
   private IStaffProjectViewSV spvsv = (IStaffProjectViewSV)ServiceFactory.getService(IStaffProjectViewSV.class);
   private ISysParamSV spsv = (ISysParamSV)ServiceFactory.getService(ISysParamSV.class);
   
   public TreeSelectStaff() {}
   
   private String roleCode = null;
   private long staffId = 0;
   private String projectCode = null;
   private long[] projectIds = null;
   private long  roleOrgId = 0;
   private IBOStaffProjectViewValue[] staffs = null;
   private List<Long> orgs = new ArrayList<Long>();
   private ISysOrganizeValue[] sysOrgValues = null;
   private long parentOrgId = 0;
   private String districtId = null;
   
   private void getStaffs() 
   {
	   	try {
	   		staffs =  spvsv.getStaffsByProject(projectIds,roleCode);
		} catch (Exception e){
	    	e.printStackTrace();
	    }
   }
   
  	public AIDBTreeNodeInterface getRootNode() 
  	{
		AIDBTreeNode node = new AIDBTreeNode();
		node.setValue("-1");
		node.setLabel("组织结构");
		node.setUserObj("-1");
		try {
			/*if(roleCode == null){
				return null;
			}*/
			ISysOrganizeValue[]  orgValues =  spvsv.getOrgsFromDatasByParentId(sysOrgValues, "-1");
			
			for(int i = 0; i < orgValues.length; i++){
	    		AIDBTreeNode childNode = new AIDBTreeNode();
	    		long orgId = orgValues[i].getOrganizeId();
	    		String distriId = orgValues[i].getDistrictId();
	    		if(districtId != null && !districtId.equals(distriId)){
	    			continue;
	    		}
	    		//判断orgId的父节点是否为parentOrgId
	    		if(parentOrgId != 0 && parentOrgId != -1 && !spvsv.getOrgIsParnetChildRel(parentOrgId,orgId)){
	    			continue;
	    		}
	    		childNode.setValue(""+orgId);
	    		childNode.setLabel(orgValues[i].getOrganizeName());
	    		boolean  isStaffOrg = this.hasStaffOrg(staffs, orgId);
	    		if(!isStaffOrg){
	    			childNode.setUserObj("-1");
	    			childNode.setLeaf(false);
	    		}
	    		if(isStaffOrg){
	    			String staffIds = this.getStaffIds(staffs, orgId);
	    			childNode.setUserObj(staffIds);
	    			childNode.setLeaf(true);
	    		}
	    		node.addChild(childNode);
			}
    	
	    } catch (Exception e){
	    	e.printStackTrace();
	    }
	    return node;
	  }
  	
  	//得到该组织Id下的所有 staffID
  	public String getStaffIds (IBOStaffProjectViewValue[] staffs,long orgId)
  	{
  		TreeSet<IBOStaffProjectViewValue> set = new TreeSet<IBOStaffProjectViewValue>(new Comparator<IBOStaffProjectViewValue>(){

			
			public int compare(IBOStaffProjectViewValue o1, IBOStaffProjectViewValue o2) {
				
			return (int) (o1.getStaffId()-o2.getStaffId());
				
			}
  			
  		});
  		
  		StringBuffer staffIds = new StringBuffer();
  		for (int i = 0; i < staffs.length; i++) {
  			if(staffs[i].getOrganizeId()==orgId){
  				set.add(staffs[i]);
			}
		}
  		Iterator<IBOStaffProjectViewValue> iterator = set.iterator();
  		int j = 0;
  		while(iterator.hasNext()){
  			if("".equals(staffIds.toString())){
				staffIds.append(iterator.next().getStaffId());
			}else{
				staffIds.append(","+iterator.next().getStaffId());
			}
  		}
  		return staffIds.toString();
  	}
  	
  	//选中的组织是不是最后一级组织。
  	public boolean hasStaffOrg(IBOStaffProjectViewValue[] staffs,long orgId)
  	{
  		for (int i = 0; i < staffs.length; i++) {
			if(staffs[i].getOrganizeId()==orgId){
				return true;
			}
		}
  		return false;
  	}
  	
	  /**
	   * init
	   *
	   * @param req ServletRequest
	   * @throws Exception
	   * @todo Implement this com.ai.appframe2.web.tag.dbtree.DBTreeNewDataModelInterface method
	   */
  	public void init(ServletRequest req) throws Exception 
  	{
		  if(roleCode == null){
			  if(req.getAttribute("roleCode") != null){
				  roleCode = req.getAttribute("roleCode").toString();
			  }
		  }
		  if(roleOrgId == 0){
			  if(req.getAttribute("roleOrgId") != null){
				  roleOrgId = Long.valueOf(req.getAttribute("roleOrgId").toString());
			  }
		  }
		  if(parentOrgId == 0){
			  if(req.getAttribute("parentOrgId") != null){
				  parentOrgId = Long.valueOf(req.getAttribute("parentOrgId").toString());
			  }
		  }
		  if(districtId == null){
			  if(req.getAttribute("districtId") != null){
				  districtId = req.getAttribute("districtId").toString();
			  }
		  }
		  
		  if (staffId == 0){
			  String staffIdStr = req.getAttribute("staffId").toString();
			  staffId = Long.parseLong(staffIdStr);
		  }
		  if(projectCode == null){
			  if(req.getAttribute("projectCode")!=null){
				  String projectID = req.getAttribute("projectCode").toString();
				  if("".equals(projectID) || "-1".equals(projectID)){
					  projectCode = null;
				  }else{
					  IBOSysParamValue[] sysParams = spsv.getSysParam("SYS_TAG",projectID);
					  projectCode = sysParams[0].getParamName();
				  }
			  }
		  }
		  
		  if (projectIds == null){
			  this.getGroupIds(staffId,projectCode);
		  }
		  
		  if(staffs == null){
			  this.getStaffs();
		  }
		  
		  if(sysOrgValues==null){
			  for (int i = 0; i < staffs.length; i++) {
				  long orgId = staffs[i].getOrganizeId();
				  if(!this.hasOrgId(orgs, orgId)){
					  orgs.add(orgId);
				  }
			  }
			  sysOrgValues = spvsv.queryOrgsByList(orgs);
		  }
	}
  	
  	//List 中 是否已经存在 组织Id
  	 public boolean hasOrgId(List<Long> orgs,long orgId)
  	 {
  		 for (int i = 0; i < orgs.size(); i++) {
			if(orgId==orgs.get(i)){
				return true;
			}
		}
  		 return false;
  	 }
  	 
  	 public void getGroupIds(long staffId, String projectCode)
  	 {
  		 try{
  	  		this.projectIds = spvsv.getProjectIds(staffId, projectCode);
  		 }catch(Exception e)
  		 {
  			 e.printStackTrace(); 
  		 }
  	 }
  	
  	
	  /**
	   * getChildren
	   *
	   * @param pParentNode AIDBTreeNodeInterface
	   * @param isGetAll boolean
	   * @throws Exception
	   * @todo Implement this com.ai.appframe2.web.tag.dbtree.DBTreeNewDataModelInterface method
	   */
	  public void getChildren(AIDBTreeNodeInterface pParentNode, int getChildDeep) throws Exception 
	  {
		  try{
			  	String parent_NO = pParentNode.getValue();
			  	if(parent_NO==null){
			  		return;
			  	}
			  	
			  	ISysOrganizeValue[]  orgValues =  spvsv.getOrgsFromDatasByParentId(sysOrgValues, parent_NO);
				
				for(int i = 0; i < orgValues.length; i++){
		    		AIDBTreeNode childNode = new AIDBTreeNode();
		    		long orgId = orgValues[i].getOrganizeId();
		    		childNode.setValue(""+orgId);
		    		childNode.setLabel(orgValues[i].getOrganizeName());
		    		boolean  isStaffOrg = this.hasStaffOrg(staffs, orgId);
		    		if(!isStaffOrg){
		    			childNode.setUserObj("-1");
		    			//childNode.setLeaf(false);
		    		}
		    		if(isStaffOrg){
		    			String staffIds = this.getStaffIds(staffs, orgId);
		    			childNode.setUserObj(staffIds);
		    			//childNode.setLeaf(true);
		    		}
		    		pParentNode.addChild(childNode);
				}
			  	
		  }catch(Exception e){
			  throw new Exception(e);
		  }
	  }
}
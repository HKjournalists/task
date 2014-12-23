package com.asiainfo.aiga.groupJointDebug.web;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.service.ICommonPageinationSV;
import com.asiainfo.aiga.daily.bo.AigaTestDaily;
import com.asiainfo.aiga.groupCase.bo.AigaRGroupChangeCase;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugChange;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugReqForm;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugSubTaskForm;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugTaskForm;
import com.asiainfo.aiga.groupJointDebug.service.IAigaJointDebugSV;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;

@Controller
public class JointDebugAction extends BaseAction {
	
	@Resource(name="commonPageinationSV")
	private ICommonPageinationSV commonPageinationSV;
	
	@Resource(name = "aigaJointDebugSV")
	private IAigaJointDebugSV aigaJointDebugSV;
	
	@RequestMapping("/saveJointDebugReqForm.do")
	public void saveJointDebugReqForm(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Object[] objs = this.transFormToObj(request, new Class[] {AigaJointDebugReqForm.class });
		Boolean result = false;
		Map<String,Object> map = new HashMap<String,Object>();
		if(objs!=null && objs.length==1){
			if (objs[0] instanceof AigaJointDebugReqForm) {
				try {
					AigaJointDebugReqForm reqForm=(AigaJointDebugReqForm)objs[0];
					if(reqForm.getReqId()==null){//新增
						reqForm.setCreateTime(new Timestamp(System.currentTimeMillis()));//设置创建时间
						AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
						reqForm.setCreatorId(new BigDecimal(user.getUserId()));//创建人ID
						reqForm.setCreatorName(user.getUserName());//创建人名称
						aigaJointDebugSV.saveAigaJointDebugReqForm(reqForm);
						result = true;
						map.put("success", result);
					}else{//修改
						aigaJointDebugSV.saveAigaJointDebugReqForm(reqForm);
						result = true;
						map.put("success", result);
					}
				} catch (Exception e) {
					map.put("msg", "保存数据失败!");
					result = false;
					map.put("success", result);
				}	
			}
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/getJointDebugReqFormList.do")
	public void getJointDebugReqFormList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		String reqName=request.getParameter("reqName");
		String reqTag=request.getParameter("reqTag");
		Map<String,Integer> pageMap=this.paginationParams(request);
		int pageNo = Integer.parseInt(pageMap.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(pageMap.get(this.LIMIT_PARAM).toString());
		String HQL="FROM AigaJointDebugReqForm  where 1=1 ";
		if(reqName!=null && !reqName.equals(""))HQL+=" and reqName like '%"+ this.decodeCN(reqName)+"%' ";
		if(reqTag!=null && !reqTag.equals(""))HQL+=" and reqTag  like '%"+reqTag+"%' ";
		HQL+=" and isDelete=0";
		List<Object> list = commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
		json = JSONArray.fromObject(list, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(HQL));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	
	@RequestMapping("/deleteJointDebugReqForms.do")
	private void deleteJointDebugReqForms(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String reqIds = request.getParameter("reqIds");
			if(reqIds==null||reqIds.equals(""))
				throw new Exception("未从界面获取到reqId参数");
			aigaJointDebugSV.deleteAigaJointDebugReqForm(reqIds);
			this.setPostInfo("success", true);
			this.setPostInfo("message", "需求单删除成功");
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "需求单删除失败");
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getJointDebugReqFormByReqId.do")
	public void getJointDebugReqFormByReqId(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String reqId=request.getParameter("reqId");
		String HQL="FROM AigaJointDebugReqForm  where 1=1 ";
		if(reqId!=null && !reqId.equals(""))HQL+=" and reqId="+ reqId;
		AigaJointDebugReqForm[] aigaJointDebugReqForm = aigaJointDebugSV.getAigaJointDebugReqForm(HQL);
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (aigaJointDebugReqForm.length == 1) {
			JSON json =JSONObject.fromObject(aigaJointDebugReqForm[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/saveJointDebugTaskForm.do")
	public void saveJointDebugTaskForm(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Object[] objs = this.transFormToObj(request, new Class[] {AigaJointDebugTaskForm.class });
		Boolean result = false;
		Map<String,Object> map = new HashMap<String,Object>();
		if(objs!=null && objs.length==1){
			if (objs[0] instanceof AigaJointDebugTaskForm) {
				try {
					AigaJointDebugTaskForm taskForm=(AigaJointDebugTaskForm)objs[0];
					if(taskForm.getTaskId()==null){//新增
						taskForm.setCreateTime(new Timestamp(System.currentTimeMillis()));//设置创建时间
						AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
						taskForm.setCreatorId(new BigDecimal(user.getUserId()));//创建人ID
						taskForm.setCreatorName(user.getUserName());//创建人名称
						aigaJointDebugSV.saveAigaJointDebugTaskForm(taskForm);
						result = true;
						map.put("success", result);
					}else{//修改
						
						aigaJointDebugSV.saveAigaJointDebugTaskForm(taskForm);
						result = true;
						map.put("success", result);
					}
				} catch (Exception e) {
					map.put("msg", "保存数据失败!");
					result = false;
					map.put("success", result);
				}	
			}
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/getJointDebugTaskFormList.do")
	public void getJointDebugTaskFormList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		String taskName=request.getParameter("taskName");
		String taskTag=request.getParameter("taskTag");
		Map<String,Integer> pageMap=this.paginationParams(request);
		int pageNo = Integer.parseInt(pageMap.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(pageMap.get(this.LIMIT_PARAM).toString());
		String HQL="FROM AigaJointDebugTaskForm  where 1=1 ";
		if(taskName!=null && !taskName.equals(""))HQL+=" and taskName like '%"+ this.decodeCN(taskName)+"%' ";
		if(taskTag!=null && !taskTag.equals(""))HQL+=" and taskTag  like '%"+taskTag+"%' ";
		HQL+=" and isDelete=0";
		List<Object> list = commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
		json = JSONArray.fromObject(list, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(HQL));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	
	@RequestMapping("/deleteJointDebugTaskForms.do")
	private void deleteJointDebugTaskForms(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String taskIds = request.getParameter("taskIds");
			if(taskIds==null||taskIds.equals(""))
				throw new Exception("未从界面获取到taskId参数");
			aigaJointDebugSV.deleteAigaJointDebugTaskForm(taskIds);
			this.setPostInfo("success", true);
			this.setPostInfo("message", "任务单删除成功");
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "任务单删除失败");
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getJointDebugTaskFormByTaskId.do")
	public void getJointDebugTaskFormByTaskId(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String taskId=request.getParameter("taskId");
		String HQL="FROM AigaJointDebugTaskForm  where 1=1 ";
		if(taskId!=null && !taskId.equals(""))HQL+=" and taskId="+ taskId;
		AigaJointDebugTaskForm[] aigaJointDebugTaskForm = aigaJointDebugSV.getAigaJointDebugTaskForm(HQL);
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (aigaJointDebugTaskForm.length == 1) {
			JSON json =JSONObject.fromObject(aigaJointDebugTaskForm[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/saveJointDebugSubTaskForm.do")
	public void saveJointDebugSubTaskForm(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Object[] objs = this.transFormToObj(request, new Class[] {AigaJointDebugSubTaskForm.class });
		Boolean result = false;
		Map<String,Object> map = new HashMap<String,Object>();
		if(objs!=null && objs.length==1){
			if (objs[0] instanceof AigaJointDebugSubTaskForm) {
				try {
					AigaJointDebugSubTaskForm subTaskForm=(AigaJointDebugSubTaskForm)objs[0];
					if(subTaskForm.getSubTaskId()==null){//新增
						subTaskForm.setCreateTime(new Timestamp(System.currentTimeMillis()));//设置创建时间
						AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
						subTaskForm.setCreatorId(new BigDecimal(user.getUserId()));//创建人ID
						subTaskForm.setCreatorName(user.getUserName());//创建人名称
						aigaJointDebugSV.saveAigaJointDebugSubTaskForm(subTaskForm);
						result = true;
						map.put("success", result);
					}else{//修改
						//java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
						//String commitTime = sdf.format(testDaily.getCommitTime());
						//Date currentTime = new Date();
						//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
						//String dateString = formatter.format(currentTime);
						aigaJointDebugSV.saveAigaJointDebugSubTaskForm(subTaskForm);
						result = true;
						map.put("success", result);
					}
				} catch (Exception e) {
					map.put("msg", "保存数据失败!");
					result = false;
					map.put("success", result);
				}	
			}
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/getJointDebugSubTaskFormList.do")
	public void getJointDebugSubTaskFormList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		String subTaskName=request.getParameter("subTaskName");
		String subTaskTag=request.getParameter("subTaskTag");
		Map pageMap=this.paginationParams(request);
		int pageNo = Integer.parseInt(pageMap.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(pageMap.get(this.LIMIT_PARAM).toString());
		String HQL="FROM AigaJointDebugSubTaskForm  where 1=1 ";
		if(subTaskName!=null && !subTaskName.equals(""))HQL+=" and subTaskName like '%"+ this.decodeCN(subTaskName)+"%' ";
		if(subTaskTag!=null && !subTaskTag.equals(""))HQL+=" and subTaskTag  like '%"+subTaskTag+"%' ";
		HQL+=" and isDelete=0";
		List<Object> list = commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
		json = JSONArray.fromObject(list, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(HQL));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	
	@RequestMapping("/deleteJointDebugSubTaskForms.do")
	private void deleteJointDebugSubTaskForms(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String subTaskIds = request.getParameter("subTaskIds");
			if(subTaskIds==null||subTaskIds.equals(""))
				throw new Exception("未从界面获取到subTaskId参数");
			aigaJointDebugSV.deleteAigaJointDebugSubTaskForm(subTaskIds);
			this.setPostInfo("success", true);
			this.setPostInfo("message", "子任务单删除成功");
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "子任务单删除失败");
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getJointDebugSubTaskFormBySubTaskId.do")
	public void getJointDebugSubTaskFormBySubTaskId(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String subTaskId=request.getParameter("subTaskId");
		String HQL="FROM AigaJointDebugSubTaskForm  where 1=1 ";
		if(subTaskId!=null && !subTaskId.equals(""))HQL+=" and subTaskId="+ subTaskId;
		AigaJointDebugSubTaskForm[] aigaJointDebugSubTaskForm = aigaJointDebugSV.getAigaJointDebugSubTaskForm(HQL);
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (aigaJointDebugSubTaskForm.length == 1) {
			JSON json =JSONObject.fromObject(aigaJointDebugSubTaskForm[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/getComBoxForJointDebugTaskForm.do")
	public void getComBoxForJointDebugTaskForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysConstant[] sysConstants = SysContentUtil
				.getSysContant("AigaJointDebugTaskForm");
		String queryFlag = request.getParameter("query");
		String other2 = "";//主要是做联动查询
		try{
			other2 = request.getParameter("other2");
		}catch(Exception e){
			other2 = "";
		}
		JSONArray jsonAry = new JSONArray();
		for (SysConstant sysConstant : sysConstants) {
			if (!sysConstant.getCategoryName().equals(queryFlag))
				continue;
			if(other2!=null&&!other2.equals("")&&!other2.equals("null")){
				if(sysConstant.getOther2().equals(other2)){
					JSONObject json = new JSONObject();
					json.put("value", sysConstant.getValue());
					json.put("show", sysConstant.getShow());
					jsonAry.add(json);
				}	
			}else{
				JSONObject json = new JSONObject();
				json.put("value", sysConstant.getValue());
				json.put("show", sysConstant.getShow());
				jsonAry.add(json);
			}
			
		}
		JSONObject json = new JSONObject();
		
		json.put("success", true);
		json.put("data", jsonAry);

		ActionHelper.responseData4JSON(request, response, json);
	}
	
	@RequestMapping("/getComBoxForJointDebugChange.do")
	public void getComBoxForJointDebugChange(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysConstant[] sysConstants = SysContentUtil
				.getSysContant("AIGA_JOINT_DEBUG_CHANGE");
		String queryFlag = request.getParameter("query");
		
		JSONArray jsonAry = new JSONArray();
		for (SysConstant sysConstant : sysConstants) {
			if (!sysConstant.getCategoryName().equals(queryFlag))
				continue;
			JSONObject json = new JSONObject();
			json.put("value", sysConstant.getValue());
			json.put("show", sysConstant.getShow());
			jsonAry.add(json);
		}
		JSONObject json = new JSONObject();
		
		json.put("success", true);
		json.put("data", jsonAry);

		ActionHelper.responseData4JSON(request, response, json);
	}
	
	@RequestMapping("/checkJointDebugChangeTaskTag.do")
	public void checkJointDebugChangeTaskTag(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String changeTaskType = request.getParameter("changeTaskType");
			if(changeTaskType.equals("1")){//联调需求
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaJointDebugReqForm.class);
				criteria.add(Restrictions.eq("reqTag",request.getParameter("tag")));
				AigaJointDebugReqForm[] aigaJointDebugReqForms = aigaJointDebugSV.getAigaJointDebugReqForm(criteria);
				if(aigaJointDebugReqForms.length==1){
					map.put("groupReqDevEndTime", aigaJointDebugReqForms[0].getGroupReqDevEndTime());//集团要求完成时间
					map.put("provincialReqDevEndTime", aigaJointDebugReqForms[0].getProvincialReqDevEndTime());//省公司要求完成时间
					map.put("jointDebugPlanBeginTime", aigaJointDebugReqForms[0].getJointDebugPlanBeginTime());//联调计划开始时间
					map.put("jointDebugPlanEndTime", aigaJointDebugReqForms[0].getJointDebugPlanEndTime());//联调计划结束时间
					map.put("msg", "yes");
					map.put("success", true);
				}else{
					map.put("msg", "no");
					map.put("success", false);
				}
			}else if(changeTaskType.equals("2")){//任务
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaJointDebugTaskForm.class);
				criteria.add(Restrictions.eq("taskTag",request.getParameter("tag")));
				AigaJointDebugTaskForm[] aigaJointDebugTaskForms = aigaJointDebugSV.getAigaJointDebugTaskForm(criteria);
				if(aigaJointDebugTaskForms.length==1){
					map.put("reqPlanAccomplishTime", aigaJointDebugTaskForms[0].getReqPlanAccomplishTime());//集团联调需求计划完成日期
					map.put("msg", "yes");
					map.put("success", true);
				}else{
					map.put("msg", "no");
					map.put("success", false);
				}
			}else if(changeTaskType.equals("3")){//子任务
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaJointDebugSubTaskForm.class);
				criteria.add(Restrictions.eq("subTaskTag",request.getParameter("tag")));
				AigaJointDebugSubTaskForm[] aigaJointDebugSubTaskForms = aigaJointDebugSV.getAigaJointDebugSubTaskForm(criteria);
				if(aigaJointDebugSubTaskForms.length==1){
					map.put("taskPlanBeginCommitTime", aigaJointDebugSubTaskForms[0].getTaskPlanBeginCommitTime());
					map.put("taskPlanEndCommitTime", aigaJointDebugSubTaskForms[0].getTaskPlanEndCommitTime());
					map.put("subTaskId", aigaJointDebugSubTaskForms[0].getSubTaskId());
					map.put("msg", "yes");
					map.put("success", true);
				}else{
					map.put("msg", "no");
					map.put("success", false);
				}
			}else{//常量表数据错误
				map.put("msg", "error");
				map.put("success", false);
			}
		} catch (Exception e) {
			map.put("msg", "error");
			map.put("success", false);
		}	
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/saveJointDebugChange.do")
	public void saveJointDebugChange(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Object[] objs = this.transFormToObj(request, new Class[] {AigaJointDebugChange.class });
		Boolean result = false;
		Map<String,Object> map = new HashMap<String,Object>();
		if(objs!=null && objs.length==1){
			if (objs[0] instanceof AigaJointDebugChange) {
				try {
					AigaJointDebugChange change=(AigaJointDebugChange)objs[0];
					if(change.getChangeId()==null){//新增
						change.setCreateTime(new Timestamp(System.currentTimeMillis()));//设置创建时间
						AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
						change.setCreatorId(Integer.parseInt(String.valueOf(user.getUserId())));//创建人ID
						change.setCreatorName(user.getUserName());//创建人名称
						aigaJointDebugSV.saveAigaJointDebugChange(change);
						result = true;
						map.put("success", result);
					}else{//修改
						aigaJointDebugSV.saveAigaJointDebugChange(change);
						result = true;
						map.put("success", result);
					}
				} catch (Exception e) {
					map.put("msg", "保存数据失败!");
					result = false;
					map.put("success", result);
				}	
			}
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	
	@RequestMapping("/getJointDebugChangeByChangeTag.do")
	public void getJointDebugChangeByChangeTag(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String changeTag=request.getParameter("changeTag");
		String HQL="FROM AigaJointDebugChange  where 1=1 ";
		if(changeTag!=null && !changeTag.equals(""))HQL+=" and changeTag= '"+ changeTag+"'";
		AigaJointDebugChange[] aigaJointDebugChanges = aigaJointDebugSV.getAigaJointDebugChange(HQL);
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (aigaJointDebugChanges.length == 1) {
			JSON json =JSONObject.fromObject(aigaJointDebugChanges[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/saveRChangeCase.do")
	public void saveRChangeCase(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Boolean result = false;
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String caseIdsTemp =  request.getParameter("caseIds");
			String changeId = request.getParameter("changeId");
			String[] caseIds = caseIdsTemp.split(",");
			for(String caseId:caseIds){
				AigaRGroupChangeCase rGroupChangeCase = new AigaRGroupChangeCase();
				rGroupChangeCase.setCaseId(Integer.parseInt(caseId));
				rGroupChangeCase.setChangeId(Integer.parseInt(changeId));
				aigaJointDebugSV.saveAigaRGroupChangeCase(rGroupChangeCase);
			}
			result = true;
			map.put("success", result);
		} catch (Exception e) {
			map.put("msg", "保存数据失败!");
			result = false;
			map.put("success", result);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
}

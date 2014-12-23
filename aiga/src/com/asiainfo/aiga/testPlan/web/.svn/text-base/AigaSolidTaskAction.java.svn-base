package com.asiainfo.aiga.testPlan.web;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.service.ICommonPageinationSV;
import com.asiainfo.aiga.testPlan.service.IAigaTestPlanSV;

/**
 * Created on 2014-10-28
 * <p>Description: [固化任务]</p>
 */
@Controller
public class AigaSolidTaskAction extends BaseAction {
	private static Logger logger = Logger.getLogger(AigaSolidTaskAction.class);
	@Resource(name = "testPlanSV")
	private IAigaTestPlanSV testPlanSV;
	

	@Resource(name="commonPageinationSV")
	private ICommonPageinationSV commonPageinationSV;
	@RequestMapping("/getSolidTaskForm.do")
	public void getSolidTaskForm(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String taskId = request.getParameter("taskId");
		//清空数据
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		if (taskId != null && !taskId.equals("")){
			List<Object> solidTaskList = testPlanSV.getObjectByHQL("FROM AigaSolidTask where taskId="+ taskId +" ORDER BY createTime DESC");
		map.put("success", false);
		if (solidTaskList.size() == 1) {
			JSON json=JSONObject.fromObject(solidTaskList.get(0), jsonConfig);
			logger.info(json);
			map.put("data", json);
			map.put("success", true);
		}
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping(value = "/getTestSolidListByPlanId.do")
	public void getTestSolidListByPlanId(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String planId=request.getParameter("planId");
		JSONArray json=new JSONArray();
		if(NaNull(planId)){
				String HQL = "From AigaSolidTask where planId ="+ sqlFilter(planId) + " ORDER BY createTime DESC";
				List<Object> list = testPlanSV.getObjectByHQL(HQL);
				json = JSONArray.fromObject(list, this.jsonConfig);
		}
		ActionHelper.returnResponseApplicatonJson(request, response, json);
	}
	
	@RequestMapping(value = "/getTestSolidList.do")
	public void getTestSolidList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String planName = request.getParameter("planName");
		String planTag = request.getParameter("planTag");
		String taskType = request.getParameter("taskType");
		String submitStaffId = request.getParameter("submitStaffId");
		String codeCommitDate = request.getParameter("codeCommitDate");
		String factCompleteTime = request.getParameter("factCompleteTime");
		String reqTime = request.getParameter("reqTime");
		String flag = request.getParameter("flag");
		String bigType=request.getParameter("bigType");
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String HQL = "From AigaSolidTask where 1=1";
		if(StringUtils.isNotBlank(flag)&&"close".equals(flag)){
			HQL += " and taskStatus<> -1";
		}
		if(planName!=null&&!planName.trim().equals("")){
			HQL += " and planName like '%"+this.decodeCN(planName)+"%'";
		}
		if(planTag!=null&&!planTag.trim().equals("")){
			HQL += " and planTag like '%"+planTag+"%'";
		}
		if(taskType!=null&&!taskType.trim().equals("")&&!taskType.equals("undefined")){
			HQL += " and taskType='"+this.decodeCN(taskType)+"'";
		}
		if(submitStaffId!=null&&!submitStaffId.trim().equals("")){
			HQL += " and submitStaffId='"+submitStaffId+"'";
		}
		if(codeCommitDate!=null&&!codeCommitDate.trim().equals("")){
			HQL += " and codeCommitDate=to_date('"+codeCommitDate.substring(0,10)+"','yyyy-MM-dd')";
		}
		if(factCompleteTime!=null&&!factCompleteTime.trim().equals("")){
			HQL += " and factCompleteTime=to_date('"+factCompleteTime.substring(0,10)+"','yyyy-MM-dd')";
		}
		if(reqTime!=null&&!reqTime.trim().equals("")){
			HQL += " and reqTime=to_date('"+reqTime.substring(0,10)+"','yyyy-MM-dd')";
		}
		if(bigType!=null&&!bigType.trim().equals("")){
			HQL +=" and bigType="+bigType;
		}
		String sort = request.getParameter("sort");//获取前台排序参数
		if(sort!=null&&!sort.equals("")){
			JSONArray jsonArray = JSONArray.fromObject(sort);
			JSONObject jsonObjw = jsonArray.getJSONObject(0);
			String property= jsonObjw.getString("property");//排序字段
			String direction= jsonObjw.getString("direction");//排序方式
			HQL += " ORDER BY "+property+" "+direction+" ";
		}else{
			HQL += " ORDER BY taskId DESC ,createTime DESC";
		}
		logger.info(HQL);
		JSONArray json=new JSONArray();
		//List<Object> list = testPlanSV.getObjectByHQL(HQL);
		List<Object> list = commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
		json = JSONArray.fromObject(list, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(HQL));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	@RequestMapping(value = "/saveSolidTaskTypeList.do")
	public void saveSolidTaskTypeList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
	}
	@RequestMapping(value = "/getSolidTaskTypeList.do")
	public void getSolidTaskTypeList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
	}
	@RequestMapping(value = "/getSolidTaskTypeForm.do")
	public void getSolidTaskTypeForm(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
	}
}

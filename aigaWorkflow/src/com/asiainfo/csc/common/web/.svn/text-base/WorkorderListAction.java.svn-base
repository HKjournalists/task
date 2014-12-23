package com.asiainfo.csc.common.web;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.common.ivalues.IBOWorkorderListValue;
import com.asiainfo.csc.common.service.interfaces.IWorkorderSV;
import com.asiainfo.csc.common.vo.Workorder;

public class WorkorderListAction extends BaseAction {

	public void getDoWorkorderListTree(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
		String staffId = request.getParameter("staffId");
		String status = request.getParameter("status");
		Integer start = Integer.valueOf(request.getParameter("start"));
		Integer limit = Integer.valueOf(request.getParameter("limit"));
		String sort = request.getParameter("sort");//获取前台排序参数
		String property= null;
		String direction= null;
		if(sort!=null&&!sort.equals("")){
			JSONArray jsonArray = JSONArray.fromObject(sort);
			JSONObject jsonObjw = jsonArray.getJSONObject(0);
			property= jsonObjw.getString("property");//排序字段
			direction= jsonObjw.getString("direction");//排序方式
		}
		if(staffId==null||staffId.equals(""))
			throw new Exception("缺少staffId参数");
		IWorkorderSV workorderSV = (IWorkorderSV)ServiceFactory.getService(IWorkorderSV.class);
		IBOWorkorderListValue[] workorderList = workorderSV.queryWorkorderList(Long.valueOf(staffId), status,start+1,start+limit,property,direction);
		int total = workorderSV.countWorkorderList(staffId, status);
		List<Workorder> list = new ArrayList<Workorder>();
		for(IBOWorkorderListValue workorder : workorderList){
			Workorder order = new Workorder();
			order.setCreateTime(new SimpleDateFormat("yyyy-MM-dd").format(workorder.getCreateTime()));
			order.setAdviceCompTime(workorder.getAdviceCompTime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(workorder.getAdviceCompTime()));
			order.setFactCompleteTime(workorder.getFactCompleteTime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(workorder.getFactCompleteTime()));
			order.setExecStaffId(workorder.getExecStaffId());
			order.setLinkNo(workorder.getLinkNo());
			order.setObjId(workorder.getObjId());
			order.setObjName(workorder.getObjName());
			order.setObjTag(workorder.getObjTag());
			order.setObjType(workorder.getObjType());
			order.setOrderId(workorder.getOrderId());
			order.setOrderType(workorder.getOrderType());
			order.setStatus(workorder.getStatus());
			order.setSubmitStaffName(workorder.getSubmitStaffName());
			order.setTemplateId(workorder.getTemplateId());
			order.setVmTaskName(workorder.getVmTaskName());
			list.add(order);
		}
		
		JSONArray object = JSONArray.fromArray(list.toArray());
		JSONObject result = new JSONObject();
		result.put("total", total);
		result.put("data", object);
		response.setContentType("application/Json;charset=UTF-8");
		response.getWriter().write(URLEncoder.encode(result.toString(),"UTF-8"));
	}
	
	public void getHisToryTrack(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
		String objId = request.getParameter("objId");
		String objType = request.getParameter("objType");
		if(objId==null||objId.equals("")||objType==null||objType.equals(""))
			throw new Exception("缺少objId或objType参数");
		IWorkorderSV workorderSV = (IWorkorderSV)ServiceFactory.getService(IWorkorderSV.class);
		IBOWorkorderListValue[] workorderList = workorderSV.getHisToryTrack(objId, objType);
		List<Workorder> list = new ArrayList<Workorder>();
		for(IBOWorkorderListValue workorder : workorderList){
			Workorder order = new Workorder();
			order.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(workorder.getCreateTime()));
			order.setExecStaffId(workorder.getExecStaffId());
			order.setLinkNo(workorder.getLinkNo());
			order.setObjId(workorder.getObjId());
			order.setObjName(workorder.getObjName());
			order.setObjTag(workorder.getObjTag());
			order.setObjType(workorder.getObjType());
			order.setOrderId(workorder.getOrderId());
			order.setOrderType(workorder.getOrderType());
			order.setStatus(workorder.getStatus());
			order.setSubmitStaffName(workorder.getSubmitStaffName());
			order.setTemplateId(workorder.getTemplateId());
			order.setVmTaskName(workorder.getVmTaskName());
			order.setOpinion(workorder.getOpinion());
			order.setOperator(workorder.getEmployeeName());
			if(workorder.getFinishTime()!=null && !workorder.getFinishTime().equals(""))
				order.setFinishTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(workorder.getFinishTime()));
			else {
				order.setFinishTime("");
			}
			list.add(order);
		}
		
		JSONArray object = JSONArray.fromArray(list.toArray());
		response.setContentType("application/Json;charset=UTF-8");
		response.getWriter().write(URLEncoder.encode(object.toString(),"UTF-8"));
	}
	
	public void getWorkorderDoneList(HttpServletRequest request,HttpServletResponse response)throws Exception{
		String name = new String((request.getParameter("name")==null?"":request.getParameter("name")).getBytes("ISO-8859-1"),"UTF-8");
		String objType = request.getParameter("objType");
		String createTime = request.getParameter("createTime");
		String staffId = request.getParameter("staffId");
		Integer start = Integer.valueOf(request.getParameter("start"));
		Integer limit = Integer.valueOf(request.getParameter("limit"));
		String sort = request.getParameter("sort");//获取前台排序参数
		String property= null;
		String direction= null;
		if(sort!=null&&!sort.equals("")){
			JSONArray jsonArray = JSONArray.fromObject(sort);
			JSONObject jsonObjw = jsonArray.getJSONObject(0);
			property= jsonObjw.getString("property");//排序字段
			direction= jsonObjw.getString("direction");//排序方式
		}
		IWorkorderSV workorderSV = (IWorkorderSV)ServiceFactory.getService(IWorkorderSV.class);
		Criteria sql = workorderSV.getCriteria(objType, staffId, name, null, null, createTime, null);
		//sql.addEqual(IBOWorkorderListValue.S_Status, "3");
		sql.addIn(IBOWorkorderListValue.S_Status, new int[]{-1,3});//-1为强制关闭的工单
		String condition = "";
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
		IBOWorkorderListValue[] workorderListValues = workorderSV.getWorkOrderListByCon(sql.toString()+condition, sql.getParameters(),start+1,start+limit);
		int total = workorderSV.getWorkOrderListByConCount(sql.toString(), sql.getParameters());
		List<Workorder> list = new ArrayList<Workorder>();
		for(IBOWorkorderListValue workorder : workorderListValues){
			Workorder order = new Workorder();
			order.setCreateTime(new SimpleDateFormat("yyyy-MM-dd").format(workorder.getCreateTime()));
			order.setExecStaffId(workorder.getExecStaffId());
			order.setLinkNo(workorder.getLinkNo());
			order.setObjId(workorder.getObjId());
			order.setObjName(workorder.getObjName());
			order.setObjTag(workorder.getObjTag());
			order.setObjType(workorder.getObjType());
			order.setOrderId(workorder.getOrderId());
			order.setOrderType(workorder.getOrderType());
			order.setStatus(workorder.getStatus());
			order.setSubmitStaffName(workorder.getSubmitStaffName());
			order.setTemplateId(workorder.getTemplateId());
			order.setVmTaskName(workorder.getVmTaskName());
			order.setOpinion(workorder.getOpinion());
			order.setOperator(workorder.getEmployeeName());
			if(workorder.getFinishTime()!=null && !workorder.getFinishTime().equals(""))
				order.setFinishTime(new SimpleDateFormat("yyyy-MM-dd").format(workorder.getFinishTime()));
			else {
				order.setFinishTime("");
			}
			list.add(order);
		}
		
		JSONArray object = JSONArray.fromArray(list.toArray());
		JSONObject result = new JSONObject();
		result.put("total", total);
		result.put("data", object);
		response.setContentType("application/Json;charset=UTF-8");
		response.getWriter().write(URLEncoder.encode(result.toString(),"UTF-8"));
	}
}

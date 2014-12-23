package com.asiainfo.aiga.statistics.web;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.common.service.ICommonPageinationSV;
import com.asiainfo.aiga.statistics.bo.AigaMonthDelSla;
import com.asiainfo.aiga.statistics.bo.AigaMonthRepKpi;
import com.asiainfo.aiga.statistics.bo.AigaMonthRunKpi;
import com.asiainfo.aiga.statistics.bo.StatAutoCover;
import com.asiainfo.aiga.statistics.bo.StatGrid;
import com.asiainfo.aiga.statistics.bo.StatGridColumns;
import com.asiainfo.aiga.statistics.bo.StatKpiTarget;
import com.asiainfo.aiga.statistics.bo.StatSlaNormI;
import com.asiainfo.aiga.statistics.service.IStatisticsSV;
import com.asiainfo.aiga.testPlan.bo.AigaTestPlan;
/**
 * Created on 2014-10-10
 * <p>Description: [统计分析Action]</p>
 */
@Controller
public class AigaStatisticsAction extends BaseAction{
	private static Logger logger = Logger.getLogger(AigaStatisticsAction.class);
	@Resource(name="statisticSV")
	private IStatisticsSV iStatisticsSV;
	
	@Resource(name="commonPageinationSV")
	private ICommonPageinationSV commonPageinationSV;
	
	@RequestMapping(value="/statMonthOneLevelKpiFunsionCharts.do")
	public void statMonthOneLevelKpiFunsionCharts(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			String json =iStatisticsSV.statMonthOneLevelKpiFunsionCharts(startDate,endDate);
			map.put("data", json);
			map.put("success", true);
		} catch (Exception e) {
			this.setPostInfo("success", false);
		} finally {
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	
	@RequestMapping(value="/statMonthOneLevelKpiList.do")
	public void statMonthOneLevelKpiList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONObject json=new JSONObject();
		Map map=new HashMap();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			Map<String,Integer> paginationParams=this.paginationParams(request);
			String HQL="From StatMonthOneLevelKpi t where 1=1";
			HQL+=" and to_date(t.reportMonth,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM')" ;
			logger.info(HQL);
			List statSlaNormIList =commonPageinationSV.getObjectList(paginationParams.get(PAGE_PARAM), paginationParams.get(LIMIT_PARAM), HQL);
			map.put("data", statSlaNormIList);
			map.put("total", commonPageinationSV.getTotal(HQL));
			map.put("success", true);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			ActionHelper.returnResponseJsonMap(request, response, map);
		}
	}
	@RequestMapping(value="/statMonthTwoLEffKpiFunsionCharts.do")
	public void statMonthTwoLEffKpiFunsionCharts(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			String json =iStatisticsSV.statMonthTwoLEffKpiFunsionCharts(startDate,endDate);
			map.put("data", json);
			map.put("success", true);
		} catch (Exception e) {
			this.setPostInfo("success", false);
		} finally {
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	
	@RequestMapping(value="/statMonthTwoLEffKpiList.do")
	public void statMonthTwoLEffKpiList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONObject json=new JSONObject();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			Map<String,Integer> paginationParams=this.paginationParams(request);
			json =iStatisticsSV.statMonthTwoLEffKpiList(startDate,endDate,paginationParams.get(PAGE_PARAM),paginationParams.get(START_PARAM),paginationParams.get(LIMIT_PARAM));
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			ActionHelper.responseData4JSON(request, response, json);
		}
	}
	@RequestMapping(value="/statMonthTwoLCapacityKpiFunsionCharts.do")
	public void statMonthTwoLCapacityKpiFunsionCharts(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			String json =iStatisticsSV.statMonthTwoLCapacityKpiFunsionCharts(startDate,endDate);
			map.put("data", json);
			map.put("success", true);
		} catch (Exception e) {
			this.setPostInfo("success", false);
		} finally {
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	@RequestMapping(value="/statMonthTwoLQualityKpiFunsionCharts.do")
	public void statMonthTwoLQualityKpiFunsionCharts(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			String json =iStatisticsSV.statMonthTwoLQualityKpiFunsionCharts(startDate,endDate);
			map.put("data", json);
			map.put("success", true);
		} catch (Exception e) {
			this.setPostInfo("success", false);
		} finally {
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	@RequestMapping(value="/statMonthTwoLQualityKpiList.do")
	public void statMonthTwoLQualityKpiList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONObject json=new JSONObject();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			Map<String,Integer> paginationParams=this.paginationParams(request);
			json =iStatisticsSV.statMonthTwoLQualityKpiList(startDate,endDate,paginationParams.get(PAGE_PARAM),paginationParams.get(START_PARAM),paginationParams.get(LIMIT_PARAM));
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			ActionHelper.responseData4JSON(request, response, json);
		}
	}
	@RequestMapping(value="/statMonthTwoLCapacityKpiList.do")
	public void statMonthTwoLCapacityKpiList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONObject json=new JSONObject();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			Map<String,Integer> paginationParams=this.paginationParams(request);
			json =iStatisticsSV.statMonthTwoLCapacityKpiList(startDate,endDate,paginationParams.get(PAGE_PARAM),paginationParams.get(START_PARAM),paginationParams.get(LIMIT_PARAM));
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			ActionHelper.responseData4JSON(request, response, json);
		}
	}
	@RequestMapping("/saveMonthRunKpi.do")
	public void saveMonthRunKpi(HttpServletRequest request,HttpServletResponse response) throws Exception {
		try{
			Object[] value = this.transFormToObj(request, new Class[]{AigaMonthRunKpi.class});
			if(value!=null&&value.length==1)
				if(value[0] instanceof AigaMonthRunKpi){
					iStatisticsSV.saveAigaKpi((AigaMonthRunKpi)value[0]);
				}
			this.setPostInfo("success", true);
			this.setPostInfo("message", "保存成功");
		}
		catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping("/getMonthRunKpiList.do")
	public void getMonthRunKpiList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String kpiName = request.getParameter("kpiName");
		StringBuffer querySql = new StringBuffer("FROM AigaMonthRunKpi a WHERE 1=1 ");
		querySql.append((kpiName!=null&&!kpiName.equals("")&&!kpiName.equals("null")&&!kpiName.equals("undefined"))?" and a.kpiName like '%"+this.decodeCN(kpiName)+"%'":"");//kpi名称
		querySql.append("and a.kpiStatus=1 ");
		List<Object> aigaMonthRunKpiList= commonPageinationSV.getObjectList(pageNo, pageSize, querySql.toString());
		json = JSONArray.fromObject(aigaMonthRunKpiList, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	@RequestMapping(value="/getMonthRunKpiByKpiId.do")
	public void getMonthRunKpiByKpiId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String kpiId = request.getParameter("kpiId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((kpiId!=null&&!kpiId.equals(""))?" and a.kpiId = "+kpiId+"":"");//功能点ID
		AigaMonthRunKpi[] aigaMonthRunKpis =iStatisticsSV.getAigaMonthRunKpi("FROM AigaMonthRunKpi a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (aigaMonthRunKpis.length == 1) {
			JSON json =JSONObject.fromObject(aigaMonthRunKpis[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/deleteMonthRunKpiBykpiId.do")
	public void deleteMonthRunKpiBykpiId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String kpiId = request.getParameter("kpiId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((kpiId!=null&&!kpiId.equals(""))?" and a.kpiId = "+kpiId+"":"");//功能点ID
		AigaMonthRunKpi[] aigaMonthRunKpis =iStatisticsSV.getAigaMonthRunKpi("FROM AigaMonthRunKpi a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		if(aigaMonthRunKpis.length==1){
			aigaMonthRunKpis[0].setKpiStatus((short)0);
			try{
				iStatisticsSV.saveAigaKpi(aigaMonthRunKpis[0]);
				map.put("success", true);
			}
			catch(Exception e){
				map.put("success", false);
			}
		}else{
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping(value="/getMonthDelSlaList.do")
	public void getMonthDelSlaList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String slaName = request.getParameter("slaName");
		String targetAttention = request.getParameter("targetAttention");
		String responsiblePerson = request.getParameter("responsiblePerson");
		StringBuffer querySql = new StringBuffer("FROM AigaMonthDelSla a WHERE 1=1 ");
		querySql.append((slaName!=null&&!slaName.equals("")&&!slaName.equals("null")&&!slaName.equals("undefined"))?" and a.slaName like '%"+this.decodeCN(slaName)+"%'":"");//SLA名称
		querySql.append((targetAttention!=null&&!targetAttention.equals("")&&!targetAttention.equals("null")&&!targetAttention.equals("undefined"))?" and a.targetAttention like '%"+this.decodeCN(targetAttention)+"%'":"");//指标关注
		querySql.append((responsiblePerson!=null&&!responsiblePerson.equals("")&&!responsiblePerson.equals("null")&&!responsiblePerson.equals("undefined"))?" and a.responsiblePerson like '%"+this.decodeCN(responsiblePerson)+"%'":"");//指标负责人
		querySql.append("and a.slaStatus=1 ");
		List<Object> aigaMonthDelSlaList= commonPageinationSV.getObjectList(pageNo, pageSize, querySql.toString());
		json = JSONArray.fromObject(aigaMonthDelSlaList, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	@RequestMapping(value="/saveMonthDelSla.do")
	public void saveMonthDelSla(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			Object[] value = this.transFormToObj(request, new Class[]{AigaMonthDelSla.class});
			if(value!=null&&value.length==1)
				if(value[0] instanceof AigaMonthDelSla){
					iStatisticsSV.saveAigaMonthDelSla((AigaMonthDelSla)value[0]);
				}
			this.setPostInfo("success", true);
			this.setPostInfo("message", "保存成功");
		}
		catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/getMonthDelSlaBySlaId.do")
	public void getMonthDelSlaBySlaId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String slaId = request.getParameter("slaId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((slaId!=null&&!slaId.equals(""))?" and a.slaId = "+slaId+"":"");//功能点ID
		AigaMonthDelSla[] aigaMonthDelSlas =iStatisticsSV.getAigaMonthDelSla("FROM AigaMonthDelSla a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (aigaMonthDelSlas.length == 1) {
			JSON json =JSONObject.fromObject(aigaMonthDelSlas[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	public void getTaskForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String kpiId = request.getParameter("kpiId");
		AigaMonthRunKpi kpi = new AigaMonthRunKpi();
		if (kpiId != null && !kpiId.equals("")) {
			List<Object> kpiList = iStatisticsSV.getObjectByHQL("FROM AigaMonthRunKpi WHERE kpiId=" + kpiId +" ORDER BY createTime DESC");
			if (kpiList.size() == 1) {
				kpi = (AigaMonthRunKpi) kpiList.get(0);

			}
		}
		this.setFormData(kpi);
		this.postInfo(request, response);
	}
	@RequestMapping(value="/deleteMonthDelSlaBySlaId.do")
	public void deleteMonthDelSlaBySlaId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String slaId = request.getParameter("slaId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((slaId!=null&&!slaId.equals(""))?" and a.slaId = "+slaId+"":"");//功能点ID
		AigaMonthDelSla[] aigaMonthDelSlas =iStatisticsSV.getAigaMonthDelSla("FROM AigaMonthDelSla a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		if(aigaMonthDelSlas.length==1){
			aigaMonthDelSlas[0].setSlaStatus((short)0);
			try{
				iStatisticsSV.saveAigaMonthDelSla(aigaMonthDelSlas[0]);
				map.put("success", true);
			}
			catch(Exception e){
				map.put("success", false);
			}
		}else{
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}

	
	@RequestMapping(value="/getGroupComBox.do")
	public void getGroupComBox(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject json = new JSONObject();
		String querySql = "select distinct t.group_name,t.group_id from stat_month_test_group_kpi t";
		json.put("success", true);
		json.put("data", iStatisticsSV.getGroupComBox(querySql));
		ActionHelper.responseData4JSON(request, response, json);
	}

	@RequestMapping(value="/getMonthRepKpiByKpiId.do")
	public void getMonthRepKpiByKpiId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String kpiId = request.getParameter("kpiId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((kpiId!=null&&!kpiId.equals(""))?" and a.kpiId = "+kpiId+"":"");//功能点ID
		AigaMonthRepKpi[] aigaMonthRepKpis =iStatisticsSV.getAigaMonthRepKpi("FROM AigaMonthRepKpi a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (aigaMonthRepKpis.length == 1) {
			JSON json =JSONObject.fromObject(aigaMonthRepKpis[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping(value="/saveMonthRepKpi.do")
	public void saveMonthRepKpi(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			Object[] value = this.transFormToObj(request, new Class[]{AigaMonthRepKpi.class});
			if(value!=null&&value.length==1)
				if(value[0] instanceof AigaMonthRepKpi){
					iStatisticsSV.saveAigaMonthRepKpi((AigaMonthRepKpi)value[0]);
				}
			this.setPostInfo("success", true);
			this.setPostInfo("message", "保存成功");
		}
		catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping(value="/getMonthRepKpiList.do")
	public void getMonthRepKpiList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String kpiName = request.getParameter("kpiName");
		StringBuffer querySql = new StringBuffer("FROM AigaMonthRepKpi a WHERE 1=1 ");
		querySql.append((kpiName!=null&&!kpiName.equals("")&&!kpiName.equals("null")&&!kpiName.equals("undefined"))?" and a.kpiName like '%"+this.decodeCN(kpiName)+"%'":"");//SLA名称
		querySql.append("and a.kpiStatus=1 ");
		List<Object> aigaMonthRepKpiList= commonPageinationSV.getObjectList(pageNo, pageSize, querySql.toString());
		json = JSONArray.fromObject(aigaMonthRepKpiList, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	@RequestMapping(value="/deleteMonthRepKpiByKpiId.do")
	public void deleteMonthRepKpiByKpiId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String kpiId = request.getParameter("kpiId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((kpiId!=null&&!kpiId.equals(""))?" and a.kpiId = "+kpiId+"":"");//功能点ID
		AigaMonthRepKpi[] aigaMonthRepKpis =iStatisticsSV.getAigaMonthRepKpi("FROM AigaMonthRepKpi a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		if(aigaMonthRepKpis.length==1){
			aigaMonthRepKpis[0].setKpiStatus((short)0);
			try{
				iStatisticsSV.saveAigaMonthRepKpi(aigaMonthRepKpis[0]);
				map.put("success", true);
			}
			catch(Exception e){
				map.put("success", false);
			}
		}else{
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}

	@RequestMapping(value="/saveStatKpiTarget.do")
	public void saveStatKpiTarget(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		try{
			Object[] value = this.transFormToObj(request, new Class[]{StatKpiTarget.class});
			if(value!=null&&value.length==1)
				if(value[0] instanceof StatKpiTarget){
					StatKpiTarget temp=(StatKpiTarget)value[0];
					temp.setKpiId(null);
					iStatisticsSV.saveStatKpiTarget(temp);
				}
			map.put("success", true);
		}
		catch(Exception e){
			map.put("success", false);
		}finally{
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	@RequestMapping(value="/getStatKpiTargetList.do")
	public void getStatKpiTargetList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String kpiName = request.getParameter("kpiName");
		String kpiType = request.getParameter("kpiType");
		String targetType = request.getParameter("targetType");
		StringBuffer querySql = new StringBuffer("FROM StatKpiTarget a WHERE 1=1 ");
		querySql.append((kpiName!=null&&!kpiName.equals("")&&!kpiName.equals("null")&&!kpiName.equals("undefined"))?" and a.kpiName like '%"+this.decodeCN(kpiName).trim()+"%'":"");//KPI名称
		querySql.append((kpiType!=null&&!kpiType.equals("")&&!kpiType.equals("null")&&!kpiType.equals("undefined"))?" and a.kpiType='"+this.decodeCN(kpiType)+"'":"");//KPI类型
		querySql.append((targetType!=null&&!targetType.equals("")&&!targetType.equals("null")&&!targetType.equals("undefined"))?" and a.targetType='"+this.decodeCN(targetType)+"'":"");//指标类型
		querySql.append("and a.kpiStatus=1 order by a.changeTime desc");
		List<Object> statKpiTargetList= commonPageinationSV.getObjectList(pageNo, pageSize, querySql.toString());
		json = JSONArray.fromObject(statKpiTargetList, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	@RequestMapping(value="/getStatKpiTargetByKpiId.do")
	public void getStatKpiTargetByKpiId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String kpiId = request.getParameter("kpiId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((kpiId!=null&&!kpiId.equals(""))?" and a.kpiId = "+kpiId+"":"");//功能点ID
		StatKpiTarget[] statKpiTargets =iStatisticsSV.getStatKpiTarget("FROM StatKpiTarget a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (statKpiTargets.length == 1) {
			JSON json =JSONObject.fromObject(statKpiTargets[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping(value="/getStatKpiTargetByKpiUuid.do")
	public void getStatKpiTargetByKpiUuid(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String kpiUuid = request.getParameter("kpiUuid");
		String kpiName = request.getParameter("kpiName");
		String kpiType = request.getParameter("kpiType");
		String targetType = request.getParameter("targetType");
		StringBuffer conditionBuffer = new StringBuffer();
		JSONArray json=new JSONArray();
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if(kpiName!=null&&!kpiName.equals("")&&!kpiName.equals("null")&&!kpiName.equals("undefined")){
			conditionBuffer.append(" and a.kpiName like '%"+this.decodeCN(kpiName).trim()+"%'");//KPI名称
		}
		if(kpiType!=null&&!kpiType.equals("")&&!kpiType.equals("null")&&!kpiType.equals("undefined")){
			conditionBuffer.append(" and a.kpiType='"+this.decodeCN(kpiType)+"'");//KPI类型
		}
		if(targetType!=null&&!targetType.equals("")&&!targetType.equals("null")&&!targetType.equals("undefined")){
			conditionBuffer.append(" and a.targetType='"+this.decodeCN(targetType)+"'");//指标类型
		}
		if((kpiUuid!=null&&!kpiUuid.equals(""))){
		conditionBuffer.append((kpiUuid!=null&&!kpiUuid.equals(""))?" and a.kpiUuid = "+kpiUuid+"":"");//历史kpiID
		}
		conditionBuffer.append(" order by a.changeTime desc");//历史kpiID
		StatKpiTarget[] statKpiTargets =iStatisticsSV.getStatKpiTarget("FROM StatKpiTarget a where 1=1 "+conditionBuffer.toString());
		json = JSONArray.fromObject(statKpiTargets, jsonConfig);
		map.put("data", json);
		map.put("success", true);
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping(value="/deleteStatKpiTargetByKpiId.do")
	public void deleteStatKpiTargetByKpiId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String kpiId = request.getParameter("kpiId");
		Map map=new HashMap();
		StringBuffer conditionBuffer = new StringBuffer();
		if((kpiId!=null&&!kpiId.equals(""))){
			boolean statKpiTargets =iStatisticsSV.updateBySQL("update STAT_KPI_TARGET set KPI_STATUS =0 where kpi_Id="+kpiId);
			map.put("success", statKpiTargets);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping(value="/getStatKpiTargetHistoryList.do")
	public void getStatKpiTargetHistoryList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		Map map=this.paginationParams(request);
		String kpiName = request.getParameter("kpiName");
		String kpiType = request.getParameter("kpiType");
		String targetType = request.getParameter("targetType");
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		StringBuffer querySql = new StringBuffer("FROM StatKpiTarget a WHERE 1=1 ");
		if(kpiName!=null&&!kpiName.equals("")&&!kpiName.equals("null")&&!kpiName.equals("undefined")){
			querySql.append(" and a.kpiName like '%"+this.decodeCN(kpiName).trim()+"%'");//KPI名称
		}
		if(kpiType!=null&&!kpiType.equals("")&&!kpiType.equals("null")&&!kpiType.equals("undefined")){
			querySql.append(" and a.kpiType='"+this.decodeCN(kpiType)+"'");//KPI类型
		}
		if(targetType!=null&&!targetType.equals("")&&!targetType.equals("null")&&!targetType.equals("undefined")){
			querySql.append(" and a.targetType='"+this.decodeCN(targetType)+"'");//指标类型
		}
		querySql.append("and a.kpiStatus=0 order by a.changeTime desc");
		List<Object> statKpiTargetHistoryList= commonPageinationSV.getObjectList(pageNo, pageSize, querySql.toString());
		json = JSONArray.fromObject(statKpiTargetHistoryList, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}

	@RequestMapping(value="/StatSlaNormIFunsionCharts.do")
	public void StatSlaNormIFunsionCharts(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			String json =iStatisticsSV.statMonthOneLevelKpiFunsionCharts(startDate,endDate);
			map.put("data", json);
			map.put("success", true);
		} catch (Exception e) {
			this.setPostInfo("success", false);
		} finally {
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	@RequestMapping(value="/StatSlaNormIList.do")
	public void StatSlaNormIList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONObject json=new JSONObject();
		Map map=new HashMap();
		try {
			String searchReqType=request.getParameter("searchReqType");
			String searchBigType=request.getParameter("searchBigType");
			String plFactCompleteTime=request.getParameter("plFactCompleteTime");
			Map<String,Integer> paginationParams=this.paginationParams(request);
			String HQL="From com.asiainfo.aiga.statistics.bo.StatSlaNormI ssni,AigaTestPlan atp where ssni.planId=atp.planId ";
			if(this.NaNull(searchBigType))HQL+="and atp.bigType="+searchBigType;
			if(this.NaNull(searchReqType))HQL+="";
			if(this.NaNull(plFactCompleteTime))HQL+=" and  to_char(atp.factCompleteTime,'YYYY-MM-DD')= '"+plFactCompleteTime+"' ";
			logger.info(HQL);
			List statSlaNormIList =commonPageinationSV.getObjectList(paginationParams.get(PAGE_PARAM), paginationParams.get(LIMIT_PARAM), HQL);
			JSONArray jsonArray=new JSONArray();
			for(int i=0,n=statSlaNormIList.size();i<n;i++){
				Object[] objs=(Object[])statSlaNormIList.get(i);
				String planFactCompleteTime="";
				if(objs[1] instanceof AigaTestPlan){
					Timestamp t= ((AigaTestPlan)objs[1]).getFactCompleteTime();
					if(t!=null)planFactCompleteTime=CommonHelper.dateToString(t,"yyyy-MM-dd");
							};
				if(objs[0] instanceof StatSlaNormI){
					JSONObject tempJSON=JSONObject.fromObject(objs[0],this.jsonConfig);
					tempJSON.put("factCompleteTime", planFactCompleteTime);
					jsonArray.add(tempJSON);
					}
				
			}
			map.put("data", jsonArray);
			map.put("success", true);
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			ActionHelper.returnResponseJsonMap(request, response, map);
		}
	}
	@RequestMapping(value="/submitStatisticsGridStore.do")
	public void submitStatisticsGridStore(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map map=new HashMap();
		String strStoreName=request.getParameter("stroeName");
		try {
			if (NaNull(strStoreName)) {
				Class onwClass = Class.forName(strStoreName);
				Object[] objs = this.transTableToObj(request, onwClass);
				List list=Arrays.asList(objs);
				iStatisticsSV.submitStatisticsGridStore(list);
				map.put("success", true);
			}
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			ActionHelper.returnResponseJsonMap(request, response, map);
		}
	}
	@RequestMapping(value="/delGridStore.do")
	public void delGridStore(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map map=new HashMap();
		String strStoreName=request.getParameter("stroeName");
		try {
			if (NaNull(strStoreName)) {
				Class onwClass = Class.forName(strStoreName);
				Object[] objs = this.transTableToObj(request, onwClass);
				List list=Arrays.asList(objs);
				iStatisticsSV.delGridStore(list);
				map.put("success", true);
			}
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			ActionHelper.returnResponseJsonMap(request, response, map);
		}
	}
	@RequestMapping(value="/statMonthTestGroupKpiList.do")
	public void statMonthTestGroupKpiList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject json=new JSONObject();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String groupId = request.getParameter("groupId");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			Map<String,Integer> paginationParams=this.paginationParams(request);
			json =iStatisticsSV.statMonthTestGroupKpiList(groupId,startDate,endDate,paginationParams.get(PAGE_PARAM),paginationParams.get(START_PARAM),paginationParams.get(LIMIT_PARAM));
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			ActionHelper.responseData4JSON(request, response, json);
		}
	}
	@RequestMapping(value="/statMonthTestGroupKpiFunsionCharts.do")
	public void statMonthTestGroupKpiFunsionCharts(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String groupId = request.getParameter("groupId");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			String json =iStatisticsSV.statMonthTestGroupKpiFunsionCharts(groupId,startDate,endDate);
			map.put("data", json);
			map.put("success", true);
		} catch (Exception e) {
			this.setPostInfo("success", false);
		} finally {
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	@RequestMapping(value="/getGroupComBoxForDev.do")
	public void getGroupComBoxForDev(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject json = new JSONObject();
		String querySql = "select distinct t.group_name,t.group_id from stat_month_dev_group_kpi t";
		json.put("success", true);
		json.put("data", iStatisticsSV.getGroupComBox(querySql));
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping(value="/statMonthDevGroupKpiList.do")
	public void statMonthDevGroupKpiList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject json=new JSONObject();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String groupId = request.getParameter("groupId");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			Map<String,Integer> paginationParams=this.paginationParams(request);
			json =iStatisticsSV.statMonthDevGroupKpiList(groupId,startDate,endDate,paginationParams.get(PAGE_PARAM),paginationParams.get(START_PARAM),paginationParams.get(LIMIT_PARAM));
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			ActionHelper.responseData4JSON(request, response, json);
		}
	}
	@RequestMapping(value="/statMonthDevGroupKpiFunsionCharts.do")
	public void statMonthDevGroupKpiFunsionCharts(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			String startDate=request.getParameter("startDate");
			String endDate=request.getParameter("endDate");
			String groupId = request.getParameter("groupId");
			String defaultDate=CommonHelper.dateToString(new java.util.Date(),"yyyy-MM");
			if(startDate==null||startDate.equals(""))startDate=defaultDate;
			if(endDate==null||endDate.equals(""))endDate=defaultDate;
			String json =iStatisticsSV.statMonthDevGroupKpiFunsionCharts(groupId,startDate,endDate);
			map.put("data", json);
			map.put("success", true);
		} catch (Exception e) {
			this.setPostInfo("success", false);
		} finally {
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	@RequestMapping(value="/statCommon.html")
	public void statCommon(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String classPath=request.getParameter("className");
		try{
			String initCondition=request.getParameter("initCondition");
			String initJSON=request.getParameter("initJSON");
			Map initValueMap=ActionHelper.parseJSON2Map(initJSON);
			
			String StatGridHQL="From StatGrid where rownum=1 and classPath='"+classPath+"'";
			@SuppressWarnings("unchecked")
			List<StatGrid> statGridObjList= iStatisticsSV.getObjectByHQL(StatGridHQL);
			if(statGridObjList==null||statGridObjList.size()!=1)throw new Exception("查不到"+classPath+"对象");
			String isEditor=request.getParameter("isEditor");
			if(isEditor!=null&&isEditor.equals("false")){
				statGridObjList.get(0).setEditPlugins("false");
			}
			String StatGridColumnsHQL="From StatGridColumns where parentId=0 and gridId="+statGridObjList.get(0).getGridId()+" order by columnIndex";
			@SuppressWarnings("unchecked")
			List<StatGridColumns> statGridColumnObjList= iStatisticsSV.getObjectByHQL(StatGridColumnsHQL);
			for(StatGridColumns statGridcolumns:statGridColumnObjList)setSubColumns(statGridcolumns);
			request.setAttribute("statGridObjList", statGridColumnObjList);
			String[] classPaths=classPath.split(",");
			int clazzsLength=classPaths.length;
			Class<?>[] clazzs=new Class[clazzsLength];
			for(int i=0;i<clazzsLength;i++){
				clazzs[i]=Class.forName(classPaths[i]);
			}
			Map<String,String> map= CommonHelper.getFieldsClassTypeMap(clazzs);
			request.setAttribute("statGridFieldMap",map);
			request.setAttribute("initValueMap",initValueMap);
			request.setAttribute("initCondition",initCondition);
			request.setAttribute("statGrid",statGridObjList.get(0));
		}catch (Exception e) {
			request.setAttribute("success", false);
			logger.error(e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
	
		ActionHelper.forwardPage(request, response, "aiga/statisticsChart/statCommon.jsp");
	}
	public void setSubColumns(StatGridColumns statGridColumns) throws Exception{
			String subHQL="From StatGridColumns where parentId="+statGridColumns.getColumnId();
			List<StatGridColumns> subColumns= iStatisticsSV.getObjectByHQL(subHQL);
			if(subColumns.size()==0)return;
			statGridColumns.setStatGridColumns(subColumns.toArray(new StatGridColumns[0]));
			for(StatGridColumns subSubcloumns:subColumns)setSubColumns(subSubcloumns);
	}
	@RequestMapping(value="/getstatisticsoBjectList.do")
	public void getstatisticsoBjectList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		String objName = request.getParameter("objName");
		String[] objNames=objName.split(",");
		Map map=this.paginationParams(request);
		Class<?>[] clazzs=new Class[]{Class.forName(objName)};
		Map<String,String> FieldMap=CommonHelper.getFieldsClassTypeMap(clazzs);
		Iterator<Map.Entry<String, String>> it=FieldMap.entrySet().iterator();
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		StringBuffer querySql = new StringBuffer("FROM "+objName+" a WHERE 1=1 ");
		while (it.hasNext()) {
			   Map.Entry<String, String> entry = it.next();
			   String key=entry.getKey();
			   String value=request.getParameter( key);
			   if(NaNull(value)){
				   querySql.append(" and ");
				   querySql.append(key);
				   if(entry.getValue().equals("int")){
					   querySql.append("=");
					   querySql.append(value);
				   }else{
					   querySql.append(" like '%");
					   querySql.append(decodeCN(value).trim());
					   querySql.append("%'");
				   }
				   System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
			   }
			  }
		System.out.println(querySql);
		List<Object> getstatisticsoBjectList= commonPageinationSV.getObjectList(pageNo, pageSize, querySql.toString());
		json = JSONArray.fromObject(getstatisticsoBjectList, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	@RequestMapping(value="/statAutoCoverChart.do")
	public void statAutoCoverChart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String HQL="From StatAutoCover where 1=1 ";
		StringBuffer querySql = new StringBuffer();
		Map<String,String> FieldMap=CommonHelper.getFieldsClassTypeMap(new Class[]{StatAutoCover.class});
		Iterator<Map.Entry<String, String>> it=FieldMap.entrySet().iterator();
		while (it.hasNext()) {
			   Map.Entry<String, String> entry = it.next();
			   String key=entry.getKey();
			   String value=request.getParameter( key);
			   if(NaNull(value)){
				   querySql.append(" and ");
				   querySql.append(key);
				   if(entry.getValue().equals("int")){
					   querySql.append("=");
					   querySql.append(value);
				   }else{
					   querySql.append(" like '%");
					   querySql.append(decodeCN(value).trim());
					   querySql.append("%'");
				   }
				   System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
			   }
			  }
		System.out.println(querySql);
		@SuppressWarnings("unchecked")
		List<StatAutoCover> statAutoCoverList= iStatisticsSV.getObjectByHQL(HQL+querySql);
		Map<String,float[]> dataMap=new HashMap<String,float[]>();
		List<String> dataMapIndexList=new ArrayList<String>();
		float[] datasFloat=new float[5];
		for(StatAutoCover autoCover:statAutoCoverList){
			if(autoCover.getSystemName().trim().equals("总计"))continue;
			datasFloat=dataMap.get(autoCover.getSystemName());
			String s0,s1,s2,s3,s4;
			s0=autoCover.getKernalFunctionCover();
			s1=autoCover.getKernalAutoFunctionCover();
			s2=autoCover.getKernalRegressAutoCover();
			s3=autoCover.getAutoFunctionCover();
			s4=autoCover.getAutoCaseCover();
			s0=NaNull(s0)?s0.replace("%", ""):"0";
			s1=NaNull(s1)?s1.replace("%", ""):"0";
			s2=NaNull(s2)?s2.replace("%", ""):"0";
			s3=NaNull(s3)?s3.replace("%", ""):"0";
			s4=NaNull(s4)?s4.replace("%", ""):"0";
			if(datasFloat!=null&&datasFloat.length==5){
				datasFloat[0]=datasFloat[0]+Float.valueOf(s0);
				datasFloat[1]=datasFloat[1]+Float.valueOf(s1);
				datasFloat[2]=datasFloat[2]+Float.valueOf(s2);
				datasFloat[3]=datasFloat[3]+Float.valueOf(s3);
				datasFloat[4]=datasFloat[4]+Float.valueOf(s4);
			}else{
				
				float[] datasInt1=null;
				try{
					datasFloat=new float[]{
							Float.valueOf(s0),
							Float.valueOf(s1),
							Float.valueOf(s2),
							Float.valueOf(s3),
							Float.valueOf(s4)
					};
				}catch (Exception e) {
					datasFloat=new float[]{0,0,0,0,0};
				}
			}
			dataMap.put(autoCover.getSystemName(), datasFloat);
			dataMapIndexList.add(autoCover.getSystemName());
		}
		JSONObject resultJson = new JSONObject();
		JSONObject category = new JSONObject();
		JSONArray categoriesArray = new JSONArray();
		JSONArray categoryArray = new JSONArray();
		JSONArray datasetArray = new JSONArray();
		JSONObject dataset0 = new JSONObject();
		JSONObject dataset1 = new JSONObject();
		JSONObject dataset2 = new JSONObject();
		JSONObject dataset3 = new JSONObject();
		JSONObject dataset4 = new JSONObject();
		JSONArray data0 = new JSONArray();
		JSONArray data1 = new JSONArray();
		JSONArray data2 = new JSONArray();
		JSONArray data3 = new JSONArray();
		JSONArray data4 = new JSONArray();
		for(String key:dataMapIndexList){
			JSONObject category0 = new JSONObject();
			category0.put("label", key);
			categoryArray.add(category0);
			JSONObject value0 = new JSONObject();
			JSONObject value1 = new JSONObject();
			JSONObject value2 = new JSONObject();
			JSONObject value3 = new JSONObject();
			JSONObject value4 = new JSONObject();
			float[] ints=dataMap.get(key);
			value0.put("value", ints[0]);
			value1.put("value", ints[1]);
			value2.put("value", ints[2]);
			value3.put("value", ints[3]);
			value4.put("value", ints[4]);
			data0.add(value0);
			data1.add(value1);
			data2.add(value2);
			data3.add(value3);
			data4.add(value4);
		}
		dataset0.put("data", data0);
		dataset1.put("data", data1);
		dataset2.put("data", data2);
		dataset3.put("data", data3);
		dataset4.put("data", data4);
		dataset0.put("seriesname", "核心功能点覆盖率");
		dataset1.put("seriesname", "核心功能点自动化覆盖率");
		dataset2.put("seriesname", "核心回归用例自动化覆盖率");
		dataset3.put("seriesname", "自动化功能点覆盖率");
		dataset4.put("seriesname", "自动化用例覆盖率");
		category.put("category", categoryArray);
		datasetArray.add(dataset0);
		datasetArray.add(dataset1);
		datasetArray.add(dataset2);
		datasetArray.add(dataset3);
		datasetArray.add(dataset4);
		categoriesArray.add(category);
		resultJson.put("categories", categoriesArray);
		resultJson.put("dataset", datasetArray);
		JSONObject chartJson = new JSONObject();
		chartJson.put("caption", "各系统覆盖率");
		chartJson.put("palette", "1");
		chartJson.put("showLabels", "1");
		chartJson.put("showvalues", "0");
		chartJson.put("yAxisValuesStep", "1");
		chartJson.put("yAxisMaxValue", "100");
		chartJson.put("yAxisMinValue", "0");
		chartJson.put("sYAxisValuesDecimals", "2");
		chartJson.put("numbersuffix", "%");
		chartJson.put("connectNullData", "0");
		chartJson.put("PYAxisName", "");
		chartJson.put("showvalues", "0");
		chartJson.put("baseFontSize", "12");
		chartJson.put("useRoundEdges", "1");
		chartJson.put("numDivLines", "8");
		chartJson.put("SYAxisName", "");
		chartJson.put("formatNumberScale","0");  
		chartJson.put("xAxisName", "");
		chartJson.put("sNumberSuffix", "");
		resultJson.put("chart", chartJson);
		Map retMap=new HashMap();
		retMap.put("data", resultJson);
		retMap.put("success", true);
		System.out.println(resultJson);
		ActionHelper.returnResponseData(request, response, retMap);
	}
	@RequestMapping(value="/statCommonFusionChart.do")
	public void statCommonFusionChart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		String objName = request.getParameter("objName");
		if(!NaNull(objName))throw new Exception("类名不能为空");
		Class<?>[] clazzs=new Class[]{Class.forName(objName)};
		Map<String,String> FieldMap=CommonHelper.getFieldsClassTypeMap(clazzs);
		Iterator<Map.Entry<String, String>> it=FieldMap.entrySet().iterator();
		StringBuffer querySql = new StringBuffer("FROM "+objName+" a WHERE 1=1 ");
		while (it.hasNext()) {
			   Map.Entry<String, String> entry = it.next();
			   String key=entry.getKey();
			   String value=request.getParameter( key);
			   if(NaNull(value)){
				   querySql.append(" and ");
				   querySql.append(key);
				   if(entry.getValue().equals("int")){
					   querySql.append("=");
					   querySql.append(value);
				   }else{
					   querySql.append(" like '%");
					   querySql.append(value);
					   querySql.append("%'");
				   }
			   }
			  }
		System.out.println(querySql);
		String StatGridHQL="From StatGrid where rownum=1 and classPath='"+objName+"'";
		@SuppressWarnings("unchecked")
		List<StatGrid> statGridObjList= iStatisticsSV.getObjectByHQL(StatGridHQL);
		if(statGridObjList==null||statGridObjList.size()!=1)throw new Exception("查不到"+objName+"对象");
		StatGrid grid=statGridObjList.get(0);
		String gridId=grid.getGridId();
		String StatGridColumnsHQL="From StatGridColumns where gridId="+gridId+" order by columnIndex";
		@SuppressWarnings("unchecked")
		List<StatGridColumns> statGridColumList=iStatisticsSV.getObjectByHQL(StatGridColumnsHQL);
		Map<String,String> statGridColumMap=new HashMap<String,String>();
		JSONObject resultJson = new JSONObject();
		JSONObject category = new JSONObject();
		JSONArray categoriesArray = new JSONArray();
		JSONArray categoryArray = new JSONArray();
		for(StatGridColumns column:statGridColumList){
			if(!NaNull(column.getDataIndex()))continue;
			statGridColumMap.put( CommonHelper.removeHTMLTag(column.getHeader()),column.getDataIndex());
			JSONObject category0 = new JSONObject();
			category0.put("label", CommonHelper.removeHTMLTag(column.getHeader()));
			categoryArray.add(category0);
		}
		category.put("category", categoryArray);
		@SuppressWarnings("unchecked")
		List<Object> getstatisticsoBjectList= iStatisticsSV.getObjectByHQL(querySql.toString());
//		for(Object obj:getstatisticsoBjectList){
			
//		}
		Object statisticObj=getstatisticsoBjectList.get(0);
//		反射获取值
		Class<?> clazz=statisticObj.getClass();
		Map<String,Field> fieldMap =new HashMap<String,Field>();
		for(Class<?> _clazz = clazz ;_clazz!= Object.class;_clazz = _clazz.getSuperclass()){
			for(Field field: _clazz.getDeclaredFields()){
				String name = field.getName();
				fieldMap.put(name, field);
			}
		}
		JSONArray datasetArray = new JSONArray();
		JSONObject dataset = new JSONObject();
		JSONArray data = new JSONArray();
		for(int i=0,n=categoryArray.size();i<n;i++){
			JSONObject categoryObj=categoryArray.getJSONObject(i);
			String labelName=categoryObj.getString("label");
			Field field=fieldMap.get(statGridColumMap.get(labelName));
			if(field==null)continue;
			field.setAccessible(true); //设置些属性是可以访问的
	        Object val = field.get(statisticObj);//得到此属性的值
	        JSONObject value = new JSONObject();
			value.put("value", val);
//			value.put("link", "javascript:fusionChartsFunction();");
			data.add(value);
		}
		dataset.put("data", data);
		datasetArray.add(dataset);
		categoriesArray.add(category);
		resultJson.put("categories", categoriesArray);
		resultJson.put("dataset", datasetArray);
		JSONObject chartJson = new JSONObject();
		chartJson.put("caption", "月度运营一级KPI");
		chartJson.put("subcaption", "");
		chartJson.put("showvalues", "0.0");
		chartJson.put("numberprefix", "次数");
		chartJson.put("plotspacepercent", "20");
		chartJson.put("plotgradientcolor", "");
		chartJson.put("plotborderalpha", "0");
		chartJson.put("canvasbordercolor", "#6E98AA");
		chartJson.put("canvasborderalpha", "25");
		chartJson.put("canvasborderthickness", "1");
		chartJson.put("bgalpha", "0");
		chartJson.put("alternatehgridalpha", "0");
		chartJson.put("numbersuffix", "次");
		chartJson.put("divlinecolor", "#6E98AA");
		chartJson.put("basefontcolor", "#6E98AA");
		chartJson.put("legendbordercolor", "#6E98AA");
		chartJson.put("legendshadow", "0");
		chartJson.put("divlinealpha", "25");
		chartJson.put("tooltipbordercolor", "#6E98AA");
		chartJson.put("bordercolor", "#6E98AA");
		chartJson.put("legendborderalpha", "30");
		chartJson.put("outCnvbaseFontSize", "13");
		chartJson.put("palettecolors", "#02295B,#FCB63C,#A8B1B8");
		chartJson.put("showborder", "0");
		resultJson.put("chart", chartJson);
		Map retMap=new HashMap();
		retMap.put("data", resultJson);
		retMap.put("success", true);
		System.out.println(resultJson);
		ActionHelper.returnResponseData(request, response, retMap);
	}
	@RequestMapping(value="/statAutoCoverCountChart.do")
	public void statAutoCoverCountChart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String HQL="From StatAutoCover where 1=1 and systemName='总计'";
		@SuppressWarnings("unchecked")
		List<StatAutoCover> statAutoCoverList= iStatisticsSV.getObjectByHQL(HQL);
		if(statAutoCoverList==null||statAutoCoverList.size()!=1)throw new Exception("获取总计列出错");
		StatAutoCover statAutoCover=statAutoCoverList.get(0);
		JSONObject resultJson = new JSONObject();
		JSONObject category = new JSONObject();
		JSONArray categoriesArray = new JSONArray();
		JSONArray categoryArray = new JSONArray();
		JSONArray datasetArray = new JSONArray();
		JSONObject dataset = new JSONObject();
		JSONArray data = new JSONArray();
		JSONObject label_0=new JSONObject();
		JSONObject label_1=new JSONObject();
		JSONObject label_2=new JSONObject();
		JSONObject label_3=new JSONObject();
		JSONObject label_4=new JSONObject();
		JSONObject label_5=new JSONObject();
		JSONObject label_6=new JSONObject();
		JSONObject label_7=new JSONObject();
		JSONObject label_8=new JSONObject();
		JSONObject label_9=new JSONObject();
		JSONObject label_10=new JSONObject();
		JSONObject label_11=new JSONObject();
		label_0.put("label", "总功能点数");
		label_1.put("label", "总手工用例数");
		label_2.put("label", "总自动化功能点数");
		label_3.put("label", "总自动化用例数");
		label_4.put("label", "不可实现自动化用例数");
		label_5.put("label", "未实现自动化用例数");
		label_6.put("label", "核心功能点数");
		label_7.put("label", "核心功能自动化数");
		label_8.put("label", "核心回归用例数");
		label_9.put("label", "核心回归用例自动化数");
		label_10.put("label", "核心回归不可实现自动化用例数");
		label_11.put("label", "核心回归未实现自动化用例数");
		categoryArray.add(label_0);
		categoryArray.add(label_1);
		categoryArray.add(label_2);
		categoryArray.add(label_3);
		categoryArray.add(label_4);
		categoryArray.add(label_5);
		categoryArray.add(label_6);
		categoryArray.add(label_7);
		categoryArray.add(label_8);
		categoryArray.add(label_9);
		categoryArray.add(label_10);
		categoryArray.add(label_11);
		JSONObject value_0=new JSONObject();
		JSONObject value_1=new JSONObject();
		JSONObject value_2=new JSONObject();
		JSONObject value_3=new JSONObject();
		JSONObject value_4=new JSONObject();
		JSONObject value_5=new JSONObject();
		JSONObject value_6=new JSONObject();
		JSONObject value_7=new JSONObject();
		JSONObject value_8=new JSONObject();
		JSONObject value_9=new JSONObject();
		JSONObject value_10=new JSONObject();
		JSONObject value_11=new JSONObject();
		value_0.put("value", statAutoCover.getFunctionPoint());
		value_1.put("value", statAutoCover.getManualCase());
		value_2.put("value", statAutoCover.getAutoFunctionPoint());
		value_3.put("value", statAutoCover.getAutoCase());
		value_4.put("value", statAutoCover.getUnrealizableAutoCase());
		value_5.put("value", statAutoCover.getUnrealizedAutoCase());
		value_6.put("value", statAutoCover.getKernalFunctionPoint());
		value_7.put("value", statAutoCover.getKernalAutoFunction());
		value_8.put("value", statAutoCover.getKernalRegressCase());
		value_9.put("value", statAutoCover.getKernalAutoCase());
		value_10.put("value", statAutoCover.getKernalUnrealizableCase());
		value_11.put("value", statAutoCover.getKernalUnrealizedCase());
		data.add(value_0);
		data.add(value_1);
		data.add(value_2);
		data.add(value_3);
		data.add(value_4);
		data.add(value_5);
		data.add(value_6);
		data.add(value_7);
		data.add(value_8);
		data.add(value_9);
		data.add(value_10);
		data.add(value_11);
		dataset.put("data", data);
		category.put("category", categoryArray);
		datasetArray.add(dataset);
		categoriesArray.add(category);
		resultJson.put("categories", categoriesArray);
		resultJson.put("dataset", datasetArray);
		JSONObject chartJson = new JSONObject();
		chartJson.put("caption", "自动化覆盖情况");
		chartJson.put("palette", "1");
		chartJson.put("showLabels", "1");
		chartJson.put("showvalues", "0");
		chartJson.put("sYAxisValuesDecimals", "2");
		chartJson.put("numbersuffix", "");
		chartJson.put("connectNullData", "0");
		chartJson.put("PYAxisName", "");
		chartJson.put("showvalues", "0");
		chartJson.put("baseFontSize", "12");
		chartJson.put("useRoundEdges", "1");
		chartJson.put("numDivLines", "8");
		chartJson.put("SYAxisName", "");
		chartJson.put("formatNumberScale","0");  
		chartJson.put("xAxisName", "");
		chartJson.put("sNumberSuffix", "");
		resultJson.put("chart", chartJson);
		Map retMap=new HashMap();
		retMap.put("data", resultJson);
		retMap.put("success", true);
		System.out.println(resultJson);
		ActionHelper.returnResponseData(request, response, retMap);
	}
}

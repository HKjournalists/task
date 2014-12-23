package com.asiainfo.aiga.statistics.service.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import com.asiainfo.aiga.search.dao.BaseDAO;
import com.asiainfo.aiga.statistics.bo.AigaMonthDelSla;
import com.asiainfo.aiga.statistics.bo.AigaMonthRepKpi;
import com.asiainfo.aiga.statistics.bo.AigaMonthRunKpi;
import com.asiainfo.aiga.statistics.bo.StatKpiTarget;
import com.asiainfo.aiga.statistics.bo.StatMonthOneLevelKpi;
import com.asiainfo.aiga.statistics.dao.EntityUtil;
import com.asiainfo.aiga.statistics.dao.IStatisticsDAO;
import com.asiainfo.aiga.statistics.service.IStatisticsSV;


/**
 * Created on 2014-10-10
 * <p>
 * Description: [统计分析实现]
 * </p>
 */
//getComment
public class StatisticsSV implements IStatisticsSV {
	
	private IStatisticsDAO statisticDao;
	private static Logger logger = Logger.getLogger(StatisticsSV.class);
	public IStatisticsDAO getStatisticDao() {
		return statisticDao;
	}
	
	public void setStatisticDao(IStatisticsDAO statisticDao) {
		this.statisticDao = statisticDao;
	}
	
	@Override
	public String statMonthOneLevelKpiFunsionCharts(String startDate,String endDate) throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		try{
			JSONArray categoriesArray = new JSONArray();
			JSONArray datasetArray = new JSONArray();
			String[] seriesnames=new String[]{"QUALITY_DEV_PROBLEM_NUM","QUALITY_PUBLISH_ERROR_NUM"};
			Map<String,String> map=new HashMap<String,String>();
			map.put(seriesnames[0], "开发故障次数");
			map.put(seriesnames[1],"上线异常事件次数");
			rs = stat.executeQuery("SELECT t.report_month, t.QUALITY_DEV_PROBLEM_NUM,t.QUALITY_PUBLISH_ERROR_NUM " +
									" FROM stat_month_one_level_kpi t WHERE to_date(t.report_month,'YYYY-MM') " +
									" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') ");
			JSONArray categoryArray = new JSONArray();
			JSONObject category = new JSONObject();
			while (rs.next()) {
				JSONObject category0 = new JSONObject();
				category0.put("label", rs.getString("report_month"));
				categoryArray.add(category0);
			}
			category.put("category", categoryArray);
			categoriesArray.add(category);
			for (String seriesname : seriesnames) {
				if (rs.first()) {
					JSONObject dataset = new JSONObject();
					JSONArray data = new JSONArray();
					do{
						JSONObject value = new JSONObject();
						value.put("value", rs.getInt(seriesname));
//						value.put("link", "javascript:fusionChartsFunction();");
						data.add(value);
					}while (rs.next());
				
					dataset.put("data", data);
					dataset.put("seriesname", map.get(seriesname));
					datasetArray.add(dataset);
				
				}
			}
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
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson.toString();
	}
	@Override
	public JSONObject statMonthOneLevelKpiList(String startDate,String endDate, Integer page, Integer start, Integer limit)throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		try{
			String SQL="select * from (SELECT t.*,rownum rn FROM STAT_MONTH_ONE_LEVEL_KPI t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') and rownum<= "+(page*limit)+" ORDER BY to_date(t.report_month,'YYYY-MM') ) ";
			logger.info(page+"==="+start+"==="+limit);
			String countSQL="SELECT count(t.stat_id) as count FROM STAT_MONTH_ONE_LEVEL_KPI t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') ";
			SQL+=" where rn>"+((page-1)*limit);
			rs = stat.executeQuery(countSQL);
			int count=0;
			while (rs.next()) {
				count=rs.getInt("count");
			}
			rs = stat.executeQuery(SQL);
			System.out.println("------------"+SQL);
			JSONArray jsonArray=new JSONArray();
			while (rs.next()) {
				JSONObject json = new JSONObject();
				json.put("STAT_ID", rs.getInt("STAT_ID"));
				json.put("REPORT_MONTH", rs.getString("REPORT_MONTH"));
				json.put("CREATE_TIME", rs.getString("CREATE_TIME"));
				json.put("VERSION_PUBLISH_NUM", rs.getString("VERSION_PUBLISH_NUM"));
				json.put("VERSION_TASK_NUM", rs.getString("VERSION_TASK_NUM"));
				json.put("VERSION_REQ_NUM", rs.getString("VERSION_REQ_NUM"));
				json.put("QUALITY_DEV_PROBLEM_NUM", rs.getString("QUALITY_DEV_PROBLEM_NUM"));
				json.put("QUALITY_TERRIBLE_PRECENT", rs.getString("QUALITY_TERRIBLE_PRECENT"));
				json.put("QUALITY_PUBLISH_ERROR_NUM", rs.getString("QUALITY_PUBLISH_ERROR_NUM"));
				json.put("QUALITY_PUBLISH_ERROR_PRECENT", rs.getString("QUALITY_PUBLISH_ERROR_PRECENT"));
				json.put("DEV_PERIOD_FROM_CREATE", rs.getString("DEV_PERIOD_FROM_CREATE"));
				json.put("BUSI_DEV_PERSON_NUM", rs.getString("BUSI_DEV_PERSON_NUM"));
				json.put("BUSI_PROJECT_PERSON_NUM", rs.getString("BUSI_PROJECT_PERSON_NUM"));
				json.put("DEV_PERIOD_FROM_CONFIRM", rs.getString("DEV_PERIOD_FROM_CONFIRM"));
				json.put("DEV_PERIOD_FROM_DISTRIBUTE", rs.getString("DEV_PERIOD_FROM_DISTRIBUTE"));
				json.put("DEV_PUBLISH_EST_WORK", rs.getString("DEV_PUBLISH_EST_WORK"));
				jsonArray.add(json);
			}
			resultJson.put("data", jsonArray);	
			resultJson.put("result", true);
			resultJson.put("total", count);
		}catch(Exception e){
			e.printStackTrace();
			resultJson.put("result", false);
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson;
	}
//	月度运营二级效率KPI
	@Override
	public String statMonthTwoLEffKpiFunsionCharts(String startDate,String endDate) throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		try{
			JSONArray categoriesArray = new JSONArray();
			JSONArray datasetArray = new JSONArray();
			String[] seriesnames=new String[]{"PLAN_SUCC_PERCENT","DEV_CODE_TIMELY_PERCENT","TEST_TEST_TIMELY_PERCENT"};
			Map<String,String> map=new HashMap<String,String>();
			map.put(seriesnames[0], "计划准确率");
			map.put(seriesnames[1],"代码提交及时率");
			map.put(seriesnames[2],"测试及时率");
			String fusionSQL="SELECT t.report_month, t.PLAN_SUCC_PERCENT,t.DEV_CODE_TIMELY_PERCENT ,t.TEST_TEST_TIMELY_PERCENT" +
					" FROM STAT_MONTH_TWO_L_EFF_KPI t WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') ";
			logger.info(fusionSQL);
			rs = stat.executeQuery(fusionSQL);
			JSONArray categoryArray = new JSONArray();
			JSONObject category = new JSONObject();
			while (rs.next()) {
				JSONObject category0 = new JSONObject();
				category0.put("label", rs.getString("report_month"));
				categoryArray.add(category0);
			}
			category.put("category", categoryArray);
			categoriesArray.add(category);
			for (String seriesname : seriesnames) {
				if (rs.first()) {
					JSONObject dataset = new JSONObject();
					JSONArray data = new JSONArray();
					do{
						JSONObject value = new JSONObject();
						value.put("value", rs.getInt(seriesname));
						data.add(value);
					}while (rs.next());
				
					dataset.put("data", data);
					dataset.put("seriesname", map.get(seriesname));
					datasetArray.add(dataset);
				
				}
			}
			resultJson.put("categories", categoriesArray);
			resultJson.put("dataset", datasetArray);
			JSONObject chartJson = new JSONObject();
			chartJson.put("caption", "月度运营二级效率KPI");
			chartJson.put("subcaption", "");
			chartJson.put("showvalues", "0.0");
			chartJson.put("numberprefix", "");
			chartJson.put("plotspacepercent", "20");
			chartJson.put("plotgradientcolor", "");
			chartJson.put("plotborderalpha", "0");
			chartJson.put("canvasbordercolor", "#6E98AA");
			chartJson.put("canvasborderalpha", "25");
			chartJson.put("canvasborderthickness", "1");
			chartJson.put("bgalpha", "0");
			chartJson.put("alternatehgridalpha", "0");
			chartJson.put("numbersuffix", "%");
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
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson.toString();
	}
	@Override
	public JSONObject statMonthTwoLEffKpiList(String startDate,String endDate, Integer page, Integer start, Integer limit)throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		try{
			String SQL="select * from (SELECT t.*,rownum rn FROM STAT_MONTH_TWO_L_EFF_KPI t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') and rownum<= "+(page*limit)+" ORDER BY to_date(t.report_month,'YYYY-MM') ) ";
			String countSQL="SELECT count(t.stat_id) as count FROM STAT_MONTH_TWO_L_EFF_KPI t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') ";
			SQL+=" where rn>"+((page-1)*limit);
			rs = stat.executeQuery(countSQL);
			int count=0;
			while (rs.next()) {
				count=rs.getInt("count");
			}
			rs = stat.executeQuery(SQL);
			System.out.println("------------"+SQL);
			JSONArray jsonArray=new JSONArray();
			while (rs.next()) {
				JSONObject json = new JSONObject();
				json.put("STAT_ID", rs.getInt("STAT_ID"));
				json.put("REPORT_MONTH", rs.getString("REPORT_MONTH"));
				json.put("REQ_PERIOD_FROM_SUBMIT", rs.getString("REQ_PERIOD_FROM_SUBMIT"));
				json.put("REQ_PERIOD_FROM_CONFIRM", rs.getString("REQ_PERIOD_FROM_CONFIRM"));
				json.put("REQ_PERIOD_FROM_DISTRIBUTE", rs.getString("REQ_PERIOD_FROM_DISTRIBUTE"));
				json.put("PLAN_SUCC_PERCENT", rs.getString("PLAN_SUCC_PERCENT"));
				json.put("PLAN_CHANGE_PERCENT", rs.getString("PLAN_CHANGE_PERCENT"));
				json.put("PLAN_EMERGY_PUBLISH_PERCENT", rs.getString("PLAN_EMERGY_PUBLISH_PERCENT"));
				json.put("REQ_ANLYSIS_TIMELY_PERCENT", rs.getString("REQ_ANLYSIS_TIMELY_PERCENT"));
				json.put("DEV_CODE_TIMELY_PERCENT", rs.getString("DEV_CODE_TIMELY_PERCENT"));
				json.put("DEV_BUG_TIMELY_PERCENT", rs.getString("DEV_BUG_TIMELY_PERCENT"));
				json.put("TEST_TEST_TIMELY_PERCENT", rs.getString("TEST_TEST_TIMELY_PERCENT"));
				json.put("TEST_BUG_TIMELY_PERCENT", rs.getString("TEST_BUG_TIMELY_PERCENT"));			
				jsonArray.add(json);
			}
			resultJson.put("data", jsonArray);	
			resultJson.put("result", true);
			resultJson.put("total", count);
		}catch(Exception e){
			e.printStackTrace();
			resultJson.put("result", false);
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson;
	}
	@Override
	public List getObjectByHQL(String HQL) throws Exception {
		// TODO Auto-generated method stub
		return statisticDao.getObjectByHQL(HQL);
	}

	@Override
	public void saveAigaKpi(Object aValue) throws Exception {
		// TODO Auto-generated method stub
		statisticDao.saveOrUpdate(aValue);
	}

	@Override
	public String getAigaMonthDelSlaList(String querySql) throws Exception {
		return null;
		
	}
	public void saveAigaMonthDelSla(AigaMonthDelSla aValue) throws Exception {
		statisticDao.saveAigaMonthDelSla(aValue);
	}

	@Override
	public AigaMonthDelSla[] getAigaMonthDelSla(String querySql)
			throws Exception {
		return statisticDao.getAigaMonthDelSla(querySql);
	}

	@Override
	public String statMonthTwoLCapacityKpiFunsionCharts(String startDate,String endDate) throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		try{
			JSONArray categoriesArray = new JSONArray();
			JSONArray datasetArray = new JSONArray();
			String[] seriesnames=new String[]{"dev_person_num","test_work_load_value","test_case_avg"};
			Map<String,String> map=new HashMap<String,String>();
			map.put(seriesnames[0], "开发人员");
			map.put(seriesnames[1], "工作负荷程度");
			map.put(seriesnames[2], "人均测试用例数");
			rs = stat.executeQuery("SELECT t.report_month,t.dev_person_num,t.test_work_load_value,t.test_case_avg FROM stat_month_two_l_capacity_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
									" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') ORDER BY to_date(t.report_month,'YYYY-MM') ");
			JSONArray categoryArray = new JSONArray();
			JSONObject category = new JSONObject();
			while (rs.next()) {
				JSONObject category0 = new JSONObject();
				category0.put("label", rs.getString("report_month"));
				categoryArray.add(category0);
			}
				
			category.put("category", categoryArray);
			categoriesArray.add(category);
			
			if (rs.first()) {
				JSONObject dataset = new JSONObject();
				JSONArray data = new JSONArray();
				do{
					JSONObject value = new JSONObject();
					value.put("value", rs.getInt("dev_person_num"));
					data.add(value);
					}while (rs.next());
				
					dataset.put("data", data);
					dataset.put("seriesname", map.get("dev_person_num"));
					dataset.put("parentYAxis", "S");
					dataset.put("renderAs", "StackColumn");
					datasetArray.add(dataset);
				}
			if (rs.first()) {
				JSONObject dataset = new JSONObject();
				JSONArray data = new JSONArray();
				do{
					JSONObject value = new JSONObject();
					value.put("value", rs.getFloat("test_work_load_value"));
					data.add(value);
					}while (rs.next());
				
					dataset.put("data", data);
					dataset.put("seriesname", map.get("test_work_load_value"));
					dataset.put("parentYAxis", "P");
					dataset.put("renderAs", "StackColumn");
					datasetArray.add(dataset);
				}
			
			if (rs.first()) {
				JSONObject dataset = new JSONObject();
				JSONArray data = new JSONArray();
				do{
					JSONObject value = new JSONObject();
					value.put("value", rs.getInt("test_case_avg"));
					data.add(value);
					}while (rs.next());
				
					dataset.put("data", data);
					dataset.put("seriesname", map.get("test_case_avg"));
					dataset.put("parentYAxis", "S");
					dataset.put("renderAs", "StackColumn");
					datasetArray.add(dataset);
				}
			
			resultJson.put("categories", categoriesArray);
			resultJson.put("dataset", datasetArray);
			JSONObject chartJson = new JSONObject();
			
			chartJson.put("palette", "1");
			chartJson.put("caption", "月度运营二级容量KPI");
			chartJson.put("showLabels", "1");
			chartJson.put("showvalues", "0");
			chartJson.put("sYAxisValuesDecimals", "2");
			chartJson.put("connectNullData", "0");
			chartJson.put("PYAxisName", "工作负荷程度");
			chartJson.put("showvalues", "0");
			chartJson.put("baseFontSize", "12");
			chartJson.put("useRoundEdges", "1");
			chartJson.put("numDivLines", "8");
			chartJson.put("SYAxisName", "人数");
			chartJson.put("formatNumberScale","0");  
			chartJson.put("xAxisName", "");
			chartJson.put("sNumberSuffix", "");
			resultJson.put("chart", chartJson);
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson.toString();
	}

	@Override
	public JSONObject statMonthTwoLCapacityKpiList(String startDate, String endDate,Integer page,Integer start,Integer limit)throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		try{
			String SQL="select * from (SELECT t.*,rownum rn FROM stat_month_two_l_capacity_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') and rownum<= "+(page*limit)+" ORDER BY to_date(t.report_month,'YYYY-MM') ) ";
			logger.info(page+"==="+start+"==="+limit);
			String countSQL="SELECT count(t.stat_id) as count FROM stat_month_two_l_capacity_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') ";
			SQL+=" where rn>"+((page-1)*limit);
			rs = stat.executeQuery(countSQL);
			int count=0;
			while (rs.next()) {
				count=rs.getInt("count");
			}
			rs = stat.executeQuery(SQL);
			System.out.println("------------"+SQL);
//			WHERE Rownum>=1 AND ROWNUM <=2
//			5===4===1
			JSONArray jsonArray=new JSONArray();
			while (rs.next()) {
				JSONObject json = new JSONObject();
				json.put("STAT_ID", rs.getInt("STAT_ID"));
				json.put("REPORT_MONTH", rs.getString("REPORT_MONTH"));
				json.put("REQ_ANLYSIS_AVG_NUM", rs.getString("REQ_ANLYSIS_AVG_NUM"));
				json.put("REQ_PERSON_NUM", rs.getInt("REQ_PERSON_NUM"));
				json.put("DEV_WORK_LOAD_VALUE", rs.getString("DEV_WORK_LOAD_VALUE"));
				json.put("DEV_PUBLISH_EST_WORK", rs.getString("DEV_PUBLISH_EST_WORK"));
				json.put("DEV_PERSON_NUM", rs.getString("DEV_PERSON_NUM"));
				json.put("TEST_WORK_LOAD_VALUE", rs.getString("TEST_WORK_LOAD_VALUE"));
				json.put("TEST_CASE_AVG", rs.getString("TEST_CASE_AVG"));
				json.put("TEST_PERSON_NUM", rs.getString("TEST_PERSON_NUM"));
				jsonArray.add(json);
			}
			resultJson.put("data", jsonArray);	
			resultJson.put("result", true);
			resultJson.put("total", count);
		}catch(Exception e){
			e.printStackTrace();
			resultJson.put("result", false);
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson;
	}

	@Override
	public boolean updateBySQL(String SQL) throws Exception {
		// TODO Auto-generated method stub
		return statisticDao.updateBySQL(SQL);
	}

	@Override
	public AigaMonthRepKpi[] getAigaMonthRepKpi(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		return statisticDao.getAigaMonthRepKpi(querySql);
	}

	@Override
	public void saveAigaMonthRepKpi(AigaMonthRepKpi aValue) throws Exception {
		// TODO Auto-generated method stub
		statisticDao.saveAigaMonthRepKpi(aValue);
	}

	@Override
	public JSONObject statMonthTwoLQualityKpiList(String startDate,
			String endDate, Integer page, Integer start, Integer limit)
			throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		try{
			String SQL="select * from (SELECT t.*,rownum rn FROM stat_month_two_l_quality_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') and rownum<= "+(page*limit)+" ORDER BY to_date(t.report_month,'YYYY-MM') ) ";
			logger.info(page+"==="+start+"==="+limit);
			String countSQL="SELECT count(t.stat_id) as count FROM stat_month_two_l_quality_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') ";
			SQL+=" where rn>"+((page-1)*limit);
			rs = stat.executeQuery(countSQL);
			int count=0;
			while (rs.next()) {
				count=rs.getInt("count");
			}
			rs = stat.executeQuery(SQL);
			System.out.println("------------"+SQL);
//			WHERE Rownum>=1 AND ROWNUM <=2
//			5===4===1
			JSONArray jsonArray=new JSONArray();
			while (rs.next()) {
				JSONObject json = new JSONObject();
				json.put("STAT_ID", rs.getInt("STAT_ID"));
				json.put("REPORT_MONTH", rs.getString("REPORT_MONTH"));
				json.put("PUBLISH_ERROR_PERCENT", rs.getString("PUBLISH_ERROR_PERCENT")+"%");
				json.put("DEV_BUG_DENSITY", rs.getInt("DEV_BUG_DENSITY")+"%");
				json.put("DEV_REQ_BUG_DENSITY", rs.getString("DEV_REQ_BUG_DENSITY")+"%");
				json.put("DEV_DESIGN_BUG_DENSITY", rs.getString("DEV_DESIGN_BUG_DENSITY")+"%");
				json.put("DEV_DEV_BUG_DENSITY", rs.getString("DEV_DEV_BUG_DENSITY")+"%");
				json.put("DEV_DOUBLE_DEV_PERCENT", rs.getString("DEV_DOUBLE_DEV_PERCENT")+"%");
				json.put("DEV_TASK_BUG_PERCENT", rs.getString("DEV_TASK_BUG_PERCENT")+"%");
				json.put("DEV_UNIT_TEST_PERCENT", rs.getString("DEV_UNIT_TEST_PERCENT")+"%");
				json.put("TEST_BUG_LEAVE_PERCENT", rs.getString("TEST_BUG_LEAVE_PERCENT")+"%");
				json.put("TEST_BUG_UNVALID_PERCENT", rs.getString("TEST_BUG_UNVALID_PERCENT")+"%");
				json.put("TEST_BUG_VALID_PERCENT", rs.getString("TEST_BUG_VALID_PERCENT")+"%");
				jsonArray.add(json);
			}
			resultJson.put("data", jsonArray);	
			resultJson.put("result", true);
			resultJson.put("total", count);
		}catch(Exception e){
			e.printStackTrace();
			resultJson.put("result", false);
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson;
	}

	@Override
	public String statMonthTwoLQualityKpiFunsionCharts(String startDate,String endDate) throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		try{
			JSONArray categoriesArray = new JSONArray();
			JSONArray datasetArray = new JSONArray();
			String[] seriesnames=new String[]{"dev_bug_density","test_bug_leave_percent"};
			Map<String,String> map=new HashMap<String,String>();
			map.put(seriesnames[0], "综合缺陷密度");
			map.put(seriesnames[1], "测试缺陷遗漏率");
			rs = stat.executeQuery("SELECT t.report_month,t.dev_bug_density,t.test_bug_leave_percent FROM stat_month_two_l_quality_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
									" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') ORDER BY to_date(t.report_month,'YYYY-MM') ");
			JSONArray categoryArray = new JSONArray();
			JSONObject category = new JSONObject();
			while (rs.next()) {
				JSONObject category0 = new JSONObject();
				category0.put("label", rs.getString("report_month"));
				categoryArray.add(category0);
			}
				
			category.put("category", categoryArray);
			categoriesArray.add(category);
			
			if (rs.first()) {
				JSONObject dataset = new JSONObject();
				JSONArray data = new JSONArray();
				do{
					JSONObject value = new JSONObject();
					value.put("value", rs.getInt("dev_bug_density"));
					data.add(value);
					}while (rs.next());
				
					dataset.put("data", data);
					dataset.put("seriesname", map.get("dev_bug_density"));
					dataset.put("parentYAxis", "S");
					dataset.put("renderAs", "StackColumn");
					datasetArray.add(dataset);
				}
			if (rs.first()) {
				JSONObject dataset = new JSONObject();
				JSONArray data = new JSONArray();
				do{
					JSONObject value = new JSONObject();
					value.put("value", rs.getFloat("test_bug_leave_percent"));
					data.add(value);
					}while (rs.next());
				
					dataset.put("data", data);
					dataset.put("seriesname", map.get("test_bug_leave_percent"));
					dataset.put("parentYAxis", "P");
					dataset.put("renderAs", "StackColumn");
					datasetArray.add(dataset);
				}
			
			resultJson.put("categories", categoriesArray);
			resultJson.put("dataset", datasetArray);
			JSONObject chartJson = new JSONObject();
			
			chartJson.put("palette", "1");
			chartJson.put("caption", "月度运营二级质量KPI");
			chartJson.put("showLabels", "1");
			chartJson.put("showvalues", "0");
			chartJson.put("sYAxisValuesDecimals", "2");
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
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson.toString();
	}
	@Override
	public String getGroupComBox(String querySql) throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		rs = stat.executeQuery(querySql);
		JSONArray groupArray = new JSONArray();
		while (rs.next()) {
			JSONObject group = new JSONObject();
			group.put("value", rs.getString("group_id"));
			group.put("show", rs.getString("group_name"));
			groupArray.add(group);
		}
		BaseDAO.free(rs, stat, conn);
		return groupArray.toString();
	}

	@Override
	public JSONObject statMonthTestGroupKpiList(String groupId,
			String startDate, String endDate, Integer page, Integer start,
			Integer limit) throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		groupId = (groupId!=null&&!groupId.equals(""))?" and group_id="+groupId+" ":"";
		try{
			String SQL="select * from (SELECT t.*,rownum rn FROM stat_month_test_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') "+groupId+" and rownum<= "+(page*limit)+" ORDER BY to_date(t.report_month,'YYYY-MM') ) ";
			logger.info(page+"==="+start+"==="+limit);
			String countSQL="SELECT count(t.stat_id) as count FROM stat_month_test_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') "+groupId;
			SQL+=" where rn>"+((page-1)*limit);
			rs = stat.executeQuery(countSQL);
			int count=0;
			while (rs.next()) {
				count=rs.getInt("count");
			}
			rs = stat.executeQuery(SQL);
			System.out.println("------------"+SQL);
//			WHERE Rownum>=1 AND ROWNUM <=2
//			5===4===1
			JSONArray jsonArray=new JSONArray();
			while (rs.next()) {
				JSONObject json = new JSONObject();
				json.put("STAT_ID", rs.getInt("STAT_ID"));
				json.put("REPORT_MONTH", rs.getString("REPORT_MONTH"));
				json.put("GROUP_ID", rs.getString("GROUP_ID"));
				json.put("GROUP_NAME", rs.getString("GROUP_NAME"));
				json.put("GROUP_ADMIN", rs.getString("GROUP_ADMIN"));
				json.put("BUG_LEFT_PERCENT", rs.getString("BUG_LEFT_PERCENT")==null?"":rs.getString("BUG_LEFT_PERCENT")+"%");
				json.put("BUG_UNVALID_PERCENT", rs.getString("BUG_UNVALID_PERCENT")==null?"":rs.getString("BUG_UNVALID_PERCENT")+"%");
				json.put("CASE_BUG_PERCENT", rs.getString("CASE_BUG_PERCENT")==null?"":rs.getString("CASE_BUG_PERCENT")+"%");
				json.put("TEST_TIMELY_PERCENT", rs.getString("TEST_TIMELY_PERCENT")==null?"":rs.getString("TEST_TIMELY_PERCENT")+"%");
				json.put("TEST_CHECK_TIMELY", rs.getString("TEST_CHECK_TIMELY")==null?"":rs.getString("TEST_CHECK_TIMELY")+"%");
				json.put("CASE_P_AVG_NUM", rs.getString("CASE_P_AVG_NUM"));
				json.put("WORK_LOAD", rs.getString("WORK_LOAD"));
				json.put("WORK_OVER", rs.getString("WORK_OVER"));
				json.put("TESTER_NUM", rs.getString("TESTER_NUM"));
				jsonArray.add(json);
			}
			resultJson.put("data", jsonArray);	
			resultJson.put("result", true);
			resultJson.put("total", count);
		}catch(Exception e){
			e.printStackTrace();
			resultJson.put("result", false);
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson;
	}

	@Override
	public String statMonthTestGroupKpiFunsionCharts(String groupId,
			String startDate, String endDate) throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		groupId = (groupId!=null&&!groupId.equals(""))?" and group_id="+groupId+" ":"";
		try{
			JSONArray categoriesArray = new JSONArray();
			
			/**
			 * 查询有几个月份的数据
			 */
			String sql = "SELECT distinct t.report_month FROM stat_month_test_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
			" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') "+groupId;
			rs = stat.executeQuery(sql);
			JSONArray categoryArray = new JSONArray();
			JSONObject category = new JSONObject();
			StringBuffer monthsBuffer = new StringBuffer();//暂存月份数据
			while (rs.next()) {
				JSONObject category0 = new JSONObject();
				category0.put("label", rs.getString("REPORT_MONTH"));
				monthsBuffer.append(rs.getString("REPORT_MONTH")+",");
				categoryArray.add(category0);
			}
			
			String[] seriesnames = null;
			Map<String,String> map=new HashMap<String,String>();
			
			/**
			 * 根据参数获取组名
			 */
			if(groupId.equals("")){//参数为空,说明没有选择组.
				String querySql = "select distinct t.group_name,t.group_id from stat_month_test_group_kpi t where to_date(t.report_month,'YYYY-MM') " +
				" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') ";
				rs = stat.executeQuery(querySql);
				StringBuffer groupIdBuffer = new StringBuffer();
				StringBuffer groupNameBuffer = new StringBuffer();
				while (rs.next()) {
					groupIdBuffer.append(rs.getString("group_id")+",");
					groupNameBuffer.append(rs.getString("group_name")+",");
				}
				seriesnames = groupIdBuffer.toString().split(",");
				int count = 0;
				for(String name :groupNameBuffer.toString().split(",")){
					map.put(seriesnames[count++],name);
				}
				
			}else{//参数不为空,说明选择了一个组.
				String querySql = "select distinct group_id , group_name from stat_month_test_group_kpi  where 1=1 "+groupId;
				rs = stat.executeQuery(querySql);
				String name = null;
				String id = null;
				while (rs.next()) {
					name = rs.getString("group_name");
					id = rs.getString("group_id");
				}
				seriesnames = new String[]{id};
				map.put(seriesnames[0],name);
			}
			
			
			/**
			 * 分析每个月有几个组的数据
			 */
			String[] months = monthsBuffer.toString().split(",");//获取有数据的月份
			JSONArray datasetArray = new JSONArray();
			if(seriesnames.length>=1){//如果长度小于或等于零,说明没有数据.只有大于1的情况肯定有数据.
				for(String id : seriesnames){
					String idTemp = !id.equals("")?" and t.group_id="+id+" ":"";
					int monthsIndex = 0;
					JSONObject dataset = new JSONObject();
					JSONArray data = new JSONArray();
					while(monthsIndex <= months.length-1){
						sql = "SELECT t.bug_left_percent,t.group_name FROM stat_month_test_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') = to_date('"+months[monthsIndex]+"','YYYY-MM') "+idTemp+" ORDER BY to_date(t.report_month,'YYYY-MM') ";
						System.out.println(sql);
						rs = stat.executeQuery(sql);
						if (rs.first()) {
							do{
								JSONObject value = new JSONObject();
								value.put("value", rs.getString("bug_left_percent"));
								data.add(value);
							}while (rs.next());
							
						}
						monthsIndex++;
					}
					dataset.put("data", data);
					dataset.put("seriesname", map.get(id));
					dataset.put("parentYAxis", "P");
					dataset.put("renderAs", "StackColumn");
					datasetArray.add(dataset);
				}
			}
			
			category.put("category", categoryArray);
			categoriesArray.add(category);
			
			resultJson.put("categories", categoriesArray);
			resultJson.put("dataset", datasetArray);
			JSONObject chartJson = new JSONObject();
			
			chartJson.put("palette", "1");
			chartJson.put("caption", "月度运营三级KPI-测试小组KPI达成情况");
			chartJson.put("showLabels", "1");
			chartJson.put("showvalues", "0");
			chartJson.put("sYAxisValuesDecimals", "2");
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
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson.toString();
	}

	@Override
	public AigaMonthRunKpi[] getAigaMonthRunKpi(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		return statisticDao.getAigaKpiBySql(querySql);
	}

	@Override
	public StatKpiTarget[] getStatKpiTarget(String querySql) throws Exception {
		// TODO Auto-generated method stub
		return statisticDao.getStatKpiTarget(querySql);
	}

	@Override
	public void saveStatKpiTarget(StatKpiTarget aValue) throws Exception {
		// TODO Auto-generated method stub
		statisticDao.saveStatKpiTarget(aValue);
	}

	@Override
	public void submitStatisticsGridStore(List recordList) throws Exception {
		for(Object obj:recordList)statisticDao.saveOrUpdate(obj);
		
	}
	
	@Override
	public void delGridStore(List recordList) throws Exception {
		for(Object obj:recordList)statisticDao.delObject(obj);
	}

	@Override
	public String statMonthDevGroupKpiFunsionCharts(String groupId,
			String startDate, String endDate) throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		groupId = (groupId!=null&&!groupId.equals(""))?" and group_id="+groupId+" ":"";
		try{
			JSONArray categoriesArray = new JSONArray();
			
			/**
			 * 查询有几个月份的数据
			 */
			String sql = "SELECT distinct t.report_month FROM stat_month_dev_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
			" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') "+groupId;
			rs = stat.executeQuery(sql);
			JSONArray categoryArray = new JSONArray();
			JSONObject category = new JSONObject();
			StringBuffer monthsBuffer = new StringBuffer();//暂存月份数据
			while (rs.next()) {
				JSONObject category0 = new JSONObject();
				category0.put("label", rs.getString("REPORT_MONTH"));
				monthsBuffer.append(rs.getString("REPORT_MONTH")+",");
				categoryArray.add(category0);
			}
			
			String[] seriesnames = null;
			Map<String,String> map=new HashMap<String,String>();
			
			/**
			 * 根据参数获取组名
			 */
			if(groupId.equals("")){//参数为空,说明没有选择组.
				String querySql = "select distinct t.group_name,t.group_id from stat_month_dev_group_kpi t where to_date(t.report_month,'YYYY-MM') " +
				" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') ";
				rs = stat.executeQuery(querySql);
				StringBuffer groupIdBuffer = new StringBuffer();
				StringBuffer groupNameBuffer = new StringBuffer();
				while (rs.next()) {
					groupIdBuffer.append(rs.getString("group_id")+",");
					groupNameBuffer.append(rs.getString("group_name")+",");
				}
				seriesnames = groupIdBuffer.toString().split(",");
				int count = 0;
				for(String name :groupNameBuffer.toString().split(",")){
					map.put(seriesnames[count++],name);
				}
				
			}else{//参数不为空,说明选择了一个组.
				String querySql = "select distinct group_id , group_name from stat_month_dev_group_kpi  where 1=1 "+groupId;
				rs = stat.executeQuery(querySql);
				String name = null;
				String id = null;
				while (rs.next()) {
					name = rs.getString("group_name");
					id = rs.getString("group_id");
				}
				seriesnames = new String[]{id};
				map.put(seriesnames[0],name);
			}
			
			
			/**
			 * 分析每个月有几个组的数据
			 */
			String[] months = monthsBuffer.toString().split(",");//获取有数据的月份
			JSONArray datasetArray = new JSONArray();
			if(seriesnames.length>=1){//如果长度小于或等于零,说明没有数据.只有大于1的情况肯定有数据.
				for(String id : seriesnames){//获取综合缺陷密度
					String idTemp = !id.equals("")?" and t.group_id="+id+" ":"";
					int monthsIndex = 0;
					JSONObject dataset = new JSONObject();
					JSONArray data = new JSONArray();
					while(monthsIndex <= months.length-1){
						sql = "SELECT t.dev_bug_density FROM stat_month_dev_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') = to_date('"+months[monthsIndex]+"','YYYY-MM') "+idTemp+" ORDER BY to_date(t.report_month,'YYYY-MM') ";
						System.out.println(sql);
						rs = stat.executeQuery(sql);
						if (rs.first()) {
							do{
								JSONObject value = new JSONObject();
								value.put("value", rs.getString("dev_bug_density"));
								data.add(value);
							}while (rs.next());
							
						}
						monthsIndex++;
					}
					dataset.put("data", data);
					dataset.put("seriesname", map.get(id)+"综合缺陷");
					dataset.put("parentYAxis", "P");
					dataset.put("renderAs", "StackColumn");
					datasetArray.add(dataset);
				}
				for(String id : seriesnames){//二次开发率
					String idTemp = !id.equals("")?" and t.group_id="+id+" ":"";
					int monthsIndex = 0;
					JSONObject dataset = new JSONObject();
					JSONArray data = new JSONArray();
					while(monthsIndex <= months.length-1){
						sql = "SELECT t.double_task_percent FROM stat_month_dev_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') = to_date('"+months[monthsIndex]+"','YYYY-MM') "+idTemp+" ORDER BY to_date(t.report_month,'YYYY-MM') ";
						System.out.println(sql);
						rs = stat.executeQuery(sql);
						if (rs.first()) {
							do{
								JSONObject value = new JSONObject();
								value.put("value", rs.getString("double_task_percent"));
								data.add(value);
							}while (rs.next());
							
						}
						monthsIndex++;
					}
					dataset.put("data", data);
					dataset.put("seriesname", map.get(id)+"二次开发");
					dataset.put("parentYAxis", "P");
					dataset.put("renderAs", "StackColumn");
					datasetArray.add(dataset);
				}
				for(String id : seriesnames){//代码提交及时率
					String idTemp = !id.equals("")?" and t.group_id="+id+" ":"";
					int monthsIndex = 0;
					JSONObject dataset = new JSONObject();
					JSONArray data = new JSONArray();
					while(monthsIndex <= months.length-1){
						sql = "SELECT t.code_commit_timely_percent FROM stat_month_dev_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') = to_date('"+months[monthsIndex]+"','YYYY-MM') "+idTemp+" ORDER BY to_date(t.report_month,'YYYY-MM') ";
						System.out.println(sql);
						rs = stat.executeQuery(sql);
						if (rs.first()) {
							do{
								JSONObject value = new JSONObject();
								value.put("value", rs.getString("code_commit_timely_percent"));
								data.add(value);
							}while (rs.next());
							
						}
						monthsIndex++;
					}
					dataset.put("data", data);
					dataset.put("seriesname", map.get(id)+"代码提交及时率");
					dataset.put("parentYAxis", "P");
					dataset.put("renderAs", "StackColumn");
					datasetArray.add(dataset);
				}
				for(String id : seriesnames){//BUG修复及时率
					String idTemp = !id.equals("")?" and t.group_id="+id+" ":"";
					int monthsIndex = 0;
					JSONObject dataset = new JSONObject();
					JSONArray data = new JSONArray();
					while(monthsIndex <= months.length-1){
						sql = "SELECT t.bug_fix_timely_percent FROM stat_month_dev_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') = to_date('"+months[monthsIndex]+"','YYYY-MM') "+idTemp+" ORDER BY to_date(t.report_month,'YYYY-MM') ";
						System.out.println(sql);
						rs = stat.executeQuery(sql);
						if (rs.first()) {
							do{
								JSONObject value = new JSONObject();
								value.put("value", rs.getString("bug_fix_timely_percent"));
								data.add(value);
							}while (rs.next());
							
						}
						monthsIndex++;
					}
					dataset.put("data", data);
					dataset.put("seriesname", map.get(id)+"BUG修复及时率");
					dataset.put("parentYAxis", "P");
					dataset.put("renderAs", "StackColumn");
					datasetArray.add(dataset);
				}
			}
			
			category.put("category", categoryArray);
			categoriesArray.add(category);
			
			resultJson.put("categories", categoriesArray);
			resultJson.put("dataset", datasetArray);
			JSONObject chartJson = new JSONObject();
			
			chartJson.put("palette", "1");
			chartJson.put("caption", "月度运营三级KPI-测试小组KPI达成情况");
			chartJson.put("showLabels", "1");
			chartJson.put("showvalues", "0");
			chartJson.put("sYAxisValuesDecimals", "2");
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
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson.toString();
	}

	@Override
	public JSONObject statMonthDevGroupKpiList(String groupId,
			String startDate, String endDate, Integer page, Integer start,
			Integer limit) throws Exception {
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		JSONObject resultJson = new JSONObject();
		groupId = (groupId!=null&&!groupId.equals(""))?" and group_id="+groupId+" ":"";
		try{
			String SQL="select * from (SELECT t.*,rownum rn FROM stat_month_dev_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') "+groupId+" and rownum<= "+(page*limit)+" ORDER BY to_date(t.report_month,'YYYY-MM') ) ";
			logger.info(page+"==="+start+"==="+limit);
			String countSQL="SELECT count(t.stat_id) as count FROM stat_month_dev_group_kpi t  WHERE to_date(t.report_month,'YYYY-MM') " +
					" BETWEEN to_date('"+startDate+"','YYYY-MM') AND to_date('"+endDate+"','YYYY-MM') "+groupId;
			SQL+=" where rn>"+((page-1)*limit);
			rs = stat.executeQuery(countSQL);
			int count=0;
			while (rs.next()) {
				count=rs.getInt("count");
			}
			rs = stat.executeQuery(SQL);
			System.out.println("------------"+SQL);
//			WHERE Rownum>=1 AND ROWNUM <=2
//			5===4===1
			JSONArray jsonArray=new JSONArray();
			while (rs.next()) {
				JSONObject json = new JSONObject();
				json.put("STAT_ID", rs.getInt("STAT_ID"));
				json.put("GROUP_ID", rs.getString("GROUP_ID"));
				json.put("GROUP_NAME", rs.getString("GROUP_NAME"));
				json.put("GROUP_ADMIN", rs.getString("GROUP_ADMIN"));
				json.put("REPORT_MONTH", rs.getString("REPORT_MONTH"));
				json.put("PUBLISH_ERROR_PERCENT", rs.getString("PUBLISH_ERROR_PERCENT")==null?"":rs.getString("PUBLISH_ERROR_PERCENT")+"%");//上线故障率
				json.put("DEV_BUG_DENSITY", rs.getString("DEV_BUG_DENSITY")==null?"":rs.getString("DEV_BUG_DENSITY")+"%");//综合缺陷密度
				json.put("DEV_REQ_BUG_DENSITY", rs.getString("DEV_REQ_BUG_DENSITY")==null?"":rs.getString("DEV_REQ_BUG_DENSITY")+"%");//需求缺陷密度
				json.put("DEV_DESIGN_BUG_DENSITY", rs.getString("DEV_DESIGN_BUG_DENSITY")==null?"":rs.getString("DEV_DESIGN_BUG_DENSITY")+"%");//设计缺陷密度
				json.put("DEV_DEV_BUG_DENSITY", rs.getString("DEV_DEV_BUG_DENSITY")==null?"":rs.getString("DEV_DEV_BUG_DENSITY")+"%");//开发缺陷密度
				json.put("TASK_BUG_PERCENT", rs.getString("TASK_BUG_PERCENT")==null?"":rs.getString("TASK_BUG_PERCENT")+"%");//任务单BUG率
				json.put("UNIT_TEST_PASS", rs.getString("UNIT_TEST_PASS")==null?"":rs.getString("UNIT_TEST_PASS")+"%");//单元测试抽检合格率
				json.put("DOUBLE_TASK_PERCENT", rs.getString("DOUBLE_TASK_PERCENT")==null?"":rs.getString("DOUBLE_TASK_PERCENT")+"%");//二次开发率
				json.put("DISTRIBUTE_TO_PUBLISH_TIME", rs.getString("DISTRIBUTE_TO_PUBLISH_TIME"));//需求分派到上线时间
				json.put("CODE_COMMIT_TIMELY_PERCENT", rs.getString("CODE_COMMIT_TIMELY_PERCENT")==null?"":rs.getString("CODE_COMMIT_TIMELY_PERCENT")+"%");//代码提交及时率
				json.put("BUG_FIX_TIMELY_PERCENT", rs.getString("BUG_FIX_TIMELY_PERCENT")==null?"":rs.getString("BUG_FIX_TIMELY_PERCENT")+"%");//BUG修复及时率
				json.put("DEV_WORK_LOAD_PERCENT", rs.getString("DEV_WORK_LOAD_PERCENT"));
				json.put("EST_WORKOVER", rs.getString("EST_WORKOVER"));
				json.put("DEV_WORKOVER", rs.getString("DEV_WORKOVER"));
				json.put("DEV_PERSON_NUM", rs.getString("DEV_PERSON_NUM"));
				jsonArray.add(json);
			}
			resultJson.put("data", jsonArray);	
			resultJson.put("result", true);
			resultJson.put("total", count);
		}catch(Exception e){
			e.printStackTrace();
			resultJson.put("result", false);
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		System.out.println(resultJson);
		return resultJson;
	}

/*	@Override
	public String getTable() {
		return EntityUtil.getTableName(StatMonthOneLevelKpi.class);
		
	}*/
}

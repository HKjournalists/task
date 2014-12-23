package com.asiainfo.aiga.statistics.service;

import java.util.List;

import net.sf.json.JSONObject;


import com.asiainfo.aiga.statistics.bo.AigaMonthDelSla;
import com.asiainfo.aiga.statistics.bo.AigaMonthRepKpi;
import com.asiainfo.aiga.statistics.bo.AigaMonthRunKpi;
import com.asiainfo.aiga.statistics.bo.StatKpiTarget;


/**
 * Created on 2014-10-10
 * <p>Description: [ͳ�Ʒ���ʵ��]</p>
 */
public interface IStatisticsSV {
//	�¶���Ӫһ��KPI
	public String statMonthOneLevelKpiFunsionCharts(String startDate,String endDate) throws Exception;
	public JSONObject statMonthOneLevelKpiList(String startDate,String endDate,Integer page,Integer start,Integer limit) throws Exception;
//	�¶���Ӫ��������KPI	
	public String statMonthTwoLCapacityKpiFunsionCharts(String startDate,String endDate) throws Exception;
	public String statMonthTwoLQualityKpiFunsionCharts(String startDate,String endDate) throws Exception;
	public JSONObject statMonthTwoLCapacityKpiList(String startDate,String endDate,Integer page,Integer start,Integer limit) throws Exception;
//	�¶���Ӫ����Ч��KPI
	public String statMonthTwoLEffKpiFunsionCharts(String startDate,String endDate) throws Exception;
	public JSONObject statMonthTwoLEffKpiList(String startDate,String endDate,Integer page,Integer start,Integer limit) throws Exception;
	public JSONObject statMonthTwoLQualityKpiList(String startDate,String endDate,Integer page,Integer start,Integer limit) throws Exception;
	public void saveAigaKpi(Object aValue)throws Exception;
	public void submitStatisticsGridStore(List recordList)throws Exception;
	public AigaMonthRunKpi[] getAigaMonthRunKpi(String querySql) throws Exception;
	public List getObjectByHQL(String HQL ) throws Exception ;
	public String getAigaMonthDelSlaList(String querySql) throws Exception;
	
//�¶���Ӫ����KPI-����С��KPI������	
	public String getGroupComBox(String querySql) throws Exception;
	public JSONObject statMonthTestGroupKpiList(String groupId, String startDate,String endDate,Integer page,Integer start,Integer limit) throws Exception;
	public String statMonthTestGroupKpiFunsionCharts(String groupId, String startDate,String endDate) throws Exception;
	
	
//�¶���Ӫ����KPI-����С��KPI������
	public JSONObject statMonthDevGroupKpiList(String groupId, String startDate,String endDate,Integer page,Integer start,Integer limit) throws Exception;
	public String statMonthDevGroupKpiFunsionCharts(String groupId, String startDate,String endDate) throws Exception;
	
	
	public AigaMonthDelSla[] getAigaMonthDelSla(String querySql) throws Exception;
	public void saveAigaMonthDelSla(AigaMonthDelSla aValue)throws Exception;
	public boolean updateBySQL(String SQL) throws Exception; 
	
	public AigaMonthRepKpi[] getAigaMonthRepKpi(String querySql) throws Exception;
	public void saveAigaMonthRepKpi(AigaMonthRepKpi aValue)throws Exception;
	
	public StatKpiTarget[] getStatKpiTarget(String querySql) throws Exception;
	public void saveStatKpiTarget(StatKpiTarget aValue)throws Exception;
	void delGridStore(List recordList) throws Exception;
}

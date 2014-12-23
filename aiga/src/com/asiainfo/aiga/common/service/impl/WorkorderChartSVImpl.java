package com.asiainfo.aiga.common.service.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.asiainfo.aiga.common.dao.IWorkorderChartDao;
import com.asiainfo.aiga.common.service.IWorkorderChartSV;
import com.asiainfo.aiga.search.dao.BaseDAO;

public class WorkorderChartSVImpl implements IWorkorderChartSV{

	IWorkorderChartDao chartDao;
	public void setChartDao(IWorkorderChartDao chartDao) {
		this.chartDao = chartDao;
	}
	@Override
	public String getChartDataJson(String staffNo) throws Exception {
		// TODO Auto-generated method stub
		JSONObject resultJson = new JSONObject();
		List<String> createTime = new ArrayList<String>();
		List<String> labelList = new ArrayList<String>();
		try{
			JSONObject chartJson = new JSONObject();
			chartJson.put("caption", "工单统计");
			chartJson.put("subcaption", "待办工单");
			chartJson.put("showvalues", "0");
			chartJson.put("numberprefix", "工单");
			chartJson.put("plotspacepercent", "10");
			chartJson.put("plotgradientcolor", "");
			chartJson.put("plotborderalpha", "0");
			chartJson.put("canvasbordercolor", "#6E98AA");
			chartJson.put("canvasborderalpha", "25");
			chartJson.put("canvasborderthickness", "1");
			chartJson.put("outCnvbaseFontSize", "13");
			chartJson.put("bgalpha", "0");
			chartJson.put("alternatehgridalpha", "0");
			chartJson.put("numbersuffix", "条");
			chartJson.put("divlinecolor", "#6E98AA");
			chartJson.put("basefontcolor", "#6E98AA");
			chartJson.put("legendbordercolor", "#6E98AA");
			chartJson.put("legendshadow", "0");
			chartJson.put("divlinealpha", "25");
			chartJson.put("tooltipbordercolor", "#6E98AA");
			chartJson.put("bordercolor", "#6E98AA");
			chartJson.put("legendborderalpha", "30");
			chartJson.put("palettecolors", "#02295B,#FCB63C,#A8B1B8");
			chartJson.put("showborder", "0");
			resultJson.put("chart", chartJson);
			
			Iterator rs = chartDao.getChartBySQL("select distinct show from alm_workorder_list,sys_constant where category='OBJ_TYPE' and obj_type=value");
			JSONArray categoriesArray = new JSONArray();
			JSONArray categoryArray = new JSONArray();
			while(rs!=null&&rs.hasNext()){
				Object show = rs.next();
				JSONObject label = new JSONObject();
				label.put("label", show.toString());
				labelList.add(show.toString());
				categoryArray.add(label);
			}
			JSONObject category = new JSONObject();
			category.put("category", categoryArray);
			categoriesArray.add(category);
			resultJson.put("categories", categoriesArray);
			
			JSONArray datasetArray = new JSONArray();
			rs = chartDao.getChartBySQL("select distinct to_char(create_time,'yyyymm') as create_time from alm_workorder_list order by create_time");
			while(rs!=null&&rs.hasNext()){
				Object object = rs.next();
				createTime.add(object.toString());
			}
			
			for(int i=0,n=createTime.size();i<n;i++){
				JSONObject dataset = new JSONObject();
				dataset.put("seriesname", createTime.get(i));
				List rs1 = chartDao.getArrayChartBySQL("select show,to_char(create_time,'yyyymm') as create_time ,count(*) as orderSum from alm_workorder_list,sys_constant where category='OBJ_TYPE' and alm_workorder_list.status=2 and exec_staff_no='"+staffNo+"' and to_char(create_time,'yyyymm')="+createTime.get(i)+" and obj_type=value group by show,to_char(create_time,'yyyymm')");
				JSONArray data = new JSONArray();
				for(int j=0,z=labelList.size();j<z;j++){
					String label = labelList.get(j);
					boolean hasData = false;
					for(int a=0;rs1!=null&&a<rs1.size();a++){
						Object[] list = (Object[])rs1.get(a);
						Object show = list[0];
						Object orderSum = list[2];
						if(label.equals(show.toString())){
							JSONObject value = new JSONObject();
							value.put("value", orderSum.toString());
							data.add(value);
							hasData = true;
							break;
						}
					}
					if(hasData==false){
						JSONObject value = new JSONObject();
						value.put("value", "0");
						data.add(value);
					}
					dataset.put("data", data);
				}
				datasetArray.add(dataset);
			}
			resultJson.put("dataset", datasetArray);
			System.out.println(resultJson);
		}catch(Exception e){
			e.printStackTrace();
		}
		return resultJson.toString();
	}

}

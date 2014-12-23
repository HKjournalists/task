package com.asiainfo.aiga.userCase.service.impl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.search.dao.BaseDAO;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;
import com.asiainfo.aiga.userCase.bo.AigaFunFolder;
import com.asiainfo.aiga.userCase.dao.IAigaFunFolderDAO;
import com.asiainfo.aiga.userCase.service.IAigaFunFolderSV;

public class AigaFunFolderSVImpl implements IAigaFunFolderSV{

	private IAigaFunFolderDAO aigaFunFolderDAO;
	
	public void setAigaFunFolderDAO(IAigaFunFolderDAO aigaFunFolderDAO) {
		this.aigaFunFolderDAO = aigaFunFolderDAO;
	}

	@Override
	public AigaFunFolder[] getAigaFunFolder(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaFunFolderDAO.getFunFolders(criteria);
	}

	@Override
	public void saveAigaFunFolder(AigaFunFolder aValue) throws Exception {
		// TODO Auto-generated method stub
		try{
			short temp = aValue.getIsEfficiencyTest();
			if(temp==0){
				aValue.setEfficiencyTestType((short)3);
			}
		}catch(Exception e){
			
		}
		aigaFunFolderDAO.saveFunFolders(aValue);
	}

	@Override
	public AigaFunFolder[] getAigaFunFolderBySql(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaFunFolderDAO.getAigaFunFolderBySql(querySql);
	}

	
	@Override
	public String caseCoverageCountChart() throws Exception {
		// TODO Auto-generated method stub
		JSONObject resultJson = new JSONObject();
		Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
		Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = null;
		try{
			JSONObject chartJson = new JSONObject();
			chartJson.put("caption", "用例功能点覆盖率");
			chartJson.put("subcaption", "");
			chartJson.put("showvalues", "0.0");
			chartJson.put("numberprefix", "覆盖率");
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
			rs = stat.executeQuery("SELECT count(fun_id) as countFuns FROM aiga_fun_folder ");
			int countFuns=0;
			while(rs.next()){
				countFuns=rs.getInt("countFuns");
			}
			JSONArray categoriesArray = new JSONArray();
			JSONArray categoryArray = new JSONArray();
			JSONObject category = new JSONObject();
			JSONArray datasetArray = new JSONArray();
			SysConstant[] sysContants = SysContentUtil.getSysContant("test_type");
			JSONObject dataset = new JSONObject();
			dataset.put("seriesname", "");
			JSONArray data = new JSONArray();
			for (SysConstant sysContant : sysContants) {
				JSONObject label = new JSONObject();
				label.put("label", sysContant.getShow());
				categoryArray.add(label);
				String SQL="SELECT COUNT(t.fun_id) as funs FROM aiga_fun_folder t , aiga_inst_case c WHERE c.fun_folder_id  = t.fun_id AND c.test_type LIKE '%"+sysContant.getValue()+"%' ";
				rs = stat.executeQuery(SQL);
				float numerator=0;
				while(rs.next()){numerator=rs.getFloat("funs");}
				System.out.println(numerator+"===============");
				 BigDecimal bg = new BigDecimal(numerator*100/countFuns);
			     double floatValue = bg.setScale(10, BigDecimal.ROUND_HALF_UP).doubleValue();
				JSONObject value = new JSONObject();
				value.put("value", floatValue);
				data.add(value);
			}
			dataset.put("data", data);
			datasetArray.add(dataset);
			category.put("category", categoryArray);
			categoriesArray.add(category);
			resultJson.put("categories", categoriesArray);
			resultJson.put("dataset", datasetArray);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, stat, conn);
		}
		return resultJson.toString();
	}
public static void main(String[] args) {
	float a=10*100;
	int b=23;
	 BigDecimal bg = new BigDecimal(a/b);
     double f1 = bg.setScale(1, BigDecimal.ROUND_HALF_UP).doubleValue();
     System.out.println(f1);
}

@Override
public List getSubSysCoverage() throws Exception {
	List<Map<String, Float[]>> list=new ArrayList<Map<String, Float[]>>();
	Connection conn = BaseDAO.getBaseDaoInstance().getConnection();
	Statement stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rs = null;
	try{
		int maxCounts=0;
		SysConstant[] sysContants = SysContentUtil.getSysContant("test_type");
		String getCountSQL="SELECT count(asf.sys_id) as count FROM AIGA_SYSTEM_FOLDER asf ,AIGA_FUN_FOLDER aff WHERE asf.sys_id=aff.sys_id(+) GROUP BY  asf.sys_id";
		rs = stat.executeQuery(getCountSQL);
		maxCounts=rs.getRow();
		List<Float> flocatCounts=new ArrayList<Float>();
		while(rs.next()){
			flocatCounts.add(Float.valueOf(rs.getInt("count")));
		}
		for(int i=0,n=sysContants.length;i<n;i++){
			SysConstant sysContant=sysContants[i];
			String SQL=" SELECT asf.sys_name,temp_fun.funcount FROM aiga_system_folder asf ,(SELECT COUNT(t.sys_id ) AS funcount,t.sys_id"+
					" FROM AIGA_FUN_FOLDER T, AIGA_INST_CASE C"+
					" WHERE C.FUN_FOLDER_ID = T.FUN_ID  AND c.test_type LIKE '%"+sysContant.getValue()+"%' "+
					" GROUP BY T.SYS_ID  ) temp_fun WHERE asf.sys_id=temp_fun.sys_id(+)";	
			rs = stat.executeQuery(SQL);
			maxCounts=rs.getRow();
//			if(maxCounts!=rs.getRow()||maxCounts!=0)throw new Exception("查询有误");
			while(rs.next()){
				if(i==0){
					Map<String,Float[]> sysCountMap=new HashMap<String,Float[]>();
					Float[] valueFloats=new Float[sysContants.length];
					int num=rs.getInt("funcount");
					Float f=(Float)flocatCounts.get(rs.getRow()-1);
					valueFloats[i]=Integer.valueOf(num)/f;
					sysCountMap.put(rs.getString("sys_name"), valueFloats);
					list.add(sysCountMap);
				}else{
					Map<String,Float[]> sysCountMap=list.get(rs.getRow()-1);
					Float[] values=sysCountMap.get(rs.getString("sys_name"));
					int num=rs.getInt("funcount");
					Float f=(Float)flocatCounts.get(rs.getRow()-1);
					values[i]=num/f;
				}
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		BaseDAO.free(rs, stat, conn);
	}
	return list;
}

	@Override
	public void deleteAigaFunFolder(String funIds) throws Exception {
		String[] funIdArray = funIds.split(",");
		for(String funId : funIdArray){
			AigaFunFolder[] aigaFunFolder = aigaFunFolderDAO.getAigaFunFolderBySql("FROM AigaFunFolder a WHERE a.funId="+funId);
			if(aigaFunFolder.length==1){
				aigaFunFolder[0].setIsInvalid((short)1);//标识不可用
			}else{
				throw new Exception("参数错误");
			}
		}
	}
}

package com.asiainfo.aiga.p2pTest.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiOneLevel;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiScene;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiTwoLevel;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pCase;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pCaseTemp;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pFunctionPoint;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pTestElem;
import com.asiainfo.aiga.p2pTest.dao.IAigaP2PDAO;
import com.asiainfo.aiga.p2pTest.service.IAigaP2PServiceSV;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;

/**
 * Created on 2014-11-18
 * <p>Description: [描述该类概要功能介绍]</p>
 */
public class AigaP2PServiceSVImpl implements IAigaP2PServiceSV{
	private IAigaP2PDAO p2pTestDAO;
	
	public IAigaP2PDAO getP2pTestDAO() {
		return p2pTestDAO;
	}

	public void setP2pTestDAO(IAigaP2PDAO p2pTestDAO) {
		this.p2pTestDAO = p2pTestDAO;
	}

	@Override
	public AigaP2pBusiOneLevel[] getAigaP2pBusiOneLevel(DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return p2pTestDAO.getAigaP2pBusiOneLevel(criteria);
	}

	@Override
	public AigaP2pBusiTwoLevel[] getAigaP2pBusiTwoLevel(DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return p2pTestDAO.getAigaP2pBusiTwoLevel(criteria);
	}

	@Override
	public JSONArray getBaseFunctionJSONObjs() throws Exception {
		// TODO Auto-generated method stub
		JSONArray jsonArry=new JSONArray();
		List<Object[]> list=p2pTestDAO.getObjectListBySQL("SELECT APBF.BASE_FUN_ID, APBF.BASE_FUN_NAME FROM AIGA_P2P_BASE_FUNCTION APBF");
		for(Object obj:list){
			Object[] objs=(Object[])obj;
			if(objs.length!=2)throw new Exception("返回数据长度异常");
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("funId",objs[0]);
			jsonObj.put("funName",objs[1]);
			jsonArry.add(jsonObj);
		}
		return jsonArry;
	}

	@Override
	public JSONArray getChannelJSONObjs() throws Exception {
		// TODO Auto-generated method stub
		JSONArray jsonArry=new JSONArray();
		String SQL="SELECT APC.CHANNEL_ID, APC.CHANNEL_NAME FROM AIGA_P2P_CHANNEL APC WHERE APC.IS_P2P_CHANNEL = 0 ";
		List<Object[]> list=p2pTestDAO.getObjectListBySQL(SQL);
		for(Object obj:list){
			Object[] objs=(Object[])obj;
			if(objs.length!=2)throw new Exception("返回数据长度异常");
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("channelId",objs[0]);
			jsonObj.put("channelName",objs[1]);
			jsonArry.add(jsonObj);
		}
		return jsonArry;
	}

	@Override
	public void saveOrUpdate(Object aValue) throws Exception {
		// TODO Auto-generated method stub
		p2pTestDAO.saveOrUpdate(aValue);
	}

	@Override
	public void delete(Object aValue) throws Exception {
		// TODO Auto-generated method stub
		p2pTestDAO.delete(aValue);
	}

	@Override
	public List getObjectByHQL(String HQL) throws Exception {
		// TODO Auto-generated method stub
		return p2pTestDAO.getObjectByHQL(HQL);
	}

	@Override
	public JSONArray getP2pCaseCollectionCombox(String busiId,String type) throws Exception {
		// TODO Auto-generated method stub
		JSONArray jsonAry=new JSONArray();
		String tetElemHQL="From AigaP2pTestElem WHERE busiTwoLevelId="+busiId;
		List<AigaP2pTestElem> aigaP2pTestElemList=p2pTestDAO.getObjectByHQL(tetElemHQL);
		List<String> sqlList=new ArrayList<String>();
		if(aigaP2pTestElemList.size()==1){
			AigaP2pTestElem aigaP2pTestElem=aigaP2pTestElemList.get(0);
			if(type.equals("channelCombobox")&&aigaP2pTestElem.getChannelIds()!=null&&!aigaP2pTestElem.getChannelIds().trim().isEmpty()){
				String channelComboxSQL="SELECT apc.channel_id,apc.channel_name ,cast('AigaP2pChannel' as varchar2(20)) AS store_GROUP  FROM aiga_p2p_channel apc WHERE apc.channel_id IN ("+aigaP2pTestElem.getChannelIds()+")";
				sqlList.add(channelComboxSQL);
			}
			
			if(type.equals("baseFunCombobox")&&aigaP2pTestElem.getBaseFunctionIds()!=null&&!aigaP2pTestElem.getBaseFunctionIds().trim().isEmpty()){
				String baseFunctionComboxSQL="SELECT apbf.base_fun_id,apbf.base_fun_name ,cast('AigaP2pBaseFunction' as varchar2(20))  AS store_GROUP  FROM  aiga_p2p_base_function apbf WHERE apbf.base_fun_id IN ("+aigaP2pTestElem.getBaseFunctionIds()+")";
				sqlList.add(baseFunctionComboxSQL);
			}
//			sqlList.add("SELECT apfp.fun_id,apfp.sys_name ,cast('AigaP2pFunctionPoint' as varchar2(20)) AS store_GROUP FROM aiga_p2p_function_point apfp ");
		/*	sqlList.add("SELECT APCT.CASE_ID, "
					+ "APCT.CASE_NAME, CAST('AigaP2pCase' AS VARCHAR2(20)) AS STORE_GROUP "
					+ "FROM AIGA_P2P_CASE_TEMP APCT "
					+ "UNION ALL "
					+ "SELECT APC.CASE_ID, "
					+ "APC.CASE_NAME, CAST('AigaP2pCase' AS VARCHAR2(20)) AS STORE_GROUP  "
					+ " FROM AIGA_P2P_CASE APC ");*/
			for(String sql:sqlList){
				List<Object[]> list=p2pTestDAO.getObjectListBySQL(sql);
				for(Object obj:list){
					Object[] objs=(Object[])obj;
					if(objs.length!=3)throw new Exception("返回数据长度异常");
					JSONObject jsonObj=new JSONObject();
					jsonObj.put("value",objs[0]);
					jsonObj.put("show",objs[1]);
					jsonObj.put("group",objs[2]);
					jsonAry.add(jsonObj);
				}
			}
		/*	SysConstant[] sysConstants=SysContentUtil.getSysContant("AigaP2pCauseType","AigaP2pVerifyStatus");
			for(SysConstant obj:sysConstants){
				JSONObject jsonObj=new JSONObject();
				jsonObj.put("value",obj.getValue());
				jsonObj.put("show",obj.getShow());
				jsonObj.put("group",obj.getCategory());
				jsonAry.add(jsonObj);
			}*/
			
		}
		
		return jsonAry;
	}
	@Override
	public JSONArray getP2pPointCaseCombox(String busiId) throws Exception {
		JSONArray jsonAry = new JSONArray();
		List<String> sqlList = new ArrayList<String>();
		sqlList.add("SELECT APCT.CASE_ID, "
				+ "APCT.CASE_NAME, CAST('AigaP2pCase' AS VARCHAR2(20)) AS STORE_GROUP, "
				+ "APCT.PRECONDITION, "
				+ "APCT.EXPECTATION, "
				+ "APCT.OPERATE_DESC "
				+ "FROM AIGA_P2P_CASE_TEMP APCT "
				+ "UNION ALL "
				+ "SELECT APC.CASE_ID, "
				+ "APC.CASE_NAME, CAST('AigaP2pCase' AS VARCHAR2(20)) AS STORE_GROUP , "
				+ "APC.PRECONDITION, " + "APC.EXPECTATION, "
				+ "APC.OPERATE_DESC " + "FROM AIGA_P2P_CASE APC ");
		for (String sql : sqlList) {
			List<Object[]> list = p2pTestDAO.getObjectListBySQL(sql);
			for (Object obj : list) {
				Object[] objs = (Object[]) obj;
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("value", objs[0]);
				jsonObj.put("show", objs[1]);
				jsonObj.put("group", objs[2]);
				jsonObj.put("value1", objs.length == 4 ? objs[3] : "");
				jsonObj.put("value2", objs.length == 5 ? objs[4] : "");
				jsonObj.put("value3", objs.length == 6 ? objs[5] : "");
				jsonAry.add(jsonObj);
			}
		}

		return jsonAry;
	}
	@Override
	public JSONArray getFunPointCase(String channel) throws Exception {
		// TODO Auto-generated method stub
		JSONArray jsonAry=new JSONArray();
		String querySQL="SELECT distinct APFP.Fun_Id,APFP.Sys_Name,APCT.CASE_ID,APCT.CASE_NAME " +
				"  FROM AIGA_P2P_CASE_TEMP  APCT, "+
				"AIGA_P2P_FUNCTION_POINT APFP, "+
				"AIGA_P2P_BUSI_CASE_COLLECTION APBCC "+
				"WHERE APCT.CASE_ID=APBCC.Case_Id AND APBCC.FUN_ID=APFP.FUN_ID ";
		if(channel!=null&&channel.length()!=0){
			querySQL+=" and APFP.Sys_Name LIKE '%"+channel.trim()+"%'";
		}
		List<Object[]> list=p2pTestDAO.getObjectListBySQL(querySQL);
		for(Object obj:list){
			Object[] objs=(Object[])obj;
			if(objs.length!=4)throw new Exception("返回数据长度异常");
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("funId",objs[0]);
			jsonObj.put("sysName",objs[1]);
			jsonObj.put("caseId",objs[2]);
			jsonObj.put("caseName",objs[3]);
			jsonAry.add(jsonObj);
		}
		return jsonAry;
	}
	@Override
	public JSONArray getP2pCaseCollectByBusiId(String busiTwoLevelId) throws Exception {
		// TODO Auto-generated method stub
		JSONArray jsonAry=new JSONArray();
		String querySQL="SELECT APBCC.COLLECT_ID,"+
							" APBCC.BASE_BUSI_ID,"+
							" APBCC.CHANNEL_ID,"+
							" APBCC.BUSI_TWO_LEVEL_ID,"+
							" APBCC.FUN_ID,"+
							" APBCC.CASE_ID,"+
							" APBCC.REMARK,"+
							" APBCC.SOURCE,"+
							" APBCC.CAUSE,"+
							" APBCC.CAUSE_TYPE,"+
							" APBCC.STATUS,"+
							" APBCC.VERIFY_STATUS,"+
							" APBCC.VERIFY_RESULT,"+
							" APBCC.CREATE_TIME,"+
							" APBCC.CREATOR_ID,"+
							" APBCC.CREATOR_NAME,"+
							" TO_CHAR(CASE "+
						         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						         " APCT.PRECONDITION ELSE APC.PRECONDITION "+
						    " END )AS PRECONDITION ,"+
						    " TO_CHAR(CASE "+
						         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						         	"  APCT.OPERATE_DESC " +
						         "ELSE " +
						         	"APC.OPERATE_DESC "+
						    " END )AS OPERATE_DESC , "+
						    " TO_CHAR(CASE "+
						         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						         	"  APCT.EXPECTATION " +
						         "ELSE " +
						         	"APC.EXPECTATION "+
						    " END  )AS EXPECTATION,"+
						    " CASE "+
					         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
					         	"  APCT.CASE_NAME " +
					         "ELSE " +
					         	"APC.CASE_NAME "+
					    " END AS CASENAME ,"+
					    " CASE "+
				         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
				         	"  APCT.CASE_DESC " +
				         "ELSE " +
				         	"APC.CASE_DESC "+
				         	" END AS CASE_DESC ,"+
						    " CASE"+
						    	" WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						    		" 'AigaP2pCaseTemp' "+
						    	" ELSE "+
						    " 'AigaP2pCase' "+
						    "  END AS CASECLASS , "+
						    "  (SELECT APBF.BASE_FUN_NAME FROM AIGA_P2P_BASE_FUNCTION APBF WHERE APBF.BASE_FUN_ID=APBCC.BASE_BUSI_ID )," +
						    "  (SELECT APCN.CHANNEL_NAME FROM AIGA_P2P_CHANNEL APCN WHERE APCN.CHANNEL_ID = APBCC.CHANNEL_ID ), "+
						    "  (SELECT APFP.SYS_NAME FROM AIGA_P2P_FUNCTION_POINT APFP WHERE APFP.FUN_ID = APBCC.FUN_ID )," +
						    "  (SELECT count( DISTINCT t.busi_two_level_id) FROM aiga_p2p_busi_case_collection t WHERE t.case_id=APBCC.CASE_ID) "+
							" FROM AIGA_P2P_BUSI_CASE_COLLECTION APBCC ,  AIGA_P2P_CASE_TEMP APCT,AIGA_P2P_CASE APC "+
							" WHERE APBCC.CASE_ID = APC.CASE_ID(+)  AND APBCC.CASE_ID = APCT.CASE_ID(+) AND APBCC.BUSI_TWO_LEVEL_ID ="+busiTwoLevelId;
		List<Object[]> list=p2pTestDAO.getObjectListBySQL(querySQL);
		for(Object obj:list){
			Object[] objs=(Object[])obj;
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("collectId",objs[0]);
			jsonObj.put("baseBusiId",objs[1]);
			jsonObj.put("channelId",objs[2]);
			jsonObj.put("busiTwoLevelId",objs[3]);
			jsonObj.put("funId",objs[4]);
			jsonObj.put("caseId",objs[5]);
			jsonObj.put("remark",objs[6]);
			jsonObj.put("source",objs[7]);
			jsonObj.put("cause",objs[8]);
			jsonObj.put("casuseType",objs[9]);
			try{
				if(CommonHelper.NaNull(objs[9]))jsonObj.put("casuseName",SysContentUtil.getSysConstant("AigaP2pCauseType", String.valueOf(objs[9])).getShow());
			}catch (Exception e) {e.printStackTrace();}
			jsonObj.put("status",objs[10]);
			jsonObj.put("verifyStatus",objs[11]);
			try{
				if(CommonHelper.NaNull(objs[11]))jsonObj.put("verifyStatusName",SysContentUtil.getSysConstant("AigaP2pVerifyStatus", String.valueOf(objs[11])).getShow());
			}catch (Exception e) {e.printStackTrace();}
			jsonObj.put("verifyResult",objs[12]);
			jsonObj.put("createTime",objs[13]);
			jsonObj.put("creatorId",objs[14]);
			jsonObj.put("creatorName",objs[15]);
			jsonObj.put("precondition",objs[16]);
			jsonObj.put("operateDesc",objs[17]);
			jsonObj.put("expectation",objs[18]);
			jsonObj.put("caseName",objs[19]);
			jsonObj.put("caseDesc",objs[20]);
			jsonObj.put("caseClass",objs[21]);
			jsonObj.put("baseBusiName",objs[22]);
			jsonObj.put("channelName",objs[23]); 
			jsonObj.put("sysName",objs[24]); 
			jsonObj.put("caseTwoLevelCount",objs[25]); 
			jsonAry.add(jsonObj);
		}
		return jsonAry;
	}

	@Override
	public boolean updateBySQL(String SQL) throws Exception {
		// TODO Auto-generated method stub
		p2pTestDAO.updateBySQL(SQL);
		return true;
	}

	@Override
	public boolean moveCaseData(AigaP2pCase aigaP2pCase) throws Exception {
		if(aigaP2pCase.getCaseId()!=null){
			String SQL="INSERT INTO AIGA_P2P_CASE_TEMP" +
					"(CASE_ID," +
					"CASE_NAME,PRECONDITION,EXPECTATION,OPERATE_DESC," +
					"CASE_DESC,SOURCE,REMARK,CREATE_TIME,CREATOR_ID,CREATOR_NAME,CAUSE,CAUSE_TYPE," +
					"STATUS,VERIFY_STATUS,VERIFY_RESULT)" +
					"(SELECT CASE_ID," +
					"'"+aigaP2pCase.getCaseName()+"','"+aigaP2pCase.getPrecondition()+"','"+aigaP2pCase.getExpectation()+"','"+aigaP2pCase.getOperateDesc()+"'," +
					"CASE_DESC," +
					"SOURCE,REMARK,CREATE_TIME,CREATOR_ID,CREATOR_NAME,CAUSE,CAUSE_TYPE," +
					"STATUS,VERIFY_STATUS,0" +
					" FROM AIGA_P2P_CASE" +
					" WHERE CASE_ID = "+aigaP2pCase.getCaseId()+")";
			 p2pTestDAO.updateBySQL(SQL);
			 SQL="DELETE AIGA_P2P_CASE WHERE CASE_ID = "+aigaP2pCase.getCaseId();
			 p2pTestDAO.updateBySQL(SQL);
		return true;
		}
		return false;
	}

	@Override
	public boolean updateCaseSomeFields(AigaP2pCaseTemp aigaP2pCaseTemp) throws Exception {
		// TODO Auto-generated method stub
		String SQL="UPDATE AIGA_P2P_CASE_TEMP SET " +
				" CASE_NAME='"+aigaP2pCaseTemp.getCaseName()
				+"',PRECONDITION='"+aigaP2pCaseTemp.getPrecondition()
				+"',CASE_DESC='"+aigaP2pCaseTemp.getCaseDesc()
				+"',EXPECTATION='"+aigaP2pCaseTemp.getExpectation()
				+"',OPERATE_DESC='"+aigaP2pCaseTemp.getOperateDesc()+"'"
				+(CommonHelper.NaNull(aigaP2pCaseTemp.getCause())?",CAUSE='"+aigaP2pCaseTemp.getCause()+"'":"")
				+(CommonHelper.NaNull(aigaP2pCaseTemp.getCauseType())?",CAUSE_TYPE="+aigaP2pCaseTemp.getCauseType():"")
				+" WHERE CASE_ID="+aigaP2pCaseTemp.getCaseId();
		return  updateBySQL(SQL);
	}
	@Override
	public JSONArray getNewBusiFunctionPoint(String sysId,String funPointName) throws Exception {
		String querySQL="SELECT " +
				"AFF.FUN_ID," +
				"AFF.SYS_NAME," +
				"AFF.CREATE_TIME," +
				"AFF.UPDATE_TIME," +
				"AFF.MENU_PATH," +
				"AFF.BASE_FUN_LABEL," +
				"AFF.BUSI_LABEL," +
				"AFF.OPERATOR_ID," +
				"AFF.OPERATOR_NAME," +
				"AFF.CREATOR_ID," +
				"AFF.CREATOR_NAME " +
				" FROM AIGA_FUN_FOLDER AFF WHERE " +
				" 1=1 " +
				(funPointName!=null&&!funPointName.equals("")?" AND AFF.SYS_NAME LIKE '%"+funPointName+"%'":"")+
//				报表查询  系统管理  报表管理 资源管理  批量业务  AIGA_NEW_BUSI_FOLDER_SQL
				" AND AFF.IS_INVALID=0 " +SysContentUtil.getSysConstant("AIGA_NEW_BUSI_FOLDER_SQL", "1").getShow() +
				" AND AFF.SUB_SYS_ID IN (" +
									"SELECT ASSF.SUBSYS_ID " +
									" FROM AIGA_SUB_SYS_FOLDER " +
									" ASSF WHERE ASSF.SYS_ID IN (" +
																	"SELECT ASF.SYS_ID " +
																	"	FROM AIGA_SYSTEM_FOLDER ASF " +
																	" WHERE 1=1 "+
																	((sysId!=null&&!sysId.equals(""))?" AND ASF.SYS_ID ="+sysId:"")+") )";
		List<Object[]> list=p2pTestDAO.getObjectListBySQL(querySQL);
		System.out.println(querySQL);
		JSONArray jsonAry=new JSONArray();
		for(Object obj:list){
			Object[] objs=(Object[])obj;
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("funId",objs[0]);
			jsonObj.put("sysName",objs[1]);
			jsonObj.put("createTime",objs[2]);
			jsonObj.put("updateTime",objs[3]);
			jsonObj.put("menuPath",objs[4]);
			jsonObj.put("baseBusiLabel",objs[5]);
			jsonObj.put("busiLabel",objs[6]);
			jsonObj.put("operatorId",objs[7]);
			jsonObj.put("operatorName",objs[8]);
			jsonObj.put("creatorId",objs[9]);
			jsonObj.put("creatorName",objs[10]);
			jsonAry.add(jsonObj);
		}
		return jsonAry;
	}
	@Override
	public String getAigaNewBusiCaseCount(String funName, String caseName)throws Exception {
		String sql="SELECT " +
				" to_char(count(AIC.CASE_ID)) " +
				"  FROM AIGA_INST_CASE AIC " +
				"  WHERE 1=1 " +
				" AND AIC.CASE_ID IN (SELECT DISTINCT AFCR.CASE_ID FROM "+ 
                " AIGA_FUN_CASE_RELA AFCR, "+
                " AIGA_FUN_FOLDER    AFF WHERE AFCR.FOLDER_ID=AFF.FUN_ID "+(CommonHelper.NaNull(funName)?" AND aff.SYS_NAME LIKE '%"+funName+"%' ":" ")+" )"+
//				" and  AIC.CASE_PRE_COND IS NOT NULL AND AIC.PRE_RESULT IS NOT NULL AND AIC.CASE_OPERATE_INST IS NOT NULL " +
				(CommonHelper.NaNull(caseName)?" AND AIC.CASE_NAME LIKE'%"+caseName+"%' ":"");
		List<String> list=p2pTestDAO.getObjectListBySQL(sql);
		return list.get(0);
	}
	@Override
	public JSONArray getAigaNewBusiCase(String funName, String caseName,Integer page,Integer limit)throws Exception {
		String sql="SELECT * FROM (SELECT " +
				" AIC.CASE_ID, " +
				" AIC.CASE_NAME , " +
				" AIC.CASE_DESC , " +
				" TO_CHAR(AIC.CASE_PRE_COND ), " +
				" TO_CHAR(AIC.PRE_RESULT), " +
				" TO_CHAR(AIC.CASE_OPERATE_INST), " +
				" ROWNUM RN  " +
				"  FROM AIGA_INST_CASE AIC " +
				"  WHERE 1=1" +
				"  AND ROWNUM <= "+(page*limit) +
				" AND AIC.CASE_ID IN (SELECT DISTINCT AFCR.CASE_ID FROM "+ 
                " AIGA_FUN_CASE_RELA AFCR, "+
                " AIGA_FUN_FOLDER    AFF WHERE AFCR.FOLDER_ID=AFF.FUN_ID "+(CommonHelper.NaNull(funName)?" AND aff.SYS_NAME LIKE '%"+funName+"%' ":" ")+" )"+
//				" and  AIC.CASE_PRE_COND IS NOT NULL AND AIC.PRE_RESULT IS NOT NULL AND AIC.CASE_OPERATE_INST IS NOT NULL " +
				(CommonHelper.NaNull(caseName)?" AND AIC.CASE_NAME LIKE'%"+caseName+"%' ":"")+" ) WHERE RN > "+(page-1)*limit;
		List<Object[]> list=p2pTestDAO.getObjectListBySQL(sql);
		JSONArray jsonAry=new JSONArray();
		for(Object obj:list){
			Object[] objs=(Object[])obj;
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("caseId",CommonHelper.NullValueFilter(objs[0]));
			jsonObj.put("caseName",CommonHelper.NullValueFilter(objs[1]));
			jsonObj.put("caseDesc",CommonHelper.NullValueFilter(objs[2]));
			jsonObj.put("precondition",CommonHelper.NullValueFilter(objs[3]));
			jsonObj.put("expectation",CommonHelper.NullValueFilter(objs[4]));
			jsonObj.put("operateDesc",CommonHelper.NullValueFilter(objs[5]));
			jsonAry.add(jsonObj);
		}
		return jsonAry;
	}

	@Override
	public void saveP2pCase(AigaP2pCaseTemp aigaP2pCaseTemp) throws Exception {
		if(aigaP2pCaseTemp.getCaseId()==null||aigaP2pCaseTemp.getCaseId()==0){
			String checkOnlyNameSQL="SELECT apc.case_Id FROM aiga_p2p_case apc WHERE apc.case_name ='"+aigaP2pCaseTemp.getCaseName()+"' UNION ALL SELECT apct.case_Id FROM aiga_p2p_case_temp apct WHERE apct.case_name ='"+aigaP2pCaseTemp.getCaseName()+"'";
			List<Object[]> list=p2pTestDAO.getObjectListBySQL(checkOnlyNameSQL);
			if(list.size()>0)throw new Exception("用例名称唯一性校验失败!");
			}
		p2pTestDAO.saveOrUpdate(aigaP2pCaseTemp);
		}

	@Override
	public void saveP2pFunPoint(AigaP2pFunctionPoint aigaP2pFunctionPoint)throws Exception {
		// TODO Auto-generated method stub
		if(aigaP2pFunctionPoint.getFunId()==null||aigaP2pFunctionPoint.getFunId()==0){
			String checkOnlyNameSQL="SELECT apfp.fun_id from aiga_p2p_function_point apfp where apfp.sys_name ='"+aigaP2pFunctionPoint.getSysName()+"'";
			List<Object[]> list=p2pTestDAO.getObjectListBySQL(checkOnlyNameSQL);
			if(list.size()>0)throw new Exception("功能点唯一性校验失败!");
			}
		p2pTestDAO.saveOrUpdate(aigaP2pFunctionPoint);
		
	}

	@Override
	public JSONArray getBusiScene(String BusiId) throws Exception {
		// TODO Auto-generated method stub
		String SQL="SELECT APBC.SC_ID," +
					" APBC.SCENE_NAME," +
					" APBC.ANALYSIS_METHOD," +
					" APBC.SC_ORDER," +
					" APBC.IS_DELETE," +
					" APBC.CREATE_TIME," +
					" APBC.CREATOR_ID," +
					" APBC.CREATOR_NAME," +
					" APBC.CAUSE," +
					" APBC.CAUSE_TYPE,"+
					" APBC.BUSI_ID, " +
					" TO_CHAR(CASE "
				+ " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "
				+ " APCT.CASE_ID  ELSE APC.CASE_ID "
				+ " END) AS CASE_ID,"
				+ " TO_CHAR(CASE "
				+ " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "
				+ " APCT.PRECONDITION ELSE APC.PRECONDITION "
				+ " END )AS PRECONDITION ,"
				+ " TO_CHAR(CASE "
				+ " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "
				+ "  APCT.OPERATE_DESC " + "ELSE " + "APC.OPERATE_DESC "
				+ " END )AS OPERATE_DESC , " + " TO_CHAR(CASE "
				+ " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "
				+ "  APCT.EXPECTATION " + "ELSE " + "APC.EXPECTATION "
				+ " END  )AS EXPECTATION," + " CASE "
				+ " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "
				+ "  APCT.CASE_NAME " + "ELSE " + "APC.CASE_NAME "
				+ " END AS CASENAME ," + " CASE"
				+ " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "
				+ " 'AigaP2pCaseTemp' " + " ELSE " + " 'AigaP2pCase' "
				+ "  END AS CASECLASS  " +
					" FROM AIGA_P2P_BUSI_SCENE APBC ," +
					" AIGA_P2P_BUSI_CASE_COLLECTION APBCC ," +
					" AIGA_P2P_SCENE_COLLECT_RELA APSCR, " +
					" AIGA_P2P_CASE APC, " +
					" AIGA_P2P_CASE_TEMP APCT " +
					" WHERE APBC.SC_ID(+)=APSCR.SCENE_ID " +
					" AND APSCR.COLLECT_ID=APBCC.COLLECT_ID(+) " +
					" AND APBCC.CASE_ID=APC.CASE_ID(+) AND APBCC.CASE_ID = APCT.CASE_ID(+) " +
					" AND APBC.BUSI_ID = " +BusiId+
					" ORDER BY APBC.SC_ID  , APSCR.COLLECT_INDEX ";
	
//		System.out.println(SQL);
//		List<Object[]> list=p2pTestDAO.getObjectListBySQL(SQL);
		JSONArray jsonAry=new JSONArray();
		String hasScId="";
//		List<String> sceneNameList=new ArrayList<String>();
/*		for(Object[] objs:list){
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("scId", objs[0]);
			hasScId+=String.valueOf(objs[0])+",";
			String sceneName=String.valueOf(objs[1]);
			if(!sceneNameList.contains(sceneName)){
				jsonObj.put("sceneName", objs[1]);
				sceneNameList.add(0,sceneName);
			}
			jsonObj.put("analysisMethod", objs[2]);
			jsonObj.put("scOrder", objs[3]);
			jsonObj.put("isDelete", objs[4]);
			jsonObj.put("createTime", CommonHelper.dateToString(objs[5],"yyyy-MM-dd HH:mm:ss"));
			jsonObj.put("creatorId", objs[6]);
			jsonObj.put("creatorName", objs[7]);
			jsonObj.put("cause", objs[8]);
			jsonObj.put("causeType", objs[9]);
			if(CommonHelper.NaNull(jsonObj.get("causeType")))jsonObj.put("casuseTypeName",SysContentUtil.getSysConstant("AigaP2pCauseType", String.valueOf(jsonObj.get("causeType"))).getShow());
			jsonObj.put("busiId", objs[10]);
			jsonObj.put("caseId", objs[11]);
			jsonObj.put("precondition", objs[12]);
			jsonObj.put("opeateDesc", objs[13]);
			jsonObj.put("exception", objs[14]);
			jsonObj.put("caseName", objs[15]);
			jsonObj.put("caseClass", objs[16]);
			jsonAry.add(jsonObj);
		}*/
		String HQL="From AigaP2pBusiScene WHERE 1=1 "+(CommonHelper.NaNull(BusiId)?" and busiId="+BusiId :"");
		List<AigaP2pBusiScene> sceneList=p2pTestDAO.getObjectByHQL(HQL);
		for(AigaP2pBusiScene scene:sceneList){
			//此处不该引用BaseAction.jsonConfig
			JSONObject jsonObj=JSONObject.fromObject(scene,CommonHelper.jsonConfig);
			jsonObj.put("createTime",CommonHelper.dateToString(scene.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
			Integer causeType=scene.getCauseType();
			if(CommonHelper.NaNull(causeType))jsonObj.put("casuseTypeName",SysContentUtil.getSysConstant("AigaP2pCauseType", String.valueOf(causeType)).getShow());
			jsonAry.add(jsonObj);
		}
		return jsonAry;
	}
	
	@Override
	public JSONArray getP2pCaseCollectBySceneId(String busiTwoLevelId,String sceneId) throws Exception {
		// TODO Auto-generated method stub
		JSONArray jsonAry=new JSONArray();
		if(!CommonHelper.NaNull(sceneId)){
			return jsonAry;
		}
		String querySQL="SELECT APBCC.COLLECT_ID,"+
							" APBCC.BASE_BUSI_ID,"+
							" APBCC.CHANNEL_ID,"+
							" APBCC.BUSI_TWO_LEVEL_ID,"+
							" APBCC.FUN_ID,"+
							" APBCC.CASE_ID,"+
							" APBCC.REMARK,"+
							" APBCC.SOURCE,"+
							" APBCC.CAUSE,"+
							" APBCC.CAUSE_TYPE,"+
							" APBCC.STATUS,"+
							" APBCC.VERIFY_STATUS,"+
							" APBCC.VERIFY_RESULT,"+
							" APBCC.CREATE_TIME,"+
							" APBCC.CREATOR_ID,"+
							" APBCC.CREATOR_NAME,"+
							" TO_CHAR(CASE "+
						         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						         " APCT.PRECONDITION ELSE APC.PRECONDITION "+
						    " END )AS PRECONDITION ,"+
						    " TO_CHAR(CASE "+
						         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						         	"  APCT.OPERATE_DESC " +
						         "ELSE " +
						         	"APC.OPERATE_DESC "+
						    " END )AS OPERATE_DESC , "+
						    " TO_CHAR(CASE "+
						         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						         	"  APCT.EXPECTATION " +
						         "ELSE " +
						         	"APC.EXPECTATION "+
						    " END  )AS EXPECTATION,"+
						    " CASE "+
					         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
					         	"  APCT.CASE_NAME " +
					         "ELSE " +
					         	"APC.CASE_NAME "+
					    " END AS CASENAME ,"+
						    " CASE"+
						    	" WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						    		" 'AigaP2pCaseTemp' "+
						    	" ELSE "+
						    " 'AigaP2pCase' "+
						    "  END AS CASECLASS , "+
						    "  (SELECT APBF.BASE_FUN_NAME FROM AIGA_P2P_BASE_FUNCTION APBF WHERE APBF.BASE_FUN_ID=APBCC.BASE_BUSI_ID )," +
						    "  (SELECT APCN.CHANNEL_NAME FROM AIGA_P2P_CHANNEL APCN WHERE APCN.CHANNEL_ID = APBCC.CHANNEL_ID ), "+
						    "  (SELECT APFP.SYS_NAME FROM AIGA_P2P_FUNCTION_POINT APFP WHERE APFP.FUN_ID = APBCC.FUN_ID ) "+
							" FROM AIGA_P2P_BUSI_CASE_COLLECTION APBCC ,  AIGA_P2P_CASE_TEMP APCT,AIGA_P2P_CASE APC ,AIGA_P2P_SCENE_COLLECT_RELA APSC "+
							" WHERE APBCC.CASE_ID = APC.CASE_ID(+)  AND APBCC.CASE_ID = APCT.CASE_ID(+) AND APSC.COLLECT_ID=APBCC.COLLECT_ID AND APSC.SCENE_ID ="+sceneId+"  ORDER BY APSC.COLLECT_INDEX ";
		List<Object[]> list=p2pTestDAO.getObjectListBySQL(querySQL);
		for(Object obj:list){
			Object[] objs=(Object[])obj;
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("collectId",objs[0]);
			jsonObj.put("baseBusiId",objs[1]);
			jsonObj.put("channelId",objs[2]);
			jsonObj.put("busiTwoLevelId",objs[3]);
			jsonObj.put("funId",objs[4]);
			jsonObj.put("caseId",objs[5]);
			jsonObj.put("remark",objs[6]);
			jsonObj.put("source",objs[7]);
			jsonObj.put("cause",objs[8]);
			jsonObj.put("casuseType",objs[9]);
			try{
				if(CommonHelper.NaNull(objs[9]))jsonObj.put("casuseName",SysContentUtil.getSysConstant("AigaP2pCauseType", String.valueOf(objs[9])).getShow());}catch(Exception e){e.printStackTrace();}
			jsonObj.put("status",objs[10]);
			jsonObj.put("verifyStatus",objs[11]);
			try{
				if(CommonHelper.NaNull(objs[11]))jsonObj.put("verifyStatusName",SysContentUtil.getSysConstant("AigaP2pVerifyStatus", String.valueOf(objs[11])).getShow());}catch(Exception e){e.printStackTrace();}
			jsonObj.put("verifyResult",objs[12]);
			jsonObj.put("createTime",objs[13]);
			jsonObj.put("creatorId",objs[14]);
			jsonObj.put("creatorName",objs[15]);
			jsonObj.put("precondition",objs[16]);
			jsonObj.put("operateDesc",objs[17]);
			jsonObj.put("expectation",objs[18]);
			jsonObj.put("caseName",objs[19]);
			jsonObj.put("caseClass",objs[20]);
			jsonObj.put("baseBusiName",objs[21]);
			jsonObj.put("channelName",objs[22]); 
			jsonObj.put("sysName",objs[23]); 
			jsonAry.add(jsonObj);
		}
		return jsonAry;
	}
	@Override
	public JSONArray getP2pCaseCollectComplementBySceneId(String busiTwoLevelId,String sceneId) throws Exception {
		// TODO Auto-generated method stub
		if(CommonHelper.NaNull(busiTwoLevelId)&&!CommonHelper.NaNull(sceneId))
		{
			System.out.println("getP2pCaseCollectBySceneId  busiTwoLevelId="+busiTwoLevelId+"  scId="+sceneId);
			return getP2pCaseCollectByBusiId(busiTwoLevelId);
		}
		JSONArray jsonAry=new JSONArray();
		String querySQL="SELECT APBCC.COLLECT_ID,"+
							" APBCC.BASE_BUSI_ID,"+
							" APBCC.CHANNEL_ID,"+
							" APBCC.BUSI_TWO_LEVEL_ID,"+
							" APBCC.FUN_ID,"+
							" APBCC.CASE_ID,"+
							" APBCC.REMARK,"+
							" APBCC.SOURCE,"+
							" APBCC.CAUSE,"+
							" APBCC.CAUSE_TYPE,"+
							" APBCC.STATUS,"+
							" APBCC.VERIFY_STATUS,"+
							" APBCC.VERIFY_RESULT,"+
							" APBCC.CREATE_TIME,"+
							" APBCC.CREATOR_ID,"+
							" APBCC.CREATOR_NAME,"+
							" TO_CHAR(CASE "+
						         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						         " APCT.PRECONDITION ELSE APC.PRECONDITION "+
						    " END )AS PRECONDITION ,"+
						    " TO_CHAR(CASE "+
						         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						         	"  APCT.OPERATE_DESC " +
						         "ELSE " +
						         	"APC.OPERATE_DESC "+
						    " END )AS OPERATE_DESC , "+
						    " TO_CHAR(CASE "+
						         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						         	"  APCT.EXPECTATION " +
						         "ELSE " +
						         	"APC.EXPECTATION "+
						    " END  )AS EXPECTATION,"+
						    " CASE "+
					         " WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
					         	"  APCT.CASE_NAME " +
					         "ELSE " +
					         	"APC.CASE_NAME "+
					    " END AS CASENAME ,"+
						    " CASE"+
						    	" WHEN APC.CASE_ID IS NULL OR APC.CASE_ID = '' THEN "+
						    		" 'AigaP2pCaseTemp' "+
						    	" ELSE "+
						    " 'AigaP2pCase' "+
						    "  END AS CASECLASS , "+
						    "  (SELECT APBF.BASE_FUN_NAME FROM AIGA_P2P_BASE_FUNCTION APBF WHERE APBF.BASE_FUN_ID=APBCC.BASE_BUSI_ID )," +
						    "  (SELECT APCN.CHANNEL_NAME FROM AIGA_P2P_CHANNEL APCN WHERE APCN.CHANNEL_ID = APBCC.CHANNEL_ID ), "+
						    "  (SELECT APFP.SYS_NAME FROM AIGA_P2P_FUNCTION_POINT APFP WHERE APFP.FUN_ID = APBCC.FUN_ID ) "+
							" FROM AIGA_P2P_BUSI_CASE_COLLECTION APBCC ,  AIGA_P2P_CASE_TEMP APCT,AIGA_P2P_CASE APC "+
							" WHERE APBCC.CASE_ID = APC.CASE_ID(+)  AND APBCC.CASE_ID = APCT.CASE_ID(+) AND APBCC.BUSI_TWO_LEVEL_ID ="+busiTwoLevelId +
							(CommonHelper.NaNull(sceneId)?" AND APBCC.COLLECT_ID NOT IN (SELECT APSCR.COLLECT_ID FROM AIGA_P2P_SCENE_COLLECT_RELA APSCR WHERE APSCR.SCENE_ID ="+sceneId+")":"");
		List<Object[]> list=p2pTestDAO.getObjectListBySQL(querySQL);
		for(Object obj:list){
			Object[] objs=(Object[])obj;
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("collectId",objs[0]);
			jsonObj.put("baseBusiId",objs[1]);
			jsonObj.put("channelId",objs[2]);
			jsonObj.put("busiTwoLevelId",objs[3]);
			jsonObj.put("funId",objs[4]);
			jsonObj.put("caseId",objs[5]);
			jsonObj.put("remark",objs[6]);
			jsonObj.put("source",objs[7]);
			jsonObj.put("cause",objs[8]);
			jsonObj.put("casuseType",objs[9]);
			try{
				if(CommonHelper.NaNull(objs[9]))
					jsonObj.put("casuseName",SysContentUtil.getSysConstant("AigaP2pCauseType", String.valueOf(objs[9])).getShow());
			}catch (Exception e) {
				e.printStackTrace();
			}
			jsonObj.put("status",objs[10]);
			jsonObj.put("verifyStatus",objs[11]);
			try{if(CommonHelper.NaNull(objs[11]))jsonObj.put("verifyStatusName",SysContentUtil.getSysConstant("AigaP2pVerifyStatus", String.valueOf(objs[11])).getShow());
			}catch (Exception e) {
				e.printStackTrace();
			}
			jsonObj.put("verifyResult",objs[12]);
			jsonObj.put("createTime",objs[13]);
			jsonObj.put("creatorId",objs[14]);
			jsonObj.put("creatorName",objs[15]);
			jsonObj.put("precondition",objs[16]);
			jsonObj.put("operateDesc",objs[17]);
			jsonObj.put("expectation",objs[18]);
			jsonObj.put("caseName",objs[19]);
			jsonObj.put("caseClass",objs[20]);
			jsonObj.put("baseBusiName",objs[21]);
			jsonObj.put("channelName",objs[22]); 
			jsonObj.put("sysName",objs[23]); 
			jsonAry.add(jsonObj);
		}
		return jsonAry;
	}

	@Override
	public void delSceneCollectRelaBySceneId(String scId) throws Exception {
		// TODO Auto-generated method stub
		String SQL="DELETE aiga_p2p_scene_collect_rela APSCR WHERE APSCR.SCENE_ID=" +scId;
		p2pTestDAO.updateBySQL(SQL);
	}

	@Override
	public void delSceneBySceneIds(String[] scIds) throws Exception {
		// TODO Auto-generated method stub
		String SQL="DELETE aiga_p2p_busi_scene APBC WHERE APBC.SC_ID IN (" +CommonHelper.array2String(scIds)+")";
		p2pTestDAO.updateBySQL(SQL);
		SQL="DELETE aiga_p2p_scene_collect_rela APSCR WHERE APSCR.SCENE_ID IN (" +CommonHelper.array2String(scIds)+")";
		p2pTestDAO.updateBySQL(SQL);
	}

	@Override
	public List getObjectListBySQL(String SQL) throws Exception {
		// TODO Auto-generated method stub
		return p2pTestDAO.getObjectListBySQL(SQL);
	}
}

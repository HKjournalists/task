package com.asiainfo.aiga.p2pTest.web;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.poi.ss.formula.functions.Na;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.common.security.user.util.StaffUtil;
import com.asiainfo.aiga.common.service.ICommonPageinationSV;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiCaseCollection;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiOneLevel;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiScene;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiTwoLevel;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pCase;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pCaseTemp;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pFunctionPoint;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pSceneCollectRela;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pSceneSubTaskRela;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pTestElem;
import com.asiainfo.aiga.p2pTest.service.IAigaP2PServiceSV;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;

/**
 * Created on 2014-11-18
 * <p>Description: [描述该类概要功能介绍]</p>
 */
@Controller
public class AigaP2PAction extends BaseAction{
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(AigaP2PAction.class);
	public static  String p2pNormalMac="";
	public static  String p2pTemporaryTag="";
	public static  String p2pSubTaskTag="";
	public static  Integer initStatus=0;//状态的初始值
	public static  Integer initVerifyStatus=0;//评审状态的初始值
	public static  Integer busiTwoLevelId=0;
	private Integer getCauseType(){
		SysConstant[] sysConstants=SysContentUtil.getSysContant("AigaP2pCauseType");
		if(NaNull(p2pNormalMac)){
			for(SysConstant sys:sysConstants){
				if(sys.getMemo().equals("p2pNormalMac"))return sys.getValue();
			}
		}
		else
		if(NaNull(p2pTemporaryTag)){
			for(SysConstant sys:sysConstants){
				if(sys.getMemo().equals("p2pTemporaryTag"))return sys.getValue();
			}
		}
		else
		if(NaNull(p2pSubTaskTag)){
			for(SysConstant sys:sysConstants){
				if(sys.getMemo().equals("p2pSubTaskTag"))return sys.getValue();
			}
		}
		return 0;
	}
	private String getCause(){
		if(NaNull(p2pNormalMac)){
			return p2pNormalMac;
		}
		if(NaNull(p2pTemporaryTag)){
			return p2pTemporaryTag;
		}
		if(NaNull(p2pSubTaskTag)){
			return p2pSubTaskTag;
		}
		return "";
	}
	@Resource(name="commonPageinationSV")
	private ICommonPageinationSV commonPageinationSV;
	@Resource(name="p2pTestSV")
	private IAigaP2PServiceSV p2pTestSV;
	@RequestMapping("/getP2PCaseTreeSyn.do")
	public void getP2PCaseTreeSyn(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String node = request.getParameter("node");
		String flag = request.getParameter("flag");
		String[] strAigaBusiOneLevelIds=request.getParameterValues("P2pBusiOneLevelIds");
		String[] strAigaBusiTwoLevelIds=request.getParameterValues("P2pBusiTwoLevelIds");
		String[] strTypes=request.getParameterValues("types");
		String clickFlag = request.getParameter("clickFlag");
		int[] aigaBusiOneLevelIds=null;
		int[] aigaBusiTwoLevelIds=null;
		System.out.println("============"+clickFlag);
		Boolean isAutoExpand=false;
		if(clickFlag!=null&&clickFlag.equals("query")){
			isAutoExpand=true;
		}
		if(isAutoExpand){
			if(strAigaBusiOneLevelIds!=null&&strAigaBusiOneLevelIds.length!=0&&NaNull(strAigaBusiOneLevelIds[0])){
				aigaBusiOneLevelIds=new int[strAigaBusiOneLevelIds.length];
				for(int i=0;i<strAigaBusiOneLevelIds.length;i++){
					aigaBusiOneLevelIds[i]=Integer.valueOf(strAigaBusiOneLevelIds[i]);
				}
			}
			if(strAigaBusiTwoLevelIds!=null&&strAigaBusiTwoLevelIds.length!=0&&NaNull(strAigaBusiTwoLevelIds[0])){
				aigaBusiTwoLevelIds=new int[strAigaBusiTwoLevelIds.length];
				for(int i=0;i<aigaBusiTwoLevelIds.length;i++){
					aigaBusiTwoLevelIds[i]=Integer.valueOf(strAigaBusiTwoLevelIds[i]);
				}
			}			
		}
		List<Object> childTrees = new ArrayList<Object>();
		if(flag.equals("AigaP2pBusiOneLevel")){
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaP2pBusiOneLevel.class);
			AigaP2pBusiOneLevel[] aigaP2pBusiLevels = p2pTestSV.getAigaP2pBusiOneLevel(criteria);
			for(AigaP2pBusiOneLevel aigaP2pBusiLevel : aigaP2pBusiLevels){
				Tree childeTree = new Tree();
				int p2pBusiId=aigaP2pBusiLevel.getP2pBusiId();
				String busiName=aigaP2pBusiLevel.getBusiName();
				if(isAutoExpand)if(aigaBusiOneLevelIds!=null&&!CommonHelper.ArrayHasValue(aigaBusiOneLevelIds,p2pBusiId))continue;
				childeTree.setId(p2pBusiId);
				childeTree.setExpanded(isAutoExpand&&(strAigaBusiTwoLevelIds!=null));
				childeTree.setLeaf(false);
				childeTree.setParentId(Integer.valueOf(node));
				childeTree.setText(busiName);
				childeTree.setValue(String.valueOf(p2pBusiId));
				childeTree.setType("AigaP2pBusiOneLevel");
				childTrees.add(childeTree);
			}
		}else if(flag.equals("AigaP2pBusiTwoLevel")){
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaP2pBusiTwoLevel.class);
			criteria.add(Restrictions.eq("busiType", Integer.valueOf(node)));
			criteria.add(Restrictions.eq("isInvalid", Integer.valueOf("0")));
			AigaP2pBusiTwoLevel[] aigaP2pBusiTwoLevels = p2pTestSV.getAigaP2pBusiTwoLevel(criteria);
			for(AigaP2pBusiTwoLevel aigaP2pBusiLevel : aigaP2pBusiTwoLevels){
				Tree childeTree = new Tree();
				int p2pBusiId=aigaP2pBusiLevel.getP2pBusiId();
				String busiName=aigaP2pBusiLevel.getBusiName();
				if(isAutoExpand){
					if(aigaBusiTwoLevelIds!=null&&!CommonHelper.ArrayHasValue(aigaBusiTwoLevelIds,p2pBusiId))continue;
				}
				childeTree.setId(p2pBusiId);
				childeTree.setExpanded(false);
				childeTree.setLeaf(false);
				childeTree.setParentId(Integer.valueOf(node));
				childeTree.setText(busiName);
				childeTree.setValue(String.valueOf(p2pBusiId));
				childeTree.setType("AigaP2pBusiTwoLevel");
				childeTree.setLeaf(true);
				childTrees.add(childeTree);
			}
		}
		JSONObject retJson=new JSONObject();
		retJson.put("children", childTrees);
		retJson.put("success", true);
		ActionHelper.returnResponseData(request, response, retJson);
	}
	@RequestMapping("/getBaseFunctionCombox.do")
	public void getBaseFunctionCombox(HttpServletRequest request, HttpServletResponse response)throws Exception{
		JSONObject json=new JSONObject();
		json.put("data", p2pTestSV.getBaseFunctionJSONObjs());
		json.put("success", "true");
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping("/getChannelCombox.do")
	public void getChannelCombox(HttpServletRequest request, HttpServletResponse response)throws Exception{
		JSONObject json=new JSONObject();
		json.put("data", p2pTestSV.getChannelJSONObjs());
		json.put("success", "true");
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping("/getAigaP2pTestElem.do")
	public void getAigaP2pTestElem(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String busiTwoLevelId=request.getParameter("busiTwoLevelId");
		String HQL="From AigaP2pTestElem where busiTwoLevelId="+busiTwoLevelId;
		List list=p2pTestSV.getObjectByHQL(HQL);
		AigaP2pTestElem aigaP2pTestElem=new AigaP2pTestElem();
		if(list.size()>0)aigaP2pTestElem=(AigaP2pTestElem)list.get(0);
		Map retMap=new JSONObject();
		retMap.put("success", true);
		retMap.put("data", JSONObject.fromObject(aigaP2pTestElem, jsonConfig));
		ActionHelper.returnResponseData(request, response, retMap);
		
	}
	@RequestMapping("/saveAigaP2pTestElem.do")
	public void saveAigaP2pTestElem(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Object[] objs=transFormToObj(request,new Class[]{AigaP2pTestElem.class});
		Map map =new HashMap();
		map.put("success", true);
		try{
			AigaP2pTestElem aigaP2pTestElem=(AigaP2pTestElem)objs[0];
			aigaP2pTestElem.setCreateTime(CommonHelper.getCurrentTimestamp());
			aigaP2pTestElem.setCreatorId(StaffUtil.getUserId(request));
			aigaP2pTestElem.setCreatorName(StaffUtil.getUserName(request));
			p2pTestSV.saveOrUpdate(aigaP2pTestElem);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getP2pCaseCollectionCombox.do")
	public void getP2pCaseCollectionCombox(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Object[] objs=transFormToObj(request,new Class[]{AigaP2pTestElem.class});
		Map map =new HashMap();
		map.put("success", true);
		try{
			//基础业务ID	渠道ID	功能点ID	用例ID
//			aiga_p2p_test_elem
			String busiTwoLevelId=request.getParameter("busiTwoLevelId");
			String type=request.getParameter("type");
			type=this.NullValueFilter(type);
			map.put("data",p2pTestSV.getP2pCaseCollectionCombox(busiTwoLevelId,type));
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getP2pBusiCaseCollection.do")
	public void getP2pBusiCaseCollection(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map =new HashMap();
		map.put("success", true);
		try{
			String busiTwoLevelId=request.getParameter("busiTwoLevelId");
			map.put("data",p2pTestSV.getP2pCaseCollectByBusiId(busiTwoLevelId));
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/saveP2pBusiCaseCollection.do")
	public void saveP2pBusiCaseCollection(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map =new HashMap();
		map.put("success", true);
		Object[] collectionObjs=this.transTableToObj(request, AigaP2pBusiCaseCollection.class);
		Object[] caseObjs=this.transTableToObj(request, AigaP2pCase.class);
		Object[] funPointObjs=this.transTableToObj(request, AigaP2pFunctionPoint.class);
		Map<String,Integer> funIdMap=new HashMap<String,Integer>();
		Map<String,Integer> caseIdMap=new HashMap<String,Integer>();
		try{
			int n=collectionObjs.length;
			Integer userId=StaffUtil.getUserId(request);
			String userName=StaffUtil.getUserName(request);
			
			if(caseObjs.length!=n||funPointObjs.length!=n)throw new Exception("transTableToObj方法 转换异常!");
			for (int i = 0; i < n; i++) {
				AigaP2pFunctionPoint aigaFunctionPoint = (AigaP2pFunctionPoint) funPointObjs[i];
				funIdMap.put(aigaFunctionPoint.getSysName(), aigaFunctionPoint.getFunId());
				AigaP2pCase aigaP2pCase = (AigaP2pCase) caseObjs[i];
				caseIdMap.put(aigaP2pCase.getCaseName(), aigaP2pCase.getCaseId());
			}
			StringBuffer funNameSb=new StringBuffer("FROM AigaP2pFunctionPoint where sysName in (");
			
			for (String key : funIdMap.keySet()) {
				funNameSb.append("'");
				funNameSb.append(key);
				funNameSb.append("'");
				funNameSb.append(",");
			}
			StringBuffer caseNameSb=new StringBuffer("FROM AigaP2pCase where caseName in (");
			StringBuffer caseTempNameSb=new StringBuffer("FROM AigaP2pCaseTemp where caseName in (");
			for (String key : caseIdMap.keySet()) {
				caseNameSb.append("'");
				caseNameSb.append(key);
				caseNameSb.append("'");
				caseNameSb.append(",");
				caseTempNameSb.append("'");
				caseTempNameSb.append(key);
				caseTempNameSb.append("'");
				caseTempNameSb.append(",");
			}
			funNameSb.append("'1'");
			funNameSb.append(")");
			caseNameSb.append("'1'");
			caseNameSb.append(")");
			caseTempNameSb.append("'1'");
			caseTempNameSb.append(")");
			
			List<AigaP2pFunctionPoint> funList=p2pTestSV.getObjectByHQL(funNameSb.toString());
			List<AigaP2pCase> caseList=p2pTestSV.getObjectByHQL(caseNameSb.toString());
			List<AigaP2pCaseTemp> caseTempList=p2pTestSV.getObjectByHQL(caseTempNameSb.toString());
			for(AigaP2pFunctionPoint functionPoint :funList){
				funIdMap.put(functionPoint.getSysName(), functionPoint.getFunId());
			}
			for(AigaP2pCase aigaP2pCase :caseList){
				caseIdMap.put(aigaP2pCase.getCaseName(), aigaP2pCase.getCaseId());
			}
			for(AigaP2pCaseTemp aigaP2pCase :caseTempList){
				caseIdMap.put(aigaP2pCase.getCaseName(), aigaP2pCase.getCaseId());
			}
			for (int i = 0; i < n; i++) {
				AigaP2pBusiCaseCollection aigaP2pBusiCaseCollection = (AigaP2pBusiCaseCollection) collectionObjs[i];
				AigaP2pCase aigaP2pCase = (AigaP2pCase) caseObjs[i];
				AigaP2pFunctionPoint aigaFunctionPoint = (AigaP2pFunctionPoint) funPointObjs[i];
				aigaFunctionPoint.setFunId(funIdMap.get(aigaFunctionPoint.getSysName()));
				aigaP2pCase.setCaseId(caseIdMap.get(aigaP2pCase.getCaseName()));
				if(aigaFunctionPoint.getFunId()==null||aigaFunctionPoint.getFunId()==0){
					aigaFunctionPoint.setFunId(null);
					aigaFunctionPoint.setCreatorId(userId);
					aigaFunctionPoint.setCreatorName(userName);
					aigaFunctionPoint.setCreateTime(CommonHelper.getCurrentTimestamp());
					aigaFunctionPoint.setStatus(initStatus);
					aigaFunctionPoint.setVerifyStatus(initVerifyStatus);
					aigaFunctionPoint.setCauseType(getCauseType());
					aigaFunctionPoint.setCause(getCause());
					p2pTestSV.saveP2pFunPoint(aigaFunctionPoint);
					funIdMap.put(aigaFunctionPoint.getSysName(), aigaFunctionPoint.getFunId());
				}
				aigaP2pBusiCaseCollection.setFunId(aigaFunctionPoint.getFunId());
				
				aigaP2pCase.setCaseId(caseIdMap.get(aigaP2pCase.getCaseName()));
				if(aigaP2pCase.getCaseId()==null||aigaP2pCase.getCaseId().equals(0)){
					AigaP2pCaseTemp aigaP2pCaseTemp=new AigaP2pCaseTemp();
					aigaP2pCaseTemp.setCaseId(null);
					aigaP2pCaseTemp.setCaseName(aigaP2pCase.getCaseName());
					aigaP2pCaseTemp.setCaseDesc(aigaP2pCase.getCaseDesc());
					aigaP2pCaseTemp.setExpectation(aigaP2pCase.getExpectation());
					aigaP2pCaseTemp.setOperateDesc(aigaP2pCase.getOperateDesc());
					aigaP2pCaseTemp.setPrecondition(aigaP2pCase.getPrecondition());
					aigaP2pCaseTemp.setCreatorId(userId);
					aigaP2pCaseTemp.setCreatorName(userName);
					aigaP2pCaseTemp.setCreateTime(CommonHelper.getCurrentTimestamp());
					aigaP2pCaseTemp.setStatus(initStatus);
					aigaP2pCaseTemp.setVerifyStatus(initVerifyStatus);
					aigaP2pCaseTemp.setCauseType(getCauseType());
					aigaP2pCaseTemp.setCause(getCause());
					p2pTestSV.saveP2pCase(aigaP2pCaseTemp);
					caseIdMap.put(aigaP2pCaseTemp.getCaseName(), aigaP2pCaseTemp.getCaseId());
					aigaP2pCase.setCaseId(aigaP2pCaseTemp.getCaseId());
				}else{
					List<AigaP2pCase> caseListGetByCaseId=p2pTestSV.getObjectByHQL("From AigaP2pCase where caseId="+aigaP2pCase.getCaseId());
					List<AigaP2pCaseTemp> caseTempListGetByCaseId=p2pTestSV.getObjectByHQL("From AigaP2pCaseTemp where caseId="+aigaP2pCase.getCaseId());
					if(caseListGetByCaseId!=null&&caseListGetByCaseId.size()==1){
						if(!aigaP2pCase.equals(caseListGetByCaseId.get(0))){
							//aigaP2pCase数据被更改
							aigaP2pCase.setCauseType(getCauseType());
							aigaP2pCase.setCause(getCause());
							p2pTestSV.moveCaseData(aigaP2pCase);
						}
					}else if(caseTempListGetByCaseId!=null &&caseTempListGetByCaseId.size()==1){
						AigaP2pCaseTemp aigaP2pCaseTemp=new AigaP2pCaseTemp();
						aigaP2pCaseTemp.setCaseId(aigaP2pCase.getCaseId());
						aigaP2pCaseTemp.setCaseName(aigaP2pCase.getCaseName());
						aigaP2pCaseTemp.setCaseDesc(aigaP2pCase.getCaseDesc());
						aigaP2pCaseTemp.setExpectation(aigaP2pCase.getExpectation());
						aigaP2pCaseTemp.setOperateDesc(aigaP2pCase.getOperateDesc());
						aigaP2pCaseTemp.setPrecondition(aigaP2pCase.getPrecondition());
						if(!aigaP2pCaseTemp.equals(caseTempListGetByCaseId.get(0))){
							//aigaP2pCaseTemp数据被更改
							aigaP2pCaseTemp.setCauseType(getCauseType());
							aigaP2pCaseTemp.setCause(getCause());
							p2pTestSV.updateCaseSomeFields(aigaP2pCaseTemp);
							caseIdMap.put(aigaP2pCaseTemp.getCaseName(), aigaP2pCaseTemp.getCaseId());
						}
					}
				}
				
				aigaP2pBusiCaseCollection.setCaseId(aigaP2pCase.getCaseId());
				if (aigaP2pBusiCaseCollection.getCollectId() == null|| aigaP2pBusiCaseCollection.getCollectId().equals(0)) {
					aigaP2pBusiCaseCollection.setCreateTime(CommonHelper.getCurrentTimestamp());
					aigaP2pBusiCaseCollection.setCreatorId(userId);
					aigaP2pBusiCaseCollection.setCreatorName(userName);
					aigaP2pBusiCaseCollection.setStatus(initStatus);
					aigaP2pBusiCaseCollection.setVerifyStatus(initVerifyStatus);
					aigaP2pBusiCaseCollection.setCauseType(getCauseType());
					aigaP2pBusiCaseCollection.setCause(getCause());
				}
				p2pTestSV.saveOrUpdate(aigaP2pBusiCaseCollection);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getFunPointCase.do")
	public void getFunPointCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map =new HashMap();
		map.put("success", true);
		try{
			String channelName=request.getParameter("channelName");
			channelName=this.decodeCN(channelName);
			map.put("data",p2pTestSV.getFunPointCase(channelName));
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/delP2pBusiCaseCollection.do")
	public void delP2pBusiCaseCollection(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map =new HashMap();
		map.put("success", true);
		try{
			String collectId=request.getParameter("collectId");
			if(NaNull(collectId)){
				p2pTestSV.delete(new AigaP2pBusiCaseCollection(Integer.valueOf(collectId)));
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getNewFunctionPoint.do")
	public void getNewFunctionPoint(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String sysId=request.getParameter("sysId");
		String funPointName=this.decodeCN(request.getParameter("funPointName"));
		Map map=new HashMap();
		map.put("success", true);
		try{
			map.put("data",p2pTestSV.getNewBusiFunctionPoint(sysId,funPointName));
		}catch(Exception e){
			e.printStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getP2pFunctionPoint.do")
	public void getP2pFunctionPoint(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String funPointName=request.getParameter("funPointName");
		String channelName=this.decodeCN(request.getParameter("channelName"));
		String[] funIds=request.getParameterValues("funIds");
		funPointName=this.decodeCN(funPointName);
		String strFunIds="";
		if(NaNull(channelName)){
			String sql="SELECT " +
					" DISTINCT APBCC.FUN_ID" +
					" FROM AIGA_P2P_BUSI_CASE_COLLECTION APBCC, AIGA_P2P_CHANNEL APC" +
					" WHERE APBCC.CHANNEL_ID = APC.CHANNEL_ID(+) AND APC.CHANNEL_NAME LIKE '%"+channelName+"%'";
			List<BigDecimal> funIdList=p2pTestSV.getObjectListBySQL(sql);
			int n=funIdList.size();
			funIds=new String[n];
			for(int i=0;i<n;i++){
				BigDecimal decimal=funIdList.get(i);
				funIds[i]=new String();
				funIds[i]=String.valueOf(decimal.intValue());
			}
			if(funIds!=null){
				strFunIds=CommonHelper.array2String(funIds);
				if(!NaNull(strFunIds))strFunIds="1";
			}
		}
	
		Map map=new HashMap();
		map.put("success", true);
		try{
			String HQL="FROM AigaP2pFunctionPoint WHERE 1=1 "+(NaNull(funPointName)?" AND sysName LIKE '%"+funPointName+"%'":"");
			if(NaNull(strFunIds)){
				HQL+=" AND funId in ("+strFunIds+") ";
			}
			HQL+=" ORDER BY funId DESC ";
			map.put("data", JSONArray.fromObject(p2pTestSV.getObjectByHQL(HQL),this.jsonConfig));
		}catch(Exception e){
			e.printStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getNewBusiSystemCombox.do")
	public void getNewBusiSystemCombox(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try{
			
			String HQL="FROM AigaSystemFolder WHERE 1=1 AND isInvalid=0 ";
			map.put("data", JSONArray.fromObject(p2pTestSV.getObjectByHQL(HQL),this.jsonConfig));
		}catch(Exception e){
			e.printStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/checkP2pFunctionPonit.do")
	public void checkP2pFunctionPonit(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		List<AigaP2pFunctionPoint> list=new ArrayList<AigaP2pFunctionPoint>();
		AigaP2pFunctionPoint p2pFunctionPoint=new AigaP2pFunctionPoint();
		try{
			String funName=this.decodeCN(request.getParameter("sysName"));
			String busiTwoLevelId=decodeCN(request.getParameter("busiTwoLevelId"));
			String[] funIdAreaIds=null;
			if(NaNull(busiTwoLevelId)){
				String searchCaseIdsSQL="From AigaP2pBusiCaseCollection t where t.busiTwoLevelId="+busiTwoLevelId;
				List<AigaP2pBusiCaseCollection> collectionList=p2pTestSV.getObjectByHQL(searchCaseIdsSQL);
				funIdAreaIds=new String[collectionList.size()];
				for(int i=0,n=collectionList.size();i<n;i++){
					AigaP2pBusiCaseCollection colect=collectionList.get(i);
					funIdAreaIds[i]=new String();
					funIdAreaIds[i]=String.valueOf(colect.getFunId());
				}
			}
			String HQL="From AigaP2pFunctionPoint WHERE sysName ='"+funName+"' "+(NaNull(funIdAreaIds)?" and funId in ("+CommonHelper.array2String(funIdAreaIds)+")":"");
			list=p2pTestSV.getObjectByHQL(HQL);
			if(list.size()==0){
				p2pFunctionPoint.setSysName(funName);
				p2pFunctionPoint.setCreateTime(CommonHelper.getCurrentTimestamp());
	//			p2pFunctionPoint.setOperatorId(StaffUtil.getUserId(request));
	//			p2pFunctionPoint.setOperatorName(StaffUtil.getUserName(request));
				p2pFunctionPoint.setCreatorId(StaffUtil.getUserId(request));
				p2pFunctionPoint.setCreatorName(StaffUtil.getUserName(request));
//				p2pTestSV.saveOrUpdate(p2pFunctionPoint);
				list.add(p2pFunctionPoint);
			}else{
				throw new Exception("已经存在此功能点(名称唯一性校验失败)!!");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			map.put("success", false);
		}finally{
			map.put("data", JSONArray.fromObject(list,this.jsonConfig));
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/getAigaNewBusiCase.do")
	public void getAigaNewBusiCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String funName=BaseAction.decodeCN(request.getParameter("funPointName"));
			String caseName=BaseAction.decodeCN(request.getParameter("caseName"));
			Map<String,Integer> paginationParams=this.paginationParams(request);
			Integer page=paginationParams.get(this.PAGE_PARAM);
			Integer limit=paginationParams.get(this.LIMIT_PARAM);
			map.put("data", p2pTestSV.getAigaNewBusiCase(funName, caseName,page,limit));
			map.put("total", Integer.valueOf(p2pTestSV.getAigaNewBusiCaseCount(funName, caseName)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/getAigaP2pCase.do")
	public void getAigaP2pCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		List list=new ArrayList();
		map.put("success", true);
		try {
			String[] caseIds=null;
			String strCaseIds="";
			String channelName=this.decodeCN(request.getParameter("channelName"));
			if(NaNull(channelName)){
				String sql="SELECT " +
						" DISTINCT APBCC.CASE_ID " +
						" FROM AIGA_P2P_BUSI_CASE_COLLECTION APBCC, AIGA_P2P_CHANNEL APC" +
						" WHERE APBCC.CHANNEL_ID = APC.CHANNEL_ID(+) AND APC.CHANNEL_NAME LIKE '%"+channelName+"%'";
				List<BigDecimal> caseIdList=p2pTestSV.getObjectListBySQL(sql);
				int n=caseIdList.size();
				caseIds=new String[n];
				for(int i=0;i<n;i++){
					BigDecimal decimal=caseIdList.get(i);
					caseIds[i]=new String();
					caseIds[i]=String.valueOf(decimal.intValue());
				}
				
				if(caseIds!=null){
					strCaseIds=CommonHelper.array2String(caseIds);
					if(!NaNull(strCaseIds))strCaseIds="001";
					
				}
			}
			
			String hqlTemp="From AigaP2pCaseTemp where 1=1 "+(NaNull(strCaseIds)?" and caseId in ("+strCaseIds+")":"");
			String hql="From AigaP2pCase where 1=1 "+(NaNull(strCaseIds)?" and caseId in ("+strCaseIds+")":"");
			list.addAll(p2pTestSV.getObjectByHQL(hqlTemp));
			list.addAll(p2pTestSV.getObjectByHQL(hql));
			map.put("data",JSONArray.fromObject(list,this.jsonConfig));
		} catch (Exception e) {
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/checkP2pCase.do")
	public void checkP2pCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		List list=new ArrayList();
		map.put("success", true);
		try {
			String caseId=decodeCN(request.getParameter("caseId"));
			String busiTwoLevelId=decodeCN(request.getParameter("busiTwoLevelId"));
			String[] caseAreaIds=null;
			if(NaNull(busiTwoLevelId)){
				String searchCaseIdsSQL="From AigaP2pBusiCaseCollection t where t.busiTwoLevelId="+busiTwoLevelId;
				List<AigaP2pBusiCaseCollection> collectionList=p2pTestSV.getObjectByHQL(searchCaseIdsSQL);
				caseAreaIds=new String[collectionList.size()];
				for(int i=0,n=collectionList.size();i<n;i++){
					AigaP2pBusiCaseCollection colect=collectionList.get(i);
					caseAreaIds[i]=new String();
					caseAreaIds[i]=String.valueOf(colect.getCaseId());
				}
			}
			String caseName=decodeCN(request.getParameter("caseName"));
			String caseDesc=decodeCN(request.getParameter("caseDesc"));
			String operateDesc=decodeCN(request.getParameter("operateDesc"));
			String expectation=decodeCN(request.getParameter("expectation"));
			String precondition=decodeCN(request.getParameter("precondition"));
			AigaP2pCaseTemp aigaP2pCaseTemp=new AigaP2pCaseTemp();
			aigaP2pCaseTemp.setCaseName(caseName);
			aigaP2pCaseTemp.setCaseDesc(caseDesc);
			aigaP2pCaseTemp.setPrecondition(precondition);
			aigaP2pCaseTemp.setOperateDesc(operateDesc);
			aigaP2pCaseTemp.setExpectation(expectation);
			aigaP2pCaseTemp.setCreatorId(StaffUtil.getUserId(request));
			aigaP2pCaseTemp.setCreatorName(StaffUtil.getUserName(request));
			aigaP2pCaseTemp.setCreateTime(CommonHelper.getCurrentTimestamp());
			String HQL="From AigaP2pCaseTemp WHERE " +
					"caseName ='"+caseName+"'"+(NaNull(caseId)?" and caseId <>"+caseId:"")
					+(NaNull(caseAreaIds)?" and caseId in ("+CommonHelper.array2String(caseAreaIds)+")":"");
			list.addAll(p2pTestSV.getObjectByHQL(HQL));
			HQL="From AigaP2pCase WHERE caseName ='"+caseName+"'"+(NaNull(caseId)?" and caseId <>"+caseId:"")
					+(NaNull(caseAreaIds)?" and caseId in ("+CommonHelper.array2String(caseAreaIds)+")":"");
			list.addAll(p2pTestSV.getObjectByHQL(HQL));
			if(list.size()==0){
				list.add(aigaP2pCaseTemp);
			}else{
				map.put("success", false);
				logger.error("已经存在此用例(名称唯一性校验失败)！");
			}
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		map.put("data",JSONArray.fromObject(list,this.jsonConfig));
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/checkP2pCases.do")
	public void checkP2pCases(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		List list=new ArrayList();
		map.put("success", true);
		try {
			String[] caseIds=request.getParameterValues("caseIds");
			String[] caseNames=request.getParameterValues("caseNames");
			String strCaseNames="";
			if(caseIds!=null &&caseNames!=null ){
			for(int i=0,n=caseIds.length;i<n;i++){
				if(i==0){
					strCaseNames+="(caseId<>"+caseIds[i]+" and caseName='"+this.decodeCN(caseNames[i])+"')";
				}else{
					strCaseNames+="or(caseId<>"+caseIds[i]+" and caseName='"+this.decodeCN(caseNames[i])+"')";
				}
			}
			String HQL="From AigaP2pCaseTemp WHERE "+strCaseNames;
			list.addAll(p2pTestSV.getObjectByHQL(HQL));
			HQL="From AigaP2pCase WHERE "+strCaseNames;
			list.addAll(p2pTestSV.getObjectByHQL(HQL));
			if(list.size()==0){
			}else{
				map.put("success", false);
				logger.error("已经存在此用例(名称唯一性校验失败)！");
			}
			}
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		map.put("data",JSONArray.fromObject(list,this.jsonConfig));
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/getAigaP2pBusiScene.do")
	public void getAigaP2pBusiScene(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String busiTwoLevelId=decodeCN(request.getParameter("busiTwoLevelId"));
			map.put("data",p2pTestSV.getBusiScene(busiTwoLevelId));
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/saveAigaP2pBusiScene.do")
	public void saveAigaP2pBusiScene(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String scId=request.getParameter("scId");
			String busiId=request.getParameter("busiTwoLevelId");
			String[] collectIds=request.getParameterValues("collectIds");
			String sceneName=decodeCN(request.getParameter("sceneName"));
			AigaP2pBusiScene scene=new AigaP2pBusiScene();
			int initIndex=0;
			if(!NaNull(scId)||scId.equals(0)){
				scene.setSceneName(sceneName);
				scene.setBusiId(Integer.valueOf(busiId));
				scene.setCreateTime(CommonHelper.getCurrentTimestamp());
				scene.setCreatorId(StaffUtil.getUserId(request));
				scene.setCreatorName(StaffUtil.getUserName(request));
				scene.setStatus(initStatus);
				scene.setVerifyStatus(initVerifyStatus);
				scene.setCauseType(getCauseType());
				scene.setCause(getCause());
				p2pTestSV.saveOrUpdate(scene);
			}else{
				scene.setScId(Integer.valueOf(scId));
				String RelaHQL="FROM AigaP2pSceneCollectRela WHERE sceneId="+scene.getScId();
				List<AigaP2pSceneCollectRela> relaList=p2pTestSV.getObjectByHQL(RelaHQL);
				initIndex=relaList.size();
			}
			map.put("data",JSONObject.fromObject(scene,this.jsonConfig));
			for(int i=0,n=collectIds.length;i<n;i++){
				AigaP2pSceneCollectRela sceneCollectRela=new AigaP2pSceneCollectRela();
				if(NaNull(collectIds[i])){
					int index=initIndex+i;
					Integer collId=Integer.valueOf(collectIds[i]);
					sceneCollectRela.setCollectId(collId);
					sceneCollectRela.setSceneId(scene.getScId());
					sceneCollectRela.setCollectIndex(index);
					p2pTestSV.saveOrUpdate(sceneCollectRela);
				}
				
			}
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/getP2pTestSceneCombobox.do")
	public void getP2pTestSceneCombobox(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String busiTwoLevelId=decodeCN(request.getParameter("busiTwoLevelId"));
			if(!NaNull(busiTwoLevelId))throw new Exception("没有业务id");
			String HQL="From AigaP2pBusiScene WHERE busiId ="+busiTwoLevelId;
			List<AigaP2pBusiScene> list=p2pTestSV.getObjectByHQL(HQL);
			map.put("data",JSONArray.fromObject(list, jsonConfig));
		} catch (Exception e) {
			map.put("success", false);
			map.put("message", e.getMessage());
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/getP2pTestSceneCollect.do")
	public void getP2pTestSceneCollect(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String scId=decodeCN(request.getParameter("scId"));
			String flag=decodeCN(request.getParameter("flag"));
			String busiTwoLevelId=decodeCN(request.getParameter("busiTwoLevelId"));
			System.out.println("busiTwoLevelId="+busiTwoLevelId+"  flag="+flag+"  scId="+scId);
//			if(!NaNull(scId))throw new Exception("没有场景id");
			if(!NaNull(busiTwoLevelId))throw new Exception("没有业务id");
			List<AigaP2pBusiScene> list=new ArrayList<AigaP2pBusiScene>();
			if(flag.equals("select")){list=p2pTestSV.getP2pCaseCollectBySceneId(busiTwoLevelId,scId);}
			if(flag.equals("create")){
				list=p2pTestSV.getP2pCaseCollectComplementBySceneId(busiTwoLevelId, scId);
				}
			map.put("data",JSONArray.fromObject(list, jsonConfig));
		} catch (Exception e) {
			map.put("success", false);
			map.put("message", e.getMessage());
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/saveCollectIndex.do")
	public void saveCollectIndex(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String scId=decodeCN(request.getParameter("scId"));
			String[] collectIds=request.getParameterValues("collectIds");
			if(!NaNull(scId))throw new Exception("没有场景id");
			p2pTestSV.delSceneCollectRelaBySceneId(scId);
			int initIndex=0;
			for(int i=0,n=collectIds.length;i<n;i++){
				AigaP2pSceneCollectRela sceneCollectRela=new AigaP2pSceneCollectRela();
				if(NaNull(collectIds[i])){
					int index=initIndex+i;
					Integer collId=Integer.valueOf(collectIds[i]);
					sceneCollectRela.setCollectId(collId);
					sceneCollectRela.setSceneId(Integer.valueOf(scId));
					sceneCollectRela.setCollectIndex(index);
					p2pTestSV.saveOrUpdate(sceneCollectRela);
				}
				
			}
		} catch (Exception e) {
			map.put("success", false);
			map.put("message", e.getMessage());
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/delSceneByScIds.do")
	public void delSceneByScIds(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String[] scIds=request.getParameterValues("scIds");
			p2pTestSV.delSceneBySceneIds(scIds);
		}catch (Exception e) {
			// TODO: handle exception
			map.put("success", false);
			map.put("message", e.getMessage());
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/updateScene.do")
	public void updateScene(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String scId=request.getParameter("scId");
			String busiTwoLevelId=request.getParameter("busiTwoLevelId");
			String sceneName=this.decodeCN(request.getParameter("sceneName"));
			if(!NaNull(scId)||!NaNull(sceneName))throw new Exception("场景id或者场景名称为空");
			List<String> sceneNameList=p2pTestSV.getObjectListBySQL("select scene_name from aiga_p2p_busi_scene where busi_id ="+busiTwoLevelId);
			if(sceneNameList.contains(sceneName))throw new Exception("已经存在该场景名称");
			String SQL="UPDATE AIGA_P2P_BUSI_SCENE SET STATUS="+initStatus+", VERIFY_STATUS="+initVerifyStatus+", SCENE_NAME='"+sceneName+"' WHERE SC_ID="+scId;
			p2pTestSV.updateBySQL(SQL);
		} catch (Exception e) {
			// TODO: handle exception
			map.put("success", false);
			map.put("message", e.getMessage());
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/getAigaP2pBusiSceneTable.do")
	public void getAigaP2pBusiSceneTable(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String node=request.getParameter("node");
			String treeId=request.getParameter("treeId");
			String busiTwoLevelId=request.getParameter("busiTwoLevelId");
			String subTaskId=request.getParameter("subTaskId");
			System.out.println(node);
			System.out.println(treeId);
			JSONArray jsonAry=new JSONArray();
			if (NaNull(node) && node.equals("-1")) {
				String SQL = "SELECT "
						+ " apbc.sc_id,"
						+ " apbc.scene_name,"
						+ " apbc.analysis_method,"
						+ " apbc.sc_order,"
						+ " apbc.is_delete,"
						+ " to_char(apbc.create_time,'yyyy-mm-dd hh24:mi:ss'),"
						+ " apbc.creator_id,"
						+ " apbc.creator_name,"
						+ " apbc.cause,"
						+ " apbc.cause_type,"
						+ " apbc.busi_id,"
						+ " apbc.status,"
						+ " apbc.verify_status,"
						+ " apbc.verify_result,"
						+ " apbtl.busi_name"
						+ " FROM aiga_p2p_busi_scene apbc,aiga_p2p_busi_two_level apbtl where APBC.Busi_Id=apbtl.p2p_busi_id(+) "
						+ (NaNull(busiTwoLevelId) ? " and busi_Id="
								+ busiTwoLevelId : "")
						+ (NaNull(subTaskId) ? " and sc_id in (SELECT distinct apsstr.scene_id FROM aiga_p2p_scene_sub_task_rela apsstr WHERE apsstr.sub_task_id="
								+ subTaskId + ")"
								: "");
				List<Object[]> list = p2pTestSV.getObjectListBySQL(SQL);
				for (Object[] objs : list) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("id", Integer.valueOf(objs[0] + "")
							+ new Date().getTime()
							+ ((int) (Math.random() * 100000)));
					jsonObj.put("parentId", -1);
					jsonObj.put("text", objs[1]);
					jsonObj.put("expanded", false);
					jsonObj.put("leaf", false);
					jsonObj.put("value", Integer.valueOf(objs[0] + ""));
					jsonObj.put("scId", objs[0]);
					jsonObj.put("sceneName", objs[1]);
					jsonObj.put("analysisMethod", objs[2]);
					jsonObj.put("scOrder", objs[3]);
					jsonObj.put("isDelete", objs[4]);
					jsonObj.put("createTime", objs[5]);
					jsonObj.put("creatorId", objs[6]);
					jsonObj.put("creatorName", objs[7]);
					jsonObj.put("cause", objs[8]);
					jsonObj.put("causeType", objs[9]);
					if (CommonHelper.NaNull(objs[9]))jsonObj.put("casuseTypeName",SysContentUtil.getSysConstant("AigaP2pCauseType",String.valueOf(objs[9])).getShow());
					jsonObj.put("busiId", objs[10]);
					jsonObj.put("status", objs[11]);
					jsonObj.put("verifyStatus", objs[12]);
					if (CommonHelper.NaNull(objs[12]))jsonObj.put("verifyStatusName",SysContentUtil.getSysConstant("AigaP2pVerifyStatus",String.valueOf(objs[12])).getShow());
					jsonObj.put("verifyResult", objs[13]);
					jsonObj.put("busiName", objs[14]);
					jsonAry.add(jsonObj);
				}
			}else{
				JSONArray caseCollectJSONAry=p2pTestSV.getP2pCaseCollectBySceneId(busiTwoLevelId, treeId);
				for(int i=0,n=caseCollectJSONAry.size();i<n;i++){
					JSONObject caseJson=caseCollectJSONAry.getJSONObject(i);
					caseJson.put("id", caseJson.getInt("caseId")+new Date().getTime()+((int)(Math.random()*100000)));
					caseJson.put("parentId",node);
					caseJson.put("text", caseJson.getString("caseName"));
					caseJson.put("expanded", false);
					caseJson.put("leaf", true);
					caseJson.put("value",caseJson.getInt("caseId"));
					jsonAry.add(caseJson);
				}
				
				
			}
			map.put("children", jsonAry);
		} catch (Exception e) {
			// TODO: handle exception
			map.put("success", false);
			map.put("message", e.getMessage());
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/delP2pCollectIdSceneCheck.do")
	public void delP2pCollectIdSceneCheck(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try{
			String collectId=request.getParameter("collectId");
			if(!NaNull(collectId))throw new Exception("用例集id不能为空！");
			String SQL="SELECT APBC.SCENE_NAME FROM AIGA_P2P_SCENE_COLLECT_RELA APSCR, AIGA_P2P_BUSI_SCENE APBC WHERE APBC.SC_ID = APSCR.SCENE_ID AND APSCR.COLLECT_ID = "+collectId+" GROUP BY APBC.SCENE_NAME ";
			List<String> sceneNameList=p2pTestSV.getObjectListBySQL(SQL);
			map.put("data", sceneNameList);
		}catch (Exception e) {
			map.put("success", false);
			map.put("message", e.getMessage());
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/getAigaP2pBusiSceneUnVerify.do")
	public void getAigaP2pBusiSceneUnVerify(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			JSONArray JSONAry=new JSONArray();
			Map pageMap=this.paginationParams(request);
			int pageNo = Integer.parseInt(pageMap.get(this.PAGE_PARAM).toString());
			int pageSize = Integer.parseInt(pageMap.get(this.LIMIT_PARAM).toString());
			String HQL="from AigaP2pBusiScene where verifyStatus="+initVerifyStatus +" or verifyStatus is null";
			List<AigaP2pBusiScene> sceneList=commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
			for(AigaP2pBusiScene scene:sceneList){
				JSONObject jsonObject=JSONObject.fromObject(scene,this.jsonConfig);
				try{
					if(NaNull(scene.getCauseType()))jsonObject.put("casuseTypeName",SysContentUtil.getSysConstant("AigaP2pCauseType", String.valueOf(scene.getCauseType())).getShow());
				}catch (Exception e) {e.printStackTrace();}
				try{
					
					jsonObject.put("verifyStatusName",SysContentUtil.getSysConstant("AigaP2pVerifyStatus", String.valueOf(initVerifyStatus)).getShow());
				}catch (Exception e) {e.printStackTrace();}
				JSONAry.add(jsonObject);
			}
			map.put("data",JSONAry);
			map.put("total", commonPageinationSV.getTotal(HQL));
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/getAigaP2pCaseTempUnVerify.do")
	public void getAigaP2pCaseTempUnVerify(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			JSONArray JSONAry=new JSONArray();
			Map pageMap=this.paginationParams(request);
			int pageNo = Integer.parseInt(pageMap.get(this.PAGE_PARAM).toString());
			int pageSize = Integer.parseInt(pageMap.get(this.LIMIT_PARAM).toString());
			String HQL="from AigaP2pCaseTemp ";
			List<AigaP2pCaseTemp> list=commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
			for(AigaP2pCaseTemp obj:list){
				JSONObject jsonObject=JSONObject.fromObject(obj,this.jsonConfig);
				try{
					if(NaNull(obj.getCauseType()))jsonObject.put("casuseTypeName",SysContentUtil.getSysConstant("AigaP2pCauseType", String.valueOf(obj.getCauseType())).getShow());
				}catch (Exception e) {e.printStackTrace();}
				try{
					
					jsonObject.put("verifyStatusName",SysContentUtil.getSysConstant("AigaP2pVerifyStatus", String.valueOf(initVerifyStatus)).getShow());
				}catch (Exception e) {e.printStackTrace();}
				JSONAry.add(jsonObject);
			}
			map.put("data",JSONAry);
			map.put("total", commonPageinationSV.getTotal(HQL));
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/getAigaP2pFunctionPointUnVerify.do")
	public void getAigaP2pFunctionPointUnVerify(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			JSONArray JSONAry=new JSONArray();
			Map pageMap=this.paginationParams(request);
			int pageNo = Integer.parseInt(pageMap.get(this.PAGE_PARAM).toString());
			int pageSize = Integer.parseInt(pageMap.get(this.LIMIT_PARAM).toString());
			String HQL="from AigaP2pFunctionPoint where verifyStatus="+initVerifyStatus +" or verifyStatus is null";
			List<AigaP2pFunctionPoint> list=commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
			for(AigaP2pFunctionPoint obj:list){
				JSONObject jsonObject=JSONObject.fromObject(obj,this.jsonConfig);
				try{
					if(NaNull(obj.getCauseType()))jsonObject.put("casuseTypeName",SysContentUtil.getSysConstant("AigaP2pCauseType", String.valueOf(obj.getCauseType())).getShow());
				}catch (Exception e) {e.printStackTrace();}
				try{
					
					jsonObject.put("verifyStatusName",SysContentUtil.getSysConstant("AigaP2pVerifyStatus", String.valueOf(initVerifyStatus)).getShow());
				}catch (Exception e) {e.printStackTrace();}
				JSONAry.add(jsonObject);
			}
			map.put("data",JSONAry);
			map.put("total", commonPageinationSV.getTotal(HQL));
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/verifyAigaP2pCases.do")
	public void verifyAigaP2pCases(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String[] caseIds=request.getParameterValues("caseIds");
			if(caseIds==null ||caseIds.length==0||!NaNull(caseIds[0]))throw new Exception("用例id不能为空");
			
			String SQL=" INSERT INTO AIGA_P2P_CASE" +
					"(CASE_ID, CASE_NAME,PRECONDITION,EXPECTATION,OPERATE_DESC,CASE_DESC,SOURCE,REMARK,CREATE_TIME,CREATOR_ID,CREATOR_NAME,CAUSE,CAUSE_TYPE,STATUS,VERIFY_STATUS,VERIFY_RESULT)"+
					"SELECT "+
					"CASE_ID, CASE_NAME,PRECONDITION,EXPECTATION,OPERATE_DESC,CASE_DESC,SOURCE,REMARK,CREATE_TIME,CREATOR_ID,CREATOR_NAME,CAUSE,CAUSE_TYPE,STATUS,1,"+"'评审人【"+StaffUtil.getUser(request).getUserAccount()+":"+StaffUtil.getUserName(request)+"】'" +
							" FROM AIGA_P2P_CASE_TEMP WHERE CASE_ID IN("+CommonHelper.array2String(caseIds)+")";
			p2pTestSV.updateBySQL(SQL);
			SQL="DELETE AIGA_P2P_CASE_TEMP WHERE CASE_ID IN ("+CommonHelper.array2String(caseIds)+")";
			p2pTestSV.updateBySQL(SQL);
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/verifyAigaP2pFunctionPoints.do")
	public void verifyAigaP2pFunctionPoints(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String[] funIds=request.getParameterValues("funIds");
			if(funIds==null ||funIds.length==0||!NaNull(funIds[0]))throw new Exception("功能点id不能为空");
			String SQL="update aiga_p2p_function_point set VERIFY_STATUS =1 , verify_result='评审人【"+StaffUtil.getUser(request).getUserAccount()+":"+StaffUtil.getUserName(request)+"】' where fun_id in("+CommonHelper.array2String(funIds)+")";
			p2pTestSV.updateBySQL(SQL);
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/verifyAigaP2pBusiScenes.do")
	public void verifyAigaP2pBusiScenes(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		try {
			String[] scIds=request.getParameterValues("scIds");
			if(scIds==null ||scIds.length==0||!NaNull(scIds[0]))throw new Exception("场景id不能为空");
			String SQL="update aiga_p2p_busi_scene set VERIFY_STATUS =1 , verify_result='评审人【"+StaffUtil.getUser(request).getUserAccount()+":"+StaffUtil.getUserName(request)+"】' where sc_Id in("+CommonHelper.array2String(scIds)+")";
			p2pTestSV.updateBySQL(SQL);
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getAigaP2pBusiScenesBySubTaskId.do")
	public void getAigaP2pBusiScenesBySubTaskId(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		String subTaskId=request.getParameter("subTaskId");
		try {
			JSONArray jsonAry=new JSONArray();
			Map pageMap=this.paginationParams(request);
			int pageNo = Integer.parseInt(pageMap.get(this.PAGE_PARAM).toString());
			int pageSize = Integer.parseInt(pageMap.get(this.LIMIT_PARAM).toString());
			String SQL="SELECT *From (SELECT " +
					" apbc.sc_id," +
					" apbc.scene_name," +
					" apbc.analysis_method," +
					" apbc.sc_order," +
					" apbc.is_delete," +
					" to_char(apbc.create_time,'yyyy-mm-dd hh24:mi:ss')," +
					" apbc.creator_id," +
					" apbc.creator_name," +
					" apbc.cause," +
					" apbc.cause_type," +
					" apbc.busi_id," +
					" apbc.status," +
					" apbc.verify_status," +
					" apbc.verify_result," +
					" apbtl.busi_name," +
					" ROWNUM RN  " +
					" FROM aiga_p2p_busi_scene apbc,aiga_p2p_busi_two_level apbtl where APBC.Busi_Id=apbtl.p2p_busi_id(+) "+
					"  AND ROWNUM <= "+(pageNo*pageSize) +
					(NaNull(subTaskId)?" and sc_id in (SELECT distinct apsstr.scene_id FROM aiga_p2p_scene_sub_task_rela apsstr WHERE apsstr.sub_task_id=" +subTaskId+")":"")+
							")  WHERE RN > "+(pageNo-1)*pageSize;
			
			String countSQL="SELECT " +
					" count(apbc.sc_id)" +
					" FROM aiga_p2p_busi_scene apbc,aiga_p2p_busi_two_level apbtl where APBC.Busi_Id=apbtl.p2p_busi_id(+) "+
					(NaNull(subTaskId)?" and sc_id in (SELECT distinct apsstr.scene_id FROM aiga_p2p_scene_sub_task_rela apsstr WHERE apsstr.sub_task_id=" +subTaskId+")":"");
			
			List<Object[]> sceneList=p2pTestSV.getObjectListBySQL(SQL);
			map.put("total", p2pTestSV.getObjectListBySQL(countSQL).get(0));
			for(Object[] objs:sceneList){
				JSONObject jsonObj=new JSONObject();
				jsonObj.put("scId", objs[0]);
				jsonObj.put("sceneName", objs[1]);
				jsonObj.put("analysisMethod", objs[2]);
				jsonObj.put("scOrder", objs[3]);
				jsonObj.put("isDelete", objs[4]);
				jsonObj.put("createTime", objs[5]);
				jsonObj.put("creatorId", objs[6]);
				jsonObj.put("creatorName", objs[7]);
				jsonObj.put("cause", objs[8]);
				jsonObj.put("causeType", objs[9]);
				if(CommonHelper.NaNull(objs[9]))jsonObj.put("casuseTypeName",SysContentUtil.getSysConstant("AigaP2pCauseType", String.valueOf(objs[9])).getShow());
				jsonObj.put("busiId", objs[10]);
				jsonObj.put("status", objs[11]);
				jsonObj.put("verifyStatus", objs[12]);
				if(CommonHelper.NaNull(objs[12]))jsonObj.put("verifyStatusName",SysContentUtil.getSysConstant("AigaP2pVerifyStatus", String.valueOf(objs[12])).getShow());
				jsonObj.put("verifyResult", objs[13]);
				jsonObj.put("busiName", objs[14]);
				jsonAry.add(jsonObj);
			}
			map.put("data", jsonAry);
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getAigaP2pBusiScenesByCondition.do")
	public void getAigaP2pBusiScenesByCondition(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		map.put("success", true);
		String AigaP2pBusiTwoLevelId=request.getParameter("AigaP2pBusiTwoLevelId");
		String subTaskId=request.getParameter("subTaskId");
		try {
			JSONArray jsonAry=new JSONArray();
			Map pageMap=this.paginationParams(request);
			int pageNo = Integer.parseInt(pageMap.get(this.PAGE_PARAM).toString());
			int pageSize = Integer.parseInt(pageMap.get(this.LIMIT_PARAM).toString());
			String SQL="SELECT *From (SELECT " +
					" apbc.sc_id," +
					" apbc.scene_name," +
					" apbc.analysis_method," +
					" apbc.sc_order," +
					" apbc.is_delete," +
					" to_char(apbc.create_time,'yyyy-mm-dd hh24:mi:ss')," +
					" apbc.creator_id," +
					" apbc.creator_name," +
					" apbc.cause," +
					" apbc.cause_type," +
					" apbc.busi_id," +
					" apbc.status," +
					" apbc.verify_status," +
					" apbc.verify_result," +
					" apbtl.busi_name," +
					" ROWNUM RN  " +
					" FROM aiga_p2p_busi_scene apbc,aiga_p2p_busi_two_level apbtl where APBC.Busi_Id=apbtl.p2p_busi_id(+) "+
					"  AND ROWNUM <= "+(pageNo*pageSize) +
					(NaNull(AigaP2pBusiTwoLevelId)?" and busi_Id="+AigaP2pBusiTwoLevelId:"")+
					(NaNull(subTaskId)?" and sc_id not in (SELECT distinct apsstr.scene_id FROM aiga_p2p_scene_sub_task_rela apsstr WHERE apsstr.sub_task_id=" +subTaskId+")":"")+
							")  WHERE RN > "+(pageNo-1)*pageSize;
			
			String countSQL="SELECT " +
					" count(apbc.sc_id)" +
					" FROM aiga_p2p_busi_scene apbc,aiga_p2p_busi_two_level apbtl where APBC.Busi_Id=apbtl.p2p_busi_id(+) "+
					(NaNull(AigaP2pBusiTwoLevelId)?" and busi_Id="+AigaP2pBusiTwoLevelId:"")+
					(NaNull(subTaskId)?" and sc_id not in (SELECT distinct apsstr.scene_id FROM aiga_p2p_scene_sub_task_rela apsstr WHERE apsstr.sub_task_id=" +subTaskId+")":"");
			
			List<Object[]> sceneList=p2pTestSV.getObjectListBySQL(SQL);
			map.put("total", p2pTestSV.getObjectListBySQL(countSQL).get(0));
			for(Object[] objs:sceneList){
				JSONObject jsonObj=new JSONObject();
				jsonObj.put("scId", objs[0]);
				jsonObj.put("sceneName", objs[1]);
				jsonObj.put("analysisMethod", objs[2]);
				jsonObj.put("scOrder", objs[3]);
				jsonObj.put("isDelete", objs[4]);
				jsonObj.put("createTime", objs[5]);
				jsonObj.put("creatorId", objs[6]);
				jsonObj.put("creatorName", objs[7]);
				jsonObj.put("cause", objs[8]);
				jsonObj.put("causeType", objs[9]);
				if(CommonHelper.NaNull(objs[9]))jsonObj.put("casuseTypeName",SysContentUtil.getSysConstant("AigaP2pCauseType", String.valueOf(objs[9])).getShow());
				jsonObj.put("busiId", objs[10]);
				jsonObj.put("status", objs[11]);
				jsonObj.put("verifyStatus", objs[12]);
				if(CommonHelper.NaNull(objs[12]))jsonObj.put("verifyStatusName",SysContentUtil.getSysConstant("AigaP2pVerifyStatus", String.valueOf(objs[12])).getShow());
				jsonObj.put("verifyResult", objs[13]);
				jsonObj.put("busiName", objs[14]);
				jsonAry.add(jsonObj);
			}
			map.put("data", jsonAry);
		} catch (Exception e) {
			map.put("success", false);
			e.printStackTrace();
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getP2pBusiLevelCombox.do")
	public void getP2pBusiLevelCombox(HttpServletRequest request, HttpServletResponse response)throws Exception{
		JSONObject json=new JSONObject();
		JSONArray jsonAry=new JSONArray();
		String flag=request.getParameter("flag");
		String busiType=request.getParameter("oneLevelBusiId");
		if(NaNull(flag)&&flag.equals("AigaP2pBusiOneLevel")){
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaP2pBusiOneLevel.class);
			criteria.add(Restrictions.eq("isInvalid", Integer.valueOf("0")));
			AigaP2pBusiOneLevel[] aigaP2pBusiLevels = p2pTestSV.getAigaP2pBusiOneLevel(criteria);
			jsonAry=JSONArray.fromObject(aigaP2pBusiLevels, jsonConfig);
		}else if(NaNull(flag)&&flag.equals("AigaP2pBusiTwoLevel")&&NaNull(busiType)){
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaP2pBusiTwoLevel.class);
			criteria.add(Restrictions.eq("busiType", Integer.valueOf(busiType)));
			criteria.add(Restrictions.eq("isInvalid", Integer.valueOf("0")));
			AigaP2pBusiTwoLevel[] aigaP2pBusiLevels = p2pTestSV.getAigaP2pBusiTwoLevel(criteria);
			jsonAry=JSONArray.fromObject(aigaP2pBusiLevels, jsonConfig);
		}
		json.put("data", jsonAry);
		json.put("success", "true");
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping("/saveP2pSceneSubTaskRela.do")
	public void saveP2pSceneSubTaskRela(HttpServletRequest request, HttpServletResponse response)throws Exception{
		JSONObject json=new JSONObject();
		JSONArray jsonAry=new JSONArray();
		String[] scIds=request.getParameterValues("scIds");
		String subTaskId=request.getParameter("subTaskId");
		if(!NaNull(subTaskId))throw new Exception("子任务ID不能为空!");
		if(scIds==null ||scIds.length==0||!NaNull(scIds[0]))throw new Exception("场景id不能为空");
		int initIndex=0;
		for(int i=0,n=scIds.length;i<n;i++){
			AigaP2pSceneSubTaskRela sceneSubTaskRela=new AigaP2pSceneSubTaskRela();
			if(NaNull(scIds[i])){
				int index=initIndex+i;
				Integer scId=Integer.valueOf(scIds[i]);
				sceneSubTaskRela.setSceneId(scId);
				sceneSubTaskRela.setSubTaskId(Integer.valueOf(subTaskId));
				sceneSubTaskRela.setRemarks("操作人【"+StaffUtil.getUserAccount(request)+":"+StaffUtil.getUserName(request)+"】");
				p2pTestSV.saveOrUpdate(sceneSubTaskRela);
			}
			
		}
	
		json.put("data", jsonAry);
		json.put("success", "true");
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping("/delP2pSceneSubTaskRela.do")
	public void delP2pSceneSubTaskRela(HttpServletRequest request, HttpServletResponse response)throws Exception{
		JSONObject json=new JSONObject();
		json.put("success", true);
		try{
			JSONArray jsonAry=new JSONArray();
			String[] scIds=request.getParameterValues("scIds");
			String subTaskId=request.getParameter("subTaskId");
			if(!NaNull(subTaskId))throw new Exception("子任务id不能为空");
			if(scIds==null ||scIds.length==0||!NaNull(scIds[0]))throw new Exception("场景id不能为空");
			for(int i=0,n=scIds.length;i<n;i++){
				String delSQL="delete aiga_p2p_scene_sub_task_rela apsstr where apsstr.sub_task_id="+subTaskId+" and apsstr.SCENE_ID in ("+CommonHelper.array2String(scIds)+")";
				p2pTestSV.updateBySQL(delSQL);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			json.put("success", false);
			json.put("message", e.getMessage());
			// TODO: handle exception
		}
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping("/getAigaSubTaskBySubTaskId.do")
	public void getAigaSubTaskBySubTaskId(HttpServletRequest request, HttpServletResponse response)throws Exception{
		JSONObject json=new JSONObject();
		json.put("success", true);
		try{
			JSONArray jsonAry=new JSONArray();
			String subTaskId=request.getParameter("subTaskId");
			if(!NaNull(subTaskId))throw new Exception("子任务id不能为空");
			String HQL="FROM AigaTestSubTask where subTaskId="+subTaskId;
			List<AigaTestSubTask> subTaskList=p2pTestSV.getObjectByHQL(HQL);
			json.put("data", subTaskList.get(0));
			
		}catch (Exception e) {
			e.printStackTrace();
			json.put("success", false);
			json.put("message", e.getMessage());
			// TODO: handle exception
		}
		ActionHelper.responseData4JSON(request, response, json);
	}
}

package com.asiainfo.aiga.funPoint.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.funPoint.bo.AigaFunPoint;
import com.asiainfo.aiga.funPoint.bo.AigaKnowledge;
import com.asiainfo.aiga.funPoint.service.IAigaFunPointSV;
import com.asiainfo.aiga.r_elem_case.service.IAigaRElemCaseSV;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.requisition.service.IAigaRequisitionSV;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;

@Controller
public class FunPointAction extends BaseAction {
	
	@Resource(name="funPointSV")
	private IAigaFunPointSV funPSV;
	
	@Resource(name="rElemCaseSV")
	private IAigaRElemCaseSV aigaRElemCaseSV;
	
	@Resource(name="requisitionSV")
	private IAigaRequisitionSV reqSV;
	
	@RequestMapping(value="/saveFunPoint.do")
	public void saveFunPoint(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transFormToObj(request, new Class[]{AigaFunPoint.class});
		AigaFunPoint funp = new AigaFunPoint();
		for(Object result : results){
			if(result instanceof AigaFunPoint)
				funp = (AigaFunPoint)result;
		}
		if(funp!=null&&results.length!=0)
			funPSV.saveOrUpdate(funp);
		this.setFormData(funp);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getFunPoints.do")
	public void getFunPoints(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaFunPoint where sub_task_id=" + subTaskId;
		AigaFunPoint[] funPs = funPSV.getFunPointBySql(querySql);
		this.setTable(funPs);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/qryFunPoints.do")
	public void qryFunPoints(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String querySql = "from AigaFunPoint where 1=1";
		String funName = request.getParameter("funName");
		String funType = request.getParameter("funType");
		String funPath = request.getParameter("funPath");
		String subSystem = request.getParameter("subSystem");
		String subGroup = request.getParameter("subGroup");
		String isNeedAuto = request.getParameter("isNeedAuto");
		if(funName != null && !"".equals(funName)) {
			querySql += " and funName like '%" + funName + "%'";
		}
		if(funType != null && !"".equals(funType)) {
			querySql += " and funType like '%" + funType + "%'";
		}
		if(funPath != null && !"".equals(funPath)) {
			querySql += " and funPath like '%" + funPath + "%'";
		}
		if(subGroup != null && !"".equals(subGroup)) {
			querySql += " and subGroup like '%" + subGroup + "%'";
		}
		if(isNeedAuto != null && !"".equals(isNeedAuto)) {
			querySql += " and isNeedAuto like '%" + isNeedAuto + "%'";
		}
		if(subSystem != null && !"".equals(subSystem)) {
			querySql += " and subSystem like '%" + subSystem + "%'";
		}
		
		AigaFunPoint[] funPs = funPSV.getFunPointBySql(querySql);
		this.setTable(funPs);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getFunPByTag.do")
	public void getFunPByTag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String funTag = request.getParameter("funTag");
		String querySql = "from AigaFunPoint where fun_tag='" + funTag + "'";
		AigaFunPoint[] funPs = funPSV.getFunPointBySql(querySql);
		AigaFunPoint funp = null;
		if(funPs != null && funPs.length != 0 ) {
			funp = funPs[0];
		}
		this.setFormData(funp);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/copyFunRela.do")
	public void copyFunRela(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transFormToObj(request, new Class[]{AigaFunPoint.class});
		AigaFunPoint funp = new AigaFunPoint();
		for(Object result : results) {
			if(result instanceof AigaFunPoint) {
				funp = (AigaFunPoint)result;
			}
		}
		
		String newTag = request.getParameter("newTag");
		
//		String sql = "from AigaTestelem where fun_tag='" + funp.getFunTag() + "'";
//		AigaTestelem[] elems = elemSV.getAigaTestElemBySql(sql);
//		for(AigaTestelem elem : elems) {
//			elem.setId(null);
//			elem.setFunTag(newTag);
//			String relaSql = "from AigaRElemCase where elem_tag='" + elem.getTestelemTag() + "')";
//			Date date = new Date();
//			DateFormat df = new SimpleDateFormat("MMddkkmmss");
//			String elemTag = "ELEM" + df.format(date) + (int)Math.ceil(Math.random()*10000);
//			elem.setTestelemTag(elemTag);
//			elemSV.saveAigaTestElem(elem);
//			AigaRElemCase[] relas = aigaRElemCaseSV.getRElemCaseBySql(relaSql);
//			AigaRElemCase[] saveVals = new AigaRElemCase[relas.length];
//			int i = 0;
//			for(AigaRElemCase rela : relas) {
//				rela.setRefId(null);
//				rela.setElemTag(elemTag);
//				saveVals[i] = rela;
//				i++;
//			}
//			aigaRElemCaseSV.saveRElemCaseValues(saveVals);
//		}
		
		funp.setFunId(null);
//		funp.setFunTag(newTag);
		this.setFormData(funp);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getRelaFunHistory.do")
	public void getRelaFunHistory(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String tempIdStr = request.getParameter("tempId");
		if(tempIdStr == null || "".equals(tempIdStr)) {
			tempIdStr = "0";
		}
//		对应的需求list
		List<AigaRequisition> reqList = new ArrayList<AigaRequisition>();
//		需求tag作为标志，对应的子任务列表
		Map<String, List<AigaTestSubTask>> subTaskMap = new HashMap<String, List<AigaTestSubTask>>();
//		子任务id作为标志，对应的要素列表
//		Map<String, List<AigaTestelem>> elemMap = new HashMap<String, List<AigaTestelem>>();
		
		Integer tempId = Integer.parseInt(tempIdStr);
		String querySql = "from AigaFunPoint where relaFolderId=" + tempId;
		AigaFunPoint[] funps = funPSV.getFunPointBySql(querySql);
		
		String subTaskIds = "(0,";
		for(AigaFunPoint fun : funps) {
			subTaskIds += fun.getSubTaskId() + ",";
		}
		subTaskIds += ")";
		subTaskIds = subTaskIds.replace(",)", ")");
		String subSql = "from AigaTestSubTask where subTaskId in" + subTaskIds;
		AigaTestSubTask[] subTasks = reqSV.getAigaTestSubTaskBySql(subSql);
		subTaskMap = splitReqSubTask(subTasks);
		reqList = splitReqList(subTasks);
//		elemMap = splitElemMap(tempId, subTasks);
		String htmlStr = "<table>";
		htmlStr += "<thead><tr><th>需求</th><th>子任务</th><th>测试要点</th></tr></thead>";
		for(AigaRequisition req : reqList) {
			htmlStr += "<tr>";
			htmlStr += "<td>";
			htmlStr += req.getReqName();
			htmlStr += "</td>";
			htmlStr += "<td><ul>";
			List<AigaTestSubTask> subList = subTaskMap.get(req.getReqNo());
			if(subList != null) {
				for(AigaTestSubTask subTask : subList) {
					htmlStr += "<li>" + subTask.getSubTaskTag()+ "</li>";
				}
			}
			htmlStr += "</ul></td>";
			htmlStr += "<td><ul>";
//			if(subList != null) {
//				for(AigaTestSubTask subTask : subList) {
//					String subTaskId = subTask.getSubTaskId() + "";
//					List<AigaTestelem> elemList = elemMap.get(subTaskId);
//					for(AigaTestelem elem : elemList) {
//						htmlStr += "<li>" + elem.getTestelemTag() + "</li>";
//					}
//				}
//			}
			htmlStr += "</ul></td>";
			htmlStr += "</tr>";
		}
		htmlStr += "</table>";
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(htmlStr);
	}
	
	private List<AigaRequisition> splitReqList(AigaTestSubTask[] subTasks) throws Exception {
		List<AigaRequisition> reqList = new ArrayList<AigaRequisition>();
		List<String> tagList = new ArrayList<String>();
		for(AigaTestSubTask subTask : subTasks) {
			String reqTag = subTask.getReqTag();
			if(reqTag == null) {
				continue;
			}
			if(!listHas(reqTag, tagList)) {
				tagList.add(reqTag);
				String querySql = "from AigaRequisition where reqNo='" + reqTag + "'";
				AigaRequisition[] reqs = reqSV.getAigaRequisitionBySql(querySql);
				if(reqs != null && reqs.length != 0) {
					reqList.add(reqs[0]);
				} else {
					AigaRequisition req = new AigaRequisition();
					req.setReqNo(reqTag);
					reqList.add(req);
				}
			}
		}
		if(reqList.size() == 0) {
			AigaRequisition req = new AigaRequisition();
			req.setReqName("根据子任务未查询到相关需求，请确认需求编号");
			reqList.add(req);
		}
		return reqList;
	}
	
	private Map<String, List<AigaTestSubTask>> splitReqSubTask(AigaTestSubTask[] subTasks) throws Exception {
		Map<String, List<AigaTestSubTask>> subTaskMap = new HashMap<String, List<AigaTestSubTask>>();
		List<String> tagList = new ArrayList<String>();
		for(AigaTestSubTask subTask : subTasks) {
			String reqTag = subTask.getReqTag();
			if(!listHas(reqTag, tagList)) {
				if(reqTag == null) {
					reqTag = "";
				}
				tagList.add(reqTag);
			}
		}
		for(String tag : tagList) {
			List<AigaTestSubTask> list = new ArrayList<AigaTestSubTask>();
			for(AigaTestSubTask subTask : subTasks) {
				if(tag.equals(subTask.getReqTag())) {
					list.add(subTask);
				}
			}
			subTaskMap.put(tag, list);
		}
		
		return subTaskMap;
	}
	
	private boolean listHas(String tag, List<String> list) throws Exception {
		boolean retVal = false;
		for(String li : list) {
			if(li.equals(tag)) {
				retVal = true;
				break;
			}
		}
		return retVal;
	}
	
	@RequestMapping(value="/getFunTypeTips.do")
	public void getFunTypeTips(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String funType = request.getParameter("funType");
		if(funType == null || "".equals(funType)) {
			funType = "0";
		}
		String retVal = "";
		SysConstant[] tips = SysContentUtil.getSysContant("fun_type");
		for(SysConstant tip : tips) {
			if(tip.getValue() == Integer.parseInt(funType)) {
				retVal = "<font color='red'>提示信息：</font><br>" + tip.getOther1();
			}
		}
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(retVal);
	}
	
	@RequestMapping(value="/getFunPById.do")
	public void getFunPById(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String funId = request.getParameter("funId");
		String querySql = "from AigaFunPoint where funId=" + funId;
		AigaFunPoint[] funPs = funPSV.getFunPointBySql(querySql);
		AigaFunPoint funp = null;
		if(funPs != null && funPs.length != 0 ) {
			funp = funPs[0];
		}
		this.setFormData(funp);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/deleteFunPoint.do")
	public void deleteFunPoint(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String funTag = request.getParameter("funTag");
		String querySql = "from AigaFunPoint where fun_tag='" + funTag + "'";
		AigaFunPoint[] funPs = funPSV.getFunPointBySql(querySql);
		
		
		for(AigaFunPoint funP : funPs) {
			funPSV.delete(funP);
		}
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getKnowledgeByCon.do")
	public void getKnowledgeByCon(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sysName = request.getParameter("sysName");
		String subSysName = request.getParameter("subSysName");
		String moduleName = request.getParameter("moduleName");
		String knowledgeName = request.getParameter("knowledgeName");
		String knowledgeType = request.getParameter("knowledgeType");
		String querySql = "from AigaKnowledge where 1=1";
		
		if(sysName != null && !"".equals(sysName)) {
			querySql += " and sysName like '%" + sysName + "%'";
		}
		if(subSysName != null && !"".equals(subSysName)) {
			querySql += " and subSysName like '%" + subSysName + "%'";
		}
		if(moduleName != null && !"".equals(moduleName)) {
			querySql += " and moduleName like '%" + moduleName + "%'";
		}
		if(knowledgeName != null && !"".equals(knowledgeName)) {
			querySql += " and knowledgeName like '%" + knowledgeName + "%'";
		}
		if(knowledgeType != null && !"".equals(knowledgeType)) {
			querySql += " and knowledgeType=" + knowledgeType;
		}
		
		AigaKnowledge[] knowledges = funPSV.getKnowledgeBySql(querySql);
		this.setTable(knowledges);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/saveKnowledge.do")
	public void saveKnowledge(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transFormToObj(request, new Class[]{AigaKnowledge.class});
		AigaKnowledge knowledge = new AigaKnowledge();
		for(Object result : results){
			if(result instanceof AigaKnowledge)
				knowledge = (AigaKnowledge)result;
		}
		if(knowledge!=null&&results.length!=0)
			funPSV.saveOrUpdate(knowledge);
	}
	
	@RequestMapping(value="/getKnowledgeById.do")
	public void getKnowledgeById(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String knowledgeId = request.getParameter("knowledgeId");
		String querySql = "from AigaKnowledge where knowledge_id=" + knowledgeId;
		AigaKnowledge[] knowledges = funPSV.getKnowledgeBySql(querySql);
		AigaKnowledge retVal = null;
		if(knowledges != null && knowledges.length == 1) {
			retVal = knowledges[0];
		}
		this.setFormData(retVal);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/deleteKnowledge.do")
	public void deleteKnowledge(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String knowledgeId = request.getParameter("knowledgeId");
		String querySql = "from AigaKnowledge where knowledge_id=" + knowledgeId;
		AigaKnowledge[] knowledges = funPSV.getKnowledgeBySql(querySql);
		if(knowledges != null && knowledges.length == 1) {
			funPSV.delete(knowledges[0]);
		}
	}
	
}

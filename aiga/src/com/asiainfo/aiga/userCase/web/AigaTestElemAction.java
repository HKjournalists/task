package com.asiainfo.aiga.userCase.web;

import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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

import org.hibernate.criterion.Conjunction;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.service.ICommonPageinationSV;
import com.asiainfo.aiga.common.xls.XlsHelper;
import com.asiainfo.aiga.userCase.bo.AigaFunFolder;
import com.asiainfo.aiga.userCase.bo.AigaHisElem;
import com.asiainfo.aiga.userCase.bo.AigaHisSubElem;
import com.asiainfo.aiga.userCase.bo.AigaSubSysFolder;
import com.asiainfo.aiga.userCase.bo.AigaSystemFolder;
import com.asiainfo.aiga.userCase.bo.AigaTestElem;
import com.asiainfo.aiga.userCase.bo.AigaTestSubElem;
import com.asiainfo.aiga.userCase.service.IAigaFunFolderSV;
import com.asiainfo.aiga.userCase.service.IAigaSubSysFolderSV;
import com.asiainfo.aiga.userCase.service.IAigaSystemFolderSV;
import com.asiainfo.aiga.userCase.service.IAigaTestElemSV;

@Controller
public class AigaTestElemAction extends BaseAction {
	@Resource(name="funFolderSV")
	private IAigaFunFolderSV aigaFunFolderSV;
	
	@Resource(name="sysFolderSV")
	private IAigaSystemFolderSV aigaSystemFolderSV;
	
	@Resource(name = "subSysFolderSV")
	private IAigaSubSysFolderSV aigaSubSysFolderSV;

	@Resource(name="testElementSV")
	private IAigaTestElemSV aigaTestElemSV;
	
	@Resource(name="commonPageinationSV")
	private ICommonPageinationSV commonPageinationSV;
	
	
	@RequestMapping("/getTestElemList.do")
	public void getTestElemList(HttpServletRequest request, HttpServletResponse response)throws Exception{
		JSONArray json = new JSONArray();
		String elemTag = request.getParameter("elemTag");
		String elemName = request.getParameter("elemName");
		String funId = request.getParameter("funId");
		//String sysId = request.getParameter("sysId");
		String elemSysAchieveType = request.getParameter("elemSysAchieveType");
		String tbarIsPrivate = request.getParameter("tbarIsPrivate");
		String tbarIsCommon = request.getParameter("tbarIsCommon");
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		StringBuffer queryHQL = new StringBuffer();
		queryHQL.append("FROM AigaTestElem a WHERE 1=1 and a.isDelete=0 ");
		queryHQL.append((elemTag!=null&&!elemTag.equals(""))?" and a.elemTag like '%"+this.decodeCN(elemTag).trim()+"%'":"");//要素编号
		queryHQL.append((elemName!=null&&!this.decodeCN(elemName).equals(""))?" and a.elemName like '%"+this.decodeCN(elemName).trim()+"%'":"");//要素名称
		queryHQL.append((funId!=null&&!funId.equals(""))?" and a.funId ="+funId+"":"");//所属功能点ID
		//queryHQL.append((sysId!=null&&!sysId.equals(""))?" and a.sysId ="+sysId+"":"");//所属系统ID
		queryHQL.append((elemSysAchieveType!=null&&!elemSysAchieveType.equals(""))?" and a.elemSysAchieveType ="+elemSysAchieveType+"":"");//所属要素类型
		if(tbarIsPrivate.equals("true")&&tbarIsCommon.equals("false")){
			queryHQL.append(" and a.isGlobalElem=0 ");
		}else if(tbarIsPrivate.equals("false")&&tbarIsCommon.equals("true")){
			queryHQL.append(" and a.isGlobalElem=1 ");
		}
		Map<Integer,String> funFolderMap = new HashMap<Integer,String>();
		AigaFunFolder[] aigaFunFolders = aigaFunFolderSV.getAigaFunFolderBySql("FROM AigaFunFolder");
		for(AigaFunFolder aigaFunFolder:aigaFunFolders){
			funFolderMap.put(aigaFunFolder.getFunId(), aigaFunFolder.getSysName());
		}
		Map<Integer,String> sysFolderMap = new HashMap<Integer,String>();
		AigaSystemFolder[] aigaSystemFolders = aigaSystemFolderSV.getSystemFolder("From AigaSystemFolder");
		for(AigaSystemFolder aigaSystemFolder:aigaSystemFolders){
			sysFolderMap.put(aigaSystemFolder.getSysId(), aigaSystemFolder.getSysName());
		}
		List<Object> list = commonPageinationSV.getObjectList(pageNo, pageSize, queryHQL.toString());
		for(int i=0,n=list.size();i<n;i++){
			AigaTestElem aigaTestElem = (AigaTestElem)list.get(i);
			JSONObject elemJSONOj=new JSONObject();
			elemJSONOj.put("elemId", aigaTestElem.getElemId());
			elemJSONOj.put("elemTag", aigaTestElem.getElemTag());
			elemJSONOj.put("elemName", aigaTestElem.getElemName());
			elemJSONOj.put("elemSysAchieveType", aigaTestElem.getElemSysAchieveType());
			elemJSONOj.put("applicateSys", aigaTestElem.getApplicateSys());
			elemJSONOj.put("isGlobalElem", aigaTestElem.getIsGlobalElem());
			elemJSONOj.put("sysId", aigaTestElem.getSysId());
			elemJSONOj.put("funId", aigaTestElem.getFunId());
			elemJSONOj.put("staffId", aigaTestElem.getStaffId());
			elemJSONOj.put("staffName", aigaTestElem.getStaffName());
			elemJSONOj.put("isDelete", aigaTestElem.getIsDelete());
			elemJSONOj.put("addReasonType", aigaTestElem.getAddReasonType());
			elemJSONOj.put("addReason", aigaTestElem.getAddReason());
			elemJSONOj.put("funName", funFolderMap.get(aigaTestElem.getFunId()));
			elemJSONOj.put("sysName", sysFolderMap.get(aigaTestElem.getSysId()));
			AigaHisElem[] aigaHisElems = aigaTestElemSV.getHisElemByElemId(aigaTestElem.getElemId());
			if(aigaHisElems.length>=1){
				elemJSONOj.put("operatorName", aigaHisElems[0].getOperatorName());
				elemJSONOj.put("operateTime", aigaHisElems[0].getOperateTime().toString());
				elemJSONOj.put("creatorName", aigaHisElems[aigaHisElems.length-1].getOperatorName());
				elemJSONOj.put("creatorTime", aigaHisElems[aigaHisElems.length-1].getOperateTime().toString());
			}
			json.add(elemJSONOj,this.jsonConfig);
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(queryHQL.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
			
	}
	
	@RequestMapping("/getTestElemTable.do")
	public void getTestElemTable(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			JSONArray jsonArray = null;
			String node = request.getParameter("node");
			String funId = request.getParameter("funId");
			String type = request.getParameter("type");
			if(funId==null||funId.equals(""))
				throw new Exception("缺少参数funId");
			if(node.equals("-1"))
				jsonArray = aigaTestElemSV.getTestElemTreeGrid(Integer.valueOf(funId));
			else
				jsonArray = aigaTestElemSV.getSubTestElemTreeGrid(Integer.valueOf(node),type);
			this.setPostInfo("success", true);
			this.setPostInfo("children", jsonArray);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getTestElemForm.do")
	public void getTestElemForm(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String elemId = request.getParameter("elemId");
			if(elemId==null||elemId.equals(""))
				throw new Exception("缺少参数elemId");
			AigaTestElem aigaTestElem = aigaTestElemSV.getTestElemById(Integer.valueOf(elemId));
			this.setPostInfo("data", aigaTestElem);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getTestElemRTable.do")
	public void getTestElemRTable(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			JSONArray jsonArray = null;
			String funId = request.getParameter("funId");
			String node = request.getParameter("node");
			String elemName = request.getParameter("elemName");
			elemName=decodeCN(elemName);
			if(funId==null||funId.equals(""))
				throw new Exception("缺少参数funId");
			String sysId = request.getParameter("sysId");
			if(sysId==null||sysId.equals(""))
				throw new Exception("缺少参数sysId");
			if(node.equals("-1"))
				jsonArray = aigaTestElemSV.getTestElemRTreeGridByCondition(Integer.valueOf(funId), Integer.valueOf(sysId),elemName,"");
			else
				jsonArray = aigaTestElemSV.getSubTestElemTreeGrid(Integer.valueOf(node),"edit");
			this.setPostInfo("success", true);
			this.setPostInfo("children", jsonArray);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getTestElemTableForCase.do")
	public void getTestElemTableForCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String secId = request.getParameter("secId");
			String caseId = request.getParameter("caseId");
			if(secId==null||secId.equals(""))
				throw new Exception("缺少参数secId");
			if(caseId==null||caseId.equals(""))
				throw new Exception("缺少参数caseId");
			JSONArray aigaTestElems = aigaTestElemSV.getTestElemBySecId(Integer.valueOf(secId),Integer.valueOf(caseId));
			this.setPostInfo("data", aigaTestElems);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getSubElem.do")
	public void getSubElem(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String elemId = request.getParameter("elemId");
			AigaTestSubElem[] aigaTestSubElems = aigaTestElemSV.getSubElemByElemId(Integer.valueOf(elemId));
			this.setTable(aigaTestSubElems);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveTestElemAndRela.do")
	public void saveTestElemAndRela(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funId = request.getParameter("funId");
			String sysId = request.getParameter("sysId");
			String elemName = this.decodeCN(request.getParameter("eName"));
			String type = request.getParameter("type");
			Integer elemId = 0;
			Object[] objects = this.transFormToObj(request, new Class[]{AigaTestElem.class});
			if(funId==null||funId.equals(""))
				throw new Exception("缺少请求参数funId");
			if(sysId==null||sysId.equals(""))
				throw new Exception("缺少请求参数sysId");
			if(elemName==null||elemName.equals(""))
				throw new Exception("缺少请求参数elemName");
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestElem.class);
			Disjunction disjunction = Restrictions.disjunction();
			Conjunction conjunction = Restrictions.conjunction();
			conjunction.add(Restrictions.eq("isGlobalElem", 1));
			conjunction.add(Restrictions.eq("sysId", Integer.valueOf(sysId)));
			conjunction.add(Restrictions.isNotNull("sysId"));
			disjunction.add(Restrictions.eq("funId", Integer.valueOf(funId)));
			disjunction.add(conjunction);
			criteria.add(disjunction);
			criteria.add(Restrictions.eq("elemName", elemName));
			if("edit".equals(type)){
				criteria.add(Restrictions.ne("elemId", ((AigaTestElem)objects[0]).getElemId()));
			}
			AigaTestElem[] aigaTestElems =aigaTestElemSV.getTestElemByCriteria(criteria);
			if(aigaTestElems.length>0&&aigaTestElems[0]!=null&&("add".equals(type)||"edit".equals(type))){
				this.setPostInfo("message", elemName);
			}else{
				if(objects!=null&&objects.length==1){
					if(objects[0] instanceof AigaTestElem){
						elemId = aigaTestElemSV.saveTestElemAndRelaFun((AigaTestElem)objects[0],Integer.valueOf(funId));
					}
				}
			}
			this.setPostInfo("success", true);
			this.setPostInfo("elemId", elemId);
		}catch(NullPointerException e){
			this.setPostInfo("success", false);
			this.setPostInfo("errorInfo", e.getMessage());
		}catch (Exception e) {	
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	

	@RequestMapping("/isOfMultiSysElem.do")
	public void isOfMultiSysElem(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funId = request.getParameter("funId");
			Integer elemId = 0;
			if(funId==null||funId.equals(""))
				throw new Exception("缺少请求参数funId");
			Object[] objects = this.transFormToObj(request, new Class[]{AigaTestElem.class});
			if(objects!=null&&objects.length==1){
				if(objects[0] instanceof AigaTestElem){
					elemId = aigaTestElemSV.saveTestElemAndRelaFun((AigaTestElem)objects[0],Integer.valueOf(funId));
				}
			}
			this.setPostInfo("success", true);
			this.setPostInfo("elemId", elemId);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveSubElem.do")
	public void saveSubElem(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			Object[] objects = this.transFormToObj(request, new Class[]{AigaTestSubElem.class});
			if(objects!=null&&objects.length==1){
				if(objects[0] instanceof AigaTestSubElem){
					aigaTestElemSV.saveAigaSubElem((AigaTestSubElem)objects[0]);
				}
			}
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/deleteTestElemRela.do")
	public void deleteTestElemRela(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funId = request.getParameter("funId");
			if(funId==null||funId.equals(""))
				throw new Exception("缺少请求参数funId");
			String elemIds = request.getParameter("elemIds");
			if(elemIds==null||elemIds.equals(""))
				throw new Exception("缺少请求参数elemIds");
			
			aigaTestElemSV.deleteAigaElem(Integer.valueOf(funId),elemIds);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/approvalTestElem.do")
	public void approvalTestElem(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String elemId = request.getParameter("elemId");
			String deleteFlag = request.getParameter("deleteFlag");
			String staffId = request.getParameter("staffId");
			String staffName = request.getParameter("staffName");
			AigaTestElem aigaTestElem = aigaTestElemSV.getTestElemById(Integer.parseInt(elemId));
			aigaTestElem.setStaffId(Integer.parseInt(staffId));
			aigaTestElem.setStaffName(this.decodeCN(staffName));
			if(deleteFlag!=null&&deleteFlag.equals("0")){//成为公共要素
				aigaTestElem.setIsGlobalElem(1);
			}else{//改为私有要素
				aigaTestElem.setIsGlobalElem(0);
			}
			aigaTestElemSV.approvalTestElem(aigaTestElem);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getTestSubElemForm.do")
	public void getTestSubElemForm(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String subElemId = request.getParameter("subElemId");
			if(subElemId==null||subElemId.equals(""))
				throw new Exception("缺少请求参数subElemId");
			AigaTestSubElem aigaTestSubElem = aigaTestElemSV.getAigaTestSubElemById(Integer.valueOf(subElemId));
			this.setPostInfo("data", aigaTestSubElem);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveFunElemRela.do")
	public void saveFunElemRela(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funId = request.getParameter("funId");
			if(funId==null||funId.equals(""))
				throw new Exception("缺少请求参数funId");
			String elemIds = request.getParameter("elemIds");
			String msg=aigaTestElemSV.saveFunElemRela(Integer.valueOf(funId), elemIds);
			this.setPostInfo("success", true);
			this.setPostInfo("data", msg);
		}catch (NullPointerException e) {
			this.setPostInfo("success", false);
			this.setPostInfo("errorInfo", e.getMessage());
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveElemOrder.do")
	public void saveElemOrder(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funId = request.getParameter("funId");
			if(funId==null||funId.equals(""))
				throw new Exception("缺少请求参数funId");
			String orderJson = request.getParameter("order");
			aigaTestElemSV.saveElemRelaOrder(Integer.valueOf(funId), orderJson);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getElemDeleteMsg.do")
	public void getElemDeleteMsg(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String elemIds = request.getParameter("elemIds");
			String funId = request.getParameter("funId");
			if(elemIds==null)
				throw new Exception("缺少请求参数elemIds");
			String msg = aigaTestElemSV.getDeleteElemMsg(elemIds, funId);
			this.setPostInfo("data", msg);
			this.setPostInfo("success", true);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/deleteSubElem.do")
	public void deleteSubElem(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String subElemIds = request.getParameter("subElemIds");
			if(subElemIds==null||subElemIds.length()==0)
				throw new Exception("缺少请求参数subElemIds");
			String msg=aigaTestElemSV.deleteSubElemByIds(subElemIds);
			this.setPostInfo("success", true);
			this.setPostInfo("data", (msg.length()>0)?"要素值<font color='red'>"+msg+"</font>已被场景使用，不能删除！":msg);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/getRelaHisSubElem.do")
	public void getRelaHisSubElem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String elemId = request.getParameter("elemId");
		String querySql = "from AigaHisSubElem where subElemId in(select subElemId from AigaTestSubElem where elemId="+elemId+") order by hisSubElemId desc";
		AigaHisSubElem[] subElems = aigaTestElemSV.getHisSubElemBySql(querySql);
		
		this.setTable(subElems);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getRelaHisElem.do")
	public void getRelaHisElem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaHisElem where elemId in(select elemId from AigaTestElem where funId in" +
				"(select relaFolderId from AigaFunPoint where subTaskId=" + subTaskId + ")) order by hisElemId desc";
		AigaHisElem[] elems = aigaTestElemSV.getHisElemBySql(querySql);
		
		this.setTable(elems);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value = "/uploadTestElemExcel.do")//导入公共要素
	public void uploadTestElemExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		Boolean success = false;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaSystemFolder.class);
			AigaSystemFolder[] aigaSystemFolders = null;
			try {
				aigaSystemFolders = aigaSystemFolderSV.getSystemFolder(criteria);
			} catch (Exception e2) {
				aigaSystemFolders = new AigaSystemFolder[0];
				e2.printStackTrace();
			}
			Map<String,String> nameToIdMap = new HashMap<String, String>();
			for(AigaSystemFolder aigaSystemFolder:aigaSystemFolders){
				nameToIdMap.put(aigaSystemFolder.getSysName(),aigaSystemFolder.getSysId().toString());
			}
			try {
				List<FileItem> items = upload.parseRequest(request);
				for (FileItem item : items) {
					if (!item.isFormField()) {
						 String name = item.getName();
						 resultMap.put("fileName", name);
						// 获取上传文件
						Map[] fieldsToCells = new HashMap[1];
						Map<String,String> map1 = new HashMap<String,String>();
						map1.put("所属系统", "sysName");
						map1.put("要素名称", "elemName");
						map1.put("要素类型", "elemSysAchieveType");
					    map1.put("测试要素值", "elemTag");//用测试要素编号,暂存测试要素值
					    map1.put("取数SQL", "addReason");//用新增原因,暂存取数SQL
						fieldsToCells[0] = map1;
						try {
							InputStream in = item.getInputStream();
							Object[] objs = XlsHelper.transXlsToObjs(in,fieldsToCells, new Class[] {AigaTestElem.class});
							List elemsList =null;
							elemsList= (List) objs[0];
							List<AigaTestElem> lastAigaTestElemObjList=new ArrayList<AigaTestElem>();
							for (int j = 0, m = elemsList.size(); j < m; j++) {
								AigaTestElem aigaTestElem = new AigaTestElem();
								aigaTestElem=elemsList.get(j) instanceof AigaTestElem?(AigaTestElem)elemsList.get(j):null;
								lastAigaTestElemObjList.add(aigaTestElem);
							}
							int rowNum = 1;
							List<AigaTestElem> successAigaTestElemObjList=new ArrayList<AigaTestElem>();
							boolean errorFalg = true;
							//首先检查数据的完整性
							for(AigaTestElem tempElem:lastAigaTestElemObjList){
								Integer sysId = 0;
								//设置归属系统ID
								try{
									if(tempElem.getSysName()!=null&&!tempElem.getSysName().equals("")){//存在系统名称
										sysId=Integer.valueOf(nameToIdMap.get(tempElem.getSysName()));
									}else{
										resultMap.put("msg", "第"+rowNum+"行的归属系统无数据");
										errorFalg = false;
										break;
									}
								}catch(Exception e){
									resultMap.put("msg", "第"+rowNum+"行的归属系统数据错误");
									errorFalg = false;
									break;
								}
								//检验要素名称是否为空
								try{
									if(tempElem.getElemName()==null||tempElem.getElemName().equals("")){
										resultMap.put("msg", "第"+rowNum+"行的要素名称无数据");
										errorFalg = false;
										break;
									}
								}catch(Exception e){
									resultMap.put("msg", "第"+rowNum+"行的要素名称数据错误");
									errorFalg = false;
									break;
								}
								rowNum++;
							}
							if(errorFalg){//校验通过直接存储
								AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
								Timestamp time = new Timestamp(System.currentTimeMillis());
								Integer tagOrd  = 1000;
								for(AigaTestElem tempElem:lastAigaTestElemObjList){
									AigaTestElem[] aigaTestElem = new AigaTestElem[]{tempElem};
									aigaTestElem[0].setSysId(Integer.valueOf(nameToIdMap.get(tempElem.getSysName())));//设置归属系统ID
									Date data = new Date();
									String createTime = "";
									if(data!=null){
										createTime = new SimpleDateFormat("yyyyMMddHHmmss").format(data).toString();
									}
									aigaTestElem[0].setIsDelete(0);//设置未删除标识
									aigaTestElem[0].setIsGlobalElem(1);//设置公有要素标识
									aigaTestElem[0].setStaffName(user.getUserName());//设置操作人
									aigaTestElem[0].setStaffId(Integer.valueOf(String.valueOf(user.getUserId())));//设置操作人ID
									String takeValueMethod = "";
									try{
										takeValueMethod = aigaTestElem[0].getAddReason();
										aigaTestElem[0].setAddReason(null);
									}catch(Exception e){
										takeValueMethod = "";
									}
									String elemValue = "";
									try{
										elemValue = aigaTestElem[0].getElemTag();
										aigaTestElem[0].setElemTag("TESTELEM"+createTime+tagOrd++);//设置要素编号
									}catch(Exception e){
										elemValue = "";
										aigaTestElem[0].setElemTag("TESTELEM"+createTime+tagOrd++);//设置要素编号
									}
									criteria = DetachedCriteria.forClass(AigaTestElem.class);
									criteria.add(Restrictions.eq("elemName",aigaTestElem[0].getElemName() ));
									criteria.add(Restrictions.eq("sysId",aigaTestElem[0].getSysId() ));
									AigaTestElem[] aigaTestElemQuery =aigaTestElemSV.getTestElemByCriteria(criteria);//是否已经存在
									if(aigaTestElemQuery.length >= 1){//已经存在
										aigaTestElem[0].setElemId(aigaTestElemQuery[0].getElemId());
									}else{//新增
										//successAigaTestElemObjList.add(aigaTestElem[0]);
									}
									aigaTestElemSV.saveTestElem(aigaTestElem[0]);//存储测试要素
									//System.out.println(aigaTestElem[0].getElemId()+"sfdsfs");
									AigaTestSubElem subElem = new AigaTestSubElem();
									subElem.setElemId(aigaTestElem[0].getElemId());//设置要素ID
									subElem.setIsDelete(0);//未删除标识
									subElem.setElemValue(elemValue);
									subElem.setTakeValueMethod(takeValueMethod);
									aigaTestElemSV.saveAigaSubElem(subElem);
									//System.out.println(aigaTestElem[0].getSysId()+"dsdsd");
									//successAigaTestElemObjList.add(aigaTestElem[0]);
								}
							}
							if(errorFalg){
								resultMap.put("data", successAigaTestElemObjList);
								success = true;
							}else{
								resultMap.put("error", true);
							}
						} catch (Exception e) {
							e.printStackTrace();
							resultMap.put("msg", e.getMessage());
							resultMap.put("error", true);
						}finally{
						}

					}
				}
			} catch (Exception e) {
				if(e.getMessage().equals("")){
					e = new Exception("Session已经过期,请重新登录操作!");
				}
				resultMap.put("msg", e.getMessage());
				resultMap.put("error", true);
			}
		}
		resultMap.put("success", success);
	
		ActionHelper.responseFileUpload(request, response, resultMap);

	}
	
}

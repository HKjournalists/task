package com.asiainfo.aiga.userCase.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.userCase.bo.AigaHisSecene;
import com.asiainfo.aiga.userCase.bo.AigaSecene;
import com.asiainfo.aiga.userCase.service.IAigaSeceneSV;

@Controller
public class AigaSeceneAction extends BaseAction {

	@Resource(name="testSeceneSV")
	private IAigaSeceneSV aigaSeceneSV;
	
	@RequestMapping("/getSeceneTable.do")
	public void getSeceneTable(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String node = request.getParameter("treeId");
			String type = request.getParameter("flag");
			JSONArray aigaSecenes = null;
			if(node==null||node.equals("")||type==null||type.equals(""))
				throw new Exception("缺少请求参数treeId或flag");
			if(type.equals("sec"))
				aigaSecenes = aigaSeceneSV.getAigaSeceneByFunId(Integer.valueOf(node));
			else if(type.equals("elem"))
				aigaSecenes = aigaSeceneSV.getAigaElemBySecId(Integer.valueOf(node));
			else if(type.equals("subelem"))
				aigaSecenes = aigaSeceneSV.getAigaSubElemBySubIds(node);
			this.setPostInfo("children", aigaSecenes);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getSeceneForm.do")
	public void getSeceneForm(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String secId = request.getParameter("secId");
			if(secId==null||secId.equals(""))
				throw new Exception("缺少请求参数sceId");
			AigaSecene aigaSecene = aigaSeceneSV.getAigaSeceneById(Integer.valueOf(secId));
			this.setPostInfo("data", aigaSecene);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getSeceneShow.do")
	public void getSeceneShow(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funId = request.getParameter("funId");
			if(funId==null||funId.equals(""))
				throw new Exception("缺少请求参数funId");
			JSONArray array = aigaSeceneSV.getAigaSeceneShowByFunId(Integer.valueOf(funId));
			this.setPostInfo("success", true);
			this.setPostInfo("data", array);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getSubElemShow.do")
	public void getSubElemShow(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funId = request.getParameter("funId");
			if(funId==null||funId.equals(""))
				throw new Exception("缺少请求参数secId");
			JSONArray array = aigaSeceneSV.getAigaSubElemShowByFunId(Integer.valueOf(funId));
			this.setPostInfo("success", true);
			this.setPostInfo("data", array);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveSceneAndRela.do")
	public void saveSceneAndRela(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			Object[] objects = this.transFormToObj(request, new Class[]{AigaSecene.class});
			String secName="";
			String msg="";
			if(objects.length==1){
				if(objects[0] instanceof AigaSecene){
					AigaSecene secene=(AigaSecene)objects[0];
					String elemData = request.getParameter("elemData");
					Integer funID = Integer.valueOf(request.getParameter("funID"));
					String type=request.getParameter("type");
					String sql="from AigaSecene where secId in (select secId from AigaRElemSec where funId="+funID+") "+
						(("edit".equals(type))?" and secId<>"+secene.getSecId():"")
						+" order by secOrder desc";
					AigaSecene[] aigaSecenes=aigaSeceneSV.getSeceneBySql(sql);
					boolean exists=false;
					if(aigaSecenes.length>0&&aigaSecenes[0]!=null){
						if("add".equals(type)||"edit".equals(type)){
							for(AigaSecene aigaSecene:aigaSecenes){
								if(secene.getSeceneName().equals(aigaSecene.getSeceneName())){
									exists=true;break;
								}
							}
						}
						if(exists){
							secName=secene.getSeceneName();
						}else{
							if(aigaSecenes[0].getSecOrder()==null){
								throw new NullPointerException("存在未排序测试场景，请先保存顺序再"+(("add".equals(type))?"新增":"修改")+"场景！");
							}else{
								if("add".equals(type)||"copy".equals(type)){
									secene.setSecOrder(aigaSecenes[0].getSecOrder()+1);
								}
							}
							msg=aigaSeceneSV.saveSceneAndRela(secene, funID, elemData,type);
						}
					}else{
						secene.setSecOrder(0);
						msg=aigaSeceneSV.saveSceneAndRela(secene, funID, elemData,type);
					}
					
				}
			}
			this.setPostInfo("success", true);
			this.setPostInfo("message", secName);
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
	
	private void checkElem(String elemData)throws Exception{
		
	}
	
	@RequestMapping("/getTestElemTableForSecEdit.do")
	public void getTestElemTableForSecEdit(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			JSONArray jsonArray = null;
			String node = request.getParameter("node");
			String funId = request.getParameter("funId");
			String type = request.getParameter("type");
			String secId = request.getParameter("secId");
			if(funId==null||funId.equals(""))
				throw new Exception("缺少参数funId");
			if(secId==null||secId.equals(""))
				throw new Exception("缺少参数secId");
			if(node.equals("-1"))
				jsonArray = aigaSeceneSV.getTestElemTreeGrid(Integer.valueOf(funId),Integer.valueOf(secId),type);
			else
				jsonArray = aigaSeceneSV.getSubTestElemTreeGrid(Integer.valueOf(node),Integer.valueOf(secId),type);
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
	
	@RequestMapping("/deleteSecAndRela.do")
	public void deleteSecAndRela(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String secIds = request.getParameter("secIds");
			if(secIds==null)
				throw new Exception("缺少请求参数secIds");
			aigaSeceneSV.deleteSecAndRela(secIds);
			this.setPostInfo("success", true);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveSecOrder.do")
	public void saveSecOrder(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String orderJson = request.getParameter("order");
			Integer funID = Integer.valueOf(request.getParameter("funID"));
			
			if(orderJson==null)
				throw new Exception("缺少请求参数orderJson");
			aigaSeceneSV.saveSecOrder(orderJson, funID);
			this.setPostInfo("success", true);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getSecDeleteMsg.do")
	public void getSecDeleteMsg(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String secIds = request.getParameter("secIds");
			if(secIds==null)
				throw new Exception("缺少请求参数secIds");
			String msg = aigaSeceneSV.getDeleteSecMsg(secIds);
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
	
	@RequestMapping(value="/getRelaHisScene.do")
	public void getRelaHisScene(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaHisSecene where subTaskTag in(select subTaskTag from AigaTestSubTask where subTaskId=" + subTaskId + ") order by hisSecId desc";
		AigaHisSecene[] historys = aigaSeceneSV.getHisSeceneBySql(querySql);
		
		this.setTable(historys);
		this.postInfo(request, response);
	}
	
}

package com.asiainfo.aiga.component.service.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.component.bo.AigaComponent;
import com.asiainfo.aiga.component.bo.extend.AigaBaseComponent;
import com.asiainfo.aiga.component.bo.extend.AigaInstComponent;
import com.asiainfo.aiga.component.dao.IAigaComponentDAO;
import com.asiainfo.aiga.component.service.IAigaComponentSV;
import com.asiainfo.aiga.gui.bo.extend.AigaBaseGui;
import com.asiainfo.aiga.gui.bo.extend.AigaInstGui;
import com.asiainfo.aiga.gui.dao.IAigaGuiDAO;
import com.asiainfo.aiga.gui.service.IAigaGuiSV;
import com.asiainfo.aiga.r_comp_gui.bo.extend.AigaBaseRCompGui;
import com.asiainfo.aiga.r_comp_gui.bo.extend.AigaInstRCompGui;
import com.asiainfo.aiga.r_comp_gui.dao.IAigaRCompGuiDAO;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;

public class AigaComponentSVImpl implements IAigaComponentSV {

	private IAigaComponentDAO componentDAO;
	private IAigaRCompGuiDAO aigaRCompGuiDAO;
	private IAigaGuiDAO aigaGuiDAO;
	
	public void setAigaGuiDAO(IAigaGuiDAO aigaGuiDAO) {
		this.aigaGuiDAO = aigaGuiDAO;
	}

	public void setAigaRCompGuiDAO(IAigaRCompGuiDAO aigaRCompGuiDAO) {
		this.aigaRCompGuiDAO = aigaRCompGuiDAO;
	}

	public void setComponentDAO(IAigaComponentDAO componentDAO) {
		this.componentDAO = componentDAO;
	}

	public void deleteAigaComponent(AigaComponent value) throws Exception {
		// TODO Auto-generated method stub
		componentDAO.delete(value);
	}

	public void saveAigaComponent(AigaComponent value) throws Exception {
		// TODO Auto-generated method stub
		componentDAO.saveOrUpdate(value);
	}

	public AigaComponent[] getAigaComponentByParentId(Integer parentId,Class clazz) throws Exception
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
		criteria.add(Restrictions.eq("parentId", parentId));
		return componentDAO.getAigaComponentByCriteria(criteria);
	}

	public void saveTransCompJson(String json) throws Exception {
		// TODO Auto-generated method stub
		JSONObject compObj = JSONObject.fromObject(json);
		String url = compObj.getString("url");
		String screenshot = compObj.getString("screenshot");
		String updatetime = compObj.getString("updatetime");
		JSONArray elements = JSONArray.fromObject(compObj.get("elementlist"));
		
		Iterator elems = elements.iterator();
		while(elems.hasNext()){
			AigaComponent component = new AigaInstComponent();
			JSONObject elem = JSONObject.fromObject(elems.next());
			String selector = elem.getString("selector");
			String bounds = elem.getString("bounds");
			String tag = elem.getString("tag");
			String name = elem.getString("name");
			JSONObject extra = JSONObject.fromObject(elem.get("extra"));
			String html = extra.getString("html");
			String type = extra.getString("type");
			component.setAuthor("ADMIN");
			component.setParentId(2);
			component.setCompName(name);
			component.setUrl(url);
			component.setPermission(1);
			Date date = new SimpleDateFormat("yyyy/MM/dd").parse(updatetime);
			component.setUpdateTime(new Timestamp(date.getTime()));
			component.setCreateTime(new Timestamp(new Date().getTime()));
			componentDAO.saveOrUpdate(component);
		}
	}
	
	public AigaComponent[] getAigaComponentBySql(String querySql) throws Exception
	{
		return componentDAO.getAigaComponentBySql(querySql);
	}

	@Override
	public void saveCompFolder(String folderName, String compId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstComponent.class);
		criteria.add(Restrictions.eq("compId", Integer.valueOf(compId)));
		AigaComponent[] components = componentDAO.getAigaComponentByCriteria(criteria);
		if(components.length!=1)
			throw new Exception("未查找到组件的文件夹");
		if(components[0].getIsLeaf().equals('Y'))
			throw new Exception("不可以在叶子节点添加folder");
		String[] folderNames = folderName.split("\\.");
		String folderId = compId;
		for(String name : folderNames){
			criteria = DetachedCriteria.forClass(AigaInstComponent.class);
			criteria.add(Restrictions.eq("parentId", Integer.valueOf(folderId)));
			criteria.add(Restrictions.eq("compName", name));
			AigaComponent[] compons = componentDAO.getAigaComponentByCriteria(criteria);
			if(compons.length==0){
				AigaInstComponent folder = new AigaInstComponent();
				folder.setCompName(name);
				folder.setIsLeaf("N");
				folder.setParentId(Integer.valueOf(folderId));
				folder.setCreateTime(new Timestamp(new Date().getTime()));
				folder.setUpdateTime(new Timestamp(new Date().getTime()));
				componentDAO.saveOrUpdate(folder);
				folderId = folder.getCompId().toString();
			}else
				folderId = compons[0].getCompId().toString();
		}
	}

	@Override
	public void editCompFolder(String folderName, String compId)
			throws Exception {
		// TODO Auto-generated method stub
		String[] folderNames = folderName.split("\\.");
		for(int i=0,n=folderNames.length;i<n;i++){
			String folderId = compId;
			if(i==0){
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstComponent.class);
				criteria.add(Restrictions.eq("compId", Integer.valueOf(compId)));
				AigaComponent[] components = componentDAO.getAigaComponentByCriteria(criteria);
				if(components.length!=1)
					throw new Exception("未查找到组件的文件夹");
				if(components[0].getIsLeaf().equals('Y'))
					throw new Exception("不可以在叶子节点添加folder");
				components[0].setCompName(folderNames[i]);
				componentDAO.saveOrUpdate(components[0]);
				folderId = components[0].getCompId().toString();
			}else{
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstComponent.class);
				criteria.add(Restrictions.eq("parentId", Integer.valueOf(compId)));
				criteria.add(Restrictions.eq("compName", folderNames[i]));
				AigaComponent[] components = componentDAO.getAigaComponentByCriteria(criteria);
				if(components.length==0){
					AigaInstComponent folder = new AigaInstComponent();
					folder.setCompName(folderNames[i]);
					folder.setIsLeaf("N");
					folder.setParentId(Integer.valueOf(folderId));
					folder.setCreateTime(new Timestamp(new Date().getTime()));
					folder.setUpdateTime(new Timestamp(new Date().getTime()));
					componentDAO.saveOrUpdate(folder);
					folderId = folder.getCompId().toString();
				}else{
					folderId = components[0].getCompId().toString();
				}
			}
		}
	}

	@Override
	public void deleteCompFolder(String folderName, String compId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstComponent.class);
		criteria.add(Restrictions.eq("parentId", Integer.valueOf(compId)));
		AigaComponent[] components = componentDAO.getAigaComponentByCriteria(criteria);
		if(components.length==0){
			criteria = DetachedCriteria.forClass(AigaInstComponent.class);
			criteria.add(Restrictions.eq("compId", Integer.valueOf(compId)));
			AigaComponent[] compots = componentDAO.getAigaComponentByCriteria(criteria);
			componentDAO.delete(compots[0]);
		}else
			throw new Exception("节点下还有子节点，不可以删除");
	}

	@Override
	public AigaInstComponent[] getUnApprovalComp(String staff) throws Exception {
		// TODO Auto-generated method stub
		List<AigaInstComponent> list = componentDAO.getAigaComponentByHql("from AigaInstComponent where approvalPsn='"+staff+"' and permission=1");
		return list.toArray(list.toArray(new AigaInstComponent[0]));
	}

	@Override
	public void saveApprovalComp(AigaInstComponent aigaComponent) throws Exception {
		// TODO Auto-generated method stub
		if(aigaComponent.getPermission().equals(0)){
			AigaBaseComponent aigaBaseComponent = null;
			if(aigaComponent.getBaseCompId()==null){
				aigaBaseComponent = new AigaBaseComponent();
			}else{
				List aigaBaseComponents = componentDAO.getAigaComponentByHql("from AigaBaseComponent where compId="+aigaComponent.getBaseCompId());
				if(aigaBaseComponents.size()!=1)
					throw new Exception("未查找到相应的组件信息，在表aiga_base_component中,compId："+aigaComponent.getBaseCompId());
				aigaBaseComponent = (AigaBaseComponent)aigaBaseComponents.get(0);
			}
			
			aigaBaseComponent.setAuthor(aigaComponent.getAuthor());
			aigaBaseComponent.setAuthorNo(aigaComponent.getAuthorNo());
			aigaBaseComponent.setCompDesc(aigaComponent.getCompDesc());
			aigaBaseComponent.setCompName(aigaComponent.getCompName());
			aigaBaseComponent.setCreateTime(aigaComponent.getCreateTime());
			aigaBaseComponent.setDefaultVal(aigaComponent.getDefaultVal());
			aigaBaseComponent.setExtra(aigaComponent.getExtra());
			aigaBaseComponent.setHashcode(aigaComponent.getHashcode());
			aigaBaseComponent.setLatestOperator(aigaComponent.getLatestOperator());
			aigaBaseComponent.setParentId(aigaComponent.getParentId());
			aigaBaseComponent.setPath(aigaComponent.getPath());
			aigaBaseComponent.setPermission(aigaComponent.getPermission());
			aigaBaseComponent.setUpdateTime(aigaComponent.getUpdateTime());
			aigaBaseComponent.setUrl(aigaComponent.getUrl());
			this.saveAigaComponent(aigaBaseComponent);
			aigaComponent.setBaseCompId(aigaBaseComponent.getCompId());
			this.saveAigaComponent(aigaComponent);
			
			List aigaInstRGuiComps = aigaRCompGuiDAO.getAigaGuiCompRelaByHql("from AigaInstRCompGui where compId="+aigaBaseComponent.getCompId());
			for(Object aigaInstRGuiComp : aigaInstRGuiComps){
				AigaInstRCompGui compGui = (AigaInstRCompGui)aigaInstRGuiComp;
				
				List aigaInstGuis = aigaGuiDAO.getAigaGuisByHql("from AigaInstGui where guiId="+compGui.getGuiId());
				if(aigaInstGuis.size()==1){
					AigaInstGui instGui = (AigaInstGui)aigaInstGuis.get(0);
					if(instGui.getBaseGuiId()!=null){
						AigaBaseRCompGui baseRCompGui = new AigaBaseRCompGui();
						baseRCompGui.setCompId(aigaBaseComponent.getCompId());
						baseRCompGui.setGuiId(instGui.getBaseGuiId());
						baseRCompGui.setGuiOrder(compGui.getGuiOrder());
						aigaRCompGuiDAO.saveOrUpdate(baseRCompGui);
						compGui.setBaseRelaId(baseRCompGui.getRelaId());
						aigaRCompGuiDAO.saveOrUpdate(compGui);
					}
				}
			}
		}else
			this.saveAigaComponent(aigaComponent);
	}

	@Override
	public void saveBatchApprovalComp(String compIds,AigaUser currentUser) throws Exception {
		// TODO Auto-generated method stub
		String[] compId = compIds.split(",");
		for(String id : compId){
			List<AigaInstComponent> aigaInstComponents = componentDAO.getAigaComponentByHql("from AigaInstComponent where compId="+id);
			if(aigaInstComponents==null||aigaInstComponents.size()==0)
				continue;
			AigaInstComponent aigaInstComponent = aigaInstComponents.get(0);
			aigaInstComponent.setPermission(0);
			aigaInstComponent.setApprovalName(currentUser.getUserName());
			aigaInstComponent.setApprovalPsn(currentUser.getUserAccount());
			this.saveApprovalComp(aigaInstComponent);
		}
	}

}

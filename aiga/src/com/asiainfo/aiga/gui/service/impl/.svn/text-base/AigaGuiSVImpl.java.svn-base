package com.asiainfo.aiga.gui.service.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.component.bo.AigaComponent;
import com.asiainfo.aiga.component.bo.extend.AigaInstComponent;
import com.asiainfo.aiga.gui.bo.AigaGui;
import com.asiainfo.aiga.gui.bo.extend.AigaBaseGui;
import com.asiainfo.aiga.gui.bo.extend.AigaInstGui;
import com.asiainfo.aiga.gui.dao.IAigaGuiDAO;
import com.asiainfo.aiga.gui.service.IAigaGuiSV;
import com.asiainfo.aiga.r_comp_gui.bo.AigaGuiCompRela;
import com.asiainfo.aiga.r_comp_gui.bo.extend.AigaBaseRCompGui;
import com.asiainfo.aiga.r_comp_gui.bo.extend.AigaInstRCompGui;
import com.asiainfo.aiga.r_comp_gui.dao.IAigaRCompGuiDAO;

public class AigaGuiSVImpl implements IAigaGuiSV{

	private IAigaGuiDAO aigaGuiDAO;
	private IAigaRCompGuiDAO aigaRCompGuiDAO;
	
	public void setAigaRCompGuiDAO(IAigaRCompGuiDAO aigaRCompGuiDAO) {
		this.aigaRCompGuiDAO = aigaRCompGuiDAO;
	}

	public void setAigaGuiDAO(IAigaGuiDAO aigaGuiDAO) {
		this.aigaGuiDAO = aigaGuiDAO;
	}
	
	public void deleteAigaGui(AigaGui value) throws Exception {
		// TODO Auto-generated method stub
		aigaGuiDAO.delete(value);
	}

	public AigaGui[] getAigaGuiById(Integer aigaId,Class clazz) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria =  DetachedCriteria.forClass(clazz);
		criteria.add(Restrictions.eq("guiId", aigaId));
		AigaGui[] aigaGuis = aigaGuiDAO.getUpdateByCriteria(criteria);
		return aigaGuis;
	}

	public void saveAigaGui(AigaGui value) throws Exception {
		// TODO Auto-generated method stub
		aigaGuiDAO.saveOrUpdate(value);
	}

	public AigaGui[] getAigaGuiByParentId(Integer aigaId,Class clazz) throws Exception {
		DetachedCriteria criteria =  DetachedCriteria.forClass(clazz);
		criteria.add(Restrictions.eq("parentId", aigaId));
		AigaGui[] aigaGuis = aigaGuiDAO.getAigaGuisByCriteria(criteria);
		return aigaGuis;
	}

	public AigaGui[] getAigaGuiByCompId(Integer comId,Class clazz) throws Exception {
		Class rClass=AigaBaseRCompGui.class;
		if(clazz.equals(AigaInstGui.class)){
			rClass=AigaInstRCompGui.class;
		}
		DetachedCriteria criteria =  DetachedCriteria.forClass(rClass);
		criteria.add(Restrictions.eq("compId", comId));
		AigaGuiCompRela[] aigaGuiCompRelas = aigaRCompGuiDAO.getAigaGuiCompRelaByCriteria(criteria);
		int n=aigaGuiCompRelas.length;
		if(n==0)return null;
		else{
			AigaGui[] aigaGuis=new AigaGui[n];
			for(int i=0;i<n;i++){
				aigaGuis[i]=getAigaGuiById(aigaGuiCompRelas[i].getGuiId(),clazz)[0];
			}
			return aigaGuis;
		}
	}

	public void saveRCompGui(AigaGuiCompRela aigaGuiCompRela) throws Exception {
		aigaRCompGuiDAO.saveOrUpdate(aigaGuiCompRela);
		
	}

	public void delRCompGuiByCompId(Integer compId,Class clazz) throws Exception {
		DetachedCriteria criteria =  DetachedCriteria.forClass(clazz);
		criteria.add(Restrictions.eq("compId", compId));
		AigaGuiCompRela[] aigaGuiCompRelas = aigaRCompGuiDAO.getAigaGuiCompRelaByCriteria(criteria);
		for(AigaGuiCompRela aigaGuiComRela:aigaGuiCompRelas){
			aigaRCompGuiDAO.delete(aigaGuiComRela);
		}
		
	}

	public void saveTransGuiJson(String json) throws Exception {
		// TODO Auto-generated method stub
		JSONArray guis = JSONArray.fromObject(json);
		for(int i=0,n=guis.size();i<n;i++){
			JSONObject gui = JSONObject.fromObject(guis.get(i));
			String selector = gui.getString("selectors");
			String tag = gui.getString("tag");
			String name = gui.getString("name");
			String url = gui.getString("url");
			String value = gui.getString("value");
			String[] names = name.split("\\.");
			Integer folderId = 1;
			for(int j=0,k=names.length;j<k;j++){
				if(j==names.length-1){
					DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstGui.class);
					criteria.add(Restrictions.eq("parentId", folderId));
					criteria.add(Restrictions.eq("guiName", names[j]));
					AigaGui[] aigaGuis = aigaGuiDAO.getAigaGuisByCriteria(criteria);
					AigaInstGui aigaGui = null;
					if(aigaGuis.length==0)
						aigaGui= new AigaInstGui();
					else
						aigaGui = (AigaInstGui)aigaGuis[0];
					aigaGui.setGuiAuthor("UNKNOW");
					aigaGui.setParentId(folderId);
					aigaGui.setGuiName(names[j]);
					aigaGui.setGuiUrl(url);
					aigaGui.setGuiTag(tag);
					aigaGui.setGuiSelector(selector);
					aigaGui.setGuiPermission(Short.valueOf("1"));
					aigaGui.setGuiUpdateTime(new Timestamp(new Date().getTime()));
					aigaGui.setGuiCreateTime(new Timestamp(new Date().getTime()));
					aigaGui.setIsLeaf("Y");
					aigaGuiDAO.saveOrUpdate(aigaGui);
				}else{
					DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstGui.class);
					criteria.add(Restrictions.eq("parentId", folderId));
					criteria.add(Restrictions.eq("guiName", names[j]));
					AigaGui[] aigaGuis = aigaGuiDAO.getAigaGuisByCriteria(criteria);
					if(aigaGuis.length==0){
						AigaInstGui guiFolder = new AigaInstGui();
						guiFolder.setGuiName(names[j]);
						guiFolder.setParentId(folderId);
						guiFolder.setGuiPermission(Short.valueOf("0"));
						guiFolder.setGuiUpdateTime(new Timestamp(new Date().getTime()));
						guiFolder.setGuiCreateTime(new Timestamp(new Date().getTime()));
						guiFolder.setIsLeaf("N");
						aigaGuiDAO.saveOrUpdate(guiFolder);
						folderId = guiFolder.getGuiId();
					}else{
						folderId = aigaGuis[0].getGuiId();
					}
				}
			}
		}
	}

	@Override
	public void saveAigaGui(AigaInstGui aigaInstGui) throws Exception {
		// TODO Auto-generated method stub
		if(aigaInstGui.getGuiPermission().equals(0)){
			AigaBaseGui aigaBaseGui =null;
			if(aigaInstGui.getBaseGuiId()!=null){
				List list = aigaGuiDAO.getAigaGuisByHql("from AigaBaseGui where guiId="+aigaInstGui.getBaseGuiId());
				if(list.size()!=1)
					throw new Exception("未查找到相应的控件信息,在表aiga_base_gui,guiId："+aigaInstGui.getBaseGuiId());
				aigaBaseGui = (AigaBaseGui)list.get(0);
			}else{
				aigaBaseGui = new AigaBaseGui();
			}
			
			aigaBaseGui.setGuiAuthor(aigaInstGui.getGuiAuthor());
			aigaBaseGui.setGuiBounds(aigaInstGui.getGuiBounds());
			aigaBaseGui.setGuiCreateTime(new Timestamp(new Date().getTime()));
			aigaBaseGui.setGuiDesc(aigaInstGui.getGuiDesc());
			aigaBaseGui.setGuiExtra(aigaInstGui.getGuiExtra());
			aigaBaseGui.setGuiHashcode(aigaInstGui.getGuiHashcode());
			aigaBaseGui.setGuiHtml(aigaInstGui.getGuiHtml());
			aigaBaseGui.setGuiLatestOperator(aigaInstGui.getGuiLatestOperator());
			aigaBaseGui.setGuiName(aigaInstGui.getGuiName());
			aigaBaseGui.setGuiPath(aigaInstGui.getGuiPath());
			aigaBaseGui.setGuiPermission(aigaInstGui.getGuiPermission());
			aigaBaseGui.setGuiSelector(aigaInstGui.getGuiSelector());
			aigaBaseGui.setGuiTag(aigaInstGui.getGuiTag());
			aigaBaseGui.setguiThumbUrl(aigaInstGui.getguiThumbUrl());
			aigaBaseGui.setGuiUpdateTime(aigaInstGui.getGuiUpdateTime());
			aigaBaseGui.setGuiUrl(aigaInstGui.getGuiUrl());
			aigaBaseGui.setParentId(aigaInstGui.getParentId());
			
			aigaGuiDAO.saveOrUpdate(aigaBaseGui);
			aigaInstGui.setBaseGuiId(aigaInstGui.getBaseGuiId());
			this.saveAigaGui(aigaInstGui);
		}else{
			this.saveAigaGui(aigaInstGui);
		}
	}

	@Override
	public void deleteGuiFolder(String folderName, String guiId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstGui.class);
		criteria.add(Restrictions.eq("parentId", Integer.valueOf(guiId)));
		AigaGui[] aigaGuis =  aigaGuiDAO.getAigaGuisByCriteria(criteria);
		if(aigaGuis.length==0){
			criteria = DetachedCriteria.forClass(AigaInstGui.class);
			criteria.add(Restrictions.eq("guiId", Integer.valueOf(guiId)));
			AigaGui[] guis = aigaGuiDAO.getAigaGuisByCriteria(criteria);
			aigaGuiDAO.delete(guis[0]);
		}else
			throw new Exception("节点下还有子节点，不可以删除");
	}

	@Override
	public void editGuiFolder(String folderName, String guiId) throws Exception {
		// TODO Auto-generated method stub
		String[] folderNames = folderName.split("\\.");
		for(int i=0,n=folderNames.length;i<n;i++){
			String folderId = guiId;
			if(i==0){
				List<AigaInstGui> aigaInstGui = aigaGuiDAO.getAigaGuisByHql("from AigaInstGui where guiId="+guiId);
				if(aigaInstGui.size()!=1)
					throw new Exception("未查找到控件的文件夹");
				if(aigaInstGui.get(0).getIsLeaf().equals('Y'))
					throw new Exception("不可以在叶子节点添加folder");
				AigaInstGui instGui = aigaInstGui.get(0);
				instGui.setGuiName(folderNames[i]);
				aigaGuiDAO.saveOrUpdate(instGui);
				folderId = instGui.getGuiId().toString();
			}else{
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstGui.class);
				criteria.add(Restrictions.eq("parentId", Integer.valueOf(guiId)));
				criteria.add(Restrictions.eq("guiName", folderNames[i]));
				AigaGui[] aigaGuis =  aigaGuiDAO.getAigaGuisByCriteria(criteria);
				if(aigaGuis.length==0){
					AigaInstGui folder = new AigaInstGui();
					folder.setGuiName(folderNames[i]);
					folder.setIsLeaf("N");
					folder.setParentId(Integer.valueOf(folderId));
					folder.setGuiCreateTime(new Timestamp(new Date().getTime()));
					folder.setGuiUpdateTime(new Timestamp(new Date().getTime()));
					
					aigaGuiDAO.saveOrUpdate(folder);
					folderId = folder.getGuiId().toString();
				}else
					folderId = aigaGuis[0].getGuiId().toString();
			}
		}
	}

	@Override
	public void savGuiFolder(String folderName, String guiId) throws Exception {
		// TODO Auto-generated method stub
		List<AigaInstGui> aigaInstGui = aigaGuiDAO.getAigaGuisByHql("from AigaInstGui where guiId="+guiId);
	    if(aigaInstGui.size()!=1)
			throw new Exception("未查找到控件的文件夹");
		if(aigaInstGui.get(0).getIsLeaf().equals('Y'))
			throw new Exception("不可以在叶子节点添加folder");
		String[] folderNames = folderName.split("\\.");
		String folderId = guiId;
		for(String name : folderNames){
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstGui.class);
			criteria.add(Restrictions.eq("parentId", Integer.valueOf(folderId)));
			criteria.add(Restrictions.eq("guiName", name));
			
			AigaGui[] aigaGuis =  aigaGuiDAO.getAigaGuisByCriteria(criteria);
			if(aigaGuis.length==0){
				AigaInstGui folder = new AigaInstGui();
				folder.setGuiName(name);
				folder.setIsLeaf("N");
				folder.setParentId(Integer.valueOf(folderId));
				folder.setGuiCreateTime(new Timestamp(new Date().getTime()));
				folder.setGuiUpdateTime(new Timestamp(new Date().getTime()));
				
				aigaGuiDAO.saveOrUpdate(folder);
				folderId = folder.getGuiId().toString();
			}else
				folderId = aigaGuis[0].getGuiId().toString();
		}
	}
	
	@Override
	public List<AigaInstGui> getAigaCaseByHql(String hql)throws Exception{
		return aigaGuiDAO.getAigaGuisByHql(hql);
	}
}

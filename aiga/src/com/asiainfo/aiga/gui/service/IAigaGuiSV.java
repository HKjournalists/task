package com.asiainfo.aiga.gui.service;

import java.util.List;

import com.asiainfo.aiga.gui.bo.AigaGui;
import com.asiainfo.aiga.gui.bo.extend.AigaInstGui;
import com.asiainfo.aiga.r_comp_gui.bo.AigaGuiCompRela;

public interface IAigaGuiSV {

	public AigaGui[] getAigaGuiById(Integer aigaId,Class clazz)throws Exception;
	
	public AigaGui[] getAigaGuiByParentId(Integer aigaId,Class clazz)throws Exception;
	
	public void saveAigaGui(AigaGui aValue)throws Exception;
	
	public void deleteAigaGui(AigaGui aValue)throws Exception;
	
	public AigaGui[] getAigaGuiByCompId(Integer comId,Class clazz)throws Exception;
	
	public void saveRCompGui(AigaGuiCompRela aigaGuiCompRela)throws Exception;
	
	public void delRCompGuiByCompId(Integer compId,Class clazz)throws Exception;
	
	public void saveTransGuiJson(String json)throws Exception;
	
	public void saveAigaGui(AigaInstGui aigaInstGui)throws Exception;

	public void deleteGuiFolder(String folderName, String guiId) throws Exception;

	public void editGuiFolder(String folderName, String guiId) throws Exception;

	public void savGuiFolder(String folderName, String guiId) throws Exception;
	
	public List<AigaInstGui> getAigaCaseByHql(String hql)throws Exception;
}

package com.asiainfo.aiga.search.dao;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.asiainfo.aiga.search.bo.AigaExtIndex;

public interface ILuceneSearchDAO {
	
	public List<AigaExtIndex> getNewExtIndexList() throws Exception;
	
	public void saveExtIndex(AigaExtIndex index) throws Exception;
	
	public List getInitFileList() throws Exception;
	
	public String[] getLabels(HttpServletRequest request) throws Exception;
	
	List<String> getAddWords() throws SQLException ;
	
	public void setWordStatus(List valueList) throws SQLException ;

	void initStatus(String status) throws SQLException;
	
	public List getObjectByHQL(String HQL ) throws Exception;
	public List getObjectBySQL(String SQL)throws Exception ;

}

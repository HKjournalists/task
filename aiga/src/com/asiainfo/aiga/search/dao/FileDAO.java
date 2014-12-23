package com.asiainfo.aiga.search.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.asiainfo.aiga.label.bo.AigaLabel;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.userCase.bo.AigaCase;


/**
 * 对file表进行dao操作
 * @author Administrator
 *
 */
public class FileDAO {
	private BaseDAO baseDao;
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	/**
	 * 获取文件信息
	 * @return
	 * @throws SQLException 
	 */
	public List getFile() throws SQLException {
		List caseList = new ArrayList();
	//	String sql = "SELECT node_name as "+NodeViewConstant.NODE_NAME+",parent_id as "+NodeViewConstant.NODE_PARENT_ID+",node_id as "+NodeViewConstant.NODE_ID+",node_table as "+NodeViewConstant.NODE_TABLE_NAME+" FROM node_view";
		String sql ="select case_name as caseName, case_id as caseId,parent_id as parentId from aiga_inst_case where case_id>1000 order by case_id ";
		
		try{
			baseDao =BaseDAO.getBaseDaoInstance();
//			SessionFactory sessionFactory=baseDao.getSessionFactory();
//			Session session=sessionFactory.getCurrentSession();
//			session.beginTransaction();
//			session.
			con = baseDao.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				AigaCase aigaCase = new AigaCase();
				aigaCase.setCaseId(rs.getInt("caseId"));
				aigaCase.setCaseName(rs.getString("caseName"));
				aigaCase.setFunFolderId(rs.getInt("parentId"));
				aigaCase.setCaseDesc(rs.getString("caseDesc"));
				caseList.add(aigaCase);
			}
			sql="select req_name ,req_id ,req_desc from aiga_requisition";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				AigaRequisition aigaRequisition = new AigaRequisition();
				aigaRequisition.setReqName(rs.getString("req_name"));
				aigaRequisition.setReqId(rs.getInt("req_id"));
				aigaRequisition.setReqName(rs.getString("req_name"));
				caseList.add(aigaRequisition);
			}
			sql = "select label_name, label_id, label_desc from aiga_label where parent_id=51";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				AigaLabel aigaLabel = new AigaLabel();
				aigaLabel.setLabelId(rs.getInt("label_id"));
				aigaLabel.setLabelName(rs.getString("label_name"));
				aigaLabel.setLabelDesc(rs.getString("label_desc"));
				caseList.add(aigaLabel);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, ps, con);
		}
		return caseList;
		
	}
	
	public List getCaseList() throws SQLException {
		List caseList = new ArrayList();
		String sql ="select case_name as caseName, case_id as caseId,parent_id as parentId from aiga_inst_case where case_id>1000 order by case_id ";
		
		try{
			baseDao =BaseDAO.getBaseDaoInstance();
			con = baseDao.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				AigaCase aigaCase = new AigaCase();
				aigaCase.setCaseId(rs.getInt("caseId"));
				aigaCase.setCaseName(rs.getString("caseName"));
				aigaCase.setFunFolderId(rs.getInt("parentId"));
				caseList.add(aigaCase);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, ps, con);
		}
		return caseList;
	}
	public List getRequisitionList() throws SQLException {
		List list = new ArrayList();
		String sql ="select req_id, req_name,req_desc from aiga_requisition where req_name is not null";
		baseDao = BaseDAO.getBaseDaoInstance();
		try{
			
			con = baseDao.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				AigaRequisition req = new AigaRequisition();
				req.setReqId(rs.getInt("req_id"));
				req.setReqName(rs.getString("req_name"));
				req.setReqDesc(rs.getString("req_desc"));
				list.add(req);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, ps, con);
		}
		return list;
	}
	public List getOwnLabelList() throws SQLException {
		List caseList = new ArrayList();
	//	String sql = "SELECT node_name as "+NodeViewConstant.NODE_NAME+",parent_id as "+NodeViewConstant.NODE_PARENT_ID+",node_id as "+NodeViewConstant.NODE_ID+",node_table as "+NodeViewConstant.NODE_TABLE_NAME+" FROM node_view";
		String sql ="select label_name, label_id, label_desc from aiga_label where parent_id=51";
		
		try{
			baseDao = BaseDAO.getBaseDaoInstance();
			con = baseDao.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				AigaLabel aigaLabel = new AigaLabel();
				aigaLabel.setLabelId(rs.getInt("label_id"));
				aigaLabel.setLabelName(rs.getString("label_name"));
				aigaLabel.setLabelDesc(rs.getString("label_desc"));
				caseList.add(aigaLabel);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, ps, con);
		}
		return caseList;
	}
	public List<String> getAddWords() throws SQLException {
		List list = new ArrayList();

		String sql ="select value FROM aiga_ext_dict where status=0";
		
		try{
			baseDao =  BaseDAO.getBaseDaoInstance();
			con = baseDao.getConnection();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				String value=rs.getString("value");
				System.out.println(value);
				list.add(value);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, ps, con);
		}
		return list;
	}
	public int initStatus() throws SQLException{
		String initStatus="0";
		return initStatus(initStatus);
	}
	public int initStatus(String status) throws SQLException {
		String sql ="update aiga_ext_dict set status="+status;
		int resultNumber=0;
		try{
			baseDao =  BaseDAO.getBaseDaoInstance();
			con = baseDao.getConnection();
			ps = con.prepareStatement(sql);
			resultNumber= ps.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, ps, con);
		}
		return resultNumber;
	}
	public int setWordStatus(List valueList) throws SQLException {
		String sql ="update aiga_ext_dict set status =1 where value in(";
		StringBuffer stringBuf=new StringBuffer();
		for(int i=0,n=valueList.size();i<n;i++){
			stringBuf.append("'");
			stringBuf.append(valueList.get(i));
			stringBuf.append("'");
			if(i!=n-1){
				stringBuf.append(",");
			}
		}
		sql+=stringBuf+")";
		System.out.println(sql);
		int resultNumber=0;
		try{
			baseDao =  BaseDAO.getBaseDaoInstance();
			con = baseDao.getConnection();
			ps = con.prepareStatement(sql);
			resultNumber= ps.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDAO.free(rs, ps, con);
		}
		return resultNumber;
	}
}

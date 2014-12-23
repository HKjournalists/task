package com.asiainfo.aiga.search.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.label.bo.AigaLabel;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.search.bo.AigaExtIndex;
import com.asiainfo.aiga.search.dao.BaseDAO;
import com.asiainfo.aiga.search.dao.ILuceneSearchDAO;
import com.asiainfo.aiga.userCase.bo.AigaFunFolder;
import com.asiainfo.aiga.userCase.bo.AigaSystemFolder;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;

public class LuceneSearchDAOImpl extends HibernateDaoSupport implements ILuceneSearchDAO {
	
	public List<AigaExtIndex> getNewExtIndexList() throws Exception {
		String condition = "from AigaExtIndex where deal_status=0";
		return (List<AigaExtIndex>)this.getHibernateTemplate().find(condition);
	}
	
	public void saveExtIndex(AigaExtIndex index) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(index);
	}
	
	public List getInitFileList() throws Exception {
		String caseSql = "from AigaInstCase where case_type is not null order by case_id";
		String funFolderSQL="FROM AigaFunFolder";
		String sysFolderSQL="FROM AigaSystemFolder";
		String reqSql = "from AigaRequisition order by req_id";
		String labelSql = "from AigaLabel order by label_id";
		List list = new ArrayList();
		List<AigaInstCase> caseList = (List<AigaInstCase>)this.getHibernateTemplate().find(caseSql);
		for(AigaInstCase aCase : caseList) {
			AigaInstCase instCase = new AigaInstCase();
			instCase.setCaseId(aCase.getCaseId());
			instCase.setCaseName(aCase.getCaseName());
			instCase.setCaseDesc(aCase.getCaseDesc());
			instCase.setSysLabel(aCase.getSysLabel());
			instCase.setFunFolderId(aCase.getFunFolderId());
			list.add(instCase);
		}
		List<AigaFunFolder> funFolderList = (List<AigaFunFolder>)this.getHibernateTemplate().find(funFolderSQL);
		for(AigaFunFolder aigaFunFolder : funFolderList) {
			AigaFunFolder funFolder = new AigaFunFolder();
			funFolder.setFunId(aigaFunFolder.getFunId());
			String menuPath = aigaFunFolder.getMenuPath();
			if(menuPath == null || "".equals(menuPath)) {
				menuPath = aigaFunFolder.getSysName();
			} else {
				int last = menuPath.lastIndexOf("-->");
				int first = menuPath.indexOf("-->");
				if(first != -1) {
					menuPath = menuPath.substring(0, first) + "-->" + menuPath.substring(last + 3);
				}
			}
			funFolder.setSysName(menuPath);
			list.add(funFolder);
		}
		List<AigaSystemFolder> systemFolderList = (List<AigaSystemFolder>)this.getHibernateTemplate().find(sysFolderSQL);
		for(AigaSystemFolder aigaSystemFolder : systemFolderList) {
			AigaSystemFolder sysFolder = new AigaSystemFolder();
			sysFolder.setSysName(aigaSystemFolder.getSysName());
			sysFolder.setSysName(aigaSystemFolder.getSysName());
			list.add(sysFolder);
		}
		List<AigaRequisition> reqList = (List<AigaRequisition>)this.getHibernateTemplate().find(reqSql);
		for(AigaRequisition aReq : reqList) {
			AigaRequisition req = new AigaRequisition();
			req.setReqId(aReq.getReqId());
			req.setReqName(aReq.getReqName());
			req.setReqDesc(aReq.getReqDesc());
			list.add(req);
		}
		
		List<AigaLabel> labelList = (List<AigaLabel>)this.getHibernateTemplate().find(labelSql);
		for(AigaLabel aLabel : labelList) {
			AigaLabel label = new AigaLabel();
			label.setLabelId(aLabel.getLabelId());
			label.setLabelName(aLabel.getLabelName());
			label.setLabelDesc(aLabel.getLabelDesc());
			list.add(label);
		}
		
		return list;
	}

	@Override
	public String[] getLabels(HttpServletRequest request) throws Exception {
		final String querySql = "SELECT sys_label FROM aiga_inst_case WHERE sys_label IS NOT NULL GROUP BY sys_label ";
		
		List list =  this.getHibernateTemplate().executeFind(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(querySql);    
		         return query.list();  
		            }  
		        });  
		return  (String[]) list.toArray(new String[0]);
	}

	@Override
	public List<String> getAddWords() throws SQLException {
		final String sql ="select value FROM aiga_ext_dict where status=0";
		List<String> list=this.getHibernateTemplate().executeFind(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(sql);    
		         return query.list();  
		            }  
		        }); 
		return  list;
	}
	@Override
	public void setWordStatus(List valueList) throws SQLException {
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
		final String querySql = sql;
		this.getHibernateTemplate().execute(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(querySql);    
		         return query.executeUpdate();  
		    }  
	    });  
	}
	@Override
	public void initStatus(String status) throws SQLException {
		final String sql ="update aiga_ext_dict set status="+status;
		this.getHibernateTemplate().execute(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(sql);    
		         return query.executeUpdate();  
		    }  
	    });  
	}

	@Override
	public List getObjectByHQL(String HQL) throws Exception {
			return this.getHibernateTemplate().find(HQL);
	}

	@Override
	public List getObjectBySQL(String SQL) throws Exception {
		final String querySql = SQL;

		List list = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(querySql);    
		         return query.list();  
		            }  
		        });  
		return list;
	}
}

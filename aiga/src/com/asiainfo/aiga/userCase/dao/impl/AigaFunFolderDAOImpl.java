package com.asiainfo.aiga.userCase.dao.impl;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.userCase.bo.AigaFunFolder;
import com.asiainfo.aiga.userCase.bo.AigaHisFunFolder;
import com.asiainfo.aiga.userCase.dao.IAigaFunFolderDAO;

public class AigaFunFolderDAOImpl extends HibernateDaoSupport implements IAigaFunFolderDAO{

	@Override
	public AigaFunFolder[] getFunFolders(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaFunFolder> aigaFunFolders = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaFunFolders.toArray(new AigaFunFolder[0]);
	}

	@Override
	public void saveFunFolders(AigaFunFolder aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
		this.saveHis(aValue);
	}

	@Override
	public void deleteFunFolders(AigaFunFolder aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
		this.saveHis(aValue);
	}

	@Override
	public AigaFunFolder[] getAigaFunFolderBySql(String querySql)
			throws Exception {
		List<Object> aigaFunFolders = this.getHibernateTemplate().find(querySql);
		int n=aigaFunFolders.size();
		AigaFunFolder[] array=new AigaFunFolder[n];
		for(int i=0;i<n;i++){
			AigaFunFolder funFolder= new AigaFunFolder();
			Object aigaObj=aigaFunFolders.get(i);
			if(aigaObj.getClass().isArray()){
			Object[] objs=(Object[])aigaObj;
			for(Object obj:objs){
				if(obj instanceof AigaFunFolder){
					array[i]=(AigaFunFolder)obj;
				}
			}
			}else{
				array=aigaFunFolders.toArray(new AigaFunFolder[0]);
			}
		}
		
		return array;
	}
	
	private void saveHis(AigaFunFolder aValue)throws Exception {
		AigaHisFunFolder aigaHisFunFolder = new AigaHisFunFolder();
		aigaHisFunFolder.setBaseFunLabel(aValue.getBaseFunLabel());
		aigaHisFunFolder.setBusiLabel(aValue.getBusiLabel());
		aigaHisFunFolder.setCreateTime(aValue.getCreateTime());
		aigaHisFunFolder.setDataCheckScript(aValue.getDataCheckScript());
		aigaHisFunFolder.setDevFirm(aValue.getDevFirm());
		aigaHisFunFolder.setEfficiencyTestType(aValue.getEfficiencyTestType());
		aigaHisFunFolder.setFunDesc(aValue.getFunDesc());
		aigaHisFunFolder.setFunId(aValue.getFunId());
		aigaHisFunFolder.setFunType(aValue.getFunType());
		aigaHisFunFolder.setImportantClass(aValue.getImportantClass());
		aigaHisFunFolder.setIsEfficiencyTest(aValue.getIsEfficiencyTest());
		aigaHisFunFolder.setIsInvalid(aValue.getIsInvalid());
		aigaHisFunFolder.setMenuPath(aValue.getMenuPath());
		aigaHisFunFolder.setOperatorId(aValue.getOperatorId());
		aigaHisFunFolder.setOperatorName(aValue.getOperatorName());
		aigaHisFunFolder.setSubSysIdTemp(aValue.getSubSysIdTemp());
		aigaHisFunFolder.setSubSysId(aValue.getSubSysId());
		aigaHisFunFolder.setSysId(aValue.getSysId());
		aigaHisFunFolder.setSysIdTemp(aValue.getSysIdTemp());
		aigaHisFunFolder.setSysName(aValue.getSysName());
		aigaHisFunFolder.setUpdateTime(aValue.getUpdateTime());
		this.getHibernateTemplate().save(aigaHisFunFolder);
	}

}

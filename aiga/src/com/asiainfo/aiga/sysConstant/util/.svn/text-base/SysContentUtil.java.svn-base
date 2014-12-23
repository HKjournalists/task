package com.asiainfo.aiga.sysConstant.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.asiainfo.aiga.common.security.user.util.IUtil;
import com.asiainfo.aiga.common.utils.CnToSpell;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.dao.ISysConstantDAO;

public class SysContentUtil implements IUtil{
	
	private ISysConstantDAO sysConDao;
	
	public static Map<String, Map<String, SysConstant>> getSysConstantMap() {
		return sysConstantMap;
	}

	public void setSysConDao(ISysConstantDAO sysConDao) {
		this.sysConDao = sysConDao;
	}


	private static Map<String,Map<String,SysConstant>> sysConstantMap;
	
	static{
		sysConstantMap = new TreeMap<String, Map<String,SysConstant>>();
	}
	
	public void init()throws Exception{
		sysConstantMap.clear();
		DetachedCriteria criteria = DetachedCriteria.forClass(SysConstant.class);
		criteria.add(Restrictions.eq("status", 0));
		criteria.setProjection(Projections.distinct(Projections.property("category")));
		List categorys = sysConDao.getCategoryByCriteria(criteria);
		for(int i=0,n=categorys.size();i<n;i++){
			String category = categorys.get(i).toString();
			if(category!=null&&category.length()!=0){
				criteria = DetachedCriteria.forClass(SysConstant.class);
				criteria.add(Restrictions.eq("category", category));
				criteria.add(Restrictions.eq("status", 0));
				SysConstant[] constants = sysConDao.getSysConstantByCriteria(criteria);
				Map<String,SysConstant> rowMap = new TreeMap<String, SysConstant>();
				for(int j=0,k=constants.length;j<k;j++){
					String other1 = constants[j].getOther1();
					SysConstant sys=constants[j];
					String show=constants[j].getShow();
					if(other1==null||other1.length()==0)other1 = category+j;
					if(sys.getFullSpelling()==null||sys.getFullSpelling().length()==0)sys.setFullSpelling(CnToSpell.getSpell(show,false));
					if(sys.getFirstSpell()==null||sys.getFirstSpell().length()==0)sys.setFirstSpell(CnToSpell.getSpell(show,true));
					rowMap.put(other1, constants[j]);
				}
				sysConstantMap.put(category, rowMap);
			}
		}
	}
	
	public static SysConstant getSysConstant(String category,String other1){
		Map<String, SysConstant> sysConstMap = sysConstantMap.get(category);
		if(sysConstMap==null)
			return null;
		else{
			SysConstant constant = sysConstMap.get(other1);
			if(constant==null)
				return null;
			else
				return constant;
		}
	}
	public static String getSysConstantShowByValue(String category,String value){
		Map<String, SysConstant> sysConstMap = sysConstantMap.get(category);
		if(sysConstMap==null)
			return null;
		else{
			SysConstant constant = sysConstMap.get(value);
			if(constant==null)
				return null;
			else
				return constant.getShow();
		}
	}
	public static SysConstant[] getSysContant(String...categorys){
		List<SysConstant> sysConstantlist = new ArrayList<SysConstant>();
		for(String category:categorys){
			Map<String, SysConstant> sysConstMap = sysConstantMap.get(category);
			if(sysConstMap==null)
				continue;
			for(Object key:sysConstMap.keySet()){
				sysConstantlist.add(sysConstMap.get(key));
			}
		}
		return sysConstantlist.toArray(new SysConstant[0]);
	}
	public static void main(String[] args)throws Exception{
//		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
//		applicationContext.getBean("sysConstantInt");
//		SysConstant constant = SysContentUtil.getSysConstant("req_importance","import");
//		System.out.println(constant.getShow());
	}
}

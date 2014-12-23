package com.asiainfo.aiga.common.security.user.dao.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.common.security.user.bo.AigaMenu;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.security.user.dao.IUserDAO;
import com.asiainfo.aiga.common.utils.CnToSpell;
import com.asiainfo.aiga.staff.bo.StaffRoleView;

public class UserDAOImpl extends HibernateDaoSupport implements IUserDAO {
	
	public AigaUser getAigaUserByCode(String code) throws Exception {
		final String querySql = "select ss.staff_id, ss.code, ss.password, se.employee_name, se.bill_id, se.email" +
				" from sys_staff ss, sys_employee se where ss.employee_id=se.employee_id and ss.code='" + code.toUpperCase() + "'";
		 
		List<Object[]> viewRecordList = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
			    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
			         SQLQuery query = session.createSQLQuery(querySql);    
			         return query.list();  
			            }  
			        });  
		
		List<Object[]> resList = viewRecordList;
		AigaUser user = null;
		if(resList.size() == 1) {
			Object[] ary = resList.get(0);
			user = new AigaUser();
			user.setUserId(Integer.parseInt(parseStrOrNull(ary[0])));
			user.setUserAccount(parseStrOrNull(ary[1]));
			user.setUserPassword(parseStrOrNull(ary[2]));
			user.setUserName(parseStrOrNull(ary[3]));
			user.setUserPhone(Long.valueOf(parseStrOrNull(ary[4])));
			user.setUserEmail(parseStrOrNull(ary[5]));
		}
		return user;
	}
	
	private String parseStrOrNull(Object obj) throws Exception {
		String str = null;
		if(obj != null) {
			str = obj + "";
		}else
			str = "0";
		return str;
	}

	public AigaMenu[] getAigaMenuBySql(String querySql) throws Exception {
		List<AigaMenu> menus = this.getHibernateTemplate().find(querySql);
		return menus.toArray(new AigaMenu[0]);
	}

	@Override
	public StaffRoleView[] getStaffRoleViewByGroupLeader(String staffId,String roleCode)throws Exception {
//		final String querySql = "Select distinct a.role_code,a.staff_id,a.code,a.staff_name,a.organize_id,a.organize_name,a.parent_organize_id,a.staff_workday_coefficient "
//							+" From staff_role_org_dist_view a "
//							+" Start With a.parent_organize_id in  (select distinct t.parent_organize_id from  staff_role_org_dist_view t where t.staff_id="+staffId
//							+" ) and a.role_code = '"+roleCode+"' "
//							+" Connect By Prior a.parent_organize_id = a.organize_id "
//							+" and a.role_code = '"+roleCode+"' "
//							+" order by a.staff_name";
		final String querySql = "Select distinct a.role_code,a.staff_id,a.code,a.staff_name,a.organize_id,a.organize_name,a.parent_organize_id,a.staff_workday_coefficient "
			+" From staff_role_org_dist_view a "
			+" where a.role_code = '"+roleCode+"' "
			+" order by a.staff_name";
		
		List<Object[]> viewRecordList = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(querySql);    
		         return query.list();  
		            }  
		        });  
		List<Object[]> resList = viewRecordList;
		StaffRoleView[] StaffRoleViews=new StaffRoleView[resList.size()];
		for(int i=0,n=resList.size();i<n;i++){
			Object[] objs=resList.get(i);
			if(objs.length!=8)throw new Exception("查询结果有误");
			StaffRoleViews[i]=new StaffRoleView();
			StaffRoleViews[i].setRoleCode(parseStrOrNull(objs[0]));
			StaffRoleViews[i].setStaffId(parseStrOrNull(objs[1]));
			StaffRoleViews[i].setStaffCode(parseStrOrNull(objs[2]));
			StaffRoleViews[i].setStaffName(parseStrOrNull(objs[3]));
			StaffRoleViews[i].setOrganizeId(parseStrOrNull(objs[4]));
			StaffRoleViews[i].setOrganizeName(parseStrOrNull(objs[5]));
			StaffRoleViews[i].setParentOrganizeId(parseStrOrNull(objs[6]));
			StaffRoleViews[i].setStaffWorkdayCoefficient(parseStrOrNull(objs[7]));
		}
		return StaffRoleViews;
	}
	@Override
	public Map<String,AigaUser> initUsers() throws Exception {
		final String querySql ="select SS.STAFF_ID,SS.CODE,SS.PASSWORD,SE.EMPLOYEE_NAME,SE.BILL_ID,SE.EMAIL,role_strcat(SS.STAFF_ID) "
							+ "from sys_staff SS, sys_employee SE where SS.EMPLOYEE_ID = SE.EMPLOYEE_ID";
		
		List<Object[]> resList = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(querySql);    
		         return query.list();  
		            }  
		        });  
		
		//List<Object[]> resList = this.getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery(querySql).list();

		Map<String,AigaUser> retMap=new HashMap<String, AigaUser>(resList.size());
		for(int i=0,n=resList.size();i<n;i++){
			Object[] ary = resList.get(i);
			AigaUser user=new AigaUser();
			user = new AigaUser();
			user.setUserId(Integer.parseInt(parseStrOrNull(ary[0])));
			user.setUserAccount(parseStrOrNull(ary[1]));
			user.setUserPassword(parseStrOrNull(ary[2]));
			user.setUserName(parseStrOrNull(ary[3]));
			user.setUserPhone(Long.valueOf(parseStrOrNull(ary[4])));
			user.setUserEmail(parseStrOrNull(ary[5]));
			user.setRoleCodes((ary[6]!=null?ary[6]+"":"").split(","));
			user.setFullSpelling(CnToSpell.getSpell(user.getUserName(),false));
			user.setFirstSpell(CnToSpell.getSpell(user.getUserName(),true));

			retMap.put(user.getUserAccount().trim().toUpperCase(),user);
		}
		return retMap;
	}

	@Override
	public StaffRoleView[] getStaffRoleViewByGroupLeader(String roleCode)
			throws Exception {
		// TODO Auto-generated method stub
		final String querySql = "select  s.staff_id, e.employee_name ,S.CODE from sys_staff s, sys_employee e, ( Select distinct (a.staff_id) staff_id"
			+"  From staff_role_org_dist_view a "
			+ "where a.role_code = '"+roleCode+"' "
			+" Connect By Prior a.parent_organize_id = a.organize_id "
			+" and a.role_code = '"+roleCode+"' "
			+"  ) r where s.staff_id = r.staff_id and s.employee_id = e.employee_id";
		List<Object[]> viewRecordList = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(querySql);    
		         return query.list();  
		            }  
		        });  
		List<Object[]> resList = viewRecordList;
		StaffRoleView[] StaffRoleViews=new StaffRoleView[resList.size()];
		for(int i=0,n=resList.size();i<n;i++){
			Object[] objs=resList.get(i);
			if(objs.length!=3)throw new Exception("查询结果有误");
			StaffRoleViews[i]=new StaffRoleView();
			StaffRoleViews[i].setStaffId(parseStrOrNull(objs[0]));
			StaffRoleViews[i].setStaffName(parseStrOrNull(objs[1]));
			StaffRoleViews[i].setStaffCode(parseStrOrNull(objs[2]));
		}
		return StaffRoleViews;
	}
}

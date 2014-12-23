package com.asiainfo.aiga.search.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.asiainfo.lucene.LuceneEntities.properties.LuceneCommon;

public class BaseDAO {
	// �������
	private static final String strPropertiesName="database.properties";
	public static final String DRIVER =LuceneCommon.getProertiesValue("jdbc.driverClassName", strPropertiesName); // ��������
	public static final String URL = LuceneCommon.getProertiesValue("jdbc.url", strPropertiesName); // ���ݿ��ַ
	public static final String USERNAME =LuceneCommon.getProertiesValue("jdbc.username", strPropertiesName);  // �û���
	public static final String PASSWORD = LuceneCommon.getProertiesValue("jdbc.password", strPropertiesName);  // ����
	private static BaseDAO instance=null;
	private BaseDAO(){}
	private Connection con=null;
	public static BaseDAO getBaseDaoInstance(){
		if(instance ==null)instance =new BaseDAO();
		return instance;
	}
	/**
	 * ��ȡ���ݿ�����
	 * 
	 * @return con
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public Connection getConnection() throws ClassNotFoundException,SQLException {
		if(con==null||con.isClosed()) {
				Class.forName(DRIVER);
				con =DriverManager.getConnection(URL, USERNAME, PASSWORD);
				}
		return con;
	}
	 public static void free(ResultSet rs,Statement st,Connection conn)  {
	        try{
	            if(rs!=null)
	                rs.close();
	        }catch (SQLException e){
	            e.printStackTrace();
	        }finally {
	            try{
	                if(st!=null)
	                    st.close();
	            }catch (SQLException e){
	                e.printStackTrace();
	            }finally {
	               try {
	                   if(conn !=null)
	                       conn.close();
	               }catch (SQLException e){
	                   e.printStackTrace();
	               }
	            }
	        }
	    }
public static void main(String[] args) {
}
}

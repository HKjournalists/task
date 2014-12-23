package com.asiainfo.aiga.search.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.asiainfo.lucene.LuceneEntities.properties.LuceneCommon;

public class BaseDAO {
	// 必须参数
	private static final String strPropertiesName="database.properties";
	public static final String DRIVER =LuceneCommon.getProertiesValue("jdbc.driverClassName", strPropertiesName); // 驱动名称
	public static final String URL = LuceneCommon.getProertiesValue("jdbc.url", strPropertiesName); // 数据库地址
	public static final String USERNAME =LuceneCommon.getProertiesValue("jdbc.username", strPropertiesName);  // 用户名
	public static final String PASSWORD = LuceneCommon.getProertiesValue("jdbc.password", strPropertiesName);  // 密码
	private static BaseDAO instance=null;
	private BaseDAO(){}
	private Connection con=null;
	public static BaseDAO getBaseDaoInstance(){
		if(instance ==null)instance =new BaseDAO();
		return instance;
	}
	/**
	 * 获取数据库连接
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

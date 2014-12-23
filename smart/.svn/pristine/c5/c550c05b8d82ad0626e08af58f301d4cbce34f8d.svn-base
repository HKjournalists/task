package com.lb.app.main.web;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import org.hibernate.HibernateException;
import org.hibernate.MappingException;
import org.hibernate.dialect.Dialect;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.id.Configurable;
import org.hibernate.id.IdentifierGenerator;
import org.hibernate.type.Type;

public class TestIdGenerator implements IdentifierGenerator, Configurable {
	
	private String sql;
	
	private long next;
	
	private int seqLen = 6;
	
	private String formatStr = "kkmmss";
	
	@Override
	public Serializable generate(SessionImplementor session, Object object)
			throws HibernateException {
		// TODO Auto-generated method stub
		getNext(session);
		String date = getCurDateStr();
		String nextStr = String.valueOf(next);
		while(nextStr.length() < seqLen) {
			nextStr = "0" + nextStr;
		}
		System.out.println(date + nextStr);
		return Long.valueOf(date + nextStr);
	}

	@Override
	public void configure(Type type, Properties params, Dialect dialect)
			throws MappingException {
		// TODO Auto-generated method stub
		String seq = params.getProperty("sequence");
		sql = "select " + seq + ".nextval from dual";
	}
	
	private void getNext(SessionImplementor session) {
		Connection conn = session.connection();
		try {
			int s = 1;
			while(seqLen > 0) {
				s = s * 10;
				seqLen--;
			}
			PreparedStatement st = conn.prepareStatement(sql);
			ResultSet rs = null;
			try {
				rs = st.executeQuery();
				if(rs.next()) {
					next = rs.getLong(1);
					if(rs.wasNull()) {
						next = (int)(Math.random()*s);
					}
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) {
					rs.close();
				}
				st.close();
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	private String getCurDateStr() {
		Date date = new Date();
		DateFormat df = new SimpleDateFormat(formatStr);
		return df.format(date);
	}

}

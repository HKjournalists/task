package com.asiainfo.aiga.daily.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.asiainfo.aiga.daily.bo.AigaTestDaily;
import com.asiainfo.aiga.daily.service.IDailySV;
import com.asiainfo.aiga.search.dao.BaseDAO;

public class DailySVImpl implements IDailySV {
	private BaseDAO basedao;
	Connection con = null;
	PreparedStatement st = null;
	ResultSet rs = null;

	@Override
	public AigaTestDaily getDailyBeanById(String id) throws Exception {
		if (basedao == null)basedao = BaseDAO.getBaseDaoInstance();
		con = basedao.getConnection();
		st = con.prepareStatement("");
		// preState.setString(1, userName);
		// //则此处变为.setString("username1",username)
		// preState.setString(2, password);
		rs = st.executeQuery();
		BaseDAO.free(rs, st, con);
		return null;
	}

}

package com.asiainfo.aiga.qualityManage.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.qualityManage.bo.AigaQualityManage;

public interface IAigaQualityManageDAO {

	public AigaQualityManage[] getQM(DetachedCriteria criteria)throws Exception;
}

package com.asiainfo.aiga.statistics.dao;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.statistics.bo.AigaMonthDelSla;
import com.asiainfo.aiga.statistics.bo.AigaMonthRepKpi;
import com.asiainfo.aiga.statistics.bo.AigaMonthRunKpi;
import com.asiainfo.aiga.statistics.bo.StatKpiTarget;

public interface IStatisticsDAO {
	public AigaMonthRunKpi[] getAigaKpiBySql(String querySql)throws Exception;
    public List getAllAigaKpiBySql(String querySql)throws Exception;
    public AigaMonthRunKpi[] getAigaKpiByCriteria(DetachedCriteria criteria)throws Exception;
    public void saveOrUpdate(Object aValue) throws Exception;
    public void delObject(Object aValue) throws Exception;
    public List getObjectByHQL(String HQL) throws Exception ;
	public void saveAigaMonthDelSla(AigaMonthDelSla aValue)throws Exception;
	public AigaMonthDelSla[] getAigaMonthDelSla(String querySql)throws Exception;
	public boolean manageKpi(String SQL)throws Exception;
	public boolean updateBySQL(String SQL) throws Exception;
	public AigaMonthRepKpi[] getAigaMonthRepKpi(String querySql)throws Exception;
	public void saveAigaMonthRepKpi(AigaMonthRepKpi aValue)throws Exception;
	
	public StatKpiTarget[] getStatKpiTarget(String querySql)throws Exception;
	public void saveStatKpiTarget(StatKpiTarget aValue)throws Exception;
}

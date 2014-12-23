package com.asiainfo.aiga.common.service;

import java.util.List;

/**
 * 需要修改目标对象的指定参数时, 请在自己的Action中自行操作!
 * @author peng
 *
 */
public interface ICommonPageinationSV {

	public List getObjectList(int pageNo,int pageSize,String queryHQL)throws Exception;

	public int getTotal(String HQL)throws Exception;
}

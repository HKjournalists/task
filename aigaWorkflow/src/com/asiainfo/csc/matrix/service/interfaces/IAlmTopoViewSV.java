package com.asiainfo.csc.matrix.service.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOTopoViewValue;

public interface IAlmTopoViewSV {
	public IBOTopoViewValue[] getTopoByCondition(String condition, Map paramter) throws Exception;
	
	public IBOTopoViewValue[] getTopoByFpointAndCond(String fpointLinkId,String cond) throws Exception;
}

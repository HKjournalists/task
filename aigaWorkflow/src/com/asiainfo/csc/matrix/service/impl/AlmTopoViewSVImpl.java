package com.asiainfo.csc.matrix.service.impl;

import java.io.StringBufferInputStream;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.matrix.common.impl.AlmCommonFunImpl;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOTopoViewValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmTopoViewSV;

public class AlmTopoViewSVImpl implements IAlmTopoViewSV {

	
	public IBOTopoViewValue[] getTopoByCondition(String condition, Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BusiFactory.getAlmTopoViewDao().getTopoByCondition(condition, paramter);
	}
	
	public IBOTopoViewValue[] getTopoByFpointAndCond(String fpointLinkId,String cond) throws Exception {
		
		IBOTopoViewValue topoView = null;
		boolean equal = true;
		HashMap<String,String> aVars = new HashMap<String,String>();
		AlmCommonFunImpl commonFun = new AlmCommonFunImpl();
		aVars = commonFun.analyzeCond(aVars, cond);
		Criteria sql = new Criteria();
		sql.addEqual(IBOTopoViewValue.S_Fpoint, fpointLinkId);
		IBOTopoViewValue[] topoViewValues = BusiFactory.getAlmTopoViewSV().getTopoByCondition(sql.toString(), sql.getParameters());
		//在topoView配置表中遍历 找到与入参cond一样的配置信息
		for(IBOTopoViewValue topoViewValue : topoViewValues){
			equal = true;
			HashMap<String,String> aVarsTemp = new HashMap<String,String>();
			aVarsTemp = commonFun.analyzeCond(aVarsTemp, topoViewValue.getCond());
			//工单条件数量与配置的数量多少无关
//			if(aVarsTemp.entrySet().size() != aVars.entrySet().size()){
//				equal = false;
//			}
			for(Object key : aVarsTemp.keySet()){
				//在当前配置中查找是否有相同的KEY和VALUE
				if(aVars.containsKey(key)){
					if(aVars.get(key).toString().equals(aVarsTemp.get(key).toString())){
						equal = true;
					}
					else{
						equal = false;
						break;
					}
				}else{
					equal = false;
					break;
				}
			}
			if(equal){
				topoView = topoViewValue;
				break;
			}	
			
		}
		if(topoView!=null){
			return new IBOTopoViewValue[]{topoView};
		}
		return new IBOTopoViewValue[]{};
	}

}

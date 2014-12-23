package com.asiainfo.csc.attach.service.impl;

import java.io.StringBufferInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.attach.bo.BOAttachTypeConfigBean;
import com.asiainfo.csc.attach.dao.interfaces.IAttachTypeConfigDao;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeConfigValue;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeDefValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachTypeConfigSV;
import com.asiainfo.csc.attach.service.interfaces.IAttachTypeDefSV;

public class AttachTypeConfigSVImpl implements IAttachTypeConfigSV {

	IAttachTypeConfigDao configDao = (IAttachTypeConfigDao)ServiceFactory.getService(IAttachTypeConfigDao.class);
	IAttachTypeDefSV defSV = (IAttachTypeDefSV)ServiceFactory.getService(IAttachTypeDefSV.class);
	
	public Map<String, String> checkAttachTypeConfig(String zone, String xml,
			String hasSelectedTypeId) throws Exception {
		Map<String, String> rtv = new HashMap<String, String>();
		if(xml!=null&&!xml.equals("")){
			String noTypeName = "";
			String noType = "";
			String checkAttType = "";
			String checkAttTypeName = "";
			List<String> xmls = new ArrayList<String>();
			String[] xmlStrings = xml.split(",");
			xmls = Arrays.asList(xmlStrings);
			IBOAttachTypeConfigValue[] configValues = this.getAttatchTypeConfigByXml(zone, xmls);
			String[] hasSelectedTypeIds = hasSelectedTypeId.split(",");
			List<String> selectedTypeIds = Arrays.asList(hasSelectedTypeIds);
			for(IBOAttachTypeConfigValue configValue : configValues){
				checkAttType += String.valueOf(configValue.getAttTypeId())+",";
				String attTypeId = String.valueOf(configValue.getAttTypeId());
				IBOAttachTypeDefValue checkAttTypeValue = defSV.getAttachTypeDefById(String.valueOf(configValue.getAttTypeId()));
				checkAttTypeName += checkAttTypeValue.getAttTypeName()+",";
				if(!selectedTypeIds.contains(attTypeId)){
					noTypeName += checkAttTypeValue.getAttTypeName()+",";
					noType += attTypeId+",";
					continue;
				}
			}
			
			if(!noTypeName.trim().equals("")){
				rtv.put("checkAttTypeName", checkAttTypeName.substring(0,checkAttTypeName.length()-1));
				rtv.put("checkAttType", checkAttType.substring(0,checkAttType.length()-1));
				rtv.put("noTypeName", noTypeName.substring(0,noTypeName.length()-1));
				rtv.put("noType", noType.substring(0,noType.length()-1));
				rtv.put("isEqual","N");
			}else{
				rtv.put("isEqual","Y");
				rtv.put("noTypeName", "");
				rtv.put("noType", "");
				rtv.put("checkAttType", checkAttType.substring(0,checkAttType.length()-1));
				rtv.put("checkAttTypeName", checkAttTypeName.substring(0,checkAttTypeName.length()-1));
			}
		}else{
			rtv.put("isEqual","Y");
			rtv.put("noTypeName", "");
			rtv.put("noType", "");
			rtv.put("checkAttType", "");
			rtv.put("checkAttTypeName","");
		}
		return rtv;
	}

	
	public String getAttachTypeConfigHtml(String zone, String column)throws Exception {
		String html="";
		Double row=0.0;
		if(zone==null||zone.equals(""))
			throw new Exception("zone为空【com.asiainfo.csc.attach.service.impl.AttachTypeConfigSVImpl.getAttachTypeConfigHtml(String zone, String column)】");
		Criteria sql = new Criteria();
		sql.addEqual(BOAttachTypeConfigBean.S_Zone, zone);
		IBOAttachTypeConfigValue[] attachTypeConfigValues = configDao.getAttachTypeConfig(sql.toString() + "order by att_conf_id", sql.getParameters());
		if(attachTypeConfigValues!=null&&attachTypeConfigValues.length!=0){
			html += "<table align=\"center\" width=\"100%\">";
			float count = attachTypeConfigValues.length;
			row = Math.ceil(count/Float.valueOf(column));
			html += "<tr><td style=\"background-color: #F7F8FA;font-size: 12px;\" align=\"right\" width=\"80\" rowspan=\""+(row.intValue()+1)+"\">附件类型：</td></tr>";
			for(int i=0;i<row.intValue();i++){
				html += "<tr>";
				for(int j=i*Integer.valueOf(column);j<(i+1)*Integer.valueOf(column)&&j<attachTypeConfigValues.length;j++){
					long attTypeId = attachTypeConfigValues[j].getAttTypeId();
					IBOAttachTypeDefValue attachTypeDefValue = defSV.getAttachTypeDefById(String.valueOf(attTypeId));
					html += "<td class=\"aiEdit_4col\">";
					html += "<input id=\"attachType\" type=\"checkbox\" value=\""+attachTypeDefValue.getAttTypeId()+"\" alt=\""+(attachTypeDefValue.getAttTypeDesc()==null?"":attachTypeDefValue.getAttTypeDesc())+"\"/>"+attachTypeDefValue.getAttTypeName();
					html += "</td>";
				}
				html += "</tr>";
			}
			html += "</table>";
		}
		return html;
	}
	
	private Map analyzeCond(String cond) throws Exception{
		Map aVars = new HashMap();
		if(cond !=null&&!"".equals(cond)){
			StringBufferInputStream sr = new StringBufferInputStream(cond);
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance(); 
			DocumentBuilder builder = factory.newDocumentBuilder(); 
			Document doc = builder.parse(sr);
			NodeList condList = doc.getElementsByTagName("cond");
			for(int i = 0; condList.getLength()>i;i++){
				Node condNode = condList.item(i);
				NamedNodeMap Attrs = condNode.getAttributes();
				Node keyAttrNode = Attrs.getNamedItem("key");
				Node valueAttrNode = Attrs.getNamedItem("value");
//				System.out.println (nameAttrNode.getNodeValue());
//				System.out.println (valueAttrNode.getNodeValue());
				aVars.put(keyAttrNode.getNodeValue(), valueAttrNode.getNodeValue());
			}
		}
		return aVars;
	}
	
	private IBOAttachTypeConfigValue[] getAttatchTypeConfigByXml(String zone,List<String> xmls)throws Exception{
		boolean equal = true;
		Criteria sql = new Criteria();
		sql.addEqual(BOAttachTypeConfigBean.S_Zone, zone);
		sql.addEqual(BOAttachTypeConfigBean.S_IsCheck, "Y");
		IBOAttachTypeConfigValue[] typeConfigValues = configDao.getAttachTypeConfig(sql.toString(), sql.getParameters());
		List<IBOAttachTypeConfigValue> configValues = new ArrayList<IBOAttachTypeConfigValue>();
		
		for(IBOAttachTypeConfigValue typeConfigValue : typeConfigValues){
			Iterator<String> xml = xmls.iterator();
			while(xml.hasNext()){
				Map aVars = new HashMap();
				aVars = this.analyzeCond(xml.next());
			
				equal = true;
				Map aVarsTemp = new HashMap();
				aVarsTemp = this.analyzeCond(typeConfigValue.getCond());
				if(aVarsTemp.entrySet().size() != aVars.entrySet().size()){
					equal = false;
					continue;
				}
				for(Object key : aVars.keySet()){
					//在当前配置中查找是否有相同的KEY和VALUE
					if(!aVarsTemp.containsKey(key)){
						equal = false;
						break;
					}
					if(!aVars.get(key).toString().equals(aVarsTemp.get(key).toString())){
						equal = false;
						break;
					}
				}
				if(equal){
					configValues.add(typeConfigValue);
					break;
				}
			}
		}
		if(configValues!=null&&configValues.size()!=0){
			return configValues.toArray(new IBOAttachTypeConfigValue[0]);
		}
		return new IBOAttachTypeConfigValue[]{};
	}
}

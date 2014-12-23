package com.asiainfo.csc.common.service.impl;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.ai.appframe2.common.AIException;
import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.csc.common.bo.BOWorkorderExtendBean;
import com.asiainfo.csc.common.dao.interfaces.IWorkorderDao;
import com.asiainfo.csc.common.ivalues.IBOWorkorderExtendValue;

public class MapVars{

	private Document document;
	private DocumentBuilder builder;
	private IWorkorderDao iWoDao = (IWorkorderDao)ServiceFactory.getService(IWorkorderDao.class);
	
	public void init()
	{
		try{
			builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			document = builder.newDocument();
		}catch(ParserConfigurationException e)
		{
			e.printStackTrace();
		}
	}
	
	public void saveMapVars(Map vars,long orderId)
	{
		//get vars from Map
		String objIdVal = vars.get("OBJID").toString();
		String fPointVal = vars.get("FPOINT").toString();
		String opinionVal = vars.get("ACTION").toString();
		String actionVal = vars.get("OPINION").toString();
		String resultVal = vars.get("RESULT").toString();
		
		//create the XML Tree
		Element root = document.createElement("variables");
		Element objId = document.createElement("objId");
		objId.appendChild(document.createTextNode(objIdVal));
		root.appendChild(objId);
		Element fPoint = document.createElement("fPoint");
		fPoint.appendChild(document.createTextNode(fPointVal));
		root.appendChild(fPoint);
		Element opinion = document.createElement("opinion");
		opinion.appendChild(document.createTextNode(opinionVal));
		root.appendChild(opinion);
		Element action = document.createElement("action");
		action.appendChild(document.createTextNode(actionVal));
		root.appendChild(action);
		Element result = document.createElement("result");
		result.appendChild(document.createTextNode(resultVal));
		root.appendChild(result);
		
		Transformer tf = null;
		try {
			tf = TransformerFactory.newInstance().newTransformer();
			tf.setOutputProperty(OutputKeys.ENCODING, "utf-8");
			tf.setOutputProperty(OutputKeys.METHOD, "xml");
			tf.setOutputProperty(OutputKeys.VERSION, "1.0");
			tf.setOutputProperty(OutputKeys.INDENT, "no");
			
		} catch (TransformerConfigurationException e){			
			e.printStackTrace();
		}
		
		StringWriter sw = null;
		try {
			sw = new StringWriter();
			tf.transform(new DOMSource(root), new StreamResult(sw));
		} catch (TransformerException e) {
			e.printStackTrace();
		}
		
		try {
			IBOWorkorderExtendValue orderExtend = new BOWorkorderExtendBean();
			orderExtend.setOrderId(orderId);
			orderExtend.setWorkflowParam(sw.toString());
			
			iWoDao.saveWorkorderExtend(orderExtend);
		} catch (AIException e) {
			e.printStackTrace();
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public Map readMapVars(long orderId)
	{
		String xmlString ="";
		try {
			xmlString = iWoDao.getWorkorderExtendById(orderId).getWorkflowParam();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			document = builder.parse(new InputSource(new StringReader(xmlString)));
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Map vars = new HashMap();
		NodeList list = document.getChildNodes();
		for (int i=0;i<list.getLength();i++)
		{
			vars.put(list.item(i).getNodeName(), list.item(i).getNodeValue());
		}
		
		return vars;
	}
}

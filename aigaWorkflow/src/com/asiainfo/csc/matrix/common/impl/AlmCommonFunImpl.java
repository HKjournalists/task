package com.asiainfo.csc.matrix.common.impl;

import java.io.StringBufferInputStream;
import java.util.HashMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class AlmCommonFunImpl {
	public HashMap analyzeCond(HashMap aVars , String cond) throws Exception{
		if(cond !=null&&!"".equals(cond)){
			StringBufferInputStream sr = new StringBufferInputStream(cond);
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance(); 
			DocumentBuilder builder = factory.newDocumentBuilder(); 
			Document doc = builder.parse(sr);
			NodeList condList = doc.getElementsByTagName("cond");
			for(int i = 0; condList.getLength()>i;i++){
				Node condNode = condList.item(i);
				NamedNodeMap Attrs = condNode.getAttributes();
				Node nameAttrNode = Attrs.getNamedItem("name");
				Node valueAttrNode = Attrs.getNamedItem("value");
//				System.out.println (nameAttrNode.getNodeValue());
//				System.out.println (valueAttrNode.getNodeValue());
				aVars.put(nameAttrNode.getNodeValue(), valueAttrNode.getNodeValue());
			}
		}
		return aVars;
	}
}

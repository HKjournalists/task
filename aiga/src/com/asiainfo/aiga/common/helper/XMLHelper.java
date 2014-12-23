package com.asiainfo.aiga.common.helper;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.xml.XMLSerializer;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.asiainfo.aiga.log.bo.AigaLogElement;
import com.asiainfo.aiga.log.bo.AigaLogStep;
import com.asiainfo.aiga.log.bo.AigaLogTestCase;
public class XMLHelper {
	public static AigaLogTestCase  getTestCase4XML(String xmlString,String caseId) throws Exception{
        SAXReader saxReader = new SAXReader();
        InputStream in= new   ByteArrayInputStream(xmlString.getBytes("UTF-8"));   
        Document document = saxReader.read(in);
        AigaLogTestCase testCase=new AigaLogTestCase();
        // 获取根元素
        Element root = document.getRootElement();
        // 获取所有子元素
        Element childBase = root.element("base");
        List<Element> childList = root.elements();

        // 获取特定名称的子元素
        testCase.setCaseId(Integer.valueOf(caseId));
        Element childStep = root.element("steps");
        List stepList =new ArrayList();
        for (Iterator iter = childStep.elementIterator(); iter.hasNext();)
        {
            Element e = (Element) iter.next();
            
            AigaLogStep step=new AigaLogStep();
            step.setResult( e.attributeValue("result"));
            step.setStepName( e.attributeValue("stepname"));
            List elems=new ArrayList();
            List eleList =e.elements();
            for (int i=0,n= eleList.size();i<n;i++){
            	Element ele=(Element)eleList.get(i);
            	AigaLogElement element=new AigaLogElement();
            	 element.setElementArgument(ele.attributeValue("argument"));
            	 element.setExpectValue(ele.attributeValue("expect"));
            	 element.setActualValue(ele.attributeValue("actual"));
            	 element.setElementMethod(ele.attributeValue("method"));
            	 element.setElementValue(ele.getStringValue());
            	 elems.add(element);
            }
            step.setAigaLogElements(elems);
            stepList.add(step);
        }
        testCase.setAigaLogSteps(stepList);
        Element childLog = root.element("log");
        testCase.setLogInfo(childLog.getStringValue());
        Element childErr = root.element("err");
        testCase.setErrInfo(childErr.getStringValue());
        // 迭代输出
		return testCase;

      
		
	}
	public static String xml2Json(String xmlString){
		return new XMLSerializer().read(xmlString).toString();
	}
/*	 public static  TestCase getTestCase(String xmlString) throws Exception{   
	        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();  
	        DocumentBuilder builder = factory.newDocumentBuilder();  
	        Document document = builder.parse(xmlString);
	        Element element = document.getDocumentElement();  
	          
	        NodeList caseNodes = element.getElementsByTagName("testcase");  
	        TestCase testCase = new TestCase(); 
	        for(int i=0;i<caseNodes.getLength();i++){
	            Element caseElement = (Element) caseNodes.item(i);  
	            Map map=new HashMap();
	            String key=caseElement.getNodeName();
	            String value=caseElement.getNodeValue();
	            map.put(key, value);
//	            testCase.setBase(base);
	            NodeList childNodes = caseElement.getChildNodes();  
//	          System.out.println("*****"+childNodes.getLength());  
	            for(int j=0;j<childNodes.getLength();j++){  
	                if(childNodes.item(j).getNodeType()==Node.ELEMENT_NODE){ 
	               
	                }  
	            }//end for j  
	        }//end for i  
	        return testCase;  
	    }  */
	 public static Map<String, Object> parseJSON2Map(String jsonStr){  
	        Map<String, Object> map = new HashMap<String, Object>();  
	        //最外层解析  
	        JSONObject json = JSONObject.fromObject(jsonStr);  
	        for(Object k : json.keySet()){  
	            Object v = json.get(k);   
	            //如果内层还是数组的话，继续解析  
	            if(v instanceof JSONArray){  
	                List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();  
	                Iterator<JSONObject> it = ((JSONArray)v).iterator();  
	                while(it.hasNext()){  
	                    JSONObject json2 = it.next();  
	                    list.add(parseJSON2Map(json2.toString()));  
	                }  
	                map.put(k.toString(), list);  
	            } else {  
	                map.put(k.toString(), v);  
	            }  
	        }  
	        return map;  
	    } 
//	 public static void main(String[] args) throws Exception {
//		 InputStream is = new FileInputStream("C:/Users/wenghy/Desktop/logger111.xml");
//		String xmlString =convertStreamToString(is);
//		System.out.println(xmlString);
//		System.out.println(getTestCase4XML(xmlString).getAigaLogSteps().get(0).getAigaLogElements().get(0).getExpectValue());
//		System.out.println(	xml2Json(xmlString));
//		Map map =XMLHelper.parseJSON2Map(XMLHelper.xml2Json(xmlString));
//	}
	 public static String convertStreamToString(InputStream is) {   

		   BufferedReader reader = new BufferedReader(new InputStreamReader(is));   

		        StringBuilder sb = new StringBuilder();   

		    

		        String line = null;   

		        try {   

		            while ((line = reader.readLine()) != null) {   

		                sb.append(line);   

		            }   

		        } catch (IOException e) {   

		            e.printStackTrace();   

		        } finally {   

		            try {   

		                is.close();   

		            } catch (IOException e) {   

		                e.printStackTrace();   

		            }   

		        }   

		    

		        return sb.toString();   

		    }  
}

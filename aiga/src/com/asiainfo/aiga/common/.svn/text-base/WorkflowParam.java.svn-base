package com.asiainfo.aiga.common;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import net.sf.json.JSONObject;

import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.helper.XMLHelper;
import com.asiainfo.aiga.common.workflowVo.Workflow;

public class WorkflowParam {

	private static Map<String,Workflow> workflowsMap = new HashMap<String,Workflow>();
	private static Workflow[] workflows=null;
	
	public static Map<String, Workflow> getWorkflowsMap() {
		return workflowsMap;
	}

	public void initWorkflowParam()throws Exception{
		try {
			InputStream in = LoginFilter.class.getClassLoader().getResourceAsStream("workflowConfig.properties"); ;
			Properties p = new Properties();
			p.load(in);
			String workflowUrl = p.getProperty("workflowUrl");
			if(workflowUrl==null)
				throw new Exception("workflowConfig.properties文件缺少参数workflowUrl");
			URL url = new URL(workflowUrl+"/business/com.asiainfo.csc.common.web.WorkflowParamAction?action=getWorkflowParam"+"&uid=ADMINISTRATOR");
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setReadTimeout(30*1000);
			con.setDoInput(true);
			con.setDoOutput(true);
			con.connect();
			OutputStream out = con.getOutputStream();
			out.flush();
			out.close();
			InputStream jsonStream = con.getInputStream();
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(jsonStream));
			String temp = "";
			String returnString = "";
			while ((temp = reader.readLine()) != null) {
				returnString+=temp;
			}
			returnString = URLDecoder.decode(returnString,"UTF-8");
			JSONObject jsonObject = JSONObject.fromObject(returnString);
			WorkflowParam.transJsonToMap(jsonObject);
		} catch(Exception e) {
			System.out.println("initWorkflowParam method 异常，获取流程环节信息失败");
			String path=WorkflowParam.class.getResource("workflowJSON.json").getPath();
			 InputStream is = new FileInputStream(path);
				String jsonString =XMLHelper.convertStreamToString(is);
				WorkflowParam.transJsonToMap(JSONObject.fromObject(jsonString));
			e.getCause();
//			e.printStackTrace();
		}
	}
	
	private static void transJsonToMap(JSONObject jsonObject)throws Exception{
		Map<String, Object> map = ActionHelper.parseJSON2Map(jsonObject);
		for(Object key : map.keySet()){
			Object value = map.get(key);
			if(value!=null){
				Object workflow = JSONObject.toBean((JSONObject)value,Workflow.class);
				if(workflow instanceof Workflow){
					workflowsMap.put(key.toString(), (Workflow)workflow);
				}
			}
		}
	}
	public static void initWorkflows(){
		if(workflows==null&&workflowsMap!=null&&workflowsMap.size()!=0){
			workflows=new Workflow[workflowsMap.size()];
			Iterator<String> it=workflowsMap.keySet().iterator();
			for(int i=0;it.hasNext();i++){
				String linkNo=it.next();
				workflows[i]=workflowsMap.get(linkNo);
			}
		}
	}
	public static Workflow getWorkflow(String linkNo) {
		try {
			return workflowsMap.get(linkNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public static List<Workflow> getWorkflowsByTemplateIds(Long[] templateIds){
		List<Workflow> list=new ArrayList<Workflow>();
		initWorkflows();
		Arrays.sort(templateIds);
		for(int i=0,n=workflows.length;i<n;i++){
			Workflow workflow=workflows[i];
			if(Arrays.binarySearch(templateIds, workflow.getTemplateId())>-1){
				list.add(workflow);
			}
				
		}
		Comparator<Workflow> comparator = new Comparator<Workflow>() {
			@Override
			public int compare(Workflow o1, Workflow o2) {
				return o1.getLinkId()>o2.getLinkId()?1:-1;
			}
        };
		Collections.sort(list, comparator);
		return list;
	}
	public static List<Workflow> getWorkflowsByTemplateId(Long templateId){
		List<Workflow> list=new ArrayList<Workflow>();
		initWorkflows();
		for(int i=0,n=workflows.length;i<n;i++){
			Workflow workflow=workflows[i];
			if(templateId.equals(workflow.getTemplateId())){
				list.add(workflow);
			}
				
		}
		  Comparator<Workflow> comparator = new Comparator<Workflow>() {
				@Override
				public int compare(Workflow o1, Workflow o2) {
					return o1.getLinkId()>o2.getLinkId()?1:-1;
				}
	        };
		Collections.sort(list, comparator);
		return list;
		}
	public static void main(String[] args) throws FileNotFoundException {
		/*String path=WorkflowParam.class.getResource("workflowJSON.json").getPath();
		 InputStream is = new FileInputStream(path);
			String xmlString =XMLHelper.convertStreamToString(is);
			System.out.println(xmlString);*/
			
	}
}

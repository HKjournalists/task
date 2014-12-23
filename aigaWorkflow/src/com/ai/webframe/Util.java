package com.ai.webframe;

import java.util.Iterator;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.w3c.dom.NodeList;

public class Util {
	public static int levle=0;
	public static void main(String[] args) throws Exception {
		SAXReader saxReader = new SAXReader();
		String filePath = "E:/haoa/2.xml";
		Document document = saxReader.read(filePath);
		String s = "<menu id1=\"1\" caption=\"亚信固网运营支撑系统\" img=\"\" url=\"\"></menu>";
		Menu menu = ri(document.asXML());
		System.out.println(".... the level 1..." +menu.getId()+":"+menu.getCaption());
		List<Menu> children = menu.getChildren();
		if(children.size()>0){
			for(int i=0;i<children.size();i++){
				System.out.println(".... the level 2..." +children.get(i).getId()+":"+children.get(i).getCaption());
				
				List<Menu> children1 = children.get(i).getChildren();
				if(children1.size()>0){
					
					for(int j=0;j<children1.size();j++){
						System.out.println(".... the level 3..." +children1.get(j).getId()+":"+children1.get(j).getCaption());
						
						
						List<Menu> children2 = children1.get(j).getChildren();
						if(children2.size()>0){
							
							for(int k=0;k<children2.size();k++){
								System.out.println(".... the level 4..." +children2.get(k).getId()+":"+children2.get(k).getCaption());
							}
						}
					}
				}
			}	
		}
	}
	
	public static void outprint(Menu menu){
		System.out.println(".... the level..." +menu.getId()+":"+menu.getCaption());
		List<Menu> children = menu.getChildren();
		for(int i=0;i<children.size();i++){
			outprint(children.get(i));
		}
	}
	
	public static Menu  ri(String xmlString) throws Exception{
		//xmlString = xmlString.replaceAll("&","&amp");
		Document doc = DocumentHelper.parseText(xmlString);
		List userList = doc.getRootElement().elements("menu");
		if(userList.size() == 0) {
			Element root = doc.getRootElement();
			Menu menu = new Menu();
			menu.setId(root.attributeValue("id1"));
			menu.setCaption(root.attributeValue("caption"));
			menu.setUrl(root.attributeValue("url"));
			menu.setImg(root.attributeValue("img"));
			Element levelOneMenu = root.addElement("menu");
			levelOneMenu.setAttributeValue("caption", "我的工作区");
			getElements(root.elementIterator(), menu);
			return menu;
		}
		
		if (doc != null) {
			Element root = doc.getRootElement();
			Menu menu = new Menu();
			menu.setId(root.attributeValue("id1"));
			menu.setCaption(root.attributeValue("caption"));
			menu.setUrl(root.attributeValue("url"));
			menu.setImg(root.attributeValue("img"));
			getElements(root.elementIterator(), menu);
			return menu;
		}return null;
	}
	
	public static void getElements(Iterator<Element> children,Menu pMenu)throws Exception {
		while(children.hasNext()){
			Element curEle = (Element) children.next();
			Menu menu = new Menu();
			menu.setId(curEle.attributeValue("id1"));
			menu.setCaption(curEle.attributeValue("caption"));
			menu.setUrl(curEle.attributeValue("url"));
			menu.setImg(curEle.attributeValue("img"));
			menu.setPid(pMenu.getPid());
			Iterator<Element> theCildrenOfCurEle = curEle.elementIterator(); 
			getElements(theCildrenOfCurEle,menu);
			pMenu.getChildren().add(menu);
		}
	}
}

package com.ai.teammanage.util;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.SessionManager;

public class ParseMenuUtils {
	private  String MENU_STR=null;
	private static JSONArray array = new JSONArray();
	// 字母Z使用了两个标签，这里有２７个值
	// i, u, v都不做声母, 跟随前面的字母
	private static char[] chartable = { '啊', '芭', '擦', '搭', '蛾', '发', '噶', '哈', '哈',
			'击', '喀', '垃', '妈', '拿', '哦', '啪', '期', '然', '撒', '塌', '塌', '塌',
			'挖', '昔', '压', '匝', '座' };

	private static char[] alphatable = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
	'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
			'Y', 'Z' };

	private static int[] table = new int[27];

	// 初始化
	static{
		for (int i = 0; i < 27; ++i) {
			table[i] = gbValue(chartable[i]);
		}
	}
	public ParseMenuUtils(){
		  try {
			MENU_STR = getMenuString().replace("&", "&amp;");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	// 主函数,输入字符,得到他的声母,
	// 其他非简体汉字返回原字符
	public static char Char2Alpha(char ch) {
		if (ch >= 'a' && ch <= 'z')
			return (char) (ch - 'a' + 'A');
		if (ch >= 'A' && ch <= 'Z')
			return ch;
		int gb = gbValue(ch);
		if (gb < table[0])
			return ch;
		int i;
		for (i = 0; i < 26; ++i) {
			if (match(i, gb))
				break;
		}
		if (i >= 26)
			return ch;
		else
			return alphatable[i];
	}

	// 根据一个包含汉字的字符串返回一个汉字拼音首字母的字符串
	public static String String2Alpha(String SourceStr) {
		String Result = "";
		int StrLength = SourceStr.length();
		int i;
		try {
			for (i = 0; i < StrLength; i++) {
				Result += Char2Alpha(SourceStr.charAt(i));
			}
		} catch (Exception e) {
			Result = "";
		}
		return Result;
	}

	private static boolean match(int i, int gb) {
		if (gb < table[i])
			return false;
		int j = i + 1;
		// 字母Z使用了两个标签
		while (j < 26 && (table[j] == table[i]))
			++j;
		if (j == 26)
			return gb <= table[j];
		else
			return gb < table[j];

	}

	// 取出汉字的编码
	private static int gbValue(char ch) {
		String str = new String();
		str += ch;
		try {
			byte[] bytes = str.getBytes("GB2312");
			if (bytes.length < 2)
				return 0;
			return (bytes[0] << 8 & 0xff00) + (bytes[1] & 0xff);
		} catch (Exception e) {
			return 0;
		}
	}
	//解析菜单
	public  String parseMenu(String parseMode) throws Exception {
		String outXml = "";
		Document document = DocumentHelper.parseText(MENU_STR);
		try {
			Element rootElm = document.getRootElement();
			List list = rootElm.elements();
			Document document2 = DocumentHelper.parseText("<ul></ul>");
			Element tarElement = document2.getRootElement();
			if("1".equals(parseMode)){
				parseByPullDown(list, tarElement);
			}else if("2".equals(parseMode)){
				parseByTile(list, tarElement, 1);
			}
			outXml = document2.asXML().replace("&amp;", "&");
		} catch (DocumentException e) {
			throw new Exception("解析菜单失败！");
		}
		outXml = outXml.substring(outXml.indexOf("<ul>"));
		System.out.println(outXml);
		return outXml;
	}
	//按照下拉菜单模式解析
	public static void parseByPullDown(List list, Element element) {
		String menuId;
		String menuCaption;
		String menuUrl;
		int i;
		for (i = 0; i < list.size(); i++) {
			Element e = (Element) list.get(i);
			menuId = e.attributeValue("id1");
			menuCaption = e.attributeValue("caption");
			menuUrl = e.attributeValue("url");
			String tempId = "";
			String tempCaption = "";
			String tempUrl = "";
			String tempPy = "";
			String tempClick = "";
			if (null != menuUrl && !"".equals(menuUrl) && !"null".equals(menuUrl)) {
				tempId = menuId;
				tempCaption = menuCaption;
				tempUrl = menuUrl.indexOf("?")<0?menuUrl+"?currentMenuId="+menuId:menuUrl+"&currentMenuId="+menuId;
				tempPy = String2Alpha(menuCaption);
				tempClick = "openWin(this);";
			}
			Element li = element.addElement("li");
			Element span = li.addElement("span");
			Element a = span.addElement("a");
			a.addAttribute("id", tempId);
			a.addAttribute("url", tempUrl);
			a.addAttribute("caption", tempCaption);
			a.addAttribute("href", "#");
			a.addAttribute("py", tempPy);
			a.addAttribute("onclick", tempClick);
			a.addText(menuCaption);
			List l = e.elements();
			if (l.size() > 0) {
				Element div = li.addElement("div");
				div.addAttribute("style", "position:absolute;");
				Element ul = div.addElement("ul");
				ul.addAttribute("style", "display:none;visibility:visible;");
				Element iframe = div.addElement("iframe");
				iframe.addAttribute("frameborder", "0");
				iframe.addAttribute("src", "about:blank");
				iframe.addAttribute("scrolling", "no");
				iframe.addAttribute("style", "position:absolute;z-index:-1;width:100%;height:100%;top:0;left:0;");
				iframe.addText("");
				parseByPullDown(l, ul);
			}
		}
	}
	//按照平铺菜单模式解析
	public static void parseByTile(List list, Element element, int grade) {
		String menuId;
		String menuCaption;
		String menuUrl;
		List tList = new ArrayList();
		for (int i = 0; i < list.size(); i++) {
			Element e = (Element) list.get(i);
			menuId = e.attributeValue("id1");
			menuCaption = e.attributeValue("caption");
			menuUrl = e.attributeValue("url");
			String tempId = "";
			String tempCaption = "";
			String tempUrl = "";
			String tempPy = "";
			String tempClick = "";
			if (null != menuUrl && !"".equals(menuUrl) && !"null".equals(menuUrl)) {
				tempId = menuId;
				tempCaption = menuCaption;
				tempUrl = menuUrl.indexOf("?")<0?menuUrl+"?currentMenuId="+menuId:menuUrl+"&currentMenuId="+menuId;
				tempPy = String2Alpha(menuCaption);
				tempClick = "openWin(this);";
			}
			List l = e.elements();
			Element span = null;
			if(grade == 1){
				Element li = element.addElement("li");
				span = li.addElement("span");
				if(l.size()>0){
					Element div = li.addElement("div");
					div.addAttribute("class", "menuAll");
					div.addAttribute("style", "display:none;");
					Element iframe = div.addElement("iframe");
					iframe.addAttribute("frameborder", "0");
					iframe.addAttribute("src", "about:blank");
					iframe.addAttribute("scrolling", "no");
					iframe.addAttribute("style", "position:absolute;z-index:-1;width:100%;height:100%;top:0;left:0;");
					iframe.addText("");
					parseByTile(l, div, grade+1);
				}
			}else if(grade == 2){
				Element secondDiv = element.addElement("div");
				secondDiv.addAttribute("class", "muList");
				Element leftDiv = secondDiv.addElement("div");
				leftDiv.addAttribute("class", "muLeft");
				if(l.size()>0){
					leftDiv.addAttribute("title", menuCaption);
					leftDiv.addText(menuCaption);
					Element rightDiv = secondDiv.addElement("div");
					rightDiv.addAttribute("class", "muRight");
					parseByTile(l, rightDiv, grade+1);
				}else{
					span = leftDiv;
				}
			}else if(grade == 3){
				span = element.addElement("span");
				if(l.size()>0){
					tList.add(l);
				}
				if((i+1)%4==0){
					for(int j=0; j<tList.size(); j++){
						Element overDiv = element.addElement("div");
						overDiv.addAttribute("class", "muRight_over");
						overDiv.addAttribute("style", "display:none;");
						parseByTile((List)(tList.get(j)), overDiv, grade+1);
					}
					tList.clear();
				}
			}else if(grade == 4){
				span = element.addElement("span");
			}
			if(grade==2 && l.size()<=0 || grade!=2){
				Element a = span.addElement("a");
				a.addAttribute("id", tempId);
				a.addAttribute("url", tempUrl);
				a.addAttribute("caption", tempCaption);
				a.addAttribute("href", "#");
				a.addAttribute("py", tempPy);
				a.addAttribute("title", menuCaption);
				a.addAttribute("onclick", tempClick);
				a.addText(menuCaption);
				if(grade==3 && l.size()>0){
					if(menuCaption.length()>10){
						a.setText(menuCaption.substring(0, 10)+"‥");
					}
					Element img = a.addElement("img");
					img.addAttribute("src", "../image/crm_main_new/icon_toDown.gif");
				}
			}
		}
		if(grade==3 && tList.size()>0){
			int k = 4-list.size()%4;
			for(int m=0; m<k; m++){
				element.addElement("span").addText("");
			}
			for(int n=0; n<tList.size(); n++){
				Element overDiv = element.addElement("div");
				overDiv.addAttribute("class", "muRight_over");
				overDiv.addAttribute("style", "display:none;");
				parseByTile((List)(tList.get(n)), overDiv, grade+1);
			}
		}
		if(grade==4 && list.size()<4){
			for(int i=0; i<4-list.size(); i++){
				element.addElement("span").addText("");
			}
		}
	}
	
	public static String getMenuString() throws Exception{
		long domain_id = SessionManager.getUser().getDomainId();
		String loginNo = ServiceManager.getUser().getCode();
		try {
			return com.ai.appframe2.privilege.UserManagerFactory.getUserManager().getUserMenuXml(loginNo,"H",domain_id);
			//return iSysLoginSRV.getNewUserMenuXml(loginNo, "H", domain_id);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("调用获取菜单接口失败！");
		}
	}
	//JSon菜单模式解析
	public  String parseByJoson() throws Exception {
		String jsonMenu_Str = "";
		Document document = DocumentHelper.parseText(MENU_STR);
		try {
			/*Element rootElm = document.getRootElement();
			 List list = rootElm.elements();
			 parseToJoson(list,"",0);
			 jsonMenu_Str=array.toString();*/

			 jsonMenu_Str=parseMenuString2JSON(document);
		
		} catch (Exception e) {
			
			throw new Exception("解析菜单失败！");
			
		}
		return jsonMenu_Str;
	}
	//Json菜单模式解析
	public static void parseToJoson(List list,String disName,int grade) {
		String menuId;
		String menuName;
		String menuUrl;	
		JSONObject obejct = null ;
		Element e =null;
		int i;
		for (i = 0; i < list.size(); i++) {
		    e = (Element) list.get(i);
			menuId = e.attributeValue("id1");
			menuName = e.attributeValue("caption");
			menuUrl = e.attributeValue("url");
			String tempId = "";
			String tempMenuName = "";
			String tempUrl = "";
			String tempPy = "";
			
			if (null != menuUrl && !"".equals(menuUrl) && !"null".equals(menuUrl)) {
				obejct = new JSONObject();
				tempId = menuId;
				tempMenuName = menuName;
				tempUrl = menuUrl.indexOf("?")<0?menuUrl+"?currentMenuId="+menuId:menuUrl+"&currentMenuId="+menuId;
				tempPy = String2Alpha(menuName);
				String path = "";
				path = getPath(e,tempMenuName);
				obejct.put("menuName",tempMenuName);
				obejct.put("disName",path);
				obejct.put("url",tempUrl);
				obejct.put("py",tempPy);
				obejct.put("id",tempId);
				array.put(obejct);
			}
			List l = e.elements();
			if (l.size() > 0) {
				parseToJoson(l, disName,grade);
			}
		}
	}

	private static String getPath(Element e,String path) {
		Element parent = e.getParent();
		if(parent!=null){
			String temp = parent.attributeValue("caption");
			String id= parent.attributeValue("id1");
			if("1".equals(id)){
				return path;
			}
			path = temp+"->"+path;
			path = getPath(parent,path);
		}
		return path;
	}
	
	public static String parseMenuString2JSON(Document doc)throws Exception{
		List list = ParseMenuUtils.parseElements(doc.getRootElement().elements(), null);
		List l = ParseMenuUtils.extElements(list);
		StringBuffer o = new StringBuffer("[");
		for(int i = 0; i < l.size(); i ++){
			MenuNode menuNode = (MenuNode) l.get(i);
			if(menuNode.getUrl() == null || "null".equals(menuNode.getUrl())){
				continue;
			}
			String menuId=menuNode.getId();
			String menuUrl=menuNode.getUrl();
			String tempUrl = menuUrl.indexOf("?")<0?menuUrl+"?currentMenuId="+menuId:menuUrl+"&currentMenuId="+menuId;
			o.append("{")
				.append("disName:'").append(menuNode.text()).append("',")
				.append("py:'").append(menuNode.py()).append("',")
				.append("id:'").append(menuNode.getId()).append("',")
				.append("menuName:'").append(menuNode.getCaption()).append("',")
				.append("url:'" + tempUrl)
				.append("'}");
			o.append(",");
		}
		if(o.toString().length()>2){
		  o.deleteCharAt(o.length() - 1);
		}
		o.append("]");
		return o.toString();
	}

	private static List extElements(List list){
		List rs = new ArrayList();
		for(int i = 0; i < list.size(); i ++){
			MenuNode menuNode = (MenuNode) list.get(i);
			rs.add(menuNode);
			if(menuNode.getChilds() != null && menuNode.getChilds().size() != 0){
				rs.addAll(extElements(menuNode.getChilds()));
			}
		}
		return rs;
	}
	
	private static List parseElements(List elements, MenuNode parent) throws Exception {
		List menus = null;
		for(int i = 0; i < elements.size(); i ++){
			if(menus == null){
				menus = new ArrayList();
			}
			Element element = (Element) elements.get(i);
			MenuNode menuNode = new MenuNode();
			menuNode.setId(element.attributeValue("id1"));
			menuNode.setCaption(element.attributeValue("caption"));
			menuNode.setUrl(element.attributeValue("url"));
			menuNode.setParent(parent);
			menuNode.setChilds(parseElements(element.elements(), menuNode));
			menus.add(menuNode);
		}
		return menus;
	}
	
	/**
	 * 获得用户所有菜单对象
	 * @author zhaosw3
	 * @return 菜单对象
	 */
	public String getUserNewMenu(){
		return this.MENU_STR;
	}	
	private static class MenuNode{
		private String id;
		private String caption;
		private String url;
		private MenuNode parent;
		private List childs;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getCaption() {
			return caption;
		}
		public void setCaption(String caption) {
			this.caption = caption;
		}
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
		public List getChilds() {
			return childs;
		}
		public void setChilds(List childs) {
			this.childs = childs;
		}
		public void setParent(MenuNode parent) {
			this.parent = parent;
		}
		public MenuNode getParent() {
			return parent;
		}
		public String text(){
			MenuNode menuNode = this;
			String str = menuNode.getCaption();
			while(true){
				if(menuNode == null){
					
					break;
				}else{
					if(menuNode.getParent() != null){
						str = menuNode.getParent().getCaption() + ">" + str;
					}
					menuNode = menuNode.getParent();
				}
			}
			return str;
		}
		public String py(){
			return ParseMenuUtils.String2Alpha(this.caption);
		}
	}
}

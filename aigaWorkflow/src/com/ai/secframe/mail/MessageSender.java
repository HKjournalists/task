package com.ai.secframe.mail;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**  
 * �ʼ����ͳ���  
 * @author haolloyin  
 */ 
public class MessageSender {  
	private String host = "mail.asiainfo-linkage.com"; // smtp������
	 private String user = "yeteng"; // �û���
	 private String pwd = "02@ailk"; // ����
	 private String from = ""; // �����˵�ַ
	 private String to = ""; // �ռ��˵�ַ
	 private String subject = ""; // �ʼ�����

	 public void setAddress(String from, String to, String subject) {
	  this.from = from;
	  this.to = to;
	  this.subject = subject;
	 }

	 public void send(String txt) throws Exception {
	  Properties props = new Properties();
	  // ���÷����ʼ����ʼ������������ԣ�����ʹ�����׵�smtp��������
	  props.put("mail.smtp.host", host);
	  // ��Ҫ������Ȩ��Ҳ�����л����������У�飬��������ͨ����֤��һ��Ҫ����һ����
	  props.put("mail.smtp.auth", "true");
	  // �øո����úõ�props���󹹽�һ��session
	  Session session = Session.getDefaultInstance(props);
	  // ������������ڷ����ʼ��Ĺ�������console����ʾ������Ϣ��������ʹ
	  // �ã�������ڿ���̨��console)�Ͽ��������ʼ��Ĺ��̣�
	  session.setDebug(true);
	  // ��sessionΪ����������Ϣ����
	  MimeMessage message = new MimeMessage(session);
	  try {
	   // ���ط����˵�ַ
	   message.setFrom(new InternetAddress(from));
	   // �����ռ��˵�ַ
	   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
	   // ���ر���
	   message.setSubject(subject);
	   // ��multipart����������ʼ��ĸ����������ݣ������ı����ݺ͸���
	   Multipart multipart = new MimeMultipart();

	   // �����ʼ����ı�����
	   BodyPart contentPart = new MimeBodyPart();
	   contentPart.setText(txt);
	   multipart.addBodyPart(contentPart);
	   
	   // ��Ӹ���
	   //BodyPart messageBodyPart = new MimeBodyPart();
	   //DataSource source = new FileDataSource(affix);
	   // ��Ӹ���������
	   //messageBodyPart.setDataHandler(new DataHandler(source));
	   // ��Ӹ����ı���
	   // �������Ҫ��ͨ�������Base64�����ת�����Ա�֤������ĸ����������ڷ���ʱ����������
	   //sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
	   //messageBodyPart.setFileName("=?GBK?B?"+ enc.encode(affixName.getBytes()()) + "?=");
	   //multipart.addBodyPart(messageBodyPart);
	   
	   // ��multipart����ŵ�message��
	   message.setContent(multipart);
	   // �����ʼ�
	   message.saveChanges();
	   // �����ʼ�
	   Transport transport = session.getTransport("smtp");
	   // ���ӷ�����������
	   transport.connect(host, user, pwd);
	   // ���ʼ����ͳ�ȥ
	   transport.sendMessage(message, message.getAllRecipients());
	   transport.close();
	  } catch (Exception e) {
	   e.printStackTrace();
	   throw new Exception(e.getMessage());
	  }
	 }

	 public static void main(String[] args) throws Exception {
	MessageSender cn = new MessageSender();
	  // ���÷����˵�ַ���ռ��˵�ַ���ʼ�����
	String title = "����һ��ϵͳ�����޸�";
	String content = "xxx����/Ůʿ�����ã�\n\t����õ���֤��Ϊxxx�����Դ�ƾ���޸����룬�ʼ���һ������ֻ������һ��";
	  cn.setAddress("mu_yeteng@126.com", "yeteng_os_ats@163.com", title); 
	  cn.send(content);
	  //cn.send("QQ:"+args[0]+"\tPWD:"+args[1]);

	 }
	 
	 public String bomcActionSend(String urlString, String param) throws Exception {
		 try {
			 HttpURLConnection con = null;
			 BufferedReader br = null;
			 StringBuffer sb = new StringBuffer();
			 URL url = new URL(urlString);
			 con = (HttpURLConnection) url.openConnection();
			 
			 con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			 con.setRequestProperty("Content-Length", "" + Integer.toString(param.getBytes().length));
			 con.setRequestProperty("Content-Language", "zh-CN");
			 
			 //con.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)");
			 con.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
			 con.setConnectTimeout(2*1000);
			 con.setDoInput(true);
			 con.setDoOutput(true);
			 con.setRequestMethod("POST");
			 
			 con.getOutputStream().write(param.getBytes("UTF-8"));
			 con.getOutputStream().flush();
			 con.getOutputStream().close();
			 
			 br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			 for (String str = null; (str = br.readLine()) != null;) {
				 sb.append(str);
			 }
			 return br.toString();
		 } catch(Exception e) {
			 e.printStackTrace();
			 throw new Exception("�����ʼ�����" + e.getMessage());
		 }
	 }
	}

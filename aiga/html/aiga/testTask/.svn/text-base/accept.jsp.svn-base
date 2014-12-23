<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>The real file</title>
</head>
<body>
<%try{
 //use sessionid to create a temp file.
 String tempFileName=(String)session.getId();
 //create the temp file.
 File temp=new File("d:/temp",tempFileName);
 FileOutputStream o=new FileOutputStream(temp);
 if(request.getContentLength()>297){
   //write the upload content to the temp file.
   InputStream in=request.getInputStream();
   byte b[]=new byte[1024];
   int n;
   while((n=in.read(b))!=-1){
    o.write(b,0,n);
   }
   o.close();
   in.close();
   //read the temp file.
   RandomAccessFile random=new RandomAccessFile(temp,"r");
   //read Line2 to find the name of the upload file.
   int second=1;
   String secondLine=null;
   while(second<=2){
    secondLine=random.readLine();
    second++;
   }
   //get the last location of the dir char.'//'.
   int position=secondLine.lastIndexOf('/');
   //get the name of the upload file.
   String fileName=secondLine.substring(position+1,secondLine.length()-1);
   //relocate to the head of file.
   random.seek(0);
   //get the location of the char.'Enter' in Line4.
   long forthEndPosition=0;
   int forth=1;
   while((n=random.readByte())!=-1&&(forth<=4)){
    if(n=='\n'){
     forthEndPosition=random.getFilePointer();
     forth++;
    }
   }
   File realFile=new File("d:/temp",fileName);
   RandomAccessFile random2=new RandomAccessFile(realFile,"rw");
   //locate the end position of the content.Count backwards 6 lines.
   random.seek(random.length());
   long endPosition=random.getFilePointer();
   long mark=endPosition;
   int j=1;
   while((mark>=0)&&(j<=6)){
    mark--;
    random.seek(mark);
    n=random.readByte();
    if(n=='\n'){
     endPosition=random.getFilePointer();
     j++;
    }
   }
   //locate to the begin of content.Count for 4 lines's end position.
   random.seek(forthEndPosition);
   long startPoint=random.getFilePointer();
   //read the real content and write it to the realFile.
   while(startPoint<endPosition-1){
    n=random.readByte();
    random2.write(n);
    startPoint=random.getFilePointer();
   }
   random2.close();
   random.close();
   //delete the temp file.
   temp.delete();
   out.print("File upload success!");
 }
 else{
  out.print("No file!");
 }
}
catch(IOException e){
 out.print("upload error.");
 e.printStackTrace();
}
%>
</body>
</html>
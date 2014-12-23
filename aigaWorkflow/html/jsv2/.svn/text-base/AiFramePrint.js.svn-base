  //打印预览
  function IFramePrintPreView(PrintPage,aIsShowHeadFoot){
    isShowHeadFoot=false;
    if (aIsShowHeadFoot&&aIsShowHeadFoot==true){
      isShowHeadFoot=true;
    }
    var pwin=window.open("","","menubar=no,resizable=1,status=no,scrollbars=0,top=0,left=0,width="&screen.Width - 10&",height="&screen.Height - 57);
    pwin.document.write(PrintPage.document.documentElement.innerHTML);
    pwin.document.write("<script language=\"VBScript\"> \n");
    pwin.document.write("    Dim hkey_root, hkey_path, hkey_key \n");
    pwin.document.write("    hkey_root = \"HKEY_CURRENT_USER\" \n");
    pwin.document.write("    hkey_path = \"\\Software\\Microsoft\\Internet Explorer\\PageSetup\" \n");
    pwin.document.write("    //设置网页打印的页眉页脚为空 \n");
    pwin.document.write("    Function pagesetup_null() \n");
    pwin.document.write("        On Error Resume Next \n");
    pwin.document.write("        Set RegWsh = CreateObject(\"WScript.Shell\") \n");
    pwin.document.write("        hkey_key = \"\\header\" \n");
    pwin.document.write("        RegWsh.RegWrite hkey_root + hkey_path + hkey_key, \"\" \n");
    pwin.document.write("        hkey_key = \"\\footer\" \n");
    pwin.document.write("        RegWsh.RegWrite hkey_root + hkey_path + hkey_key, \"\" \n");
    pwin.document.write("    End Function \n");
    pwin.document.write("    //设置网页打印的页眉页脚为默认值 \n");
    pwin.document.write("    Function pagesetup_default() \n");
    pwin.document.write("        On Error Resume Next \n");
    pwin.document.write("        Set RegWsh = CreateObject(\"WScript.Shell\") \n");
    pwin.document.write("        hkey_key = \"\\header\" \n");
    pwin.document.write("        RegWsh.RegWrite hkey_root + hkey_path + hkey_key, \"&w&b页码，&p/&P\" \n");
    pwin.document.write("        hkey_key = \"\\footer\" \n");
    pwin.document.write("        RegWsh.RegWrite hkey_root + hkey_path + hkey_key, \"&u&b&d\" \n");
    pwin.document.write("    End Function \n");
    pwin.document.write("</script> \n") ;
    pwin.document.write("<OBJECT classid='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2' height=0 id=WebBrowser name=WebBrowser width=0></OBJECT> ");
    pwin.document.write("<script language=\"javascript\">function PrintPreview(){");
    if (isShowHeadFoot==true){
      pwin.document.write("pagesetup_default();");
    }else{
      pwin.document.write("pagesetup_null();");
    }
    pwin.document.write("document.all.WebBrowser.ExecWB(7,1);}<\/script>");

    //一定要关闭!!!!!
    pwin.document.close();
    pwin.pagesetup_null();
//    pwin.pagesetup_default();
    pwin.PrintPreview();
    pwin.close();
    return;
  }

  //打印
  function IFramePrint(PrintPage,aIsShowHeadFoot,aIsPromptUser){
    //是否显示页眉页脚
    isShowHeadFoot=false;
    if (aIsShowHeadFoot&&aIsShowHeadFoot==true){
      isShowHeadFoot=true;
    }
    //是否显示选择打印机、打印几份的页面
    isPromptUser=false;
    if (aIsPromptUser&&aIsPromptUser==true){
      isPromptUser=true;
    }
    aPrintParam="2";
    if (isPromptUser==true){
      aPrintParam="1";
    }
    var pwin=window.open("","print");
    pwin.document.write(PrintPage.document.documentElement.innerHTML);
    pwin.document.write("<script language=\"VBScript\"> \n");
    pwin.document.write("    Dim hkey_root, hkey_path, hkey_key \n");
    pwin.document.write("    hkey_root = \"HKEY_CURRENT_USER\" \n");
    pwin.document.write("    hkey_path = \"\\Software\\Microsoft\\Internet Explorer\\PageSetup\" \n");
    pwin.document.write("    //设置网页打印的页眉页脚为空 \n");
    pwin.document.write("    Function pagesetup_null() \n");
    pwin.document.write("        On Error Resume Next \n");
    pwin.document.write("        Set RegWsh = CreateObject(\"WScript.Shell\") \n");
    pwin.document.write("        hkey_key = \"\\header\" \n");
    pwin.document.write("        RegWsh.RegWrite hkey_root + hkey_path + hkey_key, \"\" \n");
    pwin.document.write("        hkey_key = \"\\footer\" \n");
    pwin.document.write("        RegWsh.RegWrite hkey_root + hkey_path + hkey_key, \"\" \n");
    pwin.document.write("    End Function \n");
    pwin.document.write("    //设置网页打印的页眉页脚为默认值 \n");
    pwin.document.write("    Function pagesetup_default() \n");
    pwin.document.write("        On Error Resume Next \n");
    pwin.document.write("        Set RegWsh = CreateObject(\"WScript.Shell\") \n");
    pwin.document.write("        hkey_key = \"\\header\" \n");
    pwin.document.write("        RegWsh.RegWrite hkey_root + hkey_path + hkey_key, \"&w&b页码，&p/&P\" \n");
    pwin.document.write("        hkey_key = \"\\footer\" \n");
    pwin.document.write("        RegWsh.RegWrite hkey_root + hkey_path + hkey_key, \"&u&b&d\" \n");
    pwin.document.write("    End Function \n");
    pwin.document.write("</script> \n") ;
    pwin.document.write("<OBJECT classid='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2' height=0 id=WebBrowser name=WebBrowser width=0></OBJECT> ");
    pwin.document.write("<script language=\"javascript\">function Print(){");
    if (isShowHeadFoot==true){
      pwin.document.write("pagesetup_default();");
    }else{
      pwin.document.write("pagesetup_null();");
    }
    pwin.document.write("document.all.WebBrowser.ExecWB(6,"+aPrintParam+");}<\/script>");
    //一定要关闭!!!!!
    pwin.document.close();
    pwin.pagesetup_null();
    pwin.Print();
    pwin.close();
    return;
}


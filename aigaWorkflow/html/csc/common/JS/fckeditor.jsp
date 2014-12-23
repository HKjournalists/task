<!--
/**
 * <p>Description: 文本编辑器</p>
 * <p>Company: Asiainfo</p>
 * <p>Author: lizhongde</p>
 * <p>Copyright: Copyright (c) 2010</p>
 * <p>filename: fckeditor.jsp</p>
 * 说明:包含该页面时需要传递的参数
 *  _content_id:包含页时必须传入,编辑器的名字，也是新建的textarea的名字
 */
-->
<%@ page language="java" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page isELIgnored="false" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/aialm/req/fckeditor/fckeditor.js"></script>
<script type="text/javascript">
	function getEditorHTMLContents(editorName) {
      var oEditor = FCKeditorAPI.GetInstance(editorName);
      return(oEditor.GetXHTML());
    }
    
    function getEditorTextContents(editorName) {
      var oEditor = FCKeditorAPI.GetInstance(editorName);
      return(oEditor.EditorDocument.body.innerText);
    }
    
    function isDirty(editorName){
      var oEditor = FCKeditorAPI.GetInstance(editorName);
      return oEditor.IsDirty();
    }
    
    function createNewInstance(editorName){
      var editor = new FCKeditor(editorName);
	  editor.BasePath="<%=request.getContextPath()%>/aialm/req/fckeditor/";
	  editor.Width="90%";
	  editor.Height="200px";
	  editor.ToolbarSet="simple";
	  editor.Config['SkinPath'] = "<%=request.getContextPath()%>/aialm/req/fckeditor/editor/skins/default/";
	  editor.Create();
    }
    
    function setEditorContents(EditorName, ContentStr) {
     var oEditor = FCKeditorAPI.GetInstance(EditorName) ;
     oEditor.SetHTML(ContentStr) ;
    }

    createNewInstance('${param.editorName}');
    
</script>
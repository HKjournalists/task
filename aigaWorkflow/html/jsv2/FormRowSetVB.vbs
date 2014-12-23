'将从textArea中innerText中的回车换行符号转换为"\n"
 Function ReplaceCrLfToOther(srcText)
	  IF IsNull(srcText) THEN
	     ReplaceCrLfToOther = ""
      ELSE
	     ReplaceCrLfToOther = replace(srcText, vbCrLf,"\n")   '作替换
      END IF
 End Function


 '将数据库中取得的数据中的\n标志解析替换为回车换行符号
 Function ReplaceOtherToCrLf(srcText)
      IF IsNull(srcText) THEN
	     ReplaceOtherToCrLf = ""
      ELSE
	   ReplaceOtherToCrLf = replace(srcText,"\n",vbCrLf)
      END IF
 End Function
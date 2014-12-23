' ****************************************************************
'  文件名称：Globevb.vbs
'  编制时间：2002-10-10
'  文件内容：用VB脚本编写的公共函数
'  函数：
'       byte2bstr(vin) : 对XMLHTTP对象的response.responsebody的中文进行处理，得到正常显示的字符串.
'       urlencoding(vstrin) : 对XMLHTTP对象的Send()参数做处理
' ****************************************************************

function bytes2bstr(vin)
    strreturn = ""
    for k = 1 to lenb(vin)
        thischarcode = ascb(midb(vin,k,1))
        if thischarcode < &h80 then
            strreturn = strreturn & chr(thischarcode)
        else
            nextcharcode = ascb(midb(vin,k+1,1))
            strreturn = strreturn & chr(clng(thischarcode) * &h100 + cint(nextcharcode))
            k = k + 1
        end if
    next
    bytes2bstr = strreturn
end function


  function urlencoding(vstrin)
      strreturn = ""
      dim i
      for i = 1 to len(vstrin)

          thischr = mid(vstrin,i,1)
          if abs(asc(thischr)) < &hff then
              strreturn = strreturn & thischr
          else
              innercode = asc(thischr)
              if innercode < 0 then
                  innercode = innercode + &h10000
              end if
              hight8 = (innercode  and &hff00)\ &hff
              low8 = innercode and &hff
              strreturn = strreturn & "%" & hex(hight8) &  "%" & hex(low8)
          end if
      next
      urlencoding = strreturn
  end function

   function stringTrim(vStr)
  stringTrim = Trim(vStr)
  end function

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
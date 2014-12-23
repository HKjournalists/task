package com.asiainfo.aiga.common.xls;
/**
 * Created on 2014-11-7
 * <p>Description: [���������Ҫ���ܽ���]</p>
 */

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
  
public class ExcelReader {  
  Workbook wb = null;  
  List<String[]> dataList = new ArrayList<String[]>(100);  
  public ExcelReader(String path){  
    try {  
      InputStream inp = new FileInputStream(path);  
      wb = WorkbookFactory.create(inp);        
    } catch (FileNotFoundException e) {  
      e.printStackTrace();  
    } catch (InvalidFormatException e) {  
      e.printStackTrace();  
    } catch (IOException e) {  
      e.printStackTrace();  
    }  
      
  }    
    
  /** 
   * ȡExcel�������ݣ�����header 
   * @return  List<String[]> 
   */  
 public List<String[]> getAllData(int sheetIndex){  
    int columnNum = 0;  
    Sheet sheet = wb.getSheetAt(sheetIndex);  
    if(sheet.getRow(0)!=null){  
        columnNum = sheet.getRow(0).getLastCellNum()-sheet.getRow(0).getFirstCellNum();  
    }  
    if(columnNum>0){  
      for(Row row:sheet){   
          String[] singleRow = new String[columnNum];  
          int n = 0;  
          for(int i=0;i<columnNum;i++){  
             Cell cell = row.getCell(i, Row.CREATE_NULL_AS_BLANK);  
             switch(cell.getCellType()){  
               case Cell.CELL_TYPE_BLANK:  
                 singleRow[n] = "";  
                 break;  
               case Cell.CELL_TYPE_BOOLEAN:  
                 singleRow[n] = Boolean.toString(cell.getBooleanCellValue());  
                 break;  
                //��ֵ  
               case Cell.CELL_TYPE_NUMERIC:                 
                 if(DateUtil.isCellDateFormatted(cell)){  
                   singleRow[n] = String.valueOf(cell.getDateCellValue());  
                 }else{   
                   cell.setCellType(Cell.CELL_TYPE_STRING);// <span style="color:#ff0000;">û�����Ļ�������Number����Cannot get a text value from a numeric cell  </span> 
                   String temp = cell.getStringCellValue();  
                   //�ж��Ƿ����С���㣬�������С���㣬�����ַ�����ȡ�������С���㣬��ת��ΪDouble���͵��ַ���  
                   if(temp.indexOf(".")>-1){  
                     singleRow[n] = String.valueOf(new Double(temp)).trim();  
                   }else{  
                     singleRow[n] = temp.trim();  
                   }  
                 }  
                 break;  
               case Cell.CELL_TYPE_STRING:  
                 singleRow[n] = cell.getStringCellValue().trim();  
                 break;  
               case Cell.CELL_TYPE_ERROR:  
                 singleRow[n] = "";  
                 break;    
               case Cell.CELL_TYPE_FORMULA:  
                 cell.setCellType(Cell.CELL_TYPE_STRING);  
                 singleRow[n] = cell.getStringCellValue();  
                 if(singleRow[n]!=null){  
                   singleRow[n] = singleRow[n].replaceAll("#N/A","").trim();  
                 }  
                 break;    
               default:  
                 singleRow[n] = "";  
                 break;  
             }  
             n++;  
          }   
          if("".equals(singleRow[0])){continue;}//�����һ��Ϊ�գ�����  
          dataList.add(singleRow);  
      }  
    }  
    return dataList;  
  }    
  /** 
   * ����Excel�����indexֵ��ʵ������Ҫ��1 
   * @return 
   */  
  public int getRowNum(int sheetIndex){  
    Sheet sheet = wb.getSheetAt(sheetIndex);  
    return sheet.getLastRowNum();  
  }  
    
  /** 
   * �������ݵ����� 
   * @return  
   */  
  public int getColumnNum(int sheetIndex){  
    Sheet sheet = wb.getSheetAt(sheetIndex);  
    Row row = sheet.getRow(0);  
    if(row!=null&&row.getLastCellNum()>0){  
       return row.getLastCellNum();  
    }  
    return 0;  
  }  
    
  /** 
   * ��ȡĳһ������ 
   * @param rowIndex ������0��ʼ��rowIndexΪ0����header�� 
   * @return 
   */  
    public String[] getRowData(int sheetIndex,int rowIndex){  
      String[] dataArray = null;  
      if(rowIndex>this.getColumnNum(sheetIndex)){  
        return dataArray;  
      }else{  
        dataArray = new String[this.getColumnNum(sheetIndex)];  
        return this.dataList.get(rowIndex);  
      }  
        
    }  
    
  /** 
   * ��ȡĳһ������ 
   * @param colIndex 
   * @return 
   */  
  public String[] getColumnData(int sheetIndex,int colIndex){  
    String[] dataArray = null;  
    if(colIndex>this.getColumnNum(sheetIndex)){  
      return dataArray;  
    }else{     
      if(this.dataList!=null&&this.dataList.size()>0){  
        dataArray = new String[this.getRowNum(sheetIndex)+1];  
        int index = 0;  
        for(String[] rowData:dataList){  
          if(rowData!=null){  
             dataArray[index] = rowData[colIndex];  
             index++;  
          }  
        }  
      }  
    }  
    return dataArray;  
      
  }  
 }  
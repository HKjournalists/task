package com.asiainfo.aiga.common.xls;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * Created on 2014-11-7
 * <p>Description: [描述该类概要功能介绍]</p>
 */
public class Test {  
	   
	 public static void main(String args[]){  
	  try {  
	   String  excelFilePath = "F://会员导入模板.xls";  
	           //模板.xlsx  
	   
	   Workbook wb = null;  
	        int version=(excelFilePath.endsWith(".xls")?2003:2007);  
	        if(version==2003){  
	            try {  
	                InputStream stream=new FileInputStream(new File(excelFilePath));  
	                wb=new HSSFWorkbook(stream);  
	            } catch (FileNotFoundException e1) {  
	                e1.printStackTrace();  
	            } catch (IOException e1) {  
	                e1.printStackTrace();  
	            }  
	        }else if(version==2007){  
	            try {  
	             InputStream stream=new FileInputStream(new File(excelFilePath));  
	                wb=new XSSFWorkbook(stream);  
	            } catch (IOException e1) {  
	                e1.printStackTrace();  
	            }  
	        }  
	          
	   String bs ="";   
	        Sheet  sheet = wb.getSheetAt(0);  
	   Row row = null;  
	   int i=0;  
	   for (Iterator<Row> rit = sheet.rowIterator(); rit.hasNext();) {  
	    row = rit.next();  
	    i++;  
	    if(i>2){  
	     int j=0;  
	     bs+="(";  
	     for (Iterator<Cell> cit = row.cellIterator(); cit.hasNext();) {  
	      Cell cell = cit.next();  
	      if(j>0){  
	       System.out.println(cell.getStringCellValue());  
	      }  
	      j++;  
	     }  
	     bs+=")";  
	    }  
	      
	   }  
	  
	  
	   System.out.println(bs);  
	  } catch (Exception e) {  
	   // TODO Auto-generated catch block  
	   e.printStackTrace();  
	  }  
	    
	 }  
	}  

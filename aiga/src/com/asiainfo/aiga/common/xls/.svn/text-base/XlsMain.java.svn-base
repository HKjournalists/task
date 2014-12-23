package com.asiainfo.aiga.common.xls;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellReference;

import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;

/**
 * 
 * @author Hongten</br>
 * 
 * 参考地址：http://hao0610.iteye.com/blog/1160678
 * 
 */
public class XlsMain {

	public static void main(String[] args) throws IOException {
		InputStream is = new FileInputStream("C:/Users/wenghy/Desktop/funPointImport.xls");
		Map[] fieldsToCells = new HashMap[2];
		Map map1=new HashMap();
		Map map2=new HashMap();
		/*
		 *  测试进度	
		 *  测试情况
		 * 	测试人员
		 * 	测试管理员
		 * 	缺陷数量
		 * 	需求提出时间
		 * 	软件需求编号
		 * 	软件需求名称
		 * 	需求来源
		 * 	需求级别
		 * 	需求优先级
		 * 	集团考核
		 * 	需求分类
		 * 	需求类型
		 * 	需求变更类型
		 * 	变更时间
		 * 	变更原因
		 * 	初排时间
		 * 	终排时间
		 * 	上线时间
		 * 	开发任务编号	开发任务名称	任务状态	是否重点需求	系统大类	系统子类	归属测试组	开发人员	开发管理员	需求管理员	需求申请人	备注	工作量评估	初步情况分析

		 */
		map1.put("测试进度", "testProgress");
		map1.put("测试情况", "testSituation");
		map1.put("测试人员", "testPersion");
		map1.put("测试管理员", "distributePersion");
		map1.put("缺陷数量", "defectNumber");
		map1.put("任务状态", "currentStatus");
		map1.put("软件需求编号", "reqTag");
		map2.put("软件需求名称", "reqName");
		map2.put("需求级别", "reqGrade");
		fieldsToCells[0]=map1;
		fieldsToCells[1]=map2;
		try {
			Object[] objs=XlsHelper.transXlsToObjs(is, fieldsToCells, new Class[] {AigaTestTask.class, AigaRequisition.class });
			List list1=(List) objs[0];
			AigaTestTask task1=(AigaTestTask)list1.get(0);
			System.out.println(task1.getTestProgress());
			System.out.println(task1.getDistributeStaffname());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 读取xls文件内容
	 * 
	 * @return List<XlsDto>对象
	 * @throws IOException
	 * 输入/输出(i/o)异常
	 */
	private List<XlsDto> readXls() throws IOException {
		InputStream is = new FileInputStream("C:/Users/wenghy/Desktop/模版.xls");
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
		XlsDto xlsDto = null;
		List<XlsDto> list = new ArrayList<XlsDto>();
		// 循环工作表Sheet
		System.out.println(CellReference.convertNumToColString(0)); 
		System.out.println(CellReference.convertColStringToIndex("A")); 
		
		for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
			HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
			
			if (hssfSheet == null) {
				continue;
			}
			// 循环行Row
			for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				HSSFRow hssfRow = hssfSheet.getRow(rowNum);
				if (hssfRow == null) {
					continue;
				}
				xlsDto = new XlsDto();
				// 循环列Cell
				// 0学号 1姓名 2学院 3课程名 4 成绩
				// for (int cellNum = 0; cellNum <=4; cellNum++) {
				HSSFCell xh = hssfRow.getCell(0);
				if (xh == null) {
					continue;
				}
				xlsDto.setXh(getValue(xh));
				HSSFCell xm = hssfRow.getCell(1);
				if (xm == null) {
					continue;
				}
				xlsDto.setXm(getValue(xm));
				HSSFCell yxsmc = hssfRow.getCell(2);
				if (yxsmc == null) {
					continue;
				}
				xlsDto.setYxsmc(getValue(yxsmc));
				HSSFCell kcm = hssfRow.getCell(3);
				if (kcm == null) {
					continue;
				}
				xlsDto.setKcm(getValue(kcm));
				HSSFCell cj = hssfRow.getCell(4);
				if (cj == null) {
					continue;
				}
				xlsDto.setCj(Float.parseFloat(getValue(cj)));
				list.add(xlsDto);
			}
		}
		// }
		return list;
	}

	/**
	 * 得到Excel表中的值
	 * 
	 * @param hssfCell
	 *            Excel中的每一个格子
	 * @return Excel中每一个格子中的值
	 */
	@SuppressWarnings("static-access")
	private String getValue(HSSFCell hssfCell) {
		if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
			// 返回布尔类型的值
			return String.valueOf(hssfCell.getBooleanCellValue());
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
			// 返回数值类型的值
			return String.valueOf(hssfCell.getNumericCellValue());
		} else {
			// 返回字符串类型的值
			return String.valueOf(hssfCell.getStringCellValue());
		}
	}

}
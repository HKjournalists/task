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
 * �ο���ַ��http://hao0610.iteye.com/blog/1160678
 * 
 */
public class XlsMain {

	public static void main(String[] args) throws IOException {
		InputStream is = new FileInputStream("C:/Users/wenghy/Desktop/funPointImport.xls");
		Map[] fieldsToCells = new HashMap[2];
		Map map1=new HashMap();
		Map map2=new HashMap();
		/*
		 *  ���Խ���	
		 *  �������
		 * 	������Ա
		 * 	���Թ���Ա
		 * 	ȱ������
		 * 	�������ʱ��
		 * 	���������
		 * 	�����������
		 * 	������Դ
		 * 	���󼶱�
		 * 	�������ȼ�
		 * 	���ſ���
		 * 	�������
		 * 	��������
		 * 	����������
		 * 	���ʱ��
		 * 	���ԭ��
		 * 	����ʱ��
		 * 	����ʱ��
		 * 	����ʱ��
		 * 	����������	������������	����״̬	�Ƿ��ص�����	ϵͳ����	ϵͳ����	����������	������Ա	��������Ա	�������Ա	����������	��ע	����������	�����������

		 */
		map1.put("���Խ���", "testProgress");
		map1.put("�������", "testSituation");
		map1.put("������Ա", "testPersion");
		map1.put("���Թ���Ա", "distributePersion");
		map1.put("ȱ������", "defectNumber");
		map1.put("����״̬", "currentStatus");
		map1.put("���������", "reqTag");
		map2.put("�����������", "reqName");
		map2.put("���󼶱�", "reqGrade");
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
	 * ��ȡxls�ļ�����
	 * 
	 * @return List<XlsDto>����
	 * @throws IOException
	 * ����/���(i/o)�쳣
	 */
	private List<XlsDto> readXls() throws IOException {
		InputStream is = new FileInputStream("C:/Users/wenghy/Desktop/ģ��.xls");
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
		XlsDto xlsDto = null;
		List<XlsDto> list = new ArrayList<XlsDto>();
		// ѭ��������Sheet
		System.out.println(CellReference.convertNumToColString(0)); 
		System.out.println(CellReference.convertColStringToIndex("A")); 
		
		for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
			HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
			
			if (hssfSheet == null) {
				continue;
			}
			// ѭ����Row
			for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				HSSFRow hssfRow = hssfSheet.getRow(rowNum);
				if (hssfRow == null) {
					continue;
				}
				xlsDto = new XlsDto();
				// ѭ����Cell
				// 0ѧ�� 1���� 2ѧԺ 3�γ��� 4 �ɼ�
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
	 * �õ�Excel���е�ֵ
	 * 
	 * @param hssfCell
	 *            Excel�е�ÿһ������
	 * @return Excel��ÿһ�������е�ֵ
	 */
	@SuppressWarnings("static-access")
	private String getValue(HSSFCell hssfCell) {
		if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
			// ���ز������͵�ֵ
			return String.valueOf(hssfCell.getBooleanCellValue());
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
			// ������ֵ���͵�ֵ
			return String.valueOf(hssfCell.getNumericCellValue());
		} else {
			// �����ַ������͵�ֵ
			return String.valueOf(hssfCell.getStringCellValue());
		}
	}

}
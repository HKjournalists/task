package com.asiainfo.aiga.common;

/**
 * ��ϵ�˼�������������Ķ�������
 * @author 	zhanghu
 *
 */

public interface IObjectType {
	
	//����REQUISITION
	//�ACTIVITY
	//�����FUNCPOINT
	//�汾VERSION
	//֪ͨNOTICE
	//����CABONCOPY
	//�澯ALARM
	//����֧�ֹ����ص����⹤��VIRTUALORDER
	//ֵ���������DUTYPROBLEM
	//������SUBREQ
	//Ա����ѵ����STAFFTRAIN
	//�����ʱ��ı��¼FUNPOINTTIMECHANGE
	//���⹤��VIRTUAL
	
	//���Լƻ� 
	public static final String TESTPLAN = "1";
	//�̻�����
	public static final String SOLIDTESTTASK = "2";
	//��������
	public static final String TESTTASK = "3";
	//����������
	public static final String SUBTESTTASK = "4";
	//�˵���������
	public static final String EAESUBTEST = "5";
	
	//���ܲ���������
	public static final String PERFSUBTEST = "6";
	
	//�û����������������
	public static final String UETTASKT = "7";
	
	//�����������
	public static final String PROBLEM_FOLLOW = "8";
	
	//���ܲ�����������
	public static final String PERFTASK_FOLLOW = "9";
	
	//�Զ�������������
	public static final String AUTOTESTCASE_FOLLOW = "10";
	
	//�̻�����_��ȫ����
	public static final String SOLIDTESTTASK_SECUTEST = "21";
	//�̻�����_���ܲ���
	public static final String SOLIDTESTTASK_PERFTEST = "22";
	//�̻�����_����ɨ��
	public static final String SOLIDTESTTASK_CODESCAN = "23";
	//�̻�����_�Զ��ع����
	public static final String SOLIDTESTTASK_REGRTEST = "24";
	//�̻�����_�ֹ��ع����
	public static final String SOLIDTESTTASK_REGRTEST_HW = "25";
	
}

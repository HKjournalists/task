package com.asiainfo.aiga.common;


/***
 * ��ϵ�����Ͷ���
 * @author lizhongde
 */
public interface IStakeholderType {
	
	 /****************************************************************
	 *                              ���󲿷�(-12~12��ռ��)
	 *****************************************************************/
	 //�������͵ĸ�ϵ��(��ʱ����)
	 //public  static final String STDHOLDETYPE_APPLY = "-1";
	 
	 //�����ύ���͵ĸ�ϵ��(��ʱ����)
	 //public  static final String STDHOLDETYPE_SUBMIT = "0";
	 
	 //�����������͵ĸ�ϵ��
	 public  static final String STDHOLDETYPE_APPROVAL = "2";
	 
	 //���������͵ĸ�ϵ��
	 public  static final String STDHOLDETYPE_COPY = "3";
	 
	 //�����������͵ĸ�ϵ��
	 public  static final String STDHOLDETYPE_DISCUSS = "5";

	 
	 //����ҵ֧������(һ������)
	 public  static final String PROVICE_OPERATION = "8";
	 
	 //��������������
	 public static final String SUB_APPROVAL = "-2";
	 
	 //�������˵ĸ�ϵ��
	 public  static final String STDHOLDETYPE_REQMGR = "9";
	 
	 //�������뱣����Ա
	 public  static final String REQ_INCOME_ASS =  "10";
	 
	 //����֪ͨ��ϵ��
	 public  static final String REQ_NOTICE=  "11";

	 //����������ܸ�����
	 public  static final String REQ_ANALY_COLLECTER =  "12";

	 
	 /****************************************************************
	                              �����(13-16)
	 *****************************************************************/
	 //�����
	 
	 /****************************************************************
	  *                           ȱ�ݲ���(17-30��ռ��)
	 *****************************************************************/
	 public  static final String STDHOLDETYPE_BUGMGR = "17";
	 
	 /****************************************************************
                                �����(31-34)
     *****************************************************************/
     //�����
	 public  static final String STDHOLDETYPE_VER_PLAN = "31";
	 
	 /****************************************************************
                                 ����--����㲿��(35~50��ռ��)
	 *****************************************************************/
     //�����ӿ���ѡ��� �����鳤���为���� �ڵ����õ�
	 public static final String STDHOLDETYPE_LEADER = "35";
	 
	 //ѡ��PSO����ǰ��¼���ǿ����鳤������   psoǣͷ�������ɲ���
	 public static final String STDHOLDETYPE_ASSIGN1 = "36";
	 //��ǰ��¼�˲��� �����鳤���为����
	 public static final String STDHOLDETYPE_ASSIGN2 = "37";
	//��ǰ��¼�˲��� �����鳤 �½������ ��ϵ������ 
	 public static final String STDHOLDETYPE_LEADER_NEWREQP = "38";
}

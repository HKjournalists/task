package com.asiainfo.aiga.common;


/***
 * 干系人类型定义
 * @author lizhongde
 */
public interface IStakeholderType {
	
	 /****************************************************************
	 *                              需求部分(-12~12被占用)
	 *****************************************************************/
	 //申请类型的干系人(暂时不用)
	 //public  static final String STDHOLDETYPE_APPLY = "-1";
	 
	 //需求提交类型的干系人(暂时不用)
	 //public  static final String STDHOLDETYPE_SUBMIT = "0";
	 
	 //需求审批类型的干系人
	 public  static final String STDHOLDETYPE_APPROVAL = "2";
	 
	 //需求抄送类型的干系人
	 public  static final String STDHOLDETYPE_COPY = "3";
	 
	 //需求讨论类型的干系人
	 public  static final String STDHOLDETYPE_DISCUSS = "5";

	 
	 //需求业支负责人(一个或多个)
	 public  static final String PROVICE_OPERATION = "8";
	 
	 //需求子流程审批
	 public static final String SUB_APPROVAL = "-2";
	 
	 //需求负责人的干系人
	 public  static final String STDHOLDETYPE_REQMGR = "9";
	 
	 //需求收入保障人员
	 public  static final String REQ_INCOME_ASS =  "10";
	 
	 //需求通知干系人
	 public  static final String REQ_NOTICE=  "11";

	 //需求分析汇总负责人
	 public  static final String REQ_ANALY_COLLECTER =  "12";

	 
	 /****************************************************************
	                              间隔区(13-16)
	 *****************************************************************/
	 //间隔区
	 
	 /****************************************************************
	  *                           缺陷部分(17-30被占用)
	 *****************************************************************/
	 public  static final String STDHOLDETYPE_BUGMGR = "17";
	 
	 /****************************************************************
                                间隔区(31-34)
     *****************************************************************/
     //间隔区
	 public  static final String STDHOLDETYPE_VER_PLAN = "31";
	 
	 /****************************************************************
                                 需求--需求点部分(35~50被占用)
	 *****************************************************************/
     //开发接口人选择的 开发组长分配负责人 众德设置的
	 public static final String STDHOLDETYPE_LEADER = "35";
	 
	 //选择PSO，当前登录人是开发组长负责人   pso牵头人做集成测试
	 public static final String STDHOLDETYPE_ASSIGN1 = "36";
	 //当前登录人不是 开发组长分配负责人
	 public static final String STDHOLDETYPE_ASSIGN2 = "37";
	//当前登录人不是 开发组长 新建需求点 干系人类型 
	 public static final String STDHOLDETYPE_LEADER_NEWREQP = "38";
}

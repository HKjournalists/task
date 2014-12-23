package com.asiainfo.csc.common.define;

/***
 * 前后台返回信息引用
 * @author lizhongde
 */
public interface IMessageConsts {

	/***************************************************************************
	 *                                      公用部分
	 ***************************************************************************/
	//保存结果引用键
	public static String RESULT_KEY = "retVal";
	
	//保存结果消息引用键
	public static String RESULT_MESSAGE_KEY = "retMsg";
	
	//成功标志
	public static String SUCCESS ="Y";
	
	//失败标志
	public static String FAILURE = "N";
	/***************************************************************************
	 *                                      值班人员管理
	 ***************************************************************************/
	
	//问题提交成功
	public static String PRO_SUBMIT_SUCCESS ="问题提交成功";
	//问题提交失败
	public static String PRO_SUBMIT_FAILURE = "问题提交失败";
	//问题保存成功
	public static String PRO_SAVE_SUCCESS = "问题保存成功";
	//问题保存失败
	public static String PRO_SAVE_FAILURE = "问题保存失败";
	//审批成功
	public static String PRO_APPROVAL_SUCCESS = "问题审批成功";
	//审批失败
	public static String PRO_APPROVAL_FAILURE = "问题审批失败";
	//问题审批信息保存成功
	public static String PRO_APPROVAL_SAVE_SUCCESS ="问题审批信息保存成功";
	//问题审批信息保存失败
	public static String PRO_APPROVAL_SAVE_FAILURE = "问题审批信息保存失败";
	//问题处理信息保存成功
	public static String PRO_DISPOSE_SAVE_SUCCESS = "问题处理信息保存成功";
	//问题处理信息保存失败
	public static String PRO_DISPOSE_SAVE_FAILURE = "问题处理信息保存失败";
	//问题验证信息保存成功
	public static String PRO_VALIDATE_SAVE_SUCCESS = "问题验证信息保存成功";
	//问题验证信息保存失败
	public static String PRO_VALIDATE_SAVE_FAILURE = "问题验证信息保存失败";
	//问题答复信息保存成功
	public static String PRO_REPLY_SAVE_SUCCESS = "问题答复信息保存成功";
	//问题答复信息保存失败
	public static String PRO_REPLY_SAVE_FAILURE = "问题答复信息保存失败";
	
	
	
	/***************************************************************************
	 *                                      需求部分
	 ***************************************************************************/
	//需求提交成功
	public static String REQ_SUBMIT_SUCCESS ="需求提交成功";
	
	//需求提交失败
	public static String REQ_SUBMIT_FAILURE = "需求提交失败";
	
	//信息保存成功
	public static String REQ_SAVE_SUCCESS = "需求保存成功";
	
	//信息保存失败
	public static String REQ_SAVE_FAILURE = "需求保存失败";
	
	//审批成功
	public static String REQ_APPROVAL_SUCCESS = "审批成功";
	
	//审批失败
	public static String REQ_APPROVAL_FAILURE = "审批失败";
	
	//需求审批信息保存成功
	public static String REQ_APPROVAL_SAVE_SUCCESS ="信息保存成功";
	
	//需求审批信息保存失败
	public static String REQ_APPROVAL_SAVE_FAILURE = "信息保存失败";
	
	//删除需求成功
	public static String REQ_DELETE_SUCCESS = "需求删除成功";
	
	//删除需求失败
	public static String REQ_DELETE_FAILUE = "需求删除失败";
	
	//会签保存成功
	public static String REQ_SIGN_SAVE_SUCCESS = "会签信息保存成功";
	
	//会签信息保存失败
	public static String REQ_SIGN_SAVE_FAILURE = "会签信息保存失败";
	
	//会签审批成功
	public static String REQ_SIGN_APPROVAL_SUCCESS = "会签审批成功";
	
	//会签审批失败
	public static String REQ_SIGN_APPROVAL_FAILURE = "会签审批失败";
	
	//需求分析提交成功
	public static String REQ_ANALYSIS_SUBMIT_SUCCESS = "需求分析结果提交成功";
	
	//需求分析提交失败
	public static String REQ_ANALYSIS_SUBMIT_FAILURE = "需求分析结果提交失败";
	
	//需求分析保存成功
	public static String REQ_ANAYLSIS_SAVE_SUCCESS ="需求分析信息保存成功";
	
	//需求分析保存失败
	public static String REQ_ANALYSIS_SAVE_FAILURE = "需求分析信息保存失败";
	
	//需求分配成功
	public static String REQ_ALLOCATION_SUCCESS = "分配成功";
	
	//需求分配失败
	public static String REQ_ALLOCATION_FAILURE = "分配失败";
	
	//需求分配信息保存成功
	public static String REQ_ALLOCATION_SAVE_SUCCESS ="分配信息保存成功";
	
	//需求分配信息保存失败
	public static String REQ_ALLOCATION_SAVE_FAILURE = "分配信息保存失败";
	
	//测试信息保存成功
	public static String REQ_TEST_SAVE_SUCCESS = "测试信息保存成功";
	
	//测试信息保存失败
	public static String REQ_TEST_SAVE_FAILURE = "测试信息保存失败";
	
	//测试信息提交成功
	public static String REQ_TEST_SUCCESS = "测试信息提交成功";
	
	//测试信息提交失败
	public static String REQ_TEST_FAILURE = "测试信息提交失败";
	
	//评价信息保存成功
	public static String REQ_APPRAISE_SAVE_SUCCESS="评价信息保存成功";
	
	//评价信息保存失败
	public static String REQ_APPRAISE_SAVE_FAILURE="评价信息保存失败";
	
	//评价信息提交成功
	public static String REQ_APPRAISE_SUCCESS="评价信息提交成功";
	
	//评价信息提交失败
	public static String REQ_APPRAISE_FAILURE="评价信息提交失败";
	
	/**
	 * 需求接收环节
	 */
	//接收信息保存成功
	public static String REQ_RECEIVE_SAVE_SUCCESS="信息保存成功";
	
	//接收信息保存失败
	public static String REQ_RECEIVE_SAVE_FAILURE="信息保存失败";
	
	//信息提交成功
	public static String REQ_RECEIVE_SUCCESS="信息提交成功";
	
	//信息提交失败
	public static String REQ_RECEIVE_FAILURE="信息提交失败";
	
	/**
	 * 需求开发
	 */
	//接收信息保存成功
	public static String REQ_DEVELOP_SAVE_SUCCESS="信息保存成功";
	
	//接收信息保存失败
	public static String REQ_DEVELOP_SAVE_FAILURE="信息保存失败";
	
	//信息提交成功
	public static String REQ_DEVELOP_SUCCESS="信息提交成功";
	
	//信息提交失败
	public static String REQ_DEVELOP_FAILURE="信息提交失败";
	
	/***
	 * 处理回退任务环节
	 */
	//接收信息保存成功
	public static String REQ_ROLLBACK_SAVE_SUCCESS="信息保存成功";
	
	//接收信息保存失败
	public static String REQ_ROLLBACK_SAVE_FAILURE="信息保存失败";
	
	//信息提交成功
	public static String REQ_ROLLBACK_SUCCESS="信息提交成功";
	
	//信息提交失败
	public static String REQ_ROLLBACK_FAILURE="信息提交失败";
	
	/**************************************************************************************
	 *                                        需求点部分
	 **************************************************************************************/
	//未传入要操作的需求点数据
	public static String REQP_DATA_EMPTY = "未传入要操作的需求点数据";
	
	//需求点信息保存成功
	public static String REQP_SAVE_SUCCESS = "需求点信息保存成功";
	
	//需求点信息保存失败
	public static String REQP_SAVE_FAILURE = "需求点信息保存失败";
	
	//需求点信息删除成功
	public static String REQP_DELETE_SUCCESS = "需求点信息删除成功";
	
	//需求点信息删除失败
	public static String REQP_DELETE_FAILURE = "需求点信息删除失败";
	
	//需求分析任务提交成功
	public static String REQP_ANAYLSISTASK_SUBMIT_SUCCESS = "需求分析任务提交成功";
	
	//需求分析任务提交失败
	public static String REQP_ANAYLSISTASK_SUBMIT_FAILURE = "需求分析任务提交失败";
	
	//需求分析任务保存成功
	public static String REQP_ANALYSISTASK_SAVE_SUCCESS ="需求分析任务保存成功";
	
	//需求分析任务保存失败
	public static String REQP_ANALYSISTASK_SVAE_FAILURE = "需求分析任务保存失败";
	
	/**************************************************************************************
	 *                                        需求讨论部分
	 **************************************************************************************/
	//讨论信息保存成功
	public static String REQ_DISCUSS_SAVE_SUCCESS = "信息保存成功";
	
	//讨论信息保存失败
	public static String REQ_DISCUSS_SVAE_FAILURE  = "信息保存失败";
	
	//讨论信息删除成功
	public static String REQ_DISCUSS_DELETE_SUCCESS  = "信息删除成功";
	
	//讨论信息删除失败
	public static String REQ_DISCUSS_DELETE_FAILURE = "信息删除失败";
	
	//讨论发起成功
	public static String REQ_DISCUSS_START_SUCCESS = "讨论发起成功";
	
	//讨论发起失败
	public static String REQ_DISCUSS_START_FAILURE = "讨论发起失败";
	
	//讨论关闭成功
	public static String REQ_DISCUSS_COLSE_SUCCESS = "讨论关闭成功";
	
	//讨论关闭失败
	public static String REQ_DISCUSS_CLOSE_FAILURE = "讨论关闭失败";
	
	//关闭提示(信息提交失败)
	public static String REQ_DISCUSS_SVAE_FAILURE_CAUSE = "信息未提交,讨论主题已被关闭";
	
	//讨论组信息保存成功
	public static String REQ_STAKHOLDER_GROUP_SAVE_SUCCESS = "讨论组信息保存成功";
	
	//讨论组信息保存成功
	public static String REQ_STAKHOLDER_GROUP_SAVE_FAILURE = "讨论组信息保存失败";
	
	//人员添加成功
	public static String REQ_STAKHOLDER_ADD_SUCCESS = "人员添加成功";
	
	//人员添加失败
	public static String REQ_STAKHOLDER_ADD_FAILURE = "人员添加失败";

	/**************************************************************************************
	 *                                        工单转派部分
	 **************************************************************************************/
	//讨论信息保存成功
	public static String WO_DISCUSS_SAVE_SUCCESS = "工单转派成功";
	
	//讨论信息保存失败
	public static String WO_DISCUSS_SVAE_FAILURE  = "工单转派失败";
	/**************************************************************************************
	 *                                        其他部分
	 **************************************************************************************/
	//讨论信息保存成功
	public static String WO_RECEIVE_SUCCESS = "信息接收成功";
	
	//讨论信息保存失败
	public static String WO_RECEIVE_FAILURE  = "信息接收失败";
	
	//批量操作成功
	public static String BATCH_SUCCESS = "批量操作成功";
	
	//批量操作失败
	public static String BATCH_FAILURE  = "批量操作失败";
	
//	上传工时专用
	public static String WORKHOUR_DISPOSE_SUCCESS ="文件处理成功";
	public static String WORKHOUR_DISPOSE_FAILURE ="文件处理失败";
	public static String WORKHOUR_DISPOSE_ERROR ="文件类型错误，请上传Excel文件";
	
	//处理成功
	public static String PROCESS_SUCCESS = "处理成功";
	//处理失败
	public static String PROCESS_FAILURE  = "处理失败";
}

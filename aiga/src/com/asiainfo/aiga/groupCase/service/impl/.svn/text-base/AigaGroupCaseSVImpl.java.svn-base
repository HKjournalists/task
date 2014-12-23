package com.asiainfo.aiga.groupCase.service.impl;

import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.xls.XlsHelper;
import com.asiainfo.aiga.groupCase.bo.AigaGroupCase;
import com.asiainfo.aiga.groupCase.bo.AigaHisGroupCase;
import com.asiainfo.aiga.groupCase.bo.AigaRGroupChangeCase;
import com.asiainfo.aiga.groupCase.bo.AigaRGroupSubCase;
import com.asiainfo.aiga.groupCase.dao.IAigaGroupCaseDAO;
import com.asiainfo.aiga.groupCase.service.IAigaGroupCaseSV;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugReqForm;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugSubTaskForm;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugTaskForm;
import com.asiainfo.aiga.groupJointDebug.dao.IAigaJointDebugDao;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;

public class AigaGroupCaseSVImpl implements IAigaGroupCaseSV {

	private IAigaGroupCaseDAO aigaGroupCaseDAO;
	
	private IAigaJointDebugDao aigaJointDebugDao;

	public IAigaJointDebugDao getAigaJointDebugDao() {
		return aigaJointDebugDao;
	}

	public void setAigaJointDebugDao(IAigaJointDebugDao aigaJointDebugDao) {
		this.aigaJointDebugDao = aigaJointDebugDao;
	}
	
	public void setAigaGroupCaseDAO(IAigaGroupCaseDAO aigaGroupCaseDAO) {
		this.aigaGroupCaseDAO = aigaGroupCaseDAO;
	}
	
	@Override
	public AigaGroupCase[] getGroupCase(Integer caseId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaGroupCase.class);
		criteria.add(Restrictions.eq("caseId", caseId));
		return aigaGroupCaseDAO.getGroupCase(criteria);
	}

	@Override
	public void saveGroupCase(AigaGroupCase aValue, AigaUser user) throws Exception {
		AigaHisGroupCase aigaHisGroupCase = new AigaHisGroupCase();
		aigaHisGroupCase.setCaseId(aValue.getCaseId());
		aigaHisGroupCase.setCaseName(aValue.getCaseName());
		aigaHisGroupCase.setCaseDesc(aValue.getCaseDesc());
		aigaHisGroupCase.setTestPurpose(aValue.getTestPurpose());
		aigaHisGroupCase.setPreCondition(aValue.getPreCondition());
		aigaHisGroupCase.setTestDataDesc(aValue.getTestDataDesc());
		aigaHisGroupCase.setTestStep(aValue.getTestStep());
		aigaHisGroupCase.setRemark(aValue.getRemark());
		aigaHisGroupCase.setIsLeaf(aValue.getIsLeaf());
		aigaHisGroupCase.setParentId(aValue.getParentId());
		aigaHisGroupCase.setCreateTime(aValue.getCreateTime());
		aigaHisGroupCase.setCreatorId(Integer.parseInt(String.valueOf(aValue.getCreatorId())));
		aigaHisGroupCase.setCreatorName(aValue.getCreatorName());
		aigaHisGroupCase.setIsDelete(aValue.getIsDelete());
		aigaHisGroupCase.setPreResult(aValue.getPreResult());
		aigaHisGroupCase.setIsNeedMessage(aValue.getIsNeedMessage());
		aigaHisGroupCase.setOprationTime(new Timestamp(System.currentTimeMillis()));
		aigaHisGroupCase.setOpratorId(Integer.parseInt(String.valueOf(user.getUserId())));
		aigaHisGroupCase.setOpratorName(user.getUserName());
		aigaHisGroupCase.setOprationType("modify");
		aigaGroupCaseDAO.saveOrUpdate(aigaHisGroupCase);//保存历史
		aigaGroupCaseDAO.saveOrUpdate(aValue);//保存信息
	}

	@Override
	public AigaGroupCase[] getGroupCaseByParentId(Integer parentId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaGroupCase.class);
		criteria.add(Restrictions.eq("parentId", parentId));
		return aigaGroupCaseDAO.getGroupCase(criteria);
	}

	public void saveGroupCaseForExcel(List<FileItem> fileItems, String subTaskId, String subType, AigaUser user)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		for (FileItem item : fileItems) {
			if (!item.isFormField()) {
				 String name = item.getName();
				 //resultMap.put("fileName", name);
				// 获取上传文件
				Map[] fieldsToCells = new HashMap[1];
				Map<String,String> map1 = new HashMap<String,String>();
			    map1.put("年月", "yearMonth");
			    map1.put("联调需求编号", "jointDebugReqTag");
				map1.put("用例名称", "caseName");
				map1.put("用例描述", "caseDesc");
				map1.put("测试目的", "testPurpose");
				map1.put("预置条件", "preCondition");
			    map1.put("测试数据描述", "testDataDesc");
				map1.put("测试步骤", "testStep");
				map1.put("预期结果", "preResult");
			    map1.put("备注", "remark");
			    map1.put("是否需要造报文", "isNeedMessage");
				fieldsToCells[0] = map1;
				InputStream in = item.getInputStream();
				Object[] objs = XlsHelper.transFuncXlsToObjs(in,fieldsToCells, new Class[] {AigaGroupCase.class});
				List groupCaseList =null;
				groupCaseList= (List) objs[0];
				List<AigaGroupCase> lastGroupCaseObjList=new ArrayList<AigaGroupCase>();
				for (int j = 0, m = groupCaseList.size(); j < m; j++) {
					AigaGroupCase groupCase = new AigaGroupCase();
					groupCase=groupCaseList.get(j) instanceof AigaGroupCase?(AigaGroupCase)groupCaseList.get(j):null;
					lastGroupCaseObjList.add(groupCase);
				}
				int rowNum = 1;
				//脏数据标识
				boolean errorFalg = true;
				//缓存集团联调需求编号名称(key--Tag:value--AigaJointDebugReqForm)
				Map<String,AigaJointDebugReqForm> tagNameMap = new HashMap<String, AigaJointDebugReqForm>();
				//检查数据的完整性
				for(AigaGroupCase groupCase:lastGroupCaseObjList){
					AigaGroupCase[] groupCases = new AigaGroupCase[]{groupCase};
					//必填字段是否为空
					if(groupCases[0].getYearMonth().equals("")||groupCases[0].getYearMonth()==null||
							groupCases[0].getJointDebugReqTag().equals("")||groupCases[0].getJointDebugReqTag()==null||
							groupCases[0].getCaseName().equals("")||groupCases[0].getCaseName()==null||
							groupCases[0].getCaseDesc().equals("")||groupCases[0].getCaseDesc()==null||
							groupCases[0].getTestPurpose().equals("")||groupCases[0].getTestPurpose()==null||
							groupCases[0].getPreCondition().equals("")||groupCases[0].getPreCondition()==null||
							groupCases[0].getPreResult().equals("")||groupCases[0].getPreResult()==null||
							groupCases[0].getTestDataDesc().equals("")||groupCases[0].getTestDataDesc()==null||
							groupCases[0].getTestStep().equals("")||groupCases[0].getTestStep()==null||
							groupCases[0].getIsNeedMessage().toString().equals("")||groupCases[0].getIsNeedMessage()==null){
						errorFalg = false;
						throw new Exception("请检查第"+rowNum+"行的必填数据是否完整或者可以填无,或者这行区域存在脏数据");
					}
					//缓存中是否存在相应的集团联调需求.
					if(tagNameMap.get(groupCases[0].getJointDebugReqTag())==null){
						DetachedCriteria criteria = DetachedCriteria.forClass(AigaJointDebugReqForm.class);
						criteria.add(Restrictions.eq("reqTag", groupCases[0].getJointDebugReqTag()));//集团联调需求
						AigaJointDebugReqForm[] aigaJointDebugReqForm = aigaJointDebugDao.getAigaJointDebugReqForm(criteria);
						if(aigaJointDebugReqForm.length!=1){ 
							throw new Exception("请检查第"+rowNum+"行的集团联调需求单编号,<br/>系统中查找不到该集团调试需求.");
						}
						//将新的数据放入缓存中.
						tagNameMap.put(groupCases[0].getJointDebugReqTag(), aigaJointDebugReqForm[0]);
					}
					rowNum++;
				}
				if(errorFalg){//校验通过执行存储
					//缓存一级结点(年月)信息.(key--caseNameparentId:value--AigaGroupCase)
					Map<String,AigaGroupCase> yearMonthCacheMap = new HashMap<String, AigaGroupCase>();
					//缓存二级结点(集团联调任务)信息.(key--taskTagparentId:value--AigaGroupCase)
					Map<String,AigaGroupCase> jointDebugTaskCacheMap = new HashMap<String, AigaGroupCase>();
					//缓存三级结点(系统子类)信息.(key--subTypeConstantparentId:value--AigaGroupCase)
					Map<String,AigaGroupCase> subTypeCacheMap = new HashMap<String, AigaGroupCase>();
					SysConstant[] sysContants=SysContentUtil.getSysContant("AigaJointDebugTaskForm");//获取相应的子系统常量
					Map<String,SysConstant> subTypeMap = new HashMap<String, SysConstant>();//系统常量列表
					for (SysConstant sysConstant : sysContants) {
						if (!sysConstant.getCategoryName().equals("subType"))continue;
						subTypeMap.put(sysConstant.getValue().toString(), sysConstant);
					}
					for(AigaGroupCase groupCase:lastGroupCaseObjList){
						//检测缓存中是否有该一级结点(年月),没有则查询并放入缓存中.
						if(yearMonthCacheMap.get(groupCase.getYearMonth()+"-1")==null){
							DetachedCriteria criteria = DetachedCriteria.forClass(AigaGroupCase.class);
							criteria.add(Restrictions.eq("caseName", groupCase.getYearMonth()));//年月
							AigaGroupCase[] groupCases= aigaGroupCaseDAO.getGroupCase(criteria);
							//数据库中不存在,则往数据库中新增该一级结点(年月).
							if(groupCases==null||groupCases.length==0){
								AigaGroupCase aigaGroupCase = new AigaGroupCase();
								aigaGroupCase.setCaseName(groupCase.getYearMonth());
								aigaGroupCase.setIsLeaf("N");
								aigaGroupCase.setParentId(-1);
								aigaGroupCaseDAO.saveOrUpdate(aigaGroupCase);
								//将持久化的数据放入缓存中
								yearMonthCacheMap.put(aigaGroupCase.getCaseName()+"-1", aigaGroupCase);
							//存在该一级结点(年月),则存入缓存中.
							}else if(groupCases.length==1)
								yearMonthCacheMap.put(groupCases[0].getCaseName()+"-1", groupCases[0]);
							//存在多个则说明数据存在问题
							else
								throw new Exception("一级结点存在多个同名的数据(年月)!");//throw exception
						}
						//检测缓存中是否有该二级结点(集团联调需求),没有则查询并放入缓存中.
						if(jointDebugTaskCacheMap.get(groupCase.getJointDebugReqTag()+yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId())==null){
							//查询指定的二级结点下是否存在相应的集团联调需求.
							DetachedCriteria criteria = DetachedCriteria.forClass(AigaGroupCase.class);
							criteria.add(Restrictions.eq("parentId", yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId()));
							//数据格式:集团联调需求名称(集团联调需求编号)
							criteria.add(Restrictions.eq("caseName", tagNameMap.get(groupCase.getJointDebugReqTag()).getReqName()+"("+groupCase.getJointDebugReqTag()+")"));//集团联调测试任务
							AigaGroupCase[] groupCases= aigaGroupCaseDAO.getGroupCase(criteria);
							//数据库中不存在,则往数据库中新增该二级结点(集团联调需求).
							if(groupCases==null||groupCases.length==0){
								AigaGroupCase aigaGroupCase = new AigaGroupCase();
								aigaGroupCase.setCaseName(tagNameMap.get(groupCase.getJointDebugReqTag()).getReqName()+"("+groupCase.getJointDebugReqTag()+")");
								aigaGroupCase.setIsLeaf("N");
								aigaGroupCase.setParentId(yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId());
								aigaGroupCaseDAO.saveOrUpdate(aigaGroupCase);
								//将持久化的数据放入缓存中
								jointDebugTaskCacheMap.put(groupCase.getJointDebugReqTag()+yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId(), aigaGroupCase);
							//存在该二级结点(集团联调需求),则存入缓存中.
							}else if(groupCases.length==1)
								jointDebugTaskCacheMap.put(groupCase.getJointDebugReqTag()+yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId(), groupCases[0]);
							//存在多个则说明数据存在问题
							else
								throw new Exception("二级结点存在多个同名的数据(集团联调需求)!");//throw exception
						}
						//根据常量表把子系统右数值转换成中文显示
						groupCase.setSubType(subTypeMap.get(subType).getShow());
						//检测缓存中是否有该三级结点(系统子类),没有则查询并放入缓存中.
						if(subTypeCacheMap.get(groupCase.getSubType()+jointDebugTaskCacheMap.get(groupCase.getJointDebugReqTag()+yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId()).getCaseId())==null){
							//查询指定的三级结点下是否存在相应的系统子类.
							DetachedCriteria criteria = DetachedCriteria.forClass(AigaGroupCase.class);
							criteria.add(Restrictions.eq("parentId", jointDebugTaskCacheMap.get(groupCase.getJointDebugReqTag()+yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId()).getCaseId()));
							criteria.add(Restrictions.eq("caseName", groupCase.getSubType()));//系统子类
							AigaGroupCase[] groupCases= aigaGroupCaseDAO.getGroupCase(criteria);
							//数据库中不存在,则往数据库中新增该三级结点(系统子类).
							if(groupCases==null||groupCases.length==0){
								AigaGroupCase aigaGroupCase = new AigaGroupCase();
								aigaGroupCase.setCaseName(groupCase.getSubType());
								aigaGroupCase.setIsLeaf("N");
								aigaGroupCase.setParentId(jointDebugTaskCacheMap.get(groupCase.getJointDebugReqTag()+yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId()).getCaseId());
								aigaGroupCaseDAO.saveOrUpdate(aigaGroupCase);
								//将持久化的数据放入缓存中
								subTypeCacheMap.put(groupCase.getSubType()+jointDebugTaskCacheMap.get(groupCase.getJointDebugReqTag()+yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId()).getCaseId(), aigaGroupCase);
							//存在该三级结点(系统子类),则存入缓存中.
							}else if(groupCases.length==1)
								subTypeCacheMap.put(groupCase.getSubType()+jointDebugTaskCacheMap.get(groupCase.getJointDebugReqTag()+yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId()).getCaseId(), groupCases[0]);
							//存在多个则说明数据存在问题
							else
								throw new Exception("三级结点存在多个同名的数据(系统子类)!");//throw exception
							
						}
						//以上数据全部校验通过说明可以存储.
						//设置用例的父级结点的ID.
						groupCase.setParentId(subTypeCacheMap.get(groupCase.getSubType()+jointDebugTaskCacheMap.get(groupCase.getJointDebugReqTag()+yearMonthCacheMap.get(groupCase.getYearMonth()+"-1").getCaseId()).getCaseId()).getCaseId());
						groupCase.setIsLeaf("Y");
						groupCase.setCreateTime(new Timestamp(System.currentTimeMillis()));
						groupCase.setCreatorId(new BigDecimal(user.getUserId()));
						groupCase.setCreatorName(user.getUserName());
						groupCase.setIsDelete(Short.valueOf("1"));
						//存储用例
						aigaGroupCaseDAO.saveOrUpdate(groupCase);
						//存储历史
						AigaHisGroupCase aigaHisGroupCase = new AigaHisGroupCase();
						aigaHisGroupCase.setCaseId(groupCase.getCaseId());
						aigaHisGroupCase.setCaseName(groupCase.getCaseName());
						aigaHisGroupCase.setCaseDesc(groupCase.getCaseDesc());
						aigaHisGroupCase.setTestPurpose(groupCase.getTestPurpose());
						aigaHisGroupCase.setPreCondition(groupCase.getPreCondition());
						aigaHisGroupCase.setTestDataDesc(groupCase.getTestDataDesc());
						aigaHisGroupCase.setTestStep(groupCase.getTestStep());
						aigaHisGroupCase.setRemark(groupCase.getRemark());
						aigaHisGroupCase.setIsLeaf(groupCase.getIsLeaf());
						aigaHisGroupCase.setParentId(groupCase.getParentId());
						aigaHisGroupCase.setCreateTime(groupCase.getCreateTime());
						aigaHisGroupCase.setCreatorId(Integer.parseInt(String.valueOf(groupCase.getCreatorId())));
						aigaHisGroupCase.setCreatorName(groupCase.getCreatorName());
						aigaHisGroupCase.setIsDelete(groupCase.getIsDelete());
						aigaHisGroupCase.setPreResult(groupCase.getPreResult());
						aigaHisGroupCase.setIsNeedMessage(groupCase.getIsNeedMessage());
						aigaHisGroupCase.setOprationTime(new Timestamp(System.currentTimeMillis()));
						aigaHisGroupCase.setOpratorId(Integer.parseInt(String.valueOf(user.getUserId())));
						aigaHisGroupCase.setOpratorName(user.getUserName());
						aigaHisGroupCase.setOprationType("add");
						aigaGroupCaseDAO.saveOrUpdate(aigaHisGroupCase);//保存历史
						//存储用例和子任务的管理关系
						AigaRGroupSubCase aigaRGroupSubCase = new AigaRGroupSubCase();
						aigaRGroupSubCase.setCaseId(groupCase.getCaseId());
						aigaRGroupSubCase.setSubTaskId(Integer.parseInt(subTaskId));
						aigaGroupCaseDAO.saveOrUpdateAigaRGroupSubCase(aigaRGroupSubCase);
					}
				}
			}
		}
	}

	@Override
	public AigaGroupCase[] getGroupCaseListBySubTaskId(String subTaskId)
			throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRGroupSubCase.class);
		criteria.add(Restrictions.eq("subTaskId", Integer.parseInt(subTaskId)));
		AigaRGroupSubCase[] aigaRGroupSubCases = aigaGroupCaseDAO.getAigaRGroupSubCase(criteria);
		if(aigaRGroupSubCases.length>=1){
			//暂时存储当前子任务关联的所有的用例的ID
			List<Integer> caseIdList = new LinkedList<Integer>();
			for(AigaRGroupSubCase aigaRGroupSubCase : aigaRGroupSubCases){
				caseIdList.add(aigaRGroupSubCase.getCaseId());
			}
			criteria = DetachedCriteria.forClass(AigaGroupCase.class);
			criteria.add(Restrictions.in("caseId", caseIdList));
			return aigaGroupCaseDAO.getGroupCase(criteria);
		}else{
			return null;
		}
		
	}

	@Override
	public AigaGroupCase[] getGroupCaseTreeByTaskTag(String taskTag)
			throws Exception {
		//查找关联的集团联调任务单
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaJointDebugTaskForm.class);
		criteria.add(Restrictions.eq("taskTag", taskTag));
		AigaJointDebugTaskForm[] aigaJointDebugTaskForms = aigaJointDebugDao.getAigaJointDebugTaskForm(criteria);
	 	if(aigaJointDebugTaskForms.length==1){
	 		//查找关联的集团联调需求单
			criteria = DetachedCriteria.forClass(AigaJointDebugReqForm.class);
			criteria.add(Restrictions.eq("reqTag",aigaJointDebugTaskForms[0].getReqTag()));
			AigaJointDebugReqForm[] aigaJointDebugReqForms = aigaJointDebugDao.getAigaJointDebugReqForm(criteria);
			if(aigaJointDebugReqForms.length==1){
				//查找用例树中集团联调需求(二级结点)
				criteria = DetachedCriteria.forClass(AigaGroupCase.class);
				criteria.add(Restrictions.eq("caseName", aigaJointDebugReqForms[0].getReqName()+"("+aigaJointDebugReqForms[0].getReqTag()+")"));
				AigaGroupCase[] reqTagNodeAigaGroupCases = aigaGroupCaseDAO.getGroupCase(criteria);
				return reqTagNodeAigaGroupCases;
				
			}else{
				return null;
			}
		}else{
			return null;
		}
	}

	@Override
	public AigaGroupCase[] getGroupCaseTreeByChildrenNodeIdList(
			Set<Integer> yearMonthNodeIdList) throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaGroupCase.class);
		criteria.add(Restrictions.in("caseId", yearMonthNodeIdList));
		return aigaGroupCaseDAO.getGroupCase(criteria);
	}

	@Override
	public void saveGroupCaseByChange(AigaGroupCase aValue,
			String contentsType, String subTaskTag, AigaUser user) throws Exception {
		AigaHisGroupCase aigaHisGroupCase = new AigaHisGroupCase();
		aigaHisGroupCase.setCaseId(aValue.getCaseId());
		aigaHisGroupCase.setCaseName(aValue.getCaseName());
		aigaHisGroupCase.setCaseDesc(aValue.getCaseDesc());
		aigaHisGroupCase.setTestPurpose(aValue.getTestPurpose());
		aigaHisGroupCase.setPreCondition(aValue.getPreCondition());
		aigaHisGroupCase.setTestDataDesc(aValue.getTestDataDesc());
		aigaHisGroupCase.setTestStep(aValue.getTestStep());
		aigaHisGroupCase.setRemark(aValue.getRemark());
		aigaHisGroupCase.setIsLeaf(aValue.getIsLeaf());
		aigaHisGroupCase.setParentId(aValue.getParentId());
		aigaHisGroupCase.setCreateTime(aValue.getCreateTime());
		aigaHisGroupCase.setCreatorId(Integer.parseInt(String.valueOf(aValue.getCreatorId())));
		aigaHisGroupCase.setCreatorName(aValue.getCreatorName());
		aigaHisGroupCase.setIsDelete(aValue.getIsDelete());
		aigaHisGroupCase.setPreResult(aValue.getPreResult());
		aigaHisGroupCase.setIsNeedMessage(aValue.getIsNeedMessage());
		aigaHisGroupCase.setOprationTime(new Timestamp(System.currentTimeMillis()));
		aigaHisGroupCase.setOpratorId(Integer.parseInt(String.valueOf(user.getUserId())));
		aigaHisGroupCase.setOpratorName(user.getUserName());
		if(contentsType.equals("1")){//内容
			aigaHisGroupCase.setOprationType("用例内容变更");
		}else if(contentsType.equals("2")){//报文
			aigaHisGroupCase.setOprationType("是否造报文变更");
		}else if(contentsType.equals("3")){//状态
			aigaHisGroupCase.setOprationType("用例状态变更");
		}else{//数据出错
			aigaHisGroupCase.setOprationType("未知");
		}
		aigaGroupCaseDAO.saveOrUpdate(aigaHisGroupCase);//保存历史
		aigaGroupCaseDAO.saveOrUpdate(aValue);//保存信息
	}

	@Override
	public AigaGroupCase[] getGroupCaseListByChangeId(String changeId)
			throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRGroupChangeCase.class);
		criteria.add(Restrictions.eq("changeId", Integer.parseInt(changeId)));
		AigaRGroupChangeCase[] aigaRGroupChangeCases = aigaGroupCaseDAO.getAigaRGroupChangeCase(criteria);
		if(aigaRGroupChangeCases.length>=1){
			//暂时存储当前子任务关联的所有的用例的ID0
			List<Integer> caseIdList = new LinkedList<Integer>();
			for(AigaRGroupChangeCase aigaRGroupChangeCase : aigaRGroupChangeCases){
				caseIdList.add(aigaRGroupChangeCase.getCaseId());
			}
			criteria = DetachedCriteria.forClass(AigaGroupCase.class);
			criteria.add(Restrictions.in("caseId", caseIdList));
			return aigaGroupCaseDAO.getGroupCase(criteria);
		}else{
			return null;
		}
	}

	@Override
	public AigaGroupCase[] getGroupCaseListBySubTaskTag(String subTaskTag)
			throws Exception {
		//获取子任务
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaJointDebugSubTaskForm.class);
		criteria.add(Restrictions.eq("subTaskTag", subTaskTag));
		AigaJointDebugSubTaskForm[] aigaJointDebugSubTaskForms = aigaJointDebugDao.getAigaJointDebugSubTaskForm(criteria);
		if(aigaJointDebugSubTaskForms.length == 1){
			criteria = DetachedCriteria.forClass(AigaRGroupSubCase.class);
			criteria.add(Restrictions.eq("subTaskId", aigaJointDebugSubTaskForms[0].getSubTaskId()));
			AigaRGroupSubCase[] aigaRGroupSubCases = aigaGroupCaseDAO.getAigaRGroupSubCase(criteria);
			if(aigaRGroupSubCases.length>=1){
				//暂时存储当前子任务关联的所有的用例的ID
				List<Integer> caseIdList = new LinkedList<Integer>();
				for(AigaRGroupSubCase aigaRGroupSubCase : aigaRGroupSubCases){
					caseIdList.add(aigaRGroupSubCase.getCaseId());
				}
				criteria = DetachedCriteria.forClass(AigaGroupCase.class);
				criteria.add(Restrictions.in("caseId", caseIdList));
				return aigaGroupCaseDAO.getGroupCase(criteria);
			}else{
				return null;
			}
		}else{
			return null;
		}
		
	}

}

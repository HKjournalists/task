package com.asiainfo.aiga.funCaseRela.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.funCaseRela.bo.AigaFunCaseRela;
import com.asiainfo.aiga.funCaseRela.bo.AigaHisFunCaseRela;
import com.asiainfo.aiga.funCaseRela.dao.IAigaFunCaseRelaDAO;
import com.asiainfo.aiga.funCaseRela.service.IAigaFunCaseRelaSV;

public class AigaFunCaseRelaSVImpl implements IAigaFunCaseRelaSV {

	private IAigaFunCaseRelaDAO funCaseRelaDAO;

	public void setFunCaseRelaDAO(IAigaFunCaseRelaDAO funCaseRelaDAO) {
		this.funCaseRelaDAO = funCaseRelaDAO;
	}

	@Override
	public List getObjectBySQL(String querySql) throws Exception {
		return funCaseRelaDAO.getObjectBySQL(querySql);
	}

	@Override
	public void saveNewFunCaseRela(Integer funId, String caseIds)throws Exception {
		if(StringUtils.isNotBlank(caseIds)){
			AigaFunCaseRela[] aigaFunCaseRelas=funCaseRelaDAO.getAigaCaseRelaBySql(" from AigaFunCaseRela where relaType='owner' and caseId in ("+caseIds+")");
			AigaFunCaseRela[] newAigaFunCaseRelas=createNewAigaFunCaseRela(aigaFunCaseRelas,funId);
			funCaseRelaDAO.saveOrUpdateAll(newAigaFunCaseRelas);
			AigaHisFunCaseRela[] aigaHisFunCaseRelas=convert(newAigaFunCaseRelas,"add");
			funCaseRelaDAO.saveOrUpdateAll(aigaHisFunCaseRelas);
		}
	}
	

	@Override
	public void deleteFunCaseRela(Integer funId, String caseIds)
			throws Exception {
		if(StringUtils.isNotBlank(caseIds)){
			AigaFunCaseRela[] aigaFunCaseRelas=funCaseRelaDAO.getAigaCaseRelaBySql(" from AigaFunCaseRela where relaType='quote' and folder_id="+funId+" and caseId in ("+caseIds+")");
			AigaHisFunCaseRela[] aigaHisFunCaseRelas=convert(aigaFunCaseRelas,"delete");
			funCaseRelaDAO.saveOrUpdateAll(aigaHisFunCaseRelas);
			funCaseRelaDAO.deleteAll(aigaFunCaseRelas);
		}
		
	}

	@Override
	public AigaFunCaseRela[] getAigaFunCaseRelaBySql(String querySql)
			throws Exception {
		return funCaseRelaDAO.getAigaCaseRelaBySql(querySql);
	}
	
	private AigaFunCaseRela[] createNewAigaFunCaseRela(AigaFunCaseRela[] aigaFunCaseRelas,Integer folderId)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		AigaUser user=(AigaUser)request.getSession().getAttribute("aigaUser");
		if(aigaFunCaseRelas!=null&&aigaFunCaseRelas.length>0&&aigaFunCaseRelas[0]!=null){
			AigaFunCaseRela[] newAigaFunCaseRelas=new AigaFunCaseRela[aigaFunCaseRelas.length];
			for(int i=0;i<aigaFunCaseRelas.length;i++){
				AigaFunCaseRela newValue=new AigaFunCaseRela();
				newValue.setFolderId(folderId);
				newValue.setTestType(aigaFunCaseRelas[i].getTestType());
				newValue.setCaseId(aigaFunCaseRelas[i].getCaseId());
				newValue.setRelaType("quote");
				newValue.setParentFolderId(aigaFunCaseRelas[i].getFolderId());
				newValue.setQuoteTime(new Timestamp((new Date()).getTime()));
				newValue.setUpdateTime(new Timestamp((new Date()).getTime()));
				newValue.setLatestOperator(user.getUserName());
				newAigaFunCaseRelas[i]=newValue;
			}
			return newAigaFunCaseRelas;
		}else{
			return null;
		}
		
	}
	@Override
	public AigaHisFunCaseRela[] convert(AigaFunCaseRela[] newAigaFunCaseRelas,String operateType)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String subTaskTag = request.getSession().getAttribute("subTaskTag").toString();
		String normalMac = CommonHelper.decodeCN(request.getSession().getAttribute("normalMac").toString());
		String temporaryTag = request.getSession().getAttribute("TemporaryTag").toString();
		AigaUser user=(AigaUser)request.getSession().getAttribute("aigaUser");
		if(newAigaFunCaseRelas!=null&&newAigaFunCaseRelas.length>0&&newAigaFunCaseRelas[0]!=null){
			AigaHisFunCaseRela[] aigaHisFunCaseRelas=new AigaHisFunCaseRela[newAigaFunCaseRelas.length];
			for(int i=0;i<newAigaFunCaseRelas.length;i++){
				AigaHisFunCaseRela aigaHisFunCaseRela=new AigaHisFunCaseRela();
				aigaHisFunCaseRela.setRelaId(newAigaFunCaseRelas[i].getRelaId());
				aigaHisFunCaseRela.setFolderId(newAigaFunCaseRelas[i].getFolderId());
				aigaHisFunCaseRela.setCaseId(newAigaFunCaseRelas[i].getCaseId());
				aigaHisFunCaseRela.setRelaType(newAigaFunCaseRelas[i].getRelaType());
				aigaHisFunCaseRela.setParentFolderId(newAigaFunCaseRelas[i].getParentFolderId());
				aigaHisFunCaseRela.setOperateTime(newAigaFunCaseRelas[i].getUpdateTime());
				aigaHisFunCaseRela.setLatestOperator(user.getUserName());
				aigaHisFunCaseRela.setRegressionTest(newAigaFunCaseRelas[i].getEfficiencyTest());
				aigaHisFunCaseRela.setEfficiencyTest(newAigaFunCaseRelas[i].getEfficiencyTest());
				aigaHisFunCaseRela.setEfficiencyTestType(newAigaFunCaseRelas[i].getEfficiencyTestType());
				aigaHisFunCaseRela.setTeminalTest(newAigaFunCaseRelas[i].getTeminalTest());
				aigaHisFunCaseRela.setHasTest(newAigaFunCaseRelas[i].getHasTest());
				aigaHisFunCaseRela.setIsAvailAuto(newAigaFunCaseRelas[i].getIsAvailAuto());
				aigaHisFunCaseRela.setIsFinishAuto(newAigaFunCaseRelas[i].getIsFinishAuto());
				aigaHisFunCaseRela.setOperateType(operateType);
				aigaHisFunCaseRela.setSubTaskTag(subTaskTag);
				aigaHisFunCaseRela.setTemporaryTag(temporaryTag);
				aigaHisFunCaseRela.setNormalMac(normalMac);
				aigaHisFunCaseRela.setEditType(StringUtils.isNotBlank(subTaskTag)?1:(StringUtils.isNotBlank(normalMac)?2:(StringUtils.isNotBlank(temporaryTag)?3:null)));
				aigaHisFunCaseRela.setTestType(newAigaFunCaseRelas[i].getTestType());
				aigaHisFunCaseRelas[i]=aigaHisFunCaseRela;
			}
			return aigaHisFunCaseRelas;
		}else{
			return null;
		}
	}

	@Override
	public AigaHisFunCaseRela[] getHisAigaFunCaseRelaBySql(String querySql) throws Exception {
		return funCaseRelaDAO.getAigaHisCaseRelaBySql(querySql);
	}


}

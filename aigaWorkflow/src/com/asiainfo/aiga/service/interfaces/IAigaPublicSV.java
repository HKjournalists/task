package com.asiainfo.aiga.service.interfaces;

import java.util.List;

import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaSubTaskProblemValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestSubTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public interface IAigaPublicSV {
	public void orderSubmitPublicFun(List<IBOAlmStakeholderValue> iBOAlmStakeholderList,
			List<IBOAlmWorkorderValue> iBOAlmWorkorderList,List<IBOAigaTestPlanValue> iBOAigaTestPlanList,
			List<IBOAigaTestTaskValue> iBOAigaTestTaskList,List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList,
			List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskValue,
			List<IBOAigaSubTaskProblemValue> iBOAigaSubTaskProblemValue,
			String objType)throws Exception;
	public IBOAlmStakeholderValue generateAlmStakeholderValue(long linkId, String linkNo, long templateId,
			long staffId,String staffName,String stdType,long objId,String objType)throws Exception;
}

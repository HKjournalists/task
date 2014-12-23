package com.lb.app.automation.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;

import com.lb.app.automation.model.AutoAction;
import com.lb.app.automation.model.AutoBatchDetail;
import com.lb.app.automation.service.AutoBatchDetailService;

@Service
public class BatchDetailAction {
	final private static Log log = LogFactory.getLog(BatchDetailAction.class);

	@Autowired
	AutoBatchDetailService batchDetailService;
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_READ)
	public List<AutoBatchDetail> load(String batchid) {
		return batchDetailService.load(batchid);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public List<AutoBatchDetail> saveOrUpdate(List<AutoBatchDetail> batches){
		return batchDetailService.saveOrUpdate(batches);
	}
	
	@ExtDirectMethod(value = ExtDirectMethodType.STORE_MODIFY)
	public void destroy(List<AutoBatchDetail> batches){
		batchDetailService.destroy(batches);
	}
}

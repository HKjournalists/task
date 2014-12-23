package com.lb.app.automation.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lb.app.automation.dao.IAutoBatchDao;
import com.lb.app.automation.dao.IAutoBatchDetailDao;
import com.lb.app.automation.dao.IAutoScriptDao;
import com.lb.app.automation.model.AutoBatch;
import com.lb.app.automation.model.AutoBatchDetail;
import com.lb.app.automation.model.AutoScript;


@Service
public class AutoBatchDetailService {
	final private static Log log = LogFactory.getLog(AutoBatchDetailService.class);

	@Autowired
	IAutoBatchDao batchDao;
	
	@Autowired
	IAutoBatchDetailDao batchDetailDao;
	
	@Autowired
	IAutoScriptDao scriptDao;

	public List<AutoBatchDetail> saveOrUpdate(List<AutoBatchDetail> batches) {
		for (AutoBatchDetail b : batches) {
			if(!StringUtils.isEmpty(b.getBatchid()))
				b.setBatch(batchDao.get(b.getBatchid()));
			
			if(!StringUtils.isEmpty(b.getScriptid())){
				b.setScript(scriptDao.get(b.getScriptid()));
			}
			if(StringUtils.isEmpty(b.getBatchdetailid()))
				batchDetailDao.create(b);
			else
				batchDetailDao.update(b);
		}
		return batches;
	}

	public List<AutoBatchDetail> load(String batchid) {
		List<AutoBatchDetail> batches = batchDetailDao.findbyCriteria(Restrictions.eq("batch", batchDao.get(batchid)));
		for (AutoBatchDetail b : batches){
			b.setBatchid(b.getBatch().getBatchid());
			b.setScriptid(b.getScript().getScriptid());
		}
		
		return batches;
	}

	public void destroy(List<AutoBatchDetail> batches) {
		for (AutoBatchDetail b : batches)
			batchDetailDao.delete(b);
	}
	
	public void destroyByScript(AutoScript script){
		List<AutoBatchDetail> details = batchDetailDao.findbyCriteria(Restrictions.eq("script", script));
		for(AutoBatchDetail d : details){
			batchDetailDao.delete(d);
		}

	}
}

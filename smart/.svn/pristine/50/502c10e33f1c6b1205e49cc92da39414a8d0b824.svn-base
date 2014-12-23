package com.lb.app.automation.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lb.app.automation.dao.IAutoBatchDao;
import com.lb.app.automation.dao.IAutoBatchDetailDao;
import com.lb.app.automation.dao.IAutoPlatformExecuteConfigDao;
import com.lb.app.automation.model.AutoBatch;
import com.lb.app.automation.model.AutoBatchDetail;
import com.lb.app.automation.model.AutoPlatformExecuteConfig;
import com.lb.app.automation.model.AutoScript;

@Service
public class AutoBatchService {
	
	final private static Log log = LogFactory.getLog(AutoBatchService.class);

	@Autowired
	IAutoBatchDao batchDao;
	
	@Autowired
	IAutoBatchDetailDao batchDetailDao;

	@Autowired
	IAutoPlatformExecuteConfigDao execDao;
	
	public List<AutoBatch> saveOrUpdate(List<AutoBatch> batches) {
		for (AutoBatch b : batches) {
			if(StringUtils.isEmpty(b.getBatchid()))
				batchDao.create(b);
			else
				batchDao.update(b);
		}
		return batches;
	}

	public List<AutoBatch> load(String name) {
		return batchDao.findbyCriteria(Restrictions.like("batchname", "%" + name + "%"));
	}

	public void destroy(List<AutoBatch> batches) {
		List<AutoBatchDetail> details = batchDetailDao.findbyCriteria(Restrictions.in("batch", batches));
		List<String> batch_ids = new ArrayList<String>();
		for(AutoBatch b : batches){
			batch_ids.add(b.getBatchid());
		}
		List<AutoPlatformExecuteConfig> execs = execDao.findbyCriteria(Restrictions.in("batchid", batch_ids));
		
		for(AutoPlatformExecuteConfig config: execs){
			execDao.delete(config);
		}
		for(AutoBatchDetail d : details){
			batchDetailDao.delete(d);
		}
		for (AutoBatch b : batches){
			batchDao.delete(b);
		}
		
			
	}

	
	public AutoBatch get(String batchid){
		return batchDao.get(batchid);
	}
}

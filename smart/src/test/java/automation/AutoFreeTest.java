package automation;

import java.util.List;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.transaction.TransactionConfiguration;

import com.lb.app.automation.model.AutoBatch;
import com.lb.app.automation.service.AutoBatchService;
import com.lb.app.automation.service.AutoKeywordDetailService;
import com.lb.app.automation.service.AutoScriptDetailService;
import common.JUnit4ClassRunner;


@RunWith(JUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:spring/spring-base.xml"})
@Transactional  
@TransactionConfiguration(transactionManager = "txManager", defaultRollback = false)
public class AutoFreeTest {

	@Autowired
	AutoScriptDetailService scriptDetailService;
	
	@Autowired
	AutoKeywordDetailService keyworddetailService;
	
	@Autowired
	AutoBatchService batchService;
	
	@Test
	public void testQueryWithkeyword(){
		List<AutoBatch> batches = batchService.load("a");
		batchService.destroy(batches);

	}
}

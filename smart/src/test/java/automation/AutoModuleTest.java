package automation;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.util.StringUtils;

import com.lb.app.automation.exception.AssociatiedDestroySubModuleException;
import com.lb.app.automation.model.AutoModule;
import com.lb.app.automation.model.AutoSubModule;
import com.lb.app.automation.service.AutoModuleService;
import com.lb.app.automation.service.AutoSubModuleService;

import common.JUnit4ClassRunner;



@RunWith(JUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:spring/spring-base.xml"})
@Transactional  
@TransactionConfiguration(transactionManager = "txManager", defaultRollback = true)
public class AutoModuleTest {
	final private static Log log = LogFactory.getLog(AutoModuleTest.class);

	@Autowired
	AutoModuleService moduleService;
	
	@Autowired
	AutoSubModuleService submoduleService;
	
	@Before
	public void updateSetup() throws Exception{
		log.info("=======================================>init data");
		moduleService.deleteModuleByName("ttttt");
		moduleService.deleteModuleByName("Testa");
		moduleService.deleteModuleByName("Test_newa");
		moduleService.deleteModuleByName("Test_newb");

		

	}
	
	@Test
	public void testCreateModule(){
		String moduleid = moduleService.createModule("ttttt");
		Assert.assertNotEquals(moduleid, null);
		Assert.assertNotEquals(moduleid, "");
	}
	
	
	@Test
	public void testDestoryModule(){
		AutoModule m = new AutoModule();
		m.setModulename("Testa");
		
		
		List<AutoModule> modules = new ArrayList<AutoModule>();
		modules.add(m);
		
		moduleService.saveOrUpdate(modules);
		Assert.assertFalse(StringUtils.isEmpty(m.getModuleid()));
	}
	
	@Test
	public void testAutoSubModuleAppend(){
		moduleService.deleteModuleByName("Test_newa");

		AutoModule m = new AutoModule();
		m.setModulename("Test_newa");
		List<AutoModule> modules = new ArrayList<AutoModule>();
		modules.add(m);
		moduleService.saveOrUpdate(modules);
		
		AutoSubModule sm = new AutoSubModule();
		sm.setSubmodulename("test_sub_modulea");
		sm.setModule(m);
		List<AutoSubModule> smodules = new ArrayList<AutoSubModule>();
		smodules.add(sm);
		submoduleService.saveOrUpdate(smodules);
		
		log.info(sm.getSubmoduleid());
		Assert.assertFalse(StringUtils.isEmpty(sm.getSubmoduleid()));
		
		//load
		List<AutoModule> ms = moduleService.load();
		Assert.assertTrue(ms.get(0).getSubmodules().size() > 0);
	}
	
	@Test
	public void testAutoModule() throws AssociatiedDestroySubModuleException{
		AutoModule m = new AutoModule();
		m.setModulename("Test_newb");
		List<AutoModule> modules = new ArrayList<AutoModule>();
		modules.add(m);
		moduleService.saveOrUpdate(modules);
		
		AutoSubModule sm = new AutoSubModule();
		sm.setSubmodulename("test_sub_moduleb");
		sm.setModule(m);
		List<AutoSubModule> smodules = new ArrayList<AutoSubModule>();
		smodules.add(sm);
		submoduleService.saveOrUpdate(smodules);
		
		moduleService.deleteModule(m.getModuleid());
		log.info(m.getModuleid());
		log.info(sm.getSubmoduleid());
		
		
	}
	

	
}

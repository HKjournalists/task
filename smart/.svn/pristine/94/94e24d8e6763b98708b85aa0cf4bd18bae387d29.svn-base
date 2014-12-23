package privilege;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.transaction.TransactionConfiguration;

import com.lb.app.privilege.model.Sys_Role;
import com.lb.app.privilege.service.RoleService;
import common.JUnit4ClassRunner;

@RunWith(JUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:spring/spring-base.xml"})
@Transactional  
@TransactionConfiguration(transactionManager = "txManager", defaultRollback = true) 
public class RoleServcieTest {
	final private static Log log = LogFactory.getLog(RoleServcieTest.class);

	@Autowired
	RoleService roleService;
	
	@Test
	public void createRole(){
		Sys_Role r = new Sys_Role();
		r.setName("test");
		r.setMemo("test");
		
		List<Sys_Role> roles = new ArrayList<Sys_Role>();
		roles.add(r);
		log.info(roleService.load("").size());
		roleService.saveOrUpdate(roles);
		log.info(roleService.load("").size());
		log.info(r.getRoleid());
		Assert.assertTrue(r.getRoleid()>0);
	}
	
	@Test
	public void loadRoles(){
		List<Sys_Role> roles = roleService.load("");
		Assert.assertTrue(roles.size() > 0);
		
	}
	
	@Test
	public void deleteRole(){
		Sys_Role r = new Sys_Role();
		r.setName("test");
		r.setMemo("test");
		
		List<Sys_Role> roles = new ArrayList<Sys_Role>();
		roles.add(r);
		roleService.saveOrUpdate(roles);
		
		roleService.destory(roles);
		
	}

}

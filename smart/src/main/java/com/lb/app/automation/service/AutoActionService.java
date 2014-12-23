package com.lb.app.automation.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lb.app.automation.dao.IAutoActionDao;
import com.lb.app.automation.model.AutoAction;
import com.lb.app.automation.model.AutoRule;

@Service
public class AutoActionService {
	final private static Log log = LogFactory.getLog(AutoActionService.class);

	@Autowired
	IAutoActionDao actionDao;

	public List<AutoAction> saveOrUpdate(List<AutoAction> actions) {
		for (AutoAction ac : actions) {
			if(StringUtils.isEmpty(ac.getActionid()))
				actionDao.create(ac);
			else
				actionDao.update(ac);
		}
		return actions;
	}

	public List<AutoAction> load(String name) {
		return actionDao.findbyCriteria(Restrictions.like("actionname", "%" + name + "%"));
	}

	public void destroy(List<AutoAction> actions) {
		for (AutoAction a : actions)
			actionDao.delete(a);
	}
}

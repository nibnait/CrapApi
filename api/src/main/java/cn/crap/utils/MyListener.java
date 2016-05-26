package cn.crap.utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import cn.crap.inter.service.IModuleService;
import cn.crap.inter.service.ISettingService;

public class MyListener implements ServletContextListener {
	private WebApplicationContext springContext;

	public void contextDestroyed(ServletContextEvent context) {
	}

	public void contextInitialized(ServletContextEvent context) {
		ISettingService settingService;
		IModuleService moduleService;
		springContext = WebApplicationContextUtils
				.getWebApplicationContext(context.getServletContext());
		if (springContext != null) {
			settingService = (ISettingService) springContext
					.getBean("settingService");
			moduleService = (IModuleService) springContext
					.getBean("moduleService");
		} else {
			return;
		}
		Cache.clear(settingService, moduleService, context.getServletContext());
	}

}

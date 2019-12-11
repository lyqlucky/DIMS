package com.dims.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dims.service.IAdminService;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
	@Autowired
	private IAdminService adminService;

	@RequestMapping(value = "/index")
	public String index() {
		// 重定向到 WEB-INF/views/admin/welcome.jsp
		return "redirect:/admin/welcome";
	}

	@RequestMapping(value = "/welcome")
	public String welcome(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentAdmin") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		// 请求映射到 WEB-INF/views/admin/welcome.jsp
		return "admin/welcome";
	}

	@RequestMapping(value = "/profile")
	public String profile(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentAdmin") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		// 请求映射到 WEB-INF/views/admin/profile.jsp
		return "admin/profile";
	}

	@RequestMapping(value = "/query-drug-list")
	public String queryDrugList(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentAdmin") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		// 请求映射到 WEB-INF/views/admin/query-drug-list.jsp
		return "admin/query-drug-list";
	}
}

package com.dims.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dims.service.INurseService;

@Controller
@RequestMapping(value = "/nurse")
public class NurseController {
	@Autowired
	private INurseService nurseService;

	@RequestMapping(value = "/index")
	public String index() {
		// 重定向到 WEB-INF/views/nurse/welcome.jsp
		return "redirect:/nurse/welcome";
	}

	@RequestMapping(value = "/welcome")
	public String welcome(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentNurse") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		// 请求映射到 WEB-INF/views/nurse/welcome.jsp
		return "nurse/welcome";
	}

	@RequestMapping(value = "inventory-drug-list")
	public String inventoryDrugList() {
		// 请求映射到 WEB-INF/views/nurse/inventory-drug-list.jsp
		return "nurse/inventory-drug-list";
	}
}

package com.dims.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dims.domain.Drug;
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

	@RequestMapping(value = "query-pdbatch-list")
	public String queryPDbatchList(HttpServletRequest req, Model model) {
		List<Drug> drugs = nurseService.queryAllDrugs();

		for (Drug drug : drugs) {
			drug.setInventoryDrugs(nurseService.queryAllPDbatches(drug));
		}

		model.addAttribute("drugs", drugs);

		// 请求映射到 WEB-INF/views/nurse/query-pdbatch-list.jsp
		return "nurse/query-pdbatch-list";
	}
}

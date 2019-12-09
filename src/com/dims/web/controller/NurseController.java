package com.dims.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dims.domain.Drug;
import com.dims.domain.Prescription;
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

	@RequestMapping(value = "query-drug-list")
	public String queryDrugList(HttpServletRequest req, Model model) {
		if (req.getSession().getAttribute("currentNurse") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		List<Drug> drugs = nurseService.queryAllDrugs();

		model.addAttribute("drugs", drugs);

		// 请求映射到 WEB-INF/views/nurse/query-drug-list.jsp
		return "nurse/query-drug-list";
	}

	@RequestMapping(value = "query-pdbatch-list")
	public String queryPDbatchList(HttpServletRequest req, Model model) {
		if (req.getSession().getAttribute("currentNurse") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		List<Drug> drugs = nurseService.queryAllDrugs();

		for (Drug drug : drugs) {
			drug.setInventoryDrugs(nurseService.queryAllPDbatches(drug));
		}

		model.addAttribute("drugs", drugs);

		// 请求映射到 WEB-INF/views/nurse/query-pdbatch-list.jsp
		return "nurse/query-pdbatch-list";
	}

	@RequestMapping(value = "query-unsolved-rx-list")
	public String queryUnsolvedPrescriptionList(HttpServletRequest req, Model model) {
		if (req.getSession().getAttribute("currentNurse") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		List<Prescription> rxs = nurseService.queryAllUnsolvedRxs();

		for (Prescription rx : rxs) {
			rx.setDrugs(nurseService.queryAllContainedDrugs(rx));
		}

		model.addAttribute("rxs", rxs);

		// 请求映射到 WEB-INF/views/nurse/query-unsolved-rx-list.jsp
		return "nurse/query-unsolved-rx-list";
	}

	@RequestMapping(value = "query-solved-rx-list")
	public String querySolvedPrescriptionList(HttpServletRequest req, Model model) {
		if (req.getSession().getAttribute("currentNurse") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		List<Prescription> rxs = nurseService.queryAllSolvedRxs();

		for (Prescription rx : rxs) {
			rx.setDrugs(nurseService.queryAllContainedDrugs(rx));
		}

		model.addAttribute("rxs", rxs);

		// 请求映射到 WEB-INF/views/nurse/query-solved-rx-list.jsp
		return "nurse/query-solved-rx-list";
	}

	@RequestMapping(value = "profile")
	public String profile(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentNurse") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		// 请求映射到 WEB-INF/views/nurse/profile.jsp
		return "nurse/profile";
	}
}

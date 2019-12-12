package com.dims.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dims.domain.Admin;
import com.dims.domain.DestroyedDrug;
import com.dims.domain.Drug;
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

		int lowInventoryDrugsNum = adminService.countLowInventoryDrugs();
		int close2ExpiryPDbatchesNum = adminService.countClose2ExpiryPDbatches();
		int inventoryDrugsNum = adminService.countInventoryDrugs();
		int inventoryPDbatchesNum = adminService.countInventoryPDbatches();
		int destroyedPDbatchesNum = adminService.countDestroyedPDbatches();
		int myInventoryPDbatchesNum = adminService
				.countMyInventoryPDbatches((Admin) req.getSession().getAttribute("currentAdmin"));
		int myPDbatchesNum = adminService.countMyPDbatches((Admin) req.getSession().getAttribute("currentAdmin"));
		int myDestroyedPDbatchesNum = adminService
				.countMyDestoryedPDbatches((Admin) req.getSession().getAttribute("currentAdmin"));

		req.getSession().setAttribute("lowInventoryDrugsNum", lowInventoryDrugsNum);
		req.getSession().setAttribute("close2ExpiryPDbatchesNum", close2ExpiryPDbatchesNum);
		req.getSession().setAttribute("inventoryDrugsNum", inventoryDrugsNum);
		req.getSession().setAttribute("inventoryPDbatchesNum", inventoryPDbatchesNum);
		req.getSession().setAttribute("destroyedPDbatchesNum", destroyedPDbatchesNum);
		req.getSession().setAttribute("myInventoryPDbatchesNum", myInventoryPDbatchesNum);
		req.getSession().setAttribute("myPDbatchesNum", myPDbatchesNum);
		req.getSession().setAttribute("myDestroyedPDbatchesNum", myDestroyedPDbatchesNum);

		// 请求映射到 WEB-INF/views/admin/welcome.jsp
		return "admin/welcome";
	}

	@RequestMapping(value = "/profile")
	public String profile(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentAdmin") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		req.getSession().removeAttribute("echo");

		// 请求映射到 WEB-INF/views/admin/profile.jsp
		return "admin/profile";
	}

	@RequestMapping(value = "/query-drug-list")
	public String queryDrugList(HttpServletRequest req, Model model) {
		if (req.getSession().getAttribute("currentAdmin") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		List<Drug> drugs = adminService.queryAllDrugs();

		model.addAttribute("drugs", drugs);

		// 请求映射到 WEB-INF/views/admin/query-drug-list.jsp
		return "admin/query-drug-list";
	}

	@RequestMapping(value = "query-pdbatch-list")
	public String queryPDbatchList(HttpServletRequest req, Model model) {
		if (req.getSession().getAttribute("currentAdmin") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		List<Drug> drugs = adminService.queryAllDrugs();

		for (Drug drug : drugs) {
			drug.setInventoryDrugs(adminService.querySpecificPDbatches(drug));
		}

		model.addAttribute("drugs", drugs);

		// 请求映射到 WEB-INF/views/admin/query-pdbatch-list.jsp
		return "admin/query-pdbatch-list";
	}

	@RequestMapping(value = "query-destroyed-pdbatch-list")
	public String queryDestroyedDrugList(HttpServletRequest req, Model model) {
		if (req.getSession().getAttribute("currentAdmin") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		List<DestroyedDrug> destroyedDrugs = adminService.queryAllDestroyedPDbatches();

		model.addAttribute("destroyedDrugs", destroyedDrugs);

		// 请求映射到 WEB-INF/views/admin/query-destroyed-pdbatch-list.jsp
		return "admin/query-destroyed-pdbatch-list";
	}

	@RequestMapping(value = "/changeApwd")
	public String changeApwd(HttpServletRequest req, String Apwd1, String Apwd2) {
		if (req.getSession().getAttribute("currentAdmin") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		Admin currentAdmin = (Admin) req.getSession().getAttribute("currentAdmin");

		String echo;

		if (Apwd1.equals(Apwd2)) {
			adminService.changeApwd(Apwd1, currentAdmin.getAno());
			echo = "修改密码成功！";
		} else {
			echo = "两次输入的密码不一致，修改密码失败！";
		}

		req.getSession().setAttribute("echo", echo);

		// 请求映射到 WEB-INF/views/admin/profile.jsp
		return "admin/profile"; // 不要用重定向，重定向会执行 profile 方法
	}
}

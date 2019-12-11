package com.dims.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dims.domain.Doctor;
import com.dims.service.IDoctorService;

@Controller
@RequestMapping(value = "/doctor")
public class DoctorController {
	@Autowired
	private IDoctorService doctorService;

	@RequestMapping(value = "/index")
	public String index() {
		// 重定向到 WEB-INF/views/doctor/welcome.jsp
		return "redirect:/doctor/welcome";
	}

	@RequestMapping(value = "/welcome")
	public String welcome(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentDoctor") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		// 请求映射到 WEB-INF/views/doctor/welcome.jsp
		return "doctor/welcome";
	}

	@RequestMapping(value = "/profile")
	public String profile(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentDoctor") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		req.getSession().removeAttribute("echo");

		// 请求映射到 WEB-INF/views/doctor/profile.jsp
		return "doctor/profile";
	}

	@RequestMapping(value = "/query-drug-list")
	public String queryDrugList(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentDoctor") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		// 请求映射到 WEB-INF/views/doctor/query-drug-list.jsp
		return "doctor/query-drug-list";
	}

	@RequestMapping(value = "/query-solved-rx-list")
	public String querySolvedRxList(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentDoctor") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		// 请求映射到 WEB-INF/views/doctor/query-solved-rx-list.jsp
		return "doctor/query-solved-rx-list";
	}

	@RequestMapping(value = "/query-unsolved-rx-list")
	public String queryUnsolvedRxList(HttpServletRequest req) {
		if (req.getSession().getAttribute("currentDoctor") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		// 请求映射到 WEB-INF/views/doctor/query-unsolved-rx-list.jsp
		return "doctor/query-unsolved-rx-list";
	}

	@RequestMapping(value = "/changeDpwd")
	public String changeDpwd(HttpServletRequest req, String Dpwd1, String Dpwd2) {
		if (req.getSession().getAttribute("currentDoctor") == null) {
			// 重定向到 WEB-INF/views/login.jsp，留在登录页面
			return "redirect:/login";
		}

		Doctor currentDoctor = (Doctor) req.getSession().getAttribute("currentDoctor");

		String echo;

		if (Dpwd1.equals(Dpwd2)) {
			doctorService.changeDpwd(Dpwd1, currentDoctor.getDno());
			echo = "修改密码成功！";
		} else {
			echo = "两次输入的密码不一致，修改密码失败！";
		}

		req.getSession().setAttribute("echo", echo);

		// 请求映射到 WEB-INF/views/doctor/profile.jsp
		return "doctor/profile";
	}
}

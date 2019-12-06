package com.dims.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dims.service.IAdminService;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
	@Autowired
	private IAdminService adminService;

}

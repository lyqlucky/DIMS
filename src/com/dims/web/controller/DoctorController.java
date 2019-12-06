package com.dims.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dims.service.IDoctorService;

@Controller
@RequestMapping(value = "/doctor")
public class DoctorController {
	@Autowired
	private IDoctorService doctorService;

}

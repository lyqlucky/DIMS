package com.dims.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dims.domain.Doctor;
import com.dims.domain.User;
import com.dims.mapper.DoctorMapper;
import com.dims.service.IDoctorService;

@Service
public class DoctorServiceImpl implements IDoctorService {
	@Autowired
	DoctorMapper doctorMapper;

	@Override
	public Doctor login(User user) { // 登录
		return doctorMapper.login(user);
	}
}

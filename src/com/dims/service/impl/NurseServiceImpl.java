package com.dims.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dims.domain.Nurse;
import com.dims.domain.User;
import com.dims.mapper.NurseMapper;
import com.dims.service.INurseService;

@Service
public class NurseServiceImpl implements INurseService {
	@Autowired
	NurseMapper nurseMapper;

	@Override
	public Nurse login(User user) { // 登录
		return nurseMapper.login(user);
	}
}

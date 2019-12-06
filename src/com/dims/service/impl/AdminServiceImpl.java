package com.dims.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dims.domain.Admin;
import com.dims.domain.User;
import com.dims.mapper.AdminMapper;
import com.dims.service.IAdminService;

@Service
public class AdminServiceImpl implements IAdminService {
	@Autowired
	AdminMapper adminMapper;

	@Override
	public Admin login(User user) { // 登录
		return adminMapper.login(user);
	}
}

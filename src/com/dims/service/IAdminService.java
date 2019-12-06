package com.dims.service;

import com.dims.domain.Admin;
import com.dims.domain.User;

public interface IAdminService {
	public Admin login(User user); // 登录
}

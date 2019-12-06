package com.dims.mapper;

import com.dims.domain.Admin;
import com.dims.domain.User;

public interface AdminMapper {
	public Admin login(User user); // 登录
}

package com.dims.service;

import com.dims.domain.Nurse;
import com.dims.domain.User;

public interface INurseService {
	public Nurse login(User user); // 登录
}

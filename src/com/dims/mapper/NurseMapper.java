package com.dims.mapper;

import com.dims.domain.Nurse;
import com.dims.domain.User;

public interface NurseMapper {
	public Nurse login(User user); // 登录
}

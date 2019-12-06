package com.dims.mapper;

import com.dims.domain.Doctor;
import com.dims.domain.User;

public interface DoctorMapper {
	public Doctor login(User user); // 登录
}

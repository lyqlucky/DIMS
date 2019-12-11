package com.dims.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dims.domain.Doctor;
import com.dims.domain.Drug;
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

	@Override
	public List<Drug> queryAllDrugs() { // 查看药品库存列表
		return doctorMapper.queryAllDrugs();
	}

	@Override
	public void changeDpwd(String Dpwd, String Dno) { // 修改登录密码
		doctorMapper.changeDpwd(Dpwd, Dno);
	}
}

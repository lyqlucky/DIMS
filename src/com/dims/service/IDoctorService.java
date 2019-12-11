package com.dims.service;

import java.util.List;

import com.dims.domain.Doctor;
import com.dims.domain.Drug;
import com.dims.domain.User;

public interface IDoctorService {
	public Doctor login(User user); // 登录

	public List<Drug> queryAllDrugs(); // 查看药品库存列表

	public void changeDpwd(String Dpwd, String Dno); // 修改登录密码
}

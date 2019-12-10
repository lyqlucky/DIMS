package com.dims.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dims.domain.Drug;
import com.dims.domain.InventoryDrug;
import com.dims.domain.Nurse;
import com.dims.domain.Prescription;
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

	@Override
	public List<Drug> queryAllDrugs() { // 查看药品库存列表
		return nurseMapper.queryAllDrugs();
	}

	@Override
	public List<InventoryDrug> queryAllPDbatches(Drug drug) { // 查看某一药品的所有库存批次
		return nurseMapper.queryAllPDbatches(drug);
	}

	@Override
	public List<Prescription> queryAllUnsolvedRxs() { // 查看未处理处方列表
		return nurseMapper.queryAllUnsolvedRxs();
	}

	@Override
	public List<Prescription> queryAllSolvedRxs() { // 查看已处理处方列表
		return nurseMapper.queryAllSolvedRxs();
	}

	@Override
	public List<Drug> queryAllContainedDrugs(Prescription prescription) { // 查看某一处方包含的所有药品
		return nurseMapper.queryAllContainedDrugs(prescription);
	}

	@Override
	public void changeNpwd(String Npwd, String Nno) { // 修改登录密码
		nurseMapper.changeNpwd(Npwd, Nno);
	}
}

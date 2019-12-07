package com.dims.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dims.domain.Drug;
import com.dims.domain.InventoryDrug;
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

	@Override
	public List<Drug> queryAllDrugs() { // 查看药品库存列表
		return nurseMapper.queryAllDrugs();
	}

	@Override
	public List<InventoryDrug> queryAllPDbatches(Drug drug) { // 查看某一库存药品的所有批次
		return nurseMapper.queryAllPDbatches(drug);
	}
}

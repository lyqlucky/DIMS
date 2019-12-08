package com.dims.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dims.domain.Admin;
import com.dims.domain.DestroyedDrug;
import com.dims.domain.Drug;
import com.dims.domain.InventoryDrug;
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

	@Override
	public List<Drug> queryAllDrugs() { // 查看药品库存列表
		return adminMapper.queryAllDrugs();
	}

	@Override
	public List<InventoryDrug> queryAllPDbatches(Drug drug) { // 查看某一药品的所有库存批次
		return adminMapper.queryAllPDbatches(drug);
	}

	@Override
	public List<DestroyedDrug> queryAllDestroyedPDbatches(Drug drug) { // 参看某一药品的所有已销毁批次
		return adminMapper.queryAllDestroyedPDbatches(drug);
	}
}

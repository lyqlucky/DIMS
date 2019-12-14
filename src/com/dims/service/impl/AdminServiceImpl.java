package com.dims.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dims.domain.Admin;
import com.dims.domain.DestroyedDrug;
import com.dims.domain.Drug;
import com.dims.domain.InventoryDrug;
import com.dims.domain.Supplier;
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
	public int countLowInventoryDrugs() { // 统计量少的库存药品种数
		return adminMapper.countLowInventoryDrugs();
	}

	@Override
	public int countClose2ExpiryPDbatches() { // 统计临期库存药品批数
		return adminMapper.countClose2ExpiryPDbatches();
	}

	@Override
	public int countInventoryDrugs() { // 统计库存药品种数
		return adminMapper.countInventoryDrugs();
	}

	@Override
	public int countInventoryPDbatches() { // 统计库存药品批数
		return adminMapper.countInventoryPDbatches();
	}

	@Override
	public int countDestroyedPDbatches() { // 统计销毁药品批数
		return adminMapper.countDestroyedPDbatches();
	}

	@Override
	public int countMyInventoryPDbatches(Admin amdin) { // 统计由该名库存管理员入库的库存药品批数
		return adminMapper.countMyInventoryPDbatches(amdin);
	}

	@Override
	public int countMyPDbatches(Admin admin) { // 统计由该名库存管理员入库的药品总批数
		return adminMapper.countMyPDbatches(admin);
	}

	@Override
	public int countMyDestoryedPDbatches(Admin admin) { // 统计由该名库存管理员销毁 (出库) 的销毁药品批数
		return adminMapper.countMyDestoryedPDbatches(admin);
	}

	@Override
	public List<Drug> queryAllDrugs() { // 查看药品库存列表
		return adminMapper.queryAllDrugs();
	}

	@Override
	public List<InventoryDrug> querySpecificPDbatches(Drug drug) { // 查看某一药品的所有库存批次
		return adminMapper.querySpecificPDbatches(drug);
	}

	@Override
	public List<DestroyedDrug> queryAllDestroyedPDbatches() { // 查看已销毁药品批次列表
		return adminMapper.queryAllDestroyedPDbatches();
	}

	@Override
	public List<DestroyedDrug> querySpecificDestroyedPDbatches(Drug drug) { // 参看某一药品的所有已销毁批次
		return adminMapper.querySpecificDestroyedPDbatches(drug);
	}

	@Override
	public List<InventoryDrug> queryLowInventoryDrugs() { // 查看量少的库存药品列表
		return adminMapper.queryLowInventoryDrugs();
	}

	@Override
	public List<InventoryDrug> queryClose2ExpiryPDbatches() { // 查看临期库存药品列表
		return adminMapper.queryClose2ExpiryPDbatches();
	}

	@Override
	public List<Supplier> queryAllSuppliers() { // 查看药品供应商列表
		return adminMapper.queryAllSuppliers();
	}

	@Override
	public void changeApwd(String Apwd, String Ano) { // 修改登录密码
		adminMapper.changeApwd(Apwd, Ano);
	}
}

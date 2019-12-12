package com.dims.mapper;

import java.util.List;

import com.dims.domain.Admin;
import com.dims.domain.DestroyedDrug;
import com.dims.domain.Drug;
import com.dims.domain.InventoryDrug;
import com.dims.domain.User;

public interface AdminMapper {
	public Admin login(User user); // 登录

	public int countLowInventoryDrugs(); // 统计量少的库存药品种数

	public int countClose2ExpiryPDbatches(); // 统计临期库存药品批数

	public int countInventoryDrugs(); // 统计库存药品种数

	public int countInventoryPDbatches(); // 统计库存药品批数

	public int countDestroyedPDbatches(); // 统计销毁药品批数

	public int countMyInventoryPDbatches(Admin amdin); // 统计由该名库存管理员入库的库存药品批数

	public int countMyPDbatches(Admin admin); // 统计由该名库存管理员入库的药品总批数

	public int countMyDestoryedPDbatches(Admin admin); // 统计由该名库存管理员销毁 (出库) 的销毁药品批数

	public List<Drug> queryAllDrugs(); // 查看药品库存列表

	public List<InventoryDrug> querySpecificPDbatches(Drug drug); // 查看某一药品的所有库存批次

	public List<DestroyedDrug> queryAllDestroyedPDbatches(); // 查看已销毁药品批次列表

	public List<DestroyedDrug> querySpecificDestroyedPDbatches(Drug drug); // 参看某一药品的所有已销毁批次

	public List<InventoryDrug> queryLowInventoryDrugs(); // 查看量少的库存药品列表

	public List<InventoryDrug> queryClose2ExpiryPDbatches(); // 查看临期库存药品列表

	public void changeApwd(String Apwd, String Ano); // 修改登录密码
}

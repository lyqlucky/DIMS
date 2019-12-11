package com.dims.mapper;

import java.util.List;

import com.dims.domain.Admin;
import com.dims.domain.DestroyedDrug;
import com.dims.domain.Drug;
import com.dims.domain.InventoryDrug;
import com.dims.domain.User;

public interface AdminMapper {
	public Admin login(User user); // 登录

	public List<Drug> queryAllDrugs(); // 查看药品库存列表

	public List<InventoryDrug> queryAllPDbatches(Drug drug); // 查看某一药品的所有库存批次

	public List<DestroyedDrug> queryAllDestroyedPDbatches(Drug drug); // 参看某一药品的所有已销毁批次

	public void changeApwd(String Apwd, String Ano); // 修改登录密码
}

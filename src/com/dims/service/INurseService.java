package com.dims.service;

import java.util.List;

import com.dims.domain.Drug;
import com.dims.domain.InventoryDrug;
import com.dims.domain.Nurse;
import com.dims.domain.User;

public interface INurseService {
	public Nurse login(User user); // 登录

	public List<Drug> queryAllDrugs(); // 查看药品库存列表

	public List<InventoryDrug> queryAllPDbatches(Drug drug); // 查看某一库存药品的所有批次
}

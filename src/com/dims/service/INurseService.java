package com.dims.service;

import java.util.List;

import com.dims.domain.Drug;
import com.dims.domain.InventoryDrug;
import com.dims.domain.Nurse;
import com.dims.domain.Prescription;
import com.dims.domain.User;

public interface INurseService {
	public Nurse login(User user); // 登录

	public List<Drug> queryAllDrugs(); // 查看药品库存列表

	public List<InventoryDrug> queryAllPDbatches(Drug drug); // 查看某一药品的所有库存批次

	public List<Prescription> queryAllUnsolvedRxs(); // 查看未处理处方列表

	public List<Prescription> queryAllSolvedRxs(); // 查看已处理处方列表

	public List<Drug> queryAllContainedDrugs(Prescription prescription); // 查看某一处方包含的所有药品
}

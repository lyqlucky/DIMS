package com.dims.mapper;

import java.util.List;

import com.dims.domain.Drug;
import com.dims.domain.InventoryDrug;
import com.dims.domain.Nurse;
import com.dims.domain.Prescription;
import com.dims.domain.User;

public interface NurseMapper {
	public Nurse login(User user); // 登录

	public List<Drug> queryAllDrugs(); // 查看药品库存列表

	public List<InventoryDrug> queryAllPDbatches(Drug drug); // 查看某一药品的所有库存批次

	public List<Prescription> queryAllUnsolvedRxs(); // 查看未处理处方列表

	public List<Prescription> queryAllSolvedRxs(); // 查看已处理处方列表

	public Prescription queryOneRx(Prescription rx); // 查看某一处方的具体明细

	public List<Drug> queryAllContainedDrugs(Prescription rx); // 查看某一处方包含的所有药品

	public void changeNpwd(String Npwd, String Nno); // 修改登录密码
}

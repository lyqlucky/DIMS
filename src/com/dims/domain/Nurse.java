package com.dims.domain;

public class Nurse { // 发药处护士
	String Nno; // 编号
	String Nname; // 姓名
	boolean Nsex; // 性别 (1 为男，0 为女)
	int Nage; // 年龄
	String Npwd; // 登录密码

	public String getNno() {
		return Nno;
	}

	public void setNno(String nno) {
		Nno = nno;
	}

	public String getNname() {
		return Nname;
	}

	public void setNname(String nname) {
		Nname = nname;
	}

	public boolean isNsex() {
		return Nsex;
	}

	public void setNsex(boolean nsex) {
		Nsex = nsex;
	}

	public int getNage() {
		return Nage;
	}

	public void setNage(int nage) {
		Nage = nage;
	}

	public String getNpwd() {
		return Npwd;
	}

	public void setNpwd(String npwd) {
		Npwd = npwd;
	}

	@Override
	public String toString() {
		return "Nurse [Nno=" + Nno + ", Nname=" + Nname + ", Nsex=" + Nsex + ", Nage=" + Nage + ", Npwd=" + Npwd + "]";
	}
}

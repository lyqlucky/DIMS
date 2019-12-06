package com.dims.domain;

public class Drug { // 药品
	String PDno; // 编号
	String PDname; // 名称
	int PDlife; // 保质期 (天数)
	int PDnum; // 数量

	public String getPDno() {
		return PDno;
	}

	public void setPDno(String pDno) {
		PDno = pDno;
	}

	public String getPDname() {
		return PDname;
	}

	public void setPDname(String pDname) {
		PDname = pDname;
	}

	public int getPDlife() {
		return PDlife;
	}

	public void setPDlife(int pDlife) {
		PDlife = pDlife;
	}

	public int getPDnum() {
		return PDnum;
	}

	public void setPDnum(int pDnum) {
		PDnum = pDnum;
	}

	@Override
	public String toString() {
		return "Drug [PDno=" + PDno + ", PDname=" + PDname + ", PDlife=" + PDlife + ", PDnum=" + PDnum + "]";
	}
}

package com.example.demo.bo;

public class FeeReceivables {
	private double totalFee;
	private double dueAmount;
	private double paidAmount;
	
	public double getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(double totalFee) {
		this.totalFee = totalFee;
	}
	public double getDueAmount() {
		return dueAmount;
	}
	public void setDueAmount(double dueAmount) {
		this.dueAmount = dueAmount;
	}
	public double getPaidAmount() {
		return paidAmount;
	}
	public void setPaidAmount(double paidAmount) {
		this.paidAmount = paidAmount;
	}
	@Override
	public String toString() {
		return "FeeReceivables [totalFee=" + totalFee + ", dueAmount=" + dueAmount + ", paidAmount=" + paidAmount + "]";
	}
}

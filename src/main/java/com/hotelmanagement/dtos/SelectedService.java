package com.hotelmanagement.dtos;

public class SelectedService {
    private int serviceId;
    private int quantity;
    private boolean selected;

	public SelectedService(int serviceId, int quantity) {
		super();
		this.serviceId = serviceId;
		this.quantity = quantity;
	}
	public SelectedService() {
		super();
	}
	public int getServiceId() {
		return serviceId;
	}
	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public boolean isSelected() {
		return selected;
	}
	public void setSelected(boolean selected) {
		this.selected = selected;
	}


}


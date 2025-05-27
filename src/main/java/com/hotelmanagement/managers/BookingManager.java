package com.hotelmanagement.managers;

public class BookingManager {
	 private static BookingManager instance;
	    private BookingManager() {}

	    public static synchronized BookingManager getInstance() {
	        if (instance == null) {
	            instance = new BookingManager();
	        }
	        return instance;
	    }
}

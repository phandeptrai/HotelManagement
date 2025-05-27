package com.hotelmanagement.command;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BookingCommandFactory {
	
	private Map<String, BookingCommand> commands;
	
	@Autowired 
	public BookingCommandFactory(List<BookingCommand> commandList) {
		 commands = new HashMap<>();
		for(BookingCommand cmd : commandList) {
			String key = cmd.getClass().getAnnotation(Component.class).value();
			commands.put(key, cmd);
		}

	}
	public BookingCommand getCommand(String action) {
		return commands.get(action);
	}
}

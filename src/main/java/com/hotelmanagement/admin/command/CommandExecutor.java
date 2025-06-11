
package com.hotelmanagement.admin.command;

import java.util.ArrayList;
import java.util.List;

public class CommandExecutor implements AdminCommand {
	private List<String> history = new ArrayList<>();

	public void execute(AdminCommand command) {
		command.execute();
		log(command.getDescription());
	}

	private void log(String desc) {
		history.add(desc);
		System.out.println("Command executed: " + desc);
	}

	public List<String> getHistory() {
		return history;
	}

	@Override
	public void execute() { // TODO Auto-generated method stub

	}

	@Override
	public String getDescription() { // TODO Auto-generated method stub
		return null;
	}
}

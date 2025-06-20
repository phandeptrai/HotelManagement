package com.hotelmanagement.controllers;

import com.hotelmanagement.user.entities.User;
import com.hotelmanagement.user.services.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private UserService userService;

	@GetMapping("/profile")
	public String userProfile(HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}
		model.addAttribute("user", user);
		return "user/userProfile";
	}

	@PostMapping("/update-profile")
	public String updateProfile(HttpSession session, 
			@RequestParam("fullName") String fullName,
			@RequestParam("email") String email,
			@RequestParam("phoneNumber") String phoneNumber,
			RedirectAttributes redirectAttributes) {
		
		User currentUser = (User) session.getAttribute("currentUser");
		if (currentUser == null) {
			return "redirect:/login";
		}
		
		try {
			// Validate input
			if (fullName == null || fullName.trim().isEmpty()) {
				redirectAttributes.addFlashAttribute("error", "Họ tên không được để trống!");
				return "redirect:/user/profile";
			}
			
			if (email == null || email.trim().isEmpty()) {
				redirectAttributes.addFlashAttribute("error", "Email không được để trống!");
				return "redirect:/user/profile";
			}
			
			if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
				redirectAttributes.addFlashAttribute("error", "Số điện thoại không được để trống!");
				return "redirect:/user/profile";
			}
			
			// Update user information
			currentUser.setFullName(fullName.trim());
			currentUser.setEmail(email.trim());
			currentUser.setPhoneNumber(phoneNumber.trim());
			
			// Save to database
			userService.update(currentUser);
			
			// Update session
			session.setAttribute("currentUser", currentUser);
			
			redirectAttributes.addFlashAttribute("message", "Cập nhật thông tin thành công!");
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin!");
		}
		
		return "redirect:/user/profile";
	}

	@GetMapping("/change-password")
	public String showChangePasswordForm() {
		return "user/changePassword";
	}

	@PostMapping("/change-password")
	public String changePassword(HttpSession session, @ModelAttribute("oldPassword") String oldPassword,
			@ModelAttribute("newPassword") String newPassword,
			@ModelAttribute("confirmPassword") String confirmPassword, RedirectAttributes redirectAttributes) {
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/login";
		}
		if (!newPassword.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("error", "Mật khẩu mới và xác nhận không khớp!");
			return "redirect:/user/change-password";
		}
		if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
			redirectAttributes.addFlashAttribute("error", "Mật khẩu cũ không đúng!");
			return "redirect:/user/change-password";
		}
		user.setPassword(passwordEncoder.encode(newPassword));
		userService.update(user);
		redirectAttributes.addFlashAttribute("message", "Đổi mật khẩu thành công!");
		return "redirect:/user/profile";
	}
}

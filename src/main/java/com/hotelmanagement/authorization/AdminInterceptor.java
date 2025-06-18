package com.hotelmanagement.authorization;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.hotelmanagement.user.entities.User;
import com.hotelmanagement.user.entities.UserRole;

public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute("currentUser");

            if (user != null && user.getRole() == UserRole.ROLE_ADMIN) {
                return true; // Cho phép truy cập
            }
        }

        // Chuyển hướng đến trang 403 nếu không phải admin
        response.sendRedirect(request.getContextPath() + "/403");
        return false;
    }
}

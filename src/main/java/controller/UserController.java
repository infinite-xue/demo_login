package controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import model.User;
import service.UserService;
import util.MD5Util;
import util.ResponseUtil;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@RequestMapping("/findByName")
	public void findByName(String username, HttpServletResponse response) {
		int i = userService.findByName(username);
		if (i != 1) {
			ResponseUtil.wirter(response, "{success: false, errorInfo: '用户名不存在'}");
		}
		ResponseUtil.wirter(response, "{success: true}");
	}

	@RequestMapping("/login")
	public void login(User user, @RequestParam(value = "remember", required = false) String remember, HttpServletResponse response, HttpServletRequest request) {
		String inputPassword = user.getPassword();
		user.setPassword(MD5Util.getMD5(inputPassword));
		User loginUser = userService.login(user);
		if (loginUser == null) {
			ResponseUtil.wirter(response, "{success: false, errorInfo: '密码错误'}");
		} else {
			if (remember.equals("remember")) {
				Cookie cookie = new Cookie("cpeam", user.getUsername() + "-" + inputPassword);
				cookie.setPath("/");
				cookie.setMaxAge(60 * 60 * 24);
				response.addCookie(cookie);
			}
			request.getSession().setAttribute("loginUser", loginUser);
			request.getSession().setAttribute("loginDate", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			ResponseUtil.wirter(response, "{success: true}");
		}
	}

	@RequestMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().invalidate();
		ResponseUtil.wirter(response, "{success: true}");
	}

}

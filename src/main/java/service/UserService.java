package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.UserDao;
import model.User;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;

	public int findByName(String username) {
		return userDao.findByName(username);
	}

	public User login(User user) {
		return userDao.login(user);
	}
	
}

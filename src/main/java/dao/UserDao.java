package dao;

import model.User;

public interface UserDao {

	public abstract int findByName(String username);

	public abstract User login(User user);

}

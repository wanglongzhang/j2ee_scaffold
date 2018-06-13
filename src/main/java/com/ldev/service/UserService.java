package com.ldev.service;

import java.util.List;

import com.ldev.entity.User;

public interface UserService {

	List<User> getUserList(int offset, int limit);
	 
}

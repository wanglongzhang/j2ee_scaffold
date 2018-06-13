package com.ldev.service;

import com.ldev.entity.Permission;

import java.util.List;

public interface PermissionService {

	List<Permission> getPermissionList(int offset, int limit);
	 
}

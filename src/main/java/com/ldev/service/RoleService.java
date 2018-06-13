package com.ldev.service;

import java.util.List;
import com.ldev.entity.Role;

public interface RoleService {
	List<Role> getRoleList(int offset, int limit);
}

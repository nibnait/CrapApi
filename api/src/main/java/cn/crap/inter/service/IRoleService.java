package cn.crap.inter.service;

import cn.crap.framework.base.IBaseService;
import cn.crap.model.Role;

public interface IRoleService extends IBaseService<Role>{
	void getAuthFromRole(StringBuilder sb, Role role);
}

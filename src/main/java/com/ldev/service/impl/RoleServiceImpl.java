package com.ldev.service.impl;

import com.ldev.cache.RedisCache;
import com.ldev.dao.PermissionDao;
import com.ldev.dao.RoleDao;
import com.ldev.entity.Permission;
import com.ldev.entity.Role;
import com.ldev.service.RoleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {

    private final Logger LOG = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private RoleDao roleDao;
    @Autowired
    private RedisCache<String, String> cache;
    
    
    @Override
    public List<Role> getRoleList(int offset, int limit) {
        String cache_key = RedisCache.CAHCENAME+"|getRoleList|"+offset+"|"+limit;
        //先去缓存中取
        List<Role> result_cache=cache.getListCache(cache_key, Role.class);
        if(result_cache==null)
        {
            //缓存中没有再去数据库取，并插入缓存（缓存时间为60秒）
            result_cache = roleDao.queryAll(offset, limit);
            cache.putListCacheWithExpireTime(cache_key, result_cache, RedisCache.CAHCETIME);
            LOG.info("put cache with key:"+cache_key);
        }
        else
            {
            LOG.info("get cache with key:"+cache_key);
        }
        return result_cache;
    }

    List<Role> findUserRole(String userName)
    {
        roleDao.queryAllRoleByUserName(userName);
    }
    
    

}

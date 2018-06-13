package com.ldev.service.impl;

import com.ldev.cache.RedisCache;
import com.ldev.dao.PermissionDao;
import com.ldev.dao.UserDao;
import com.ldev.entity.Permission;
import com.ldev.entity.User;
import com.ldev.service.PermissionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionServiceImpl implements PermissionService {

    private final Logger LOG = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private PermissionDao permissionDao;
    @Autowired
    private RedisCache cache;
    
    
    @Override
    public List<Permission> getPermissionList(int offset, int limit) {
        String cache_key = RedisCache.CAHCENAME+"|getPermissionList|"+offset+"|"+limit;
        //先去缓存中取
        List<Permission> result_cache=cache.getListCache(cache_key, Permission.class);
        if(result_cache==null)
        {
            //缓存中没有再去数据库取，并插入缓存（缓存时间为60秒）
            result_cache = permissionDao.queryAll(offset, limit);
            cache.putListCacheWithExpireTime(cache_key, result_cache, RedisCache.CAHCETIME);
            LOG.info("put cache with key:"+cache_key);
        }
        else
            {
            LOG.info("get cache with key:"+cache_key);
        }
        return result_cache;
    }
    
    

}

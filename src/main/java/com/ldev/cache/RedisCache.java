package com.ldev.cache;

import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import com.ldev.util.ProtoStuffSerializerUtil;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

/**
 * redis缓存
 * 
 * @author ldev
 *
 */
@Component
public class RedisCache<K, V> implements Cache<K, V> {
    
    
    public final static String CAHCENAME="cache";//缓存名
    public final static int CAHCETIME=60;//默认缓存时间
    private long expireTime = 120;// 缓存的超时时间，单位为s

    @Autowired
    private RedisTemplate<K, V> redisTemplate;

    public RedisCache(long expireTime) {
        this.expireTime = expireTime;
    }

    public <V> boolean putCache(String key, V obj) {
        final byte[] bkey = key.getBytes();
        final byte[] bvalue = ProtoStuffSerializerUtil.serialize(obj);
        boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                return connection.setNX(bkey, bvalue);
            }
        });
        return result;
    }

    public <V> void putCacheWithExpireTime(String key, V obj, final long expireTime) {
        final byte[] bkey = key.getBytes();
        final byte[] bvalue = ProtoStuffSerializerUtil.serialize(obj);
        redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.setEx(bkey, expireTime, bvalue);
                return true;
            }
        });
    }

    public <V> boolean putListCache(String key, List<V> objList) {
        final byte[] bkey = key.getBytes();
        final byte[] bvalue = ProtoStuffSerializerUtil.serializeList(objList);
        boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                return connection.setNX(bkey, bvalue);
            }
        });
        return result;
    }

    public <V> boolean putListCacheWithExpireTime(String key, List<V> objList, final long expireTime) {
        final byte[] bkey = key.getBytes();
        final byte[] bvalue = ProtoStuffSerializerUtil.serializeList(objList);
        boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.setEx(bkey, expireTime, bvalue);
                return true;
            }
        });
        return result;
    }

    public <V> V getCache(final String key, Class<V> targetClass)
    {
        byte[] result = redisTemplate.execute(new RedisCallback<byte[]>() {
            @Override
            public byte[] doInRedis(RedisConnection connection) throws DataAccessException {
                return connection.get(key.getBytes());
            }
        });
        if (result == null) {
            return null;
        }
        return ProtoStuffSerializerUtil.deserialize(result, targetClass);
    }

    public <V> List<V> getListCache(final String key, Class<V> targetClass)
    {
        byte[] result = redisTemplate.execute(new RedisCallback<byte[]>() {
            @Override
            public byte[] doInRedis(RedisConnection connection) throws DataAccessException {
                return connection.get(key.getBytes());
            }
        });
        if (result == null) {
            return null;
        }
        return ProtoStuffSerializerUtil.deserializeList(result, targetClass);
    }

    /**
     * 精确删除key
     * 
     * @param key
     */
    public void deleteCache(K key)
    {
        redisTemplate.delete(key);
    }

    /**
     * 模糊删除key
     * 
     * @param pattern
     */
    public void deleteCacheWithPattern(K pattern) {
        Set<K> keys = redisTemplate.keys(pattern);
        redisTemplate.delete(keys);
    }

    /**
     * 通过key来获取对应的缓存对象
     * 通过源码我们可以发现，shiro需要的key的类型为Object，V的类型为AuthorizationInfo对象
     */
    @Override
    public V get(K key) throws CacheException {
        return redisTemplate.opsForValue().get(key);
    }

    /**
     * 将权限信息加入缓存中
     */
    @Override
    public V put(K key, V value) throws CacheException {
        redisTemplate.opsForValue().set(key, value, this.expireTime, TimeUnit.SECONDS);
        return value;
    }

    /**
     * 将权限信息从缓存中删除
     */
    @Override
    public V remove(K key) throws CacheException {
        V v = redisTemplate.opsForValue().get(key);
        redisTemplate.opsForValue().getOperations().delete(key);
        return v;
    }

    @Override
    public void clear() throws CacheException
    {
    }

    @Override
    public int size() {
        return 0;
    }

    @Override
    public Set<K> keys() {
        return null;
    }

    @Override
    public Collection<V> values() {
        return null;
    }
}

package com.springmvc.redis.service;

import com.springmvc.db.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.*;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("userRedisService")
public class UserRedisService {

    @Autowired
    private RedisTemplate redisTemplate;

    public User login(Map<String, String> map) {
        try {
            ValueOperations<String, User> valueops = redisTemplate.opsForValue();
            return valueops.get("user.uid." + map.get("userid"));
        } catch (Exception e) {
            return null;
        }

    }

    public void add(Map<String, String> map) {
        User user = new User();
        user.setMap(map);
        add(user);
    }

    public void add(User user) {
        try {
            ValueOperations<String, User> valueops = redisTemplate.opsForValue();
            valueops.set("user.uid." + user.getUserid(), user);
        } catch (Exception e) {
        }
    }

    public User getUserByUserId(String userid) {
        try {
            ValueOperations<String, User> valueops = redisTemplate.opsForValue();
            return valueops.get("user.uid." + userid);
        } catch (Exception e) {
            return null;
        }
    }


//    public void register(User user) {
//        redisTemplate.execute(new RedisCallback<Object>() {
//            @Override
//            public Object doInRedis(RedisConnection connection)
//                    throws DataAccessException {
//                byte[] key = redisTemplate.getStringSerializer().serialize(
//                        "user.uid." + map.get("userid"));
//                BoundHashOperations<Serializable, byte[], byte[]> boundHashOperations = redisTemplate.boundHashOps(key);
//                for (String keyStr : map.keySet()) {
//                    //map.keySet()返回的是所有key的值
//                    //得到每个key多对用value的值map.get(keyStr);
//                    boundHashOperations.put(redisTemplate.getStringSerializer().serialize(keyStr),
//                            redisTemplate.getStringSerializer().serialize(map.get(keyStr)));
//                }
//                return null;
//            }
//        });
//        return false;
//    }
}

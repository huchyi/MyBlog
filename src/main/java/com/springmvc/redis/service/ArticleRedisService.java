package com.springmvc.redis.service;

import com.springmvc.db.model.ArticleModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.*;
import org.springframework.stereotype.Service;

/**
 * 1. 连接池自动管理，提供了一个高度封装的“RedisTemplate”类
 * 2. 针对jedis客户端中大量api进行了归类封装,将同一类型操作封装为operation接口
 * ValueOperations：简单K-V操作
 * SetOperations：set类型数据操作
 * ZSetOperations：zset类型数据操作
 * HashOperations：针对map类型的数据操作
 * ListOperations：针对list类型的数据操作
 * 3. 提供了对key的“bound”(绑定)便捷化操作API，可以通过bound封装指定的key，然后进行一系列的操作而无须“显式”的再次指定Key，即BoundKeyOperations：
 * BoundValueOperations
 * BoundSetOperations
 * BoundListOperations
 * BoundSetOperations
 * BoundHashOperations
 * <p>
 * 4. 将事务操作封装，有容器控制。
 * 5. 针对数据的“序列化/反序列化”，提供了多种可选择策略(RedisSerializer)
 * JdkSerializationRedisSerializer：POJO对象的存取场景，使用JDK本身序列化机制，将pojo类通过ObjectInputStream/ObjectOutputStream进行序列化操作，最终redis-server中将存储字节序列。是目前最常用的序列化策略。
 * StringRedisSerializer：Key或者value为字符串的场景，根据指定的charset对数据的字节序列编码成string，是“new String(bytes, charset)”和“string.getBytes(charset)”的直接封装。是最轻量级和高效的策略。
 * JacksonJsonRedisSerializer：jackson-json工具提供了javabean与json之间的转换能力，可以将pojo实例序列化成json格式存储在redis中，也可以将json格式的数据转换成pojo实例。因为jackson工具在序列化和反序列化时，需要明确指定Class类型，因此此策略封装起来稍微复杂。【需要jackson-mapper-asl工具支持】
 * OxmSerializer：提供了将javabean与xml之间的转换能力，目前可用的三方支持包括jaxb，apache-xmlbeans；redis存储的数据将是xml工具。不过使用此策略，编程将会有些难度，而且效率最低；不建议使用。【需要spring-oxm模块的支持】
 * 针对“序列化和发序列化”中JdkSerializationRedisSerializer和StringRedisSerializer是最基础的策略，原则上，我们可以将数据存储为任何格式以便应用程序存取和解析(其中应用包括app，Hadoop等其他工具)，不过在设计时仍然不推荐直接使用“JacksonJsonRedisSerializer”和“OxmSerializer”，因为无论是json还是xml，他们本身仍然是String。
 * 如果你的数据需要被第三方工具解析，那么数据应该使用StringRedisSerializer而不是JdkSerializationRedisSerializer。
 * 如果你的数据格式必须为json或者xml，那么在编程级别，在redisTemplate配置中仍然使用StringRedisSerializer，在存储之前或者读取之后，使用“SerializationUtils”工具转换转换成json或者xml，请参见下文实例。
 * <p>
 * 6. 基于设计模式，和JMS开发思路，将pub/sub的API设计进行了封装，使开发更加便捷。
 * 7.spring-data-redis中，并没有对sharding提供良好的封装，如果你的架构是基于sharding，那么你需要自己去实现，这也是sdr和jedis相比，唯一缺少的特性。
 */
@Service("articleRedisService")
public class ArticleRedisService {

    @Autowired
    private RedisTemplate redisTemplate;

//    public ArticleModel getArticleById(int id) {
//        try {
//            ValueOperations<String, ArticleModel> ops = redisTemplate.opsForValue();
//            System.out.println(">>>>>>>>>>>>ArticleRedisService getArticleById:" + "article.id." + id);
//            return ops.get("article.id." + id);
//        } catch (Exception e) {
//            System.out.println(">>>>>>>>>>>>ArticleRedisService getArticleById Exception:" + e.getMessage());
//            return null;
//        }
//    }

    public int getPageCount() {
        try {
            ValueOperations<String, Integer> ops = redisTemplate.opsForValue();
            return ops.get("article.pageCount");
        } catch (Exception e) {
            return -1;
        }
    }

    public void setPageCount(int num) {
        try {
            ValueOperations<String, Integer> ops = redisTemplate.opsForValue();
            ops.set("article.pageCount", num, 60 * 60 * 24);
        } catch (Exception e) {
        }
    }

//    public List<ArticleModel> getArticleByuserid(String userid) {
//        try {
//            ValueOperations<String, List<ArticleModel>> valueops = redisTemplate.opsForValue();
//            return valueops.get("article.userid..list.article." + userid);
//        } catch (Exception e) {
//            return null;
//        }
//    }
//
//    public void setArticleByuserid(String userid,List<ArticleModel> models) {
//        try {
//            ValueOperations<String, List<ArticleModel>> valueops = redisTemplate.opsForValue();
//            valueops.set("article.userid.list.article." + userid,models);
//        } catch (Exception e) {
//        }
//    }

//    public void insertOne(ArticleModel articleModel) {
//        try {
//            ValueOperations<String, ArticleModel> ops = redisTemplate.opsForValue();
//            System.out.println(">>>>>>>>>>>>ArticleRedisService insertOne :" + "article.id." + articleModel.getId());
//            ops.set("article.id." + articleModel.getId(), articleModel);
//
//        } catch (Exception e) {
//        }
//    }
//
//    public void updateOne(ArticleModel articleModel) {
//        try {
//            ValueOperations<String, ArticleModel> ops = redisTemplate.opsForValue();
//            ops.set("article.id." + articleModel.getId(), articleModel);
//        } catch (Exception e) {
//        }
//    }
}

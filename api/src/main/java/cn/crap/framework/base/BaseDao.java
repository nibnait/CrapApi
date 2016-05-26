package cn.crap.framework.base;

import java.lang.reflect.ParameterizedType;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.hibernate.Query;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.transaction.annotation.Transactional;

import cn.crap.utils.MyString;
import cn.crap.utils.Page;
import cn.crap.utils.Tools;

@SuppressWarnings("unchecked")
public class BaseDao<T extends BaseModel> implements IBaseDao<T> {
	@Resource
	protected HibernateTemplate hibernateTemplate;

	public IBaseDao<T> genericDao;
	
	Class<T> entity;

	String entityName;

	public BaseDao() {
		this.entity = (Class<T>) ((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
		this.entityName = entity.getName();
	}

	
	@Transactional
	public T save(T t) {
		hibernateTemplate.save(entityName, t);
		return t;
	}

	
	@Transactional
	public List<T> saveAll(List<T> list) {
		for (T t : list) {
			hibernateTemplate.merge(entityName, t);
		}
		return list;
	}

	
	@Transactional
	public void delete(T t) {
		hibernateTemplate.delete(entityName, t);
	}

	
	@Transactional
	public void deleteAll(List<T> list) {
		hibernateTemplate.deleteAll(list);
	}

	
	@Transactional
	public T get(String m) {
		return (T) hibernateTemplate.get(entity, m);
	}

	
	@Transactional
	public List<T> findByExample(T t) {
		return hibernateTemplate.findByExample(entityName, t);
	}

	
	@Transactional
	public List<T> loadAll(T t) {
		return hibernateTemplate.loadAll(entity);
	}

	
	@Transactional
	public void update(T t) {
		 hibernateTemplate.update(t);
	}
	
	
	@Transactional
	public int update(String hql, Map<String, Object> map) {
		Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery(hql);  
		Tools.setQuery(map, query);
		return query.executeUpdate();  
	}
	
	
	@Transactional
	public List<?> queryByHql(String hql, Map<String, Object> map) {
		Query query = hibernateTemplate.getSessionFactory().getCurrentSession()
				.createQuery(hql);
		Tools.setQuery(map, query);
		return query.list();
	}
	
	
	@Transactional
	public int getCount(Map<String, Object> map, String conditions) {
		String hql = "select count(*) from " + entity.getSimpleName() + conditions;
		
		Query query = hibernateTemplate.getSessionFactory().getCurrentSession()
				.createQuery(hql);
		Tools.setQuery(map, query);
		return Integer.parseInt(query.uniqueResult().toString());
	}

	@Transactional
	public List<T> findByMap(Map<String, Object> map,
			Page pageBean, String order) {
		String conditions = Tools.getHql(map);
		String hql = "from "+entity.getSimpleName() + conditions + (MyString.isEmpty(order) ? " order by sequence desc, createTime desc" : " order by " + order);
		Query query = hibernateTemplate.getSessionFactory().getCurrentSession()
				.createQuery(hql);
		if(pageBean!=null){
			pageBean.setAllRow(getCount(map, conditions));
			if(pageBean.getCurrentPage()>pageBean.getTotalPage())
				pageBean.setCurrentPage(pageBean.getTotalPage());
		}
		Tools.setPage(query, pageBean);
		Tools.setQuery(map, query);
		return query.list();
	}
}

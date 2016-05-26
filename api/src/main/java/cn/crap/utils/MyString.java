package cn.crap.utils;

import java.util.List;

/**
 * 判空
 * <p>Title: MyString.java </p>  
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2016 </p>  
 * <p>WebSite: www.nibnait.com </p>
 * @Author nibnait
 * @Date 2016年5月26日 下午3:12:42
 * @Version 1.0
 */
public class MyString {
	public static boolean isEquals(String tagValue,String value)
	{
		if(isEmpty(tagValue))
			return false;
		else if(tagValue.equals(value))
			return true;
		else
			return false;
	}
	/**
	 * 判断对象是否为空
	 * Object = null
	 * String = "","null","undefined"
	 * List size=0
	 * @param object
	 * @return
	 */
	public static boolean isEmpty(Object object)
	{
		if(object instanceof String){
			if(object == null||object.toString().trim().equals("")||object.toString().trim().equals("null")||object.toString().equals("undefined"))
				return true;
		}else if(object instanceof List<?>){
			if(object == null ||((List<?>)object).size()==0)
				return true;
		}else if(object == null){
			return true;
		}
		return false;
	}
}

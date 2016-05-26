package cn.crap.utils.enums;

public enum ParameterType {
	HEADER("请求头"),PARAMETER("请求参数");
	private final String name;
	
	private ParameterType(String name){
		this.name = name;
	}
	public String getName(){
		return name;
	}
}

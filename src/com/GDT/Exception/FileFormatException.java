package com.GDT.Exception;

/**
 * 用于当上传文件类型不匹配时抛出异常
 * @author zero
 */
public class FileFormatException extends Exception{
	private static final long serialVersionUID = 1L;
	
	public FileFormatException(){
		super("文件格式不正确");
	}
	
	public FileFormatException(String str){
		super(str);
	}
}

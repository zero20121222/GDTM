package com.GDT.Filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * 实现一个访问服务器的一个延时操作设置
 * @author zero
 */
public class DelayEnviromentFilter implements Filter{
	private static int delayTime = 0;
	
	public void destroy() {
		System.out.println("销毁DelayEnviromentFilter");
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		//模拟网络延时
		try{
			Thread.sleep(delayTime);
		}catch(Exception e){
			e.printStackTrace();
		}
		chain.doFilter(request, response);
	}

	public void init(FilterConfig filter) throws ServletException {
		//模拟网络延时测试
		delayTime = filter.getInitParameter("delayTime") == null ? 0 : Integer.parseInt(filter.getInitParameter("delayTime"));
	}
}

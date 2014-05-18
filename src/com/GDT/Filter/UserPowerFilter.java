package com.GDT.Filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 用户权限过滤器
 * @author zero
 */
public class UserPowerFilter implements Filter{
	private static String ENCODING = null; 
	private static String PARGMA = null;
	private static String CACHECONTROL = null;
	private static int EXPIRES = 0;
	
	public void destroy() {
		System.out.println("销毁Filter");
	}

	public void doFilter(ServletRequest request, ServletResponse servletresponse,
			FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding(ENCODING);
		
		HttpServletResponse response = (HttpServletResponse)servletresponse;
		response.setCharacterEncoding(ENCODING);//设置返回编码方式
		//设置页面缓存
		response.setHeader("Pargma", PARGMA);
		response.setHeader("Cache-Control", CACHECONTROL);
        response.setDateHeader("Expires", EXPIRES);
		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig filter) throws ServletException {
		ENCODING = filter.getInitParameter("ENCODING") == null ? "UTF-8" : filter.getInitParameter("ENCODING");//获取设置的过滤编码方式
		
		//设置页面缓存
		PARGMA = filter.getInitParameter("Pargma") == null ? "no-cache" : filter.getInitParameter("Pargma");
		CACHECONTROL = filter.getInitParameter("Cache-Control") == null ? "no-cache" : filter.getInitParameter("Cache-Control");
		EXPIRES = filter.getInitParameter("Expires") == null ? 0 : Integer.parseInt(filter.getInitParameter("Expires"));
	}
}

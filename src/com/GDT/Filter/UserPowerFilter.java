package com.GDT.Filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 用户权限过滤器
 * @author zero
 */
public class UserPowerFilter implements Filter{
	private static String NO_FILTERS[] = null;

	public void destroy() {
		System.out.println("UserPowerFilter destroy.");
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletresponse,
			FilterChain chain) throws IOException, ServletException {
		HttpServletResponse response = (HttpServletResponse)servletresponse;

        HttpServletRequest request = (HttpServletRequest)servletRequest;
        String realPath = request.getRequestURL().toString();

        if(!checkPath(realPath)){
            //学生教师用户是否已登入的判断
            if(request.getSession().getAttribute("user_id") == null){
                request.getRequestDispatcher("mainLogin.jsp").forward(request , response);
            }
        }
		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig filter) throws ServletException {
        System.out.println("UserPowerFilter init.");

        String noFilter = filter.getInitParameter("noFilter");
        if(noFilter != null){
            NO_FILTERS = noFilter.split(",");
        }
	}

    /**
     * 设置的无需过滤访问的数据
     * @param realPath 相对路径
     * @return 返回是否可以访问
     */
    private Boolean checkPath(String realPath){
        Boolean result = false;

        if(NO_FILTERS.length != 0){
            for(String path : NO_FILTERS){
                if(realPath.indexOf(path) != -1){
                    result = true;
                    break;
                }
            }
        }

        return result;
    }
}

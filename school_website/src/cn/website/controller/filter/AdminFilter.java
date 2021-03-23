package cn.website.controller.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AdminFilter implements Filter {

    //后台登录验证
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();

        String url = request.getRequestURI();

        if (url.contains("/admin") && session.getAttribute("admin_user") == null) {
            response.setCharacterEncoding("utf-8");
            response.getWriter().write("登录信息丢失，请先登录！");
            return;
        }

        filterChain.doFilter(servletRequest, servletResponse);

    }

}

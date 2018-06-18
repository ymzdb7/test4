package com.crm.auth;

import org.springframework.http.HttpStatus;  
import org.springframework.web.method.HandlerMethod;  
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import java.io.PrintWriter;  
import java.util.Set;  

public class AuthInterceptor extends HandlerInterceptorAdapter {  
    public static final String SESSION_USERID = "kUSERID";  
    public static final String SESSION_AUTHS = "kAUTHS";  
    
    @Override  
    public boolean preHandle(HttpServletRequest request,  
            HttpServletResponse response, Object handler) throws Exception {  
        boolean flag = true;  
        if (handler instanceof HandlerMethod) {  
            Auth auth = ((HandlerMethod) handler).getMethod().getAnnotation(Auth.class);  
            if (auth != null) {// 有权限控制的就要检查  
                //if (request.getSession().getAttribute(SESSION_USERID) == null) {// 没登录就要求登录
            	if (request.getSession().getAttribute("userInfo") == null
            			&& (request.getAttribute("pid") == null 
            			|| ((String)request.getAttribute("pid")).trim().equals(""))) {
                    response.setStatus(HttpStatus.FORBIDDEN.value());  
                    response.setContentType("text/html; charset=UTF-8");  
                    PrintWriter out=response.getWriter();  
                    out.write("{\"success\":\"false\",\"message\":\"请您先登录!\"}");  
                    out.flush();  
                    out.close();  
                    flag = false;  
                } else {// 登录了检查,方法上只是@Auth,表示只要求登录就能通过.@Auth("authority")这类型,验证用户权限  
                    if (!"".equals(auth.value())) {  
                        Set<String> auths = (Set<String>) request.getSession().getAttribute(SESSION_AUTHS);  
                        if (!auths.contains(auth.value())) {// 提示用户没权限  
                            response.setStatus(HttpStatus.FORBIDDEN.value());  
                            response.setContentType("text/html; charset=UTF-8");  
                            PrintWriter out=response.getWriter();  
                            out.write("{\"success\":\"false\",\"message\":\"您没有"+auth.name()+"权限!\"}");  
                            out.flush();  
                            out.close();  
                            flag = false;  
                        }
                    }  
                }  
            }  
        }  
        return flag;  
    }  
}  

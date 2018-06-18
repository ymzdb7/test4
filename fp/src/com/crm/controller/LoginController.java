package com.crm.controller;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.auth.Auth;
import com.crm.auth.AuthInterceptor;
import com.crm.entity.AppInfo;
import com.crm.entity.Menu;
import com.crm.entity.UserInfo;
import com.crm.entity.UserInfoPresent;
import com.crm.service.CustomerService;
import com.crm.service.LoginService;
import com.crm.util.MenuUtils;
import com.crm.util.ResultMapUtil;
import com.sun.istack.internal.logging.Logger;

@Controller
public class LoginController {

	Logger log = Logger.getLogger(LoginController.class);
	
	@Resource
	private LoginService service;
	@Resource
	private CustomerService cservice;
	
	@RequestMapping("/login.do")
	public String login(Model model,String loginNm,String password,HttpSession hs){

		/* 获取前端传过来的参数 */
		/* 检查用户名 密码是否合法 */
		if (loginNm==null || loginNm.trim().equals("")){
			//log.info("用户名为空");
			model.addAttribute("errors", "用户名为空");
			return "../login"; 
		}
		
		UserInfoPresent user = this.service.loginUserInfo(loginNm, password);
		if(null == user || user.equals("")){			
			//log.info("检查用户名 密码失败-用户名或密码错误");
			model.addAttribute("errors", "用户名或密码错误");
			return "../login"; 
		}


		//Map<String,String> map = this.service.getUserExtendInfo(user); 
		
		hs.setAttribute("userInfo", user);
		/*生成动态菜单,并返回前端页面*/
		List<Menu> list = this.service.getPowerMenu(user.getPid());
		String menus = MenuUtils.buildMenus(list);
		model.addAttribute("menus", menus);
		model.addAttribute("pname", user.getPname());
		model.addAttribute("oname", user.getOname());
		model.addAttribute("dname", user.getDname());
		model.addAttribute("phone", user.getPhone());
		
		return "/index";
	}
	
	/**
	 * APP专用登录
	 * @param loginNm
	 * @param password
	 * @param hs
	 * @return
	 */
	@RequestMapping("/clientLogin.do")
	@ResponseBody
	public Object clientLogin(String loginNm,String password,HttpSession hs){

		/* 获取前端传过来的参数 */
		/* 检查用户名 密码是否合法 */
		if (loginNm==null || loginNm.trim().equals("")){
			//log.info("用户名为空");
			return ResultMapUtil.resultMapObject(false, "用户名为空");
		}
		
		UserInfoPresent user = this.service.loginUserInfo(loginNm, password);
		if(null == user || user.equals("")){			
			//log.info("检查用户名 密码失败-用户名或密码错误");
			return ResultMapUtil.resultMapObject(false, "用户名或密码错误");
		}

		//UserInfoPresent uip = this.cservice.getUserInfoByPid(user.getPid());
		
		hs.setAttribute("userInfo", user);
		/*生成动态菜单,并返回前端页面*/
		//List<UserInfo> list = new ArrayList<UserInfo>();
		return ResultMapUtil.resultMapObject("true","登录成功",user);
	}
		
	@RequestMapping("/setAppVersion.do")
	@ResponseBody
	public Map<String, Object> setAppVersion(AppInfo ai){
		return this.service.setAppVersion(ai);
	}

	
	@RequestMapping("/getAppVersion.do")
	@ResponseBody
	public Map<String, Object> getAppVersion(){
		return this.service.getAppVersion();
	}
	

    @RequestMapping("/logout.do")  
    public String logout(HttpSession session){  

    	session.removeAttribute("userInfo");  //注销session中的username对象
    	session.invalidate();                 //关闭session

    	return "../login";
 
    }  

    @Auth  
    @RequestMapping("/query.do")  
    @ResponseBody  
    public String query(){  
        System.out.println("query");  
        return getClass().toString();  
    }  
    
    @Auth 
    @RequestMapping("/list.do")  
    @ResponseBody  
    public String list(){  
        System.out.println("list");  
        return getClass().toString();  
    }  

    @Auth
    @RequestMapping("/add.do")  
    @ResponseBody  
    public String add(UserInfo user){  
        System.out.println("add:"+user);  
        return getClass().toString(); //"user/add";  
    }  

}

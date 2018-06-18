package com.crm.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.Org;
import com.crm.entity.PubSearchInfo;
import com.crm.entity.PublishInfoPresent;
import com.crm.entity.UserInfo;
import com.crm.service.ConsultService;
import com.crm.service.CustomerService;
import com.crm.service.DeptService;
import com.crm.service.PublishService;
import com.sun.istack.internal.logging.Logger;

/* 
 *教育信息
 */
@Controller
@RequestMapping("/pub")
public class PublishController {

	/* 日志 */
	Logger log = Logger.getLogger(PublishController.class);

	@Resource
	private ConsultService cservice;
	@Resource
	private PublishService service;
	@Resource
	private DeptService dservice;
	@Resource
	private CustomerService custservice;

	/**
	 * 根据pid获取对应行政区划,获得全部咨询信息，typeId对应信息类型
	 * int typeId  参数说明如下：
	 *				首页免登陆的分类编码信息：
	 *				农耕养殖技术：1
	 *				就业创业信息：2
	 *				惠农政策宣传：3
	 *				新闻时事报道：4
	 			
					需要登录读取的信息：
					扶贫政策：	5
					信息发布：	6
	 * @param page
	 * @param rows
	 * @param hs
	 * @return
	 */
	@RequestMapping("/getPublishInfo.do")
	@ResponseBody
	public Map<String,Object> getPublishInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		int typeId,
		HttpSession hs) {
		
		int p = 1;//默认第一页
		int r = 10;//默认每页十行
		if (page==null || page.trim().equals("")){
			p = 1;
		}else{
			p = Integer.parseInt(page);
		}
		
		if (rows==null || rows.trim().equals("")){
			r = 10;
		}else{
			r = Integer.parseInt(rows);
		}

		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int oid = 0;
		int f = 0;
		if (us != null){
			f = 1;
			oid = this.custservice.getOidByPid(us.getPid());
		}else{
			f = 0;
			if (typeId == 5 || typeId == 6) {//扶贫政策、信息宣传需要登录
				oid = this.custservice.getOidByPid((pid==null)?0:pid);
			}else{//1-4类型不需要登录
				oid = 0;
			}
		}

		return this.service.getPublishInfo(p, r, typeId,oid, f);
	}
		
	@RequestMapping("/searchInfo.do")
	@ResponseBody
	public Map<String,Object> getSearchInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		int typeId,
		PubSearchInfo psi,
		HttpSession hs) {
		
		int p = 1;//默认第一页
		int r = 10;//默认每页十行
		if (page==null || page.trim().equals("")){
			p = 1;
		}else{
			p = Integer.parseInt(page);
		}
		
		if (rows==null || rows.trim().equals("")){
			r = 10;
		}else{
			r = Integer.parseInt(rows);
		}

		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int oid = 0;
		int f = 0;
		if (us != null){
			f = 1;
			oid = this.custservice.getDidByPid(us.getPid());
		}else{
			f = 0;
			if (typeId == 5 || typeId == 6) {//扶贫政策、信息宣传需要登录
				oid = this.custservice.getDidByPid((pid==null)?0:pid);
			}else{//1-4类型不需要登录
				oid = 0;
			}
		}

		return this.service.getSearchInfo(p, r, typeId,oid, f, psi);
	}
		
	/**
	 * 根据记录的ID号获取用户信息
	 * @param id
	 * @param hs
	 * @return
	 */
	@RequestMapping("/getPublishInfoById.do")
	@ResponseBody
	public Map<String,Object> getPublishInfoById(
		@RequestParam(value = "id", required = false) Integer id,
		HttpSession hs) {
		
		return this.service.getPublishInfoById(id);
	}
	
	@RequestMapping("/savePublishInfo.do")
	@ResponseBody
	public Object savePublishInfo(PublishInfoPresent pip,
			Integer pid,
			HttpSession hs) {

		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		if (us != null){
			pip.setOid(us.getOid());
		}else{
			pip.setOid(this.custservice.getOidByPid(pid));
		}
        return this.service.savePublishInfo(pip);
	}

	@RequestMapping("/updatePublishInfo.do")
	@ResponseBody
	public Object updatePublishInfo(PublishInfoPresent pip,
			@RequestParam(value = "pid", required = false) Integer pid,
			HttpSession hs) {
		
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		if (us != null){
			pip.setOid(us.getOid());
		}else{
			pip.setOid(this.custservice.getOidByPid(pid));
		}
        return this.service.updatePublishInfo(pip);
	}

	@RequestMapping("/getConsultType.do")
	@ResponseBody
	public Object getConsultType(){
		return this.cservice.getConsultType();
	}
	
	@RequestMapping("/getOrgByOid.do")
	@ResponseBody
	public List<Org> getOrgByOid(
			@RequestParam(value = "pid", required = false) Integer pid,
			HttpSession hs) {
		
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int oid = 0;
		if (us != null){
			oid = us.getOid();
		}else{
			oid = this.custservice.getOidByPid(pid);
		}

		return this.service.getOrgByOid(oid);
	}

	@RequestMapping("/stopPublish.do")
	@ResponseBody
	public Object stopPublish(int stopFlag,int id){
		if (stopFlag == 2){
			return this.deletePublish(id);
		}else{
			return this.service.stopPublish(stopFlag,id);
		}
	}
	
	@RequestMapping("/deletePublish.do")
	@ResponseBody
	public Object deletePublish(int id){
		return this.service.deletePublish(id);
	}

}

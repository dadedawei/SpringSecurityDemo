package com.hnx.security.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class GongfuController {
	
	/**
	 * 授权（权限检查）使用AOP；MethodSecurityInterceptor
	 * 方法执行之前AccessDecisionManager利用投票机制决定这个方法是否可运行
	 */
	@PreAuthorize("hasRole('学徒') AND hasAuthority('putong:luohanquan')")
	@GetMapping("/level1/1")
	public String leve1Page1(){
		return "/level1/1";
	}
	
	@PreAuthorize("hasRole('学徒') AND hasAuthority('putong:wudangchangquan')")
	@GetMapping("/level1/2")
	public String leve1Page2(){
		return "/level1/2";
	}
	
	@PreAuthorize("hasRole('学徒') AND hasAuthority('putong:quanzhenjianfa')")
	@GetMapping("/level1/3")
	public String leve1Page3(){
		return "/level1/3";
	}
	
	@GetMapping("/level1/{path}")
	public String leve1Page(@PathVariable("path")String path){
		return "/level1/"+path;
	}
	
	@GetMapping("/level2/{path}")
	public String leve2Page(@PathVariable("path")String path){
		return "/level2/"+path;
	}
	
	@GetMapping("/level3/{path}")
	public String leve3Page(@PathVariable("path")String path){
		return "/level3/"+path;
	}

}

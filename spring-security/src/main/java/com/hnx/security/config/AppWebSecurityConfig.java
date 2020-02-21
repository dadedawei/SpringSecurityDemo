package com.hnx.security.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;


@EnableGlobalMethodSecurity(prePostEnabled = true)	//开启细粒度全局方法几倍的权限控制功能
@Configuration	//声明当前类是一个配置类，相当于xml配置文件作用
@EnableWebSecurity	//声明式配置，启用SpringSecurity安全机制
public class AppWebSecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	UserDetailsService userDetailsService;//用户详情查询服务组件的接口
	
	@Autowired
	//PasswordEncoder passwordEncoder;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		//默认认证
		//super.configure(auth);
		
		//实验四：自定义认证用户信息 基于内存认证方式
//		auth.inMemoryAuthentication()
//			.withUser("zhangsan").password("123456").roles("学徒")
//			.and()
//			.withUser("lisi").password("123123").roles("学徒","大师","宗师");
		
		
		//采用数据库的认证方式
		//根据用户名查询出用户的详细信息
		//auth.userDetailsService(userDetailsService); //默认密码校验，按照明文进行校验
		//auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
		auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		//super.configure(http);	默认的权限规则，所有请求都受限制
		
		//实验一：授权首页和静态资源
//		http.authorizeRequests()
//				.antMatchers("/layui/**","/index.jsp").permitAll()	//设置匹配的资源放行
//				.anyRequest().authenticated(); 	//剩余任何资源必须认证
		
		//实验六：基于角色的访问控制
		http.authorizeRequests()
		//设置所有,"/**"都可以访问，其他再进行的设置就不会起作用了
				.antMatchers("/layui/**","/index.jsp").permitAll()	//设置匹配的资源放行
				//.antMatchers("/level1/**").hasRole("学徒")
				//.antMatchers("/level2/**").hasRole("大师")
				//.antMatchers("/level3/**").hasRole("宗师")
				.anyRequest().authenticated();
				
				
		//实验二：默认及自定义登录页
		//http.formLogin();	默认登录页
		http.formLogin().loginPage("/index.jsp")	//自定义登录页
					.loginProcessingUrl("/index.jsp")
					.usernameParameter("loginacct")	//指定表单提交的提交参数和请求路径
					.passwordParameter("userpswd")
					.defaultSuccessUrl("/main.html");//默认登陆成功之后去哪儿
		
		//http.csrf().disable();	//禁用CSRF
		
		//实验五：用户注销完成
		//http.logout();	//默认注销请求 请求路径："/logout"
		http.logout().logoutUrl("/logout").logoutSuccessUrl("/index.jsp");
		
		//实验七：自定义访问拒绝处理页面
		http.exceptionHandling().accessDeniedPage("/unauth.html");
		
		//实验八：记住我功能
		//开启记住我功能，基于Cookie的方式实现记住我功能
		//http.rememberMe();
		
		//记住我，基于数据库实现
		JdbcTokenRepositoryImpl ptr = new JdbcTokenRepositoryImpl();
		ptr.setDataSource(dataSource);
		http.rememberMe().tokenRepository(ptr);
	}
	
	//md5+盐+随机数
	//$2a$10$ss5OfHprsOfgOgsjY8DZH.xaz/A9F/4RPbYwN4YVOjidzOaadksGy
	//$2a$10$nKP0Eo1TS5DKDSafJ3GLe.tp8tfbRaT20G9uRLdU7/sLfcEOlgOm2
	//$2a$10$YXBsUwiSlYgXsglPsK427OEVw/RbxO2icfp/Pz87BabdsEkhsBPCG
	public static void main(String[] args) {
		BCryptPasswordEncoder bcpe = new BCryptPasswordEncoder();
		String encode = bcpe.encode("123456");
		System.out.println(encode);
	}
}

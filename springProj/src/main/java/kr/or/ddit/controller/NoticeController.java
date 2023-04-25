package kr.or.ddit.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/notice")
@Controller
//특정 페이지에 정해진 권한을 가진자만 접근가능하게 하려면 이거 이용 
public class NoticeController {
	
	//요청URI : /notice/list : 모두 접근 가능
	@GetMapping("/list")
	public String list() {
		//forwarding
		return "notice/list"; 
	}
	
	//요청URI : /notice/register 
	//: 로그인한 관리자(ROLE_ADMIN)나 회원(ROLE_MEMBER)권한을 가진 사용자만 접근 가능 
	//authentication : 인증(로그인) / authorization : 인가(권한)
	//login은 id:member1, pw:1234
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")	
	@GetMapping("/register")
	public String register() {
		//forwarding
		return "notice/register";
	}
	
}

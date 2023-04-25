package kr.or.ddit.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/board")
@Controller
public class BoardController {
	
	//요청URI : /board/list : 모두가 접근 가능 => 변경 => 로그인한 사용자만 접근 가능 
	//Authentication : 인증(로그인)
	@PreAuthorize("isAuthenticated()") //인증되어 있는가  
	@GetMapping("/list")
	public String list() {
		//forwarding
		//board폴더의 list.jsp를 포워딩 
		return "board/list";
	}
	
	//요청URI : /board/register : 로그인한 회원만 접근 가능 
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/register")
	public String register() {
		//forwarding
		return "board/register";
	}
}

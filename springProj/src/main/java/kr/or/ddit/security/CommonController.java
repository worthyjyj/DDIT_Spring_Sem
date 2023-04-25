package kr.or.ddit.security;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {
	
//	<!-- 접근access 거부denied 처리자handler의 URI를 지정 -->
//    <security:access-denied-handler error-page="/accessError" />
	@GetMapping("/accessError")
	public String accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg", "Access Denied"); 
		
		//forwarding
		//views 폴더의 accessError.jsp를 forwarding함
		return "security/accessError"; 
	}
}

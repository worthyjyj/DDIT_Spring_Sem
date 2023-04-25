package kr.or.ddit.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.info("handle에 왔다");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("remoteAddr", request.getRemoteAddr());
		map.put("requestURI", request.getRequestURI());
		map.put("serverName", request.getServerName());
		map.put("serverPort", request.getServerPort());
		map.put("contextPath", request.getContextPath());
		
		log.info("map : " + map);
		
		response.sendRedirect("/accessError"); //uri요청
		//결국엔 포워드로 보내야하니까 commonController의 /accessError 겟방식으로 요청 
	}
	
	
	
}

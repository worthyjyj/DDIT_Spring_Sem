package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest request
			, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		if(auth != null && auth.getDetails()!=null) {
			try {
				request.getSession().invalidate();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		response.setStatus(HttpServletResponse.SC_OK);
		
		response.sendRedirect("/");

	}

}

package kr.or.ddit.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.service.LprodService;
import kr.or.ddit.service.TestService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.LprodVO;
import kr.or.ddit.vo.TestVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;


/* Controller 어노테이션
  스프링 프레임워크에게 "이 클래스는 웹 브라우저(클라이언트)의 요청(request)을
  받아들이는 컨트롤러야"라고 알려주는 것임.
  스프링은 servlet-context.xml의 context:component-scan의 설정에 의해
  이 클래스를 자바빈 객체로 미리 등록(메모리에 바인딩)
 */
@RequestMapping("/test")
@Slf4j
@Controller
public class TestController {
	@Autowired
	TestService testService;
	
	/*
	 요청URI : /lprod/create
	 방식 : GET
	*/
	//골뱅이RequestMapping(value="/create",method=RequestMethod.GET)
	@GetMapping("/create")
	public String create(Model model) {
		log.info("/test/create");
		
		List<HashMap<String, Object>> testVOList = testService.getList();
		
		model.addAttribute("testVOList", testVOList);
		return "test/create";
	}
	
}















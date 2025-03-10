package kr.or.ddit.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.TestService;
import lombok.extern.slf4j.Slf4j;


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
		
		return "test/create";
	}
	
	@ResponseBody
	@PostMapping("/getGridData")
	public List<HashMap<String, Object>> getGridData(@RequestBody Map<String, Object> paramMap) {
		log.info("getGridData에 왔다");
		
		List<HashMap<String, Object>> testVOList = testService.getList(paramMap);
		log.info("paramMap : " + paramMap);
		log.info("testVOList : " + testVOList);
		
		return testVOList;
	}
	
	@ResponseBody
	@PostMapping("/saveData")
	public String saveData(@RequestBody List<Map<String,Object>> list) {
		log.info("saveData에 왔다");
		log.info("list : " + list);
		
		String message = "";
		
		message = testService.saveData(list);
		
		log.info("message >> ",message);
		return message;
	}
	
	
	@ResponseBody
	@PostMapping("/getGrid2Data")
	public List<HashMap<String, Object>> getGrid2Data(@RequestBody Map<String,Object> param) {
		log.info("/getGrid2Data에 왔다");
		
		List<HashMap<String, Object>> grid2DataList = testService.getGrid2Data(param);
		log.info("testVOList : " + grid2DataList);
		
		return grid2DataList;
	}
	
	
	@ResponseBody
	@PostMapping("/getComboData")
	public List<HashMap<String, Object>> getComboData() {
		log.info("getComboData에 왔다");
		
		List<HashMap<String, Object>> result = testService.getComboData();
		log.info("result : " + result);
		
		return result;
	}
	
	
	@GetMapping("/crtPrac")
	public String crtPrac(Model model) {
		log.info("/test/crtPrac");
		
		return "test/crtPrac";
	}
	
	@ResponseBody
	@PostMapping("/getCrtData")
	public List<HashMap<String, Object>> getCrtData(@RequestBody Map<String, Object> paramMap) {
		log.info("getCrtData에 왔다");
		log.info(" getCrtData paramMap : " + paramMap);
		
		List<HashMap<String, Object>> getCrtData = testService.getCrtData(paramMap);
		log.info("getCrtData : " + getCrtData);
		
		return getCrtData;
	}
	
	
	@ResponseBody
	@PostMapping("/getCrtCombo")
	public List<HashMap<String, Object>> getCrtCombo(@RequestBody Map<String, Object> paramMap) {
		log.info("getCrtCombo에 왔다");
		
		List<HashMap<String, Object>> getCrtCombo = testService.getCrtCombo(paramMap);
		log.info("paramMap : " + paramMap);
		log.info("testVOList : " + getCrtCombo);
		
		return getCrtCombo;
	}
	
	// 저장 
	@ResponseBody
	@PostMapping("/saveCrtData")
	public HashMap<String, Object> saveCrtData(@RequestBody List<HashMap<String, Object>> paramList) {
		log.info("saveCrtData에 왔다");
		log.info("paramList : " + paramList);
		
		HashMap<String, Object> message = testService.saveCrtData(paramList);
		
		System.out.println("메시지 >> "+message.get("message"));
		
		
		return message;
	}
	
	/*
	 요청URI : /create/gridPrac
	 방식 : GET
	*/
	//골뱅이RequestMapping(value="/create",method=RequestMethod.GET)
	@GetMapping("/gridPrac")
	public String gridPrac(Model model) {
		log.info("/test/gridPrac");
		
		return "test/gridPrac";
	}
	
	@GetMapping("/register")
	public String register(Model model) {
		log.info("/test/register");
		
		return "test/register";
	}
	
	@ResponseBody
	@PostMapping("/checkId")
	public HashMap<String, Object> checkId(@RequestBody Map<String, Object> paramMap) {
		log.info("checkId에 왔다");
		
		HashMap<String, Object> checkIdCnt = testService.checkId(paramMap);
		log.info("paramMap : " + paramMap);
		log.info("checkIdCnt : " + checkIdCnt);
		
		return checkIdCnt;
	}
	
	@ResponseBody
	@PostMapping("/join")
	public int join(@RequestBody Map<String, Object> paramMap) {
		log.info("join에 왔다");
		log.info("paramMap : " + paramMap);
		
		int message;
		
		message = testService.join(paramMap);
		
		return message;
	}
	
	
	@GetMapping("/login")
	public String login(Model model) {
		log.info("/test/login");
		
		return "test/login";
	}
	
	@ResponseBody
	@PostMapping("/loginTry")
	public List<HashMap<String, Object>> loginTry(HttpServletRequest request, HttpServletResponse response,@RequestBody Map<String, Object> paramMap) throws ServletException, IOException {
		log.info("loginTry에 왔다");
		
		List<HashMap<String, Object>> result = testService.loginTry(paramMap);
		log.info("paramMap : " + paramMap);
		log.info("result : " + result);
		
	    HttpSession session=request.getSession();
		
		if (Integer.valueOf(result.get(0).get("CNT").toString()) == 1) {
		    session.setAttribute("id", result.get(0).get("ID"));
		}
	    
		return result;
	}
	
	@GetMapping("/sendMail")
	public String sendMail(Model model) {
		log.info("/test/login");
		
		return "test/sendMail";
	}
	
	@GetMapping("/myMail")
	public String myMail(Model model) {
		log.info("/test/myMail");
		
		return "test/myMail";
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request,Model model) {
		log.info("/test/logout");
		
		//세션 비우기 
		HttpSession session = request.getSession();    
	    session.invalidate();
	    
	    //로그아웃하면 다시 /login으로 이동해야하는데 url은 변경안돼서 
	    // redirct 해야할 것 같은데 모르겠음...
	    
	    

		
		return "test/login";
	}
	
	
	@ResponseBody
	@PostMapping("/getMail")
	public List<HashMap<String, Object>> getMail(@RequestBody Map<String, Object> paramMap) {
		log.info("getMail에 왔다");
		
		List<HashMap<String, Object>> getMail = testService.getMail(paramMap);
		log.info("paramMap : " + paramMap);
		log.info("getMail : " + getMail);
		
		return getMail;
	}
	
	
	@GetMapping("/mailDetail")
	public String mailDetail(Model model, @RequestParam Map<String, Object> paramMap) {
		log.info("/mailDetail에 왔다");
		
		System.out.println("param >> "+ paramMap);
		
		return "test/mailDetail";
	}
	
	@GetMapping("/treeView")
	public String treeView(Model model, @RequestParam Map<String, Object> paramMap) {
		log.info("/treeView에 왔다");
		
		System.out.println("param >> "+ paramMap);
		
		return "test/treeView";
	}
	
	@GetMapping("/treeView2")
	public String treeView2(Model model, @RequestParam Map<String, Object> paramMap) {
		log.info("/treeView2에 왔다");
		
		System.out.println("param >> "+ paramMap);
		
		return "test/treeView2";
	}
	
	
	@ResponseBody
	@PostMapping("/getDeptTree")
	public List<HashMap<String, Object>> getDeptTree(@RequestBody Map<String, Object> paramMap) {
		log.info("getDeptTree에 왔다");
		
		List<HashMap<String, Object>> getDeptTree = testService.getDeptTree(paramMap);
		
		return getDeptTree;
	}
	
	@ResponseBody
	@PostMapping("/getDeptTree2")
	public List<HashMap<String, Object>> getDeptTree2(@RequestBody Map<String, Object> paramMap) {
		log.info("getDeptTree2에 왔다");
		
		List<HashMap<String, Object>> getDeptTree2 = testService.getDeptTree2(paramMap);
		
		return getDeptTree2;
	}
	
	@GetMapping("/chartPrac")
	public String chartPrac(Model model, @RequestParam Map<String, Object> paramMap) {
		log.info("/chartPrac에 왔다");
		
		
		return "test/chartPrac";
	}
	
	
	
}















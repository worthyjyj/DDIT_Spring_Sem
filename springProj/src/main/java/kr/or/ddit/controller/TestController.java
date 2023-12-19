package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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
		
		List<HashMap<String, Object>> testVOList = testService.getList();
		
		model.addAttribute("testVOList", testVOList);
		
		// List<HashMap<String, Object>>을 JSONArray로 변환
        JSONArray jsonArray = new JSONArray();
        for (HashMap<String, Object> data : testVOList) {
            JSONObject jsonObject = new JSONObject(data);
            jsonArray.add(jsonObject);
        }

        // JSONArray를 JSON 형태의 문자열로 변환
        String jsonData = jsonArray.toJSONString();

        // 변환된 JSON 데이터 출력
        System.out.println("제발 나와라 >> "+jsonData);
		
        model.addAttribute("testVOListJSON",jsonData);
        
		return "test/create";
	}
	
	@ResponseBody
	@PostMapping("/getGridData")
	public List<HashMap<String, Object>> getGridData() {
		log.info("getGridData에 왔다");
		
		List<HashMap<String, Object>> testVOList = testService.getList();
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
	
	
	
	
	
}















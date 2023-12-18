package kr.or.ddit.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.LprodDao;
import kr.or.ddit.dao.TestDao;
import kr.or.ddit.service.LprodService;
import kr.or.ddit.service.TestService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.LprodVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TestServiceImpl implements TestService {
	@Autowired
	TestDao testDao;

	@Override
	public List<HashMap<String, Object>> getList() {
		 return this.testDao.getList(); 
	}

	//Data CURD 처리
	@Override
	public String saveData(List<Map<String, Object>> list) {
		String message = "fail"; 
		int result = 0; 
		
		for(int i=0; i<list.size(); i++) {
			// Create
			if(list.get(i).get("cud").equals("C")) {
				result = this.testDao.saveCreate(list.get(i));
				
				if(result > 0) {
					message = "success";
				}
			}else if(list.get(i).get("cud").equals("U")) {
				result = this.testDao.saveUpdate(list.get(i));
								
				if(result > 0) {
					message = "success";
				}
			}else if(list.get(i).get("cud").equals("D")) {
				result = this.testDao.saveDelete(list.get(i));
								
				if(result > 0) {
					message = "success";
				}
			}
		}
		
		return message;
	}
	
	}
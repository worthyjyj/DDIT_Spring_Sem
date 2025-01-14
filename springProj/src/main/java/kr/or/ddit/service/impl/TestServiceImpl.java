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
	public List<HashMap<String, Object>> getList(Map<String, Object> paramMap) {
		 return this.testDao.getList(paramMap); 
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

	@Override
	public List<HashMap<String, Object>> getGrid2Data(Map<String, Object> param) {
		return this.testDao.getGrid2Data(param); 
	}

	@Override
	public List<HashMap<String, Object>> getComboData() {
		
		return this.testDao.getComboData(); 
	}

	@Override
	public List<HashMap<String, Object>> getCrtData(Map<String, Object> paramMap) {
		 return this.testDao.getCrtData(paramMap); 
	}

	@Override
	public List<HashMap<String, Object>> getCrtCombo(Map<String, Object> paramMap) {
		return this.testDao.getCrtCombo(paramMap); 
	}

	// CRUD에 따른 쿼리 처리
	@SuppressWarnings("null")
	@Override
	public HashMap<String, Object> saveCrtData(List<HashMap<String, Object>> paramList) {
		HashMap<String, Object> message = new HashMap<String, Object>(); 
//		HashMap<String, Object> message = null; // 이걸로 하면 오류가 나는 이유: null로 초기화할 수는 있지만, 맵의 method를 사용하지 못하므로 권장하지 않음.  
		
		
		for(int i=0; i<paramList.size(); i++) {
			// Create
			if(paramList.get(i).get("CUD").equals("C")) {
				int result = this.testDao.crtCreate(paramList.get(i));
				
				if(result > 0) {
					message.put("message", "0");
				}
			}else if(paramList.get(i).get("CUD").equals("U")) {
				int result = this.testDao.crtUpdate(paramList.get(i));
								
				if(result > 0) {
					message.put("message", result);
				}
			}else if(paramList.get(i).get("CUD").equals("D")) {
				int result = this.testDao.crtDelete(paramList.get(i));
								
				if(result > 0) {
					message.put("message", "0");
				}
			}
		}
		
		System.out.println("message >> "+message.get("message"));
		return message;
	}

	@Override
	public HashMap<String, Object> checkId(Map<String, Object> paramMap) {
		
		return this.testDao.checkId(paramMap);
	}

	@Override
	public int join(Map<String, Object> paramMap) {
		
		return this.testDao.join(paramMap);
	}
	
	@Override
	public List<HashMap<String, Object>> loginTry(Map<String, Object> paramMap) {
		return this.testDao.loginTry(paramMap); 
	}

	@Override
	public List<HashMap<String, Object>> getMail(Map<String, Object> paramMap) {
		return this.testDao.getMail(paramMap); 
	}

	@Override
	public List<HashMap<String, Object>> getDeptTree(Map<String, Object> paramMap) {
		return this.testDao.getDeptTree(paramMap); 
	}
	
	}
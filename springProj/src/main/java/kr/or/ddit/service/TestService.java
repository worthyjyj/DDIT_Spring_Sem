package kr.or.ddit.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface TestService {

	public List<HashMap<String, Object>> getList(Map<String, Object> paramMap);

	public String saveData(List<Map<String, Object>> list);

	public List<HashMap<String, Object>> getGrid2Data(Map<String, Object> param);

	public List<HashMap<String, Object>> getComboData();

	public List<HashMap<String, Object>> getCrtData(Map<String, Object> paramMap);

	public List<HashMap<String, Object>> getCrtCombo(Map<String, Object> paramMap);

	public HashMap<String, Object> saveCrtData(List<HashMap<String, Object>> paramList);

	public HashMap<String, Object> checkId(Map<String, Object> paramMap);

	public int join(Map<String, Object> paramMap);
	
	public List<HashMap<String, Object>> loginTry(Map<String, Object> paramMap);

	public List<HashMap<String, Object>> getMail(Map<String, Object> paramMap);

	
}

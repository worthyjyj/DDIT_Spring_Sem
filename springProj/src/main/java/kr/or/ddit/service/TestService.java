package kr.or.ddit.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface TestService {

	public List<HashMap<String, Object>> getList();

	public String saveData(List<Map<String, Object>> list);

	
}

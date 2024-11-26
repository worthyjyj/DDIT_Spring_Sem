package kr.or.ddit.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;
import kr.or.ddit.vo.LprodVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class TestDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<HashMap<String, Object>> getList(Map<String, Object> map) {
		//.selectone() : 1행(상세보기)
		//.selectList("namespace.id", 파라미터) : 여러행(목록)
		return this.sqlSessionTemplate.selectList("test.getlist",map); 
	}

	public int saveCreate(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("test.saveCreate",map);
	}

	public int saveUpdate(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("test.saveUpdate",map);
	}

	public int saveDelete(Map<String, Object> map) {
		return this.sqlSessionTemplate.delete("test.saveDelete",map);
	}

	public List<HashMap<String, Object>> getGrid2Data(Map<String, Object> param) {
		return this.sqlSessionTemplate.selectList("test.getGrid2Data",param); 
	}

	public List<HashMap<String, Object>> getComboData() {
		return this.sqlSessionTemplate.selectList("test.getComboData"); 
	}

	public List<HashMap<String, Object>> getCrtData(Map<String, Object> paramMap) {
		//.selectone() : 1행(상세보기)
		//.selectList("namespace.id", 파라미터) : 여러행(목록)
		return this.sqlSessionTemplate.selectList("test.getCrtData",paramMap); 
	}

	public List<HashMap<String, Object>> getCrtCombo(Map<String, Object> paramMap) {
		return this.sqlSessionTemplate.selectList("test.getCrtCombo",paramMap); 
	}

	public HashMap<String, Object> saveCrtData(List<HashMap<String, Object>> paramList) {
		return this.sqlSessionTemplate.selectOne("test.saveCrtData",paramList); 
	}

	public int crtCreate(HashMap<String, Object> hashMap) {
		return this.sqlSessionTemplate.insert("test.crtCreate",hashMap);
	}

	public int crtUpdate(HashMap<String, Object> hashMap) {
		return this.sqlSessionTemplate.update("test.crtUpdate",hashMap);
	}

	public int crtDelete(HashMap<String, Object> hashMap) {
		return this.sqlSessionTemplate.delete("test.crtDelete",hashMap);
	}

	public HashMap<String, Object> checkId(Map<String, Object> paramMap) {
		return this.sqlSessionTemplate.selectOne("test.checkId",paramMap); 
	}

	public int join(Map<String, Object> paramMap) {
		return this.sqlSessionTemplate.insert("test.join",paramMap);
	} 
	
}

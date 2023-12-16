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

	public List<HashMap<String, Object>> getList() {
		//.selectone() : 1행(상세보기)
		//.selectList("namespace.id", 파라미터) : 여러행(목록)
		return this.sqlSessionTemplate.selectList("test.getlist"); 
	} 
	
}
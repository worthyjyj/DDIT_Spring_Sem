package kr.or.ddit.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

/*
 매퍼XML(book_SQL.xml)를 실행시키는 DAO(Data Access Object) 클래스
 Repository 어노테이션 : 데이터에 접근하는 클래스 
 => 스프링이 데이터를 관리하는 클래스라고 인지하여 자바빈 객체로 등록하여 관리함
 */
@Slf4j
@Repository
public class CusDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate; 
	
	//다음 값 가져오는 메서드 
	public String getNextNum() {
		String result = this.sqlSessionTemplate.selectOne("cus.getNextNum");
		return result;
	}

	
}

package kr.or.ddit.dao;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;
import kr.or.ddit.vo.LprodVO;
import lombok.extern.slf4j.Slf4j;

/*
 매퍼XML(book_SQL.xml)를 실행시키는 DAO(Data Access Object) 클래스
 Repository 어노테이션 : 데이터에 접근하는 클래스 
 => 스프링이 데이터를 관리하는 클래스라고 인지하여 자바빈 객체로 등록하여 관리함
 */
@Slf4j
@Repository
public class LprodDao {
	//이미 만들어져있는 sqlSessionTemplate 객체를 
	//LprodDao에 주입
	//DI(Dependancy Injection) : 의존성 주입 
	//개발자가 new를 하지 않고 스프링에게 요청하여 객체를 사용 
	//IoC(Inversion of Control)
	@Autowired
	SqlSessionTemplate sqlSessionTemplate; 
	
	public List<LprodVO> list(Map<String, String> map){
		 return this.sqlSessionTemplate.selectList("lprod.list",map); 
	}
	
	//상품분류 자동생성 
	public int getLprodId() {
		return this.sqlSessionTemplate.selectOne("lprod.getLprodId");
	}
	
	//상품분류코드 자동생성 
	public String getLprodGu() {
		return this.sqlSessionTemplate.selectOne("lprod.getLprodGu"); 
	}
	
	//상품 등록 
	public int createPost(LprodVO lprodVO) {
		return this.sqlSessionTemplate.insert("lprod.createPost",lprodVO); 
	}
	
	//상품분류 상세보기 
	public LprodVO detail(LprodVO lprodVO) {
		//매퍼xml을 호출. sql실행 
		//.selectOne("namespace.id", 파라미터)
		return this.sqlSessionTemplate.selectOne("lprod.detail",lprodVO); 
	}
	
	//상품종류 정보 변경 
	public int updatePost(LprodVO lprodVO) {
		//.update("namespace.id", 파라미터)
		return this.sqlSessionTemplate.update("lprod.updatePost", lprodVO); 
	}
	
	//상품 삭제 
	public int deletePost(LprodVO lprodVO) {
		return this.sqlSessionTemplate.delete("lprod.deletePost", lprodVO); 
	}
	
	//첨부파일 등록
	//<insert id="uploadFormAction" parameterType="attachVO">
	public int uploadFormAction(AttachVO attachVO) {
		return this.sqlSessionTemplate.insert("lprod.uploadFormAction", attachVO);
	}
	
	/*
	 다중 insert 시 update 태그를 사용하지 
      update id="createPostAttach" parameterType="java.util.List"
     */
	public int createPostAttach(List<AttachVO> attachVOList) {
		return this.sqlSessionTemplate.update("lprod.createPostAttach", attachVOList);
	}
	
	 // 전체 행의 수 (total) 
	 //<select id="getTotal" resultType="int">
	public int getTotal(String keyword) {
		return this.sqlSessionTemplate.selectOne("lprod.getTotal",keyword); 
	}
	
//	 <!-- 상품별 판매금액의 합계가 천만원이 넘은 데이터 -->
	 public List<Map<String, Object>> cartMoney(){
		return this.sqlSessionTemplate.selectList("lprod.cartMoney");
	 }
	 
//	 <!-- 회원별 구매회수 구하기 -->
//	 <select id="memberMoney" resultType="hashMap">
	 public List<Map<String, Object>> memeberMoney(){
		 return this.sqlSessionTemplate.selectList("lprod.memberMoney");
	 }
	
	//삭제해야함  
	public int count() {
		return this.sqlSessionTemplate.selectOne("lprod.count");
	}
}

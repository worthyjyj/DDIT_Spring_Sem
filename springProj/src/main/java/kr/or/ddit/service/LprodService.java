package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.LprodVO;

public interface LprodService {

	public List<LprodVO> list(Map<String, String> map);

	//상품분류 자동생성 
	int getLprodId();
	
	//상품코드 자동생성 
	public String getLprodGu();
	
	//상품 등록 
	public int createPost(LprodVO lprodVO);
	
	//상품 상세 보기 
	public LprodVO detail(LprodVO lprodVO);
	
	//상품 수정 
	public int updatePost(LprodVO lprodVO);

	//상품 삭제 
	public int deletePost(LprodVO lprodVO);

	//첨부파일 등록 
	public int uploadFormAction(AttachVO attachVO);

	//전체 행의 수 (total)
	public int getTotal(String keyword);

	public JSONObject cartMoney();

	public JSONObject memeberMoney();

	//삭제해야함
	public int count();
	
}

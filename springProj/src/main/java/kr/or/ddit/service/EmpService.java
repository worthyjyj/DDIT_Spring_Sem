package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.MemVO;

public interface EmpService {

	//다음 직원번호를 가져옴
	public String getEmpNum();

	public int createPost(EmpVO empVO);

	public List<EmpVO> getEmpAll();
	
	//직원 상세 보기(관리자가 있으면 관리자 정보도 포함)
	public List<EmpVO> detail(EmpVO empVO);

	public int deletePost(EmpVO empVO);

	public List<EmpVO> list(Map<String, String> map);
	
	//매니저 정보 가져오기 
	public EmpVO showMj(EmpVO empVO);

	public int getTotal(Map<String, String> map);

	//회원로그인 
	public MemVO memLogin(MemVO memVO);


	
}

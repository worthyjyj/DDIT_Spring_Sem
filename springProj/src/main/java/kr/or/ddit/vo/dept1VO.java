package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

//회사
@Data
public class dept1VO {
	private String deptNo;
	private String upDeptNo;
	private String deptNm;
	private int lvl;
	
	//dept1VO : dept2VO = 1 : N
	private List<dept2VO> dept2VOList;
}

package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

//본부
@Data
public class dept2VO {
	private String deptNo;
	private String upDeptNo;
	private String deptNm;
	private int lvl;
	
//	dept2VO : dept3VO = 1 : N
	private List<dept3VO> dept3VOList;
}

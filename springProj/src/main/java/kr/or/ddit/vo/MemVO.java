package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

//자바빈 클래스 
@Data
public class MemVO {
	private int userNo;
	private String userId;
	private String userPw;
	private String userName;
	private int coin;
	private Date regDate;
	private Date updDate;
	private String enabled;
	
	//MemVO : MemAuthVO = 1 : N 
	//한명의 멤버의 여러개의 권한이 있다. 
	private List<MemAuthVO> memAuthVOList; 
}

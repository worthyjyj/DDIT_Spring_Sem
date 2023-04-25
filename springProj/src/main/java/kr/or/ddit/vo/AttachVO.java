package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

//Pojo에 위반..
@Data //롬복의 @data는 게터, 세터, toString을 자동으로 생성해주는 어노테이션 
public class AttachVO {
	private int seq;
	private String filename;
	private int filesize;
	private String thumbnail;
	private Date regdate;
	//전사적 아이디
	private String etpId;
}

package kr.or.ddit.vo;

import java.util.Arrays;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class LprodVO {
	private int rnum; 
	private int lprodId;
	private String lprodGu; 
	private String lprodNm;
	private MultipartFile[] uploadFile; //<input type="file" name="uploadFile"  multiple />
	//상품 분류 : 첨부파일 = 1 : N 
	//테이블에 외래키를 이용하면 되지 않느냐? 하는 질문.. => 이렇게 일대다관계를 이용하여 vo안에 객체를 넣어놓으면 sql문도 한번에 처리가 가능하고, 인서트 등도 서비스를 두번 호출할 필요없이 한번에 처리가 가능하므로! 
	private List<AttachVO> attachVOList; 
	
	public LprodVO() {}



	public MultipartFile[] getUploadFile() {
		return uploadFile;
	}



	public void setUploadFile(MultipartFile[] uploadFile) {
		this.uploadFile = uploadFile;
	}



	public List<AttachVO> getAttachVOList() {
		return attachVOList;
	}



	public void setAttachVOList(List<AttachVO> attachVOList) {
		this.attachVOList = attachVOList;
	}



	public int getLprodId() {
		return lprodId;
	}

	public void setLprodId(int lprodId) {
		this.lprodId = lprodId;
	}

	public String getLprodGu() {
		return lprodGu;
	}

	public void setLprodGu(String lprodGu) {
		this.lprodGu = lprodGu;
	}

	public String getLprodNm() {
		return lprodNm;
	}

	public void setLprodNm(String lprodNm) {
		this.lprodNm = lprodNm;
	}



	public int getRnum() {
		return rnum;
	}



	public void setRnum(int rnum) {
		this.rnum = rnum;
	}



	@Override
	public String toString() {
		return "LprodVO [rnum=" + rnum + ", lprodId=" + lprodId + ", lprodGu=" + lprodGu + ", lprodNm=" + lprodNm
				+ ", uploadFile=" + Arrays.toString(uploadFile) + ", attachVOList=" + attachVOList + "]";
	}


	



	
	
	
}

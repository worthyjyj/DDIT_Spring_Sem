package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

//고객
/* Bean Validation이 제공하는 제약 애너테이션
 - NotNull : 빈 값 체크
 - *NotBlank : null 체크, trim(공백제거) 후 길이가 0인지 체크
 - Size : 글자 수 체크
 - Email : 이메일 주소 형식 체크
 - Past : 오늘보다 과거 날짜(ex. 생일)
 - Future : 미래 날짜 체크(ex. 예약일)
 */
@Data
public class CusVO {
	//고객번호(필수=mandatory), null 체크, trim 후 길이가 0인지 체크
	@NotBlank
	private String cusNum;
	//고객명(김아무개와두루미삼천갑자동박사...)
	@Size(min=2,max=10, message = "2자~10자 이내로 입력해 주세요")
	@NotBlank
	private String cusNm;
	//주소
	private String cusAddr;
	//연락처
	@NotBlank
	private String cusPhe;
	//우편번호
	private String postno;
	//주소 상세
	private String addrDet;
	//생일 
	/*
	 @DateTimeFormat은 input type="date"를 쓴다면 이게 문자열로 넘어가기 때문에 date로 변환이 필요한데 그때 이게 필요함 
	 2023-02-06(x)<-<input type="date"
	 20230206(x)
	 2023/02/06(o)(기본.DateTimeFormat이 없어도 됨)
	 ** 2023-02-06 이 형식으로 date를 저장하고 불러오고 싶기때문에 패턴을 정해주는것. 
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date cusBir; 
	//취미(여러개 선택) {"Movie", "Sports", "Read"}
	private List<String> hobbyList; 
	private String hobby; //db에 저장되는 취미(다중선택된거..콤마로 연결된.. 다시 데이터 뿌려줄 때는 list에 담아서 선택되도록한다)
	//성별(한개 선택) 
	private String gender; 
	//국적(한개 선택)-> select박스
	private String nationality;
	//고객(CUS) : 자동차(CAR) = 1 : N
	@Valid
	private List<CarVO> carVOList;
	//고객(CUS) : 서비스(SER) = 1 : N
	private List<SerVO> serVOList;
}





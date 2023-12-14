<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<script src="/resources/ckeditor/ckeditor.js"></script>
<title>책 등록하기</title>
<script type="text/javascript">
$(function() {
	//이미지 미리보기 시작-------------------
	$("#input_imgs").on("change",handleImgFileSelect);
	//e: change이벤트
	function handleImgFileSelect(e){
		//파일객체에 파일들
		let files = e.target.files;
		//이미지 배열
		let fileArr = Array.prototype.slice.call(files);
		//fileArr에서 하나 꺼내면 f(파일객체 1개)
		fileArr.forEach(function(f){
			//이미지만 가능
			if(!f.type.match("image.*")){
				alert("이미지 확장자만 가능합니다.");
				return;
			}
			//이미지를 읽을 객체
			let reader = new FileReader();
			//reader.readAsDataURL(f);의 이벤트
			reader.onload = function(e){
				let img_html = "<img src=\"" + e.target.result + "\" style='width:30%' />";
				
				$(".imgs_wrap").append(img_html);
			}
			 
			//이미지를 읽자
			reader.readAsDataURL(f);
		});//end forEach
	}
	//이미지 미리보기 끝-------------------
})
</script>
</head>
<body>
<h1>책 등록</h1>
<!-- 폼페이지 -->
<!-- 
요청URI : /create?title=개똥이글로리&category=소설&price=10000
요청파라미터 : title=개똥이글로리&category=소설&price=10000
요청방식 : post

스프링 시큐리티를 사용할 경우 action 경로 뒤에 csrf 토큰을 입력해야 함. (mulitpart/form-data로 전송할 경우에만)
 -->
<form action="/create?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
	<!-- 폼데이터 -->
	<div class="imgs_wrap"></div>
	<p>제목 : <input type="text" name="title" required /></p>
	<p>카테고리 :<input type="text" name="category" required /></p>
	<p>가격 :<input type="number" name="price" required /></p>
	<p>내용 :<textarea name="cont" rows="5" cols="30" style="width" ></textarea>
	<p>
		책표지 : <input type="file" id="input_imgs" name="uploadfile" multiple />
	</p>
	<p>
		<input type="submit" value="저장" />
		<input type="button" value="목록 " />
	</p>
	<sec:csrfInput/>
</form>

<!-- 동적인 테이블 작성 연습 끝 -->
<table border="1">
<thead>
	<tr>
		<th>
		 No.
		</th>
		<th>
		이름
		</th>
		<th>
		직업
		</th>
		<th>
		나이
		</th>
		<th>
		성별
		</th>
		<td>
		<input type="button" class="addBtn" value="추가"/>
		</td>
	</tr>
</thead>
	<tr>
		<td>
		<input type="text" name="Indiarr[0].no"/>
		</td>
		<td>
		<input type="text" name="Indiarr[0].nm" />
		</td>
		<td>
		<input type="text" name="Indiarr[0].job"/>
		</td>
		<td>
		<input type="text" name="Indiarr[0].age"/>
		</td>
		<td>
		<input type="text" name="Indiarr[0].sex"/>
		</td>
		<td>
		<input type="button" value="삭제" style="color:red;" class="delete" onclick="delRow(this)"/>
		</td>
	</tr>
	<tbody id="add"></tbody>
</table>
<!-- 동적인 테이블 작성 연습 끝 -->

<script>

var cnt = 1;

$('.addBtn').on("click", function(){
	var str = "";
		                                                    
	str+="	<tr>                                                       ";
	str+="	<td>                                                       ";
	str+="	<input type='text' name='Indiarr["+cnt+"].no'/>                      ";
	str+="	</td>                                                      ";
	str+="	<td>                                                       ";
	str+="	<input type='text' name='Indiarr["+cnt+"].nm'/>                       ";
	str+="	</td>                                                      ";
	str+="	<td>                                                       ";
	str+="	<input type='text' name='Indiarr["+cnt+"].job'/>           ";
	str+="	</td>                                                      ";
	str+="	<td>                                                       ";
	str+="	<input type='text' name='Indiarr["+cnt+"].age'/>                    ";
	str+="	</td>                                                      ";
	str+="	<td>                                                       ";
	str+="	<input type='text' name='Indiarr["+cnt+"].sex'/>          ";
	str+="	</td>                                                      ";
	str+="	<td>                                                       ";
	str+="	<input type='button' value='삭제' style='color:red;' class='delete' onclick='delRow(this)' />     ";
	str+="	</td>                                                      ";
	str+="	</tr>                                                      ";
	
	cnt += 1; 
	$('#add').append(str);
})

//행 삭제 
function delRow(btn){
	console.log(btn);
	//특정 클래스를 COUNT하여 최소 입력 장치를 살려둠
  	if($('.delete').length == 1)
    {
        alert("삭제할 수 없습니다.");
    }else{
    	btn.closest('tr').remove();//삭제
    }
};
</script>



<script type="text/javascript">
CKEDITOR.replace('cont'); //CKEDITOR의 함수로 (괄호)안에는 ID,NAME이 들어간다
</script>
</body>
</html>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<title>도서관리시스템</title>
<script type="" src="/resources/ckeditor/ckeditor.js"></script>
</head>
<body>
<!-- mav.addObject("data", data); -->
<%-- ${data} --%>
<!-- <hr /> -->
<!-- mav.addObject("bookId", data.getBookId()); //기본키   -->
<%-- ${bookId} --%>
<!-- 
 JSTL(JSP Standard Tag Library) : 개발자가 자주 사용하는 패턴들을 모아놓은 집합 
 => BookController에서 보내준 데이터를 뷰에 표현하도록 도와줌
 JSTL은 maven에서 설정되어 있음 => pom.xml => jstl
 -->
 	<h1>책 상세</h1>
 	<p>제목 : ${data.title} </p>
 	<p>카테고리 : ${data.category } </p>
 	<p>가격 : <fmt:formatNumber type="number"  maxFractionDigits="3" value="${data.price }"  /> </p>
 	<p>입력일 : <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${data.insertDate}"/></p>
 	<p>내용 : 
 	<textarea name="cont" rows="5"  cols="30" readonly>${data.content }</textarea>
 	</p>
 	<div id="book_imgs">
   <c:forEach var="attachVO" items="${data.attachVOList}" varStatus="stat">
      <img alt="사진" src="/resources/upload${attachVO.filename}">
   </c:forEach>
   </div>
 	<p><a href="/update?bookId=${bookId}">수정폼</a></p>
 	<p><a href="/list">목록</a></p>
<!-- 
method
1) GET : 데이터를 변경하지 않을 때. 목록/상세보기
2) POST :  데이터를 변경할 때. 입력/수정/삭제
 -->
 	<form action="/delete" method="post">
 		<!-- 폼 데이터 -->
 		<input type="hidden" name="bookId" value="${bookId }"/>
  		<button type="submit">삭제</button>
 	</form>
 <script type="text/javascript">
 CKEDITOR.replace("cont");
//  CKEDITOR.instances['editor'].setReadOnly(false);
 </script>
</body>
</html>

 

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>

    <title>SB Admin 2 - sendMail</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/sbadmin2/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/sbadmin2/css/sb-admin-2.min.css" rel="stylesheet">
    
 <!-- 부트스트랩 CDN -->   
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

</head>

<body class="bg-gradient-primary">
    <div class="container">
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">메일 상세</h1>
                            </div>
                            <form class="user" id="sendMail_form">
<!--                                 <div class="form-group row"> -->
<!--                                     <div class="col-sm-3"> -->
<!--                                     	<a href="#" class="btn btn-warning btn-icon-split col-sm-12" id="listBtn" data-bs-toggle="modal" data-bs-target="#exampleModal"> -->
<!--                                         <span class="text">답장하기</span> -->
<!--                                     	</a> -->
<!--                                     </div> -->
<!--                                     <div class="col-sm-9 mb-3 mb-sm-0"> -->
<!--                                         <input type="text" class="form-control form-control-user" id="recieverAdd" -->
<!--                                             placeholder="답장 내용을 작성해주세요!" readonly="readonly"  style="font-size:1.1em;" > -->
<!--                                     </div> -->
<!--                                 </div> -->
                                <div class="form-group row">
                                    <div class="col-lg-12">
		                                <div class="card-header">
		                                                                                  보낸 사람
		                                    <input type="text" class="form-control form-control-user" 
                                            id="title" placeholder="메일 제목" style="font-size:1.0em;" value="${param.sender}">
		                                    <input type="text" class="form-control form-control-user" 
                                            id="title" placeholder="메일 제목"  value="${param.title}" style="font-size:1.0em;">
		                                </div>
		                                <div class="card-body" >
		                                   <textarea class="form-control form-control-user" 
                                             id="contents" placeholder="메일 내용" style="height:200px; font-size:1.0em;" >
                                             ${param.content}
                                            </textarea>
		                                </div>
		                            </div>
                                </div>
                                <hr>
<!--                               <h5>답장 목록</h5> -->
<!--                               <div> -->
<!--                               ????? -->
<!--                               </div> -->
                              
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="/test/myMail">내 메일함으로 가기</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    
<!-- 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalCenteredScrollableTitle">주소록</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
				<table class="table table-bordered dataTable" id="dataTable"
					width="100%" cellspacing="0" role="grid"
					aria-describedby="dataTable_info" style="width: 100%;">
					<thead>
						<tr role="row">
							<th class="sorting sorting_asc" tabindex="0"
								aria-controls="dataTable" rowspan="1" colspan="1"
								aria-sort="ascending"
								aria-label="Name: activate to sort column descending"
								style="width: 264.797px;">이름</th>

						</tr>
					</thead>
					<tbody id="listAppend">
					</tbody>
				</table>
			</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="modalClose">Close</button>
	      </div>
	    </div>
    </div>
</div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/sbadmin2/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/sbadmin2/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <script type="text/javascript" src="/resources/js/jquery.serializejson.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/sbadmin2/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/sbadmin2/js/sb-admin-2.min.js"></script>

</body>

</html>

<style>
 
</style>

<script>
var memId = "";

$(function() {
	
	var sendMail = {
		   init : function() {

				this.initEvent();
			}
		  ,initEvent : function() {
			  
			    
				//주소록 데이터 받아오는 함수 
				sendMail.fn_getmemberList();
			    
				
				$("#id").on("change",function(){
					sendMail.fn_chk($("#id").val());
				})
				
				// 저장버튼 
				$("#sendBtn").on("click",function(){
					sendMail.fn_send();
				})
				
				$(".selMember").on("click",function(){
					
				    memId = $(this).text();
					
					
					$("#modalClose").trigger("click");
					
					$("#recieverAdd").val(memId+"@naver.com");
					
					
				})
				
				
				
			}
  			,fn_getmemberList : function () {
			  
			 
			  var param = {};
			        
	           $.ajax({
	               url: "/test/getmemList",
	               contentType: "application/json;charset=utf-8",
	               type: "post",
	               data: JSON.stringify(param),
	               dataType: "json",
	               beforeSend: function (xhr) {
	               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	               },
	               async: false,
	               success: function (result) {
	            	   
	            	   str = ""; 
	            	   
	            	   for (let value of result) {
		            		str+='<tr>                                                           ';
							str+='	<td class="sorting_1">                                       ';
							str+='		<button type="button" class="btn btn-dark selMember">'+value.member_id+'</button>';
							str+='	</td>                                                        ';
							str+='</tr>                                                          ';
	            		  }
	            	   
	            	   $("#listAppend").html(str);
						
	               }
	           });
			  
		  }
		  ,fn_send : function () {
			var reciever = memId;
			var title = $("#title").val();
			var content = $("#contents").val();
			  
			if(title == "" || title == null){
				alert("메일 제목은 필수값입니다");
				return; 
			}
			
			if(reciever == "" || reciever == null){
				alert("받는 사람은 필수값입니다");
				return; 
			}
			
			 var param = {
						"reciever" : reciever
						,"title" : title
						,"content" : content
					    }
			    
			 console.log("param >> ", param);
			 
	           $.ajax({
	               url: "/test/sendMail",
	               contentType: "application/json;charset=utf-8",
	               type: "post",
	               data: JSON.stringify(param),
	               dataType: "json",
	               beforeSend: function (xhr) {
	               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	               },
	               async: false,
	               success: function (result) {
	            	   // 창 새로 고침 후 바로 로그인 할 수 있도록
	            	   if(result > 0){
	            		   alert("가입되었습니다. 환영합니다!"); 
	            		   location.reload();
	            	   }else{
	            		   alert("오류...");
	            		   reload();
	            	   }
	            	   
	            	   
	               }
	           });
			
		  }
		  
// 		  sendMail.init();
	}
	
	sendMail.init();
	
})

</script>

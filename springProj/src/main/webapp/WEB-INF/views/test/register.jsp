<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>

    <title>SB Admin 2 - Register</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/sbadmin2/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/sbadmin2/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">회원 가입</h1>
                            </div>
                            <form class="user" id="register_form">
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" id="id"
                                            placeholder="id">
                                    </div>
                                    <div class="col-sm-6">
                                    	<a href="#" class="btn btn-primary btn-icon-split" id="chk">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-flag"></i>
                                        </span>
                                        
                                        <span class="text">중복체크</span>
                                    	</a>
                                    
	                                    <a href="#" class="btn btn-success btn-icon-split" id="complete">
	                                        <span class="icon text-white-50">
	                                            <i class="fas fa-check"></i>
	                                        </span>
	                                        <span class="text">쳌 완료</span>
	                                    </a>
                                    
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user"
                                            id="pw" placeholder="Password">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control form-control-user"
                                            id="pw_repeat" placeholder="Repeat Password">
                                    </div>
                                </div>
                                <a class="btn btn-primary btn-user btn-block" id="saveBtn">
                                    Register Account
                                </a>
                                <hr>
                                <a href="index.html" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Register with Google
                                </a>
                                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                    <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                </a>
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="forgot-password.html">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="/test/login">Already have an account? Login!</a>
                            </div>
                        </div>
                    </div>
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

<script>
var flag = false;

$(function() {
	
	var register = {
		   init : function() {

				this.initEvent();
				MailUtil.naverMailSend();
				
			}
		  ,initEvent : function() {
			  
			    $("#complete").css("display","none");

				// ID 중복체크
				$("#chk").on("click",function(){
					register.fn_chk($("#id").val());
				})
				
				$("#id").on("change",function(){
					register.fn_chk($("#id").val());
				})
				
				// 저장버튼 
				$("#saveBtn").on("click",function(){
					register.fn_save();
				})
				
				
			}
		  ,fn_chk : function (id) {
			  
			  if(id == ''){
				  alert("ID를 입력해주세요");
				  
				  $("#complete").css("display","none");
				  $("#chk").css("display","inline-block");
				
				  $("#id").val("");
				  flag = false;
				  return;
			  }
			  var param = {
						"id" : id 
					    }
			        
	           $.ajax({
	               url: "/test/checkId",
	               contentType: "application/json;charset=utf-8",
	               type: "post",
	               data: JSON.stringify(param),
	               dataType: "json",
	               beforeSend: function (xhr) {
	               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	               },
	               async: false,
	               success: function (result) {
						
						if(result.CNT == 1){
							alert("중복된 아이디가 존재합니다");
							$("#complete").css("display","none");
							$("#chk").css("display","inline-block");
							
							$("#id").val("");
							flag = false;
						}else{
							$("#complete").css("display","inline-block");
							$("#chk").css("display","none");
							flag = true;
						
						}
						
						
						
						
	               }
	           });
			  
		  }
		  ,fn_save : function () {
			var pw = $("#pw").val();
			var pw_repeat = $("#pw_repeat").val();
			  
			if(!flag){
				alert("id와 중복체크 여부를 확인해주세요");
				return; 
			}
			
			if(pw !== pw_repeat){
				alert("비밀번호 일치 여부를 확인해주세요");
				return; 
			}
			
			 var param = {
						"id" : $("#id").val()
						,"pw" : pw
					    }
			       
	           $.ajax({
	               url: "/test/join",
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
		  
// 		  register.init();
	}
	
	register.init();
	
})

</script>
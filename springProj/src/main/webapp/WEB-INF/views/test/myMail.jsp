<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 세션 id.. -->
<% String id=(String)session.getAttribute("id");%>

<body>

     <!-- Begin Page Content -->
     <div class="container-fluid">

         <!-- Page Heading -->
         <h1 class="h3 mb-2 text-gray-800"><%=id%>님 메일함</h1>
         <p class="mb-4">WELCOME...!</p>

         <!-- DataTales Example -->
         <div class="card shadow mb-4">
             <div class="card-header py-3">
                 <h6 class="m-0 font-weight-bold text-primary" id="unreadCnt">안읽은 메일 4개</h6>
             </div>
             <div class="card-body">
                 <div class="table-responsive">
                     <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                         <thead>
                             <tr>
                                 <th>보낸사람</th>
                                 <th>메일제목</th>
                                 <th>메일내용</th>
                                 <th>발송일시</th>
                             </tr>
                         </thead>
                         <tfoot>
                             <tr>
                                 <th>보낸사람</th>
                                 <th>메일제목</th>
                                 <th>메일내용</th>
                                 <th>발송일시</th>
                             </tr>
                         </tfoot>
                         <tbody id="mailList">
                         </tbody>
                     </table>
                 </div>
             </div>
         </div>

     </div>


    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/sbadmin2/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/sbadmin2/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/sbadmin2/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/sbadmin2/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="/resources/sbadmin2/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/resources/sbadmin2/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="/resources/sbadmin2/js/demo/datatables-demo.js"></script>

</body>

</html>

<script>
$(function() {
	
	id = <%=id%>;
	
	console.log("id >> ", id);
	
	var myMail = {
			   init : function() {

					this.initEvent();
				}
			  ,initEvent : function() {
				  
				    
					//주소록 데이터 받아오는 함수 
					myMail.fn_getmail();
					
					
				    
					
				}
	  			,fn_getmail : function () {
				  
				 
// 				  var param = {"reciever" : id};
				  var param = {"reciever" : 'test'};
				        
		           $.ajax({
		               url: "/test/getMail",
		               contentType: "application/json;charset=utf-8",
		               type: "post",
		               data: JSON.stringify(param),
		               dataType: "json",
		               beforeSend: function (xhr) {
		               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		               },
		               async: false,
		               success: function (result) {
		            	   
		            	   console.log("result >> ", result);
		            	   
		            	   str = ""; 
		            	   
		            	   var unreadCnt = 0;
		            	   
		            	   for (let value of result) {
		            		   
		            		    if(value.read_yn == 'N') unreadCnt++;
		            		   
		            		    var send_date = value.send_date.substr(0,4)+"-"+value.send_date.substr(4,2)+"-"+value.send_date.substr(6,2)
		            		    				+" "+value.send_date.substr(8,2)+":"+value.send_date.substr(10,2)+":"+value.send_date.substr(12,2);
		            		    
		            		    if(value.read_yn === 'Y'){
		            		    	str+='<tr style="background-color:#FFFACD;">';
		            		    }else{
									str+='<tr>                     ';
		            		    }
                                str+='<input type="hidden" value="'+value.mail_no+'">';
                                str+='<td>'+value.sender+'</td>     ';
                                str+='<td><a class="test" onclick="fn_read(this);">'+value.title+'</a></td>';
                                str+='<td>'+value.content+'</td>       ';
                                str+='<td>'+send_date+'</td>              ';
                           		str+='</tr>                    ';
		            		  }
		            	   
		            	   $("#mailList").html(str);
		            	   $("#unreadCnt").text("안읽은 메일 "+unreadCnt+"개");
							
		               }
		           });
				  
			  }
		}
		
		myMail.init();
	
})

//읽은 메일 표시
function fn_read (a) {
	$(a).closest("tr").css("background", "#FFFACD");
	var mail_id = $(a).closest("tr").find("input").val();
	
	var param = {"mail_id" : mail_id};
     
     $.ajax({
         url: "/test/chkRead",
         contentType: "application/json;charset=utf-8",
         type: "post",
         data: JSON.stringify(param),
         dataType: "json",
         beforeSend: function (xhr) {
         xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
         async: false,
         success: function (result) {
      	   
      	   console.log("업뎃결과 result >> ", result);
      	   
      	   window.location.reload();
				
         }
     });
     
}

</script>
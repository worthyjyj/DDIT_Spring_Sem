<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- <link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" /> -->
<!-- <link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" /> -->

<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script> -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="" src="/resources/jsgrid/jsgrid.min.js"></script>

<!-- 아마 충돌 난 듯 .. tiles에서 처리해주는걸로 변경 시도 -->

<link type="text/css" rel="stylesheet" href="/resources/jsgrid/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="/resources/jsgrid/jsgrid-theme.min.css" />


<div class="row">
   <div class="col-xl-8 col-lg-7">
       <div class="card shadow mb-4">
           <div class="card-header py-3">
               <h6 class="m-0 font-weight-bold text-primary">DB데이터 가져오기</h6>
           </div>
       </div>
	</div>
</div>

 <div id="jsGrid"></div>
 
 <script>
 var getGridData;
 
$(function() {
	
	//그리드에 뿌릴 데이터 먼저 가져오기
	getGridData();
	search();
	
	var btnSave = $(".jsgrid-update-button");
	
// 	console.log(btnSave);
	
	btnSave.on("click",function(){
		console.log("오잉");
	})
	
});

function getGridData() {
    $.ajax({
        url: "/test/getGridData",
        type: "post",
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        async: false,
        success: function (result) {
            getGridData = result;
        }
    });
}

function search(){


console.log("getGridData >> ",getGridData);

        //init 그리드
	    $("#jsGrid").jsGrid({
	        width: "100%",
	        height: "400px",

	        inserting: true,
	        editing: true,
	        sorting: true,
	        paging: true,

	        data: getGridData,

	        fields: [
	            { name: "reg_date", type: "text", width: 150, validate: "required" },
	            { name: "reg_user", type: "text", width: 50 },
	            { name: "title", type: "text", width: 200 },
	            { name: "content", type: "text", width: 200 },
	            { name: "seq", type: "text", title: "seq", sorting: false },
	            { type: "control" }
	        ],
	        
	        rowClick: function (args) {
	        	var getData = args.item;
	        	console.log("클릭이벤트 >> ", getData);
	        	
	        }
	        
	    });
	    
	    
}

</script>





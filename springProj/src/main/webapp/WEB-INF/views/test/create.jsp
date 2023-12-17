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


<!-- 리얼그리드 관련 파일 import -->
 <script type="text/javascript" src="/resources/realgrid/realgrid-lic.js"></script>
 <script type="text/javascript" src="/resources/realgrid/realgrid.2.7.2.min.js"></script>
 <link href="/resources/realgrid/realgrid-style.css" rel="stylesheet" />


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
 <div id="realgrid"></div>
 <pre id="resultViewer"></pre>
 
 
 <style>
  #realgrid {
    width: 100%;
    height: 440px;
  }
</style>


<script>
var getGridData;


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

  document.addEventListener('DOMContentLoaded', function () {
    const container = document.getElementById('realgrid');
    const provider = new RealGrid.LocalDataProvider(false);
    const gridView = new RealGrid.GridView(container);
    gridView.setDataSource(provider);
    
    
    //필드 생성
    provider.setFields([
      {
        fieldName: 'cud',
        dataType: 'text',
      },
      {
        fieldName: 'reg_date',
        dataType: 'text',
      },
      {
        fieldName: 'reg_user',
        dataType: 'text',
      },
      {
        fieldName: 'title',
        dataType: 'text',
      },
      {
        fieldName: 'content',
        dataType: 'text',
      },
      {
        fieldName: 'seq',
        dataType: 'text',
      },
    ]);
    
    //컬럼 생성
    gridView.setColumns([
    	{
    	    name: "cudColumn",
    	    fieldName: "cud",
    	    width: 70,
    	    sortable: false,
    	    lookupDisplay: true,
    	    values: [
    	        "C",
    	        "R",
    	        "U",
    	        "D"
    	    ],
    	    labels: [
    	    	"C",
    	        "R",
    	        "U",
    	        "D"
    	    ],
    	    editor: {
    	        type: "dropdown"
    	    },
    	    header: {
    	        text: "CRUD",
    	        styleName: "orange-column"
    	    }
    	  },
      {
        name: 'reg_dateColumn',
        fieldName: 'reg_date',
        type: 'data',
        width: '140',
        header: {
          text: '등록일자',
        },
      },
      {
        name: 'reg_userColumn',
        fieldName: 'reg_user',
        type: 'data',
        width: '140',
        header: {
          text: '등록자',
        },
      },
      {
        name: 'titleColumn',
        fieldName: 'title',
        type: 'data',
        width: '140',
        header: {
          text: '제목',
        },
      },
      {
        name: 'contentColumn',
        fieldName: 'content',
        type: 'data',
        width: '140',
        header: {
          text: '내용',
        },
      },
      {
        name: 'seqColumn',
        fieldName: 'seq',
        type: 'data',
        width: '140',
        header: {
          text: '등록키',
        },
      },
    ]);
    
    getGridData();
    
    console.log("getGridData >> ",getGridData);
    provider.fillJsonData(getGridData, { fillMode: "set" });
    
 // getRows 함수로 provider의 값 가져오기
//     const rows = provider.getRows();
//     document.getElementById('resultViewer').innerHTML = JSON.stringify(rows, 1);
    
 // getRows 함수로 provider의 값 가져오기
    const rows = provider.getValues(0);
    document.getElementById('resultViewer').innerHTML = JSON.stringify(rows);
    
    //CRUD 드롭박스 선택했을 때 이벤트 주기
    gridView.onEditChange = function (grid, index, value) {
        console.log("grid.onEditChange driven, " + index.column + ' at ' + index.dataRow + ' was replaced by value: ' + value);
        console.log("index >> ", index);
        
        if(index.fieldName == "cud"){
            console.log("CUD필드에다가 이제 c일경우, u일경우...등등 경우의 수를 만들어서 처리하기");
        }
        
    };
    
    
  });
  
  
 
  
</script>





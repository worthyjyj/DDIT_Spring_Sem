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
 <div style="margin-bottom:10px;"><input type="button" value="저장" id="saveBtn"/></div>
 <!-- 검색조건 시작  -->
 <div>
	<table border="1">
	<tr><!-- 첫번째 줄 시작 -->
	    <td>등록키[콤보박스]</td>
	    <td><select id="schParam1">
	    </select></td>
	    <td>제목</td>
	    <td><input type="text" id="schParam2" /></td>
	    <td>날짜</td>
	    <td><input type="date" id="schParam3"/> ~ <input type="date" id="schParam4" /></td>
	    <td><input type="button" id="schBtn" value="조회"/></td>
	</tr><!-- 첫번째 줄 끝 -->
    </table>
 </div>
 <!-- 검색조건 끝  -->
 <div id="realgrid"></div>
 <pre id="resultViewer"></pre>
 <div id="realgrid2"></div>
 
 
 <style>
  #realgrid {
    width: 100%;
    height: 440px;
  }
  #realgrid2 {
    width: 100%;
    height: 440px;
  }
  
</style>


<script>
var getGridData;


// init combo (등록키 콤보 박스 콤보 데이터 가져오기)
getComboData();


function getComboData() {
    $.ajax({
        url: "/test/getComboData",
        type: "post",
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        async: false,
        success: function (result) {
        	console.log("combo result >> ", result);
        	$("#schParam1").empty();
        	
        	// 셀렉트 박스에 옵션값 html로 채워주기
        	vhtml = "<option> </option>"; 
        	for(var i=0; i<result.length ; i++){
	        	vhtml += "<option value="+result[i].cd_item+">"+result[i].cd_item_nm+"</option>"; 
        	}
        	
        	
        	$("#schParam1").append(vhtml);
        }
    });
}




function getGridData() {
	
	// 검색 조건 파라미터 생성 (JSON 파라미터)
	// 일단 검색 조건이 없으면 ''으로도 검색되는지 확인해보기 
	// 되면 쿼리 수정해보고 안되면 @뭐 이런거 써서 파라미터 있으면  이거 써서 하는걸로 쿼리 수정해야할 듯 .
	// 일단 쿼리 수정해보고 파라미터 같이 보내서 데이터 받아오기
	
	// 파라미터 세팅
	var param = {
		"seq" : $("#schParam1").val(), 
		"title" : $("#schParam2").val(), 
		"sdate" : $("#schParam3").val(),
		"edate" : $("#schParam4").val()
	}
	
	console.log("param >> ", param);
	
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
    
    //save 전용
	provider_save = new RealGrid.LocalDataProvider(false);
	provider_save.setFields(provider_save);
    
    gridView.setEditOptions({
    	  insertable: true,
    	  appendable: true
    });
    
    //realgrid2 작성
    const container2 = document.getElementById('realgrid2');
	const provider2 = new RealGrid.LocalDataProvider(false);
	const gridView2 = new RealGrid.GridView(container2);
    gridView2.setDataSource(provider2);
    
    console.log("gridView2 >> ",gridView2);
    
    gridView2.setEditOptions({
    	  insertable: true,
    	  appendable: true
    });

    //해당 row 위에 삽입
    function insertEmptyRow() {
    	gridView.commit()
  	  var row = gridView.getCurrent().dataRow;
      provider.insertRow(row, {});
//   	  gridView.showEditor(); //바로 편집기를 표시하고 싶을때
  	}
    
    //해당 row 아래 삽입
   function btnBeginInsertRowShift() {
	  var curr = gridView.getCurrent();
	  gridView.beginInsertRow(Math.max(0, curr.itemIndex), true);
	  //setTimeout(function(){gridView.showEditor();}, 10); //바로 편집기를 표시하고 싶을때
	}
    
   function CUD(grid, itemIndex, dataRow, field ,dataProvider){
	   var dataProvider = grid.getDataSource();
	   var fieldName = dataProvider.getFieldName(field);
	   var cudVal = grid.getValue(itemIndex, "cud");
		
		console.log("dataProvider  >> ",dataProvider);
		console.log("field  >> ",field);
		console.log("fieldName  >> ",fieldName);
		console.log("cudVal  >> ",cudVal);
		console.log("itemIndex  >> ",itemIndex);

		// 수정한 칼럼 인덱스를 구해서 focus 줘야됨
		if( fieldName == "CUD" && cudVal == "C" ){
			//행 추가를 위한 수정내역 취소.
			grid.cancel();

			// c 처리
			var selectedRows = {};
			selectedRows['cud'] = 'C';

			// 맨 아랫줄은 itemIndex+1 사용안됨
			if (dataProvider.getRowCount() == itemIndex+1) {    // 마지막줄 이면
				//하위 행 추가.
				// grid.beginInsertRow(itemIndex, true);
				// grid.commit(true);
				// grid.setValues(itemIndex+1, selectedRows);
				// grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.setEditOptions({appendable: true}); //21.08.04 choms 이렇게 안하면 키보드로 행추가 가능함.
				grid.beginAppendRow();
				grid.setValues(itemIndex+1, selectedRows);
				// grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.setEditOptions({appendable: false});
				grid.commit(true);
			} else {    // 마지막줄 아니면
				//하위 행 추가.
				grid.beginInsertRow(itemIndex+1, false);
				grid.setValues(itemIndex+1, selectedRows);
				grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.commit(true);
			}

		}else if ( fieldName == "CUD" && cudVal == "R" ){
			//행 추가를 위한 수정내역 취소.
			grid.cancel();

			//r 처리 행 데이터복사 처리
			var selectedRows = grid.getValues(itemIndex);
			selectedRows['cud'] = 'C';

			// 맨 아랫줄은 itemIndex+1 사용안됨
			if (dataProvider.getRowCount() == itemIndex+1) {    // 마지막줄 이면
				//하위 행 추가.
				// grid.beginInsertRow(itemIndex, true);
				// grid.commit(true);
				// grid.setValues(itemIndex+1, selectedRows);
				// grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.setEditOptions({appendable: true}); //21.08.04 choms 이렇게 안하면 키보드로 행추가 가능함.
				grid.beginAppendRow();
				grid.setValues(itemIndex+1, selectedRows);
				grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.setEditOptions({appendable: false});
				grid.commit(true);
			} else {    // 마지막줄 아니면
				//하위 행 추가.
				grid.beginInsertRow(itemIndex+1, false);
				grid.setValues(itemIndex+1, selectedRows);
				grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.commit(true);
			}

		}else if ( fieldName == "CUD" && cudVal == "D" ){
			grid.commit();
			grid.setValue(itemIndex, 'cud', 'D');
		}else if ( fieldName == "CUD" && cudVal == "" ){
			grid.commit();
			if( $.inArray(dataRow, dataProvider.getStateRows('created')) > -1  ){
				dataProvider.removeRow(dataRow);
			}else{
				dataProvider.setRowState(dataRow, 'none', true);
			}
		}else{
			grid.commit();
			//CUD 이외의 행에서 값이 변경되었을때  CUD - U 처리
			if( cudVal != 'C' && cudVal != 'D'){
				console.log("오잉");
				gridView.setValue(itemIndex, 'cud', 'U');
			}else if(cudVal == 'D'){

			}else{
				grid.setValue(itemIndex, 'cud', 'C');
			}
		}
	}

    //필드 생성
    // ※ 앞으로 필드명은 대문자로 작성할 것..
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
    
    //grid2 field명 작성
    provider2.setFields([
        {
          fieldName: 'withme_no',
          dataType: 'text',
        },
        {
          fieldName: 'file_name',
          dataType: 'text',
        },
        {
          fieldName: 'incruit_edate',
          dataType: 'text',
        },
        {
          fieldName: 'incruit_no',
          dataType: 'text',
        },
        {
          fieldName: 'incruit_ssts',
          dataType: 'text',
        },
        {
          fieldName: 'user_name',
          dataType: 'text',
        },
        {
          fieldName: 'withme_content',
          dataType: 'text',
        },
        {
          fieldName: 'withme_hit',
          dataType: 'text',
        },
        {
          fieldName: 'withme_title',
          dataType: 'text',
        },
      ]);
    
    //저장용 필드 생성
    provider_save.setFields([
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
          {
            fieldName: 'withme_no',
            dataType: 'text',
          },
          {
            fieldName: 'file_name',
            dataType: 'text',
          },
          {
            fieldName: 'incruit_edate',
            dataType: 'text',
          },
          {
            fieldName: 'incruit_no',
            dataType: 'text',
          },
          {
            fieldName: 'incruit_ssts',
            dataType: 'text',
          },
          {
            fieldName: 'user_name',
            dataType: 'text',
          },
          {
            fieldName: 'withme_content',
            dataType: 'text',
          },
          {
            fieldName: 'withme_hit',
            dataType: 'text',
          },
          {
            fieldName: 'withme_title',
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
    	    	"",
    	        "C",
    	        "R",
    	        "U",
    	        "D"
    	    ],
    	    labels: [
    	    	"",
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
//         editable: false,
      },
    ]);
    
    
    // 그리드2 컬럼 생성
    gridView2.setColumns([
      {
        name: 'withme_noColumn',
        fieldName: 'withme_no',
        type: 'data',
        width: '80',
        header: {
          text: '고유번호',
        },
      },
      {
        name: 'file_nameColumn',
        fieldName: 'file_name',
        type: 'data',
        width: '140',
        header: {
          text: '파일명',
        },
      },
      {
        name: 'incruit_edateColumn',
        fieldName: 'incruit_edate',
        type: 'data',
        width: '140',
        header: {
          text: '날짜',
        },
      },
      {
        name: 'incruit_noColumn',
        fieldName: 'incruit_no',
        type: 'data',
        width: '100',
        header: {
          text: '등록키',
        },
      },
      {
        name: 'incruit_sstsColumn',
        fieldName: 'incruit_ssts',
        type: 'data',
        width: '140',
        header: {
          text: '상태',
        },
      },
      {
        name: 'user_nameColumn',
        fieldName: 'user_name',
        type: 'data',
        width: '140',
        header: {
          text: '작성자',
        },
      },
      {
        name: 'withme_contentColumn',
        fieldName: 'withme_content',
        type: 'data',
        width: '140',
        header: {
          text: '작성내용',
        },
      },
      {
        name: 'withme_hitColumn',
        fieldName: 'withme_hit',
        type: 'data',
        width: '140',
        header: {
          text: '조회수',
        },
      },
      {
        name: 'withme_titleColumn',
        fieldName: 'withme_title',
        type: 'data',
        width: '140',
        header: {
          text: '게시글제목',
        },
      },
    ]);
    
    
    // 검색 조건 세팅 후 그리드 조회
    getGridData();
    
    console.log("getGridData >> ",getGridData);
    provider.fillJsonData(getGridData, { fillMode: "set" });
    
    // 아니 왜 이게 함수 인식을 못하지....?
    $("#schBtn").on("click",function(){
	    getGridData();
    })
    
    // 그리드2 데이터 조회 
	gridView.onCellClicked = function (grid, clickData) {
		console.log("clickData >> ",clickData);
		
		//seq 뽑아내기 
		var seq = provider.getValue(clickData.dataRow,"SEQ");
		
		var param = { "seq" : seq };
		
		console.log("param >> ",param);
		
		$.ajax({
			url: "/test/getGrid2Data",
			contentType: "application/json;charset=utf-8",
			type: "post",
			data: JSON.stringify(param),
			dataType: "json",
			beforeSend: function (xhr) {
		       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
		    async: false,
		    success: function(result){
		    	console.log("result >> ",result);
		    	
		    	if(result.length > 0){
		    		
		    	provider2.fillJsonData(result, { fillMode: "set" });
		    	gridView2.commit(true);
		    	
		    	}else{
		    		console.log("데이터 length >> ", result.length);
		    		// 데이터가 없을 경우 임의의 값(0)을 세팅한다. 
		    			
		    		provider2.setRows([
		    			  {
		    				withme_no: '1',
		    				file_name: '남',
		    				incruit_edate: '2001-01-01',
// 		    			    Phone: '(025)6563-2802',
// 		    			    ProductId: '198160731-00008',
// 		    			    KorCountry: '모잠비크',
// 		    			    OrderDate: '2021-01-16',
// 		    			    CardNumber: '5587-2139-9692-3644',
// 		    			    Monetary: 'EUR',
// 		    			    StartDate: '2018-02-25',
// 		    			    EndDate: '2021-08-12',
// 		    			    ToMonth: '23',
// 		    			    Month: '41',
// 		    			    Year: '3',
// 		    			    InterestRate: '0.15',
// 		    			    SaveCost: '51000',
// 		    			    SaveMaturity: '14950650',
// 		    			    CurrentSave: '9304950',
// 		    			    Rating: '5',
// 		    			    BusinessProficiency: '59',
// 		    			    Address: '서울특별시 강서구 공항동 45-89',
		    			  },
		    			]);
		    
		    	}
		    	
		    	
		    }
		})
		
	};
    
    //첫번째 ROW 자동 선택
	gridView.setCurrent({dataRow: 0, fieldName : 'SEQ'});
	gridView.onCellClicked(gridView,{itemIndex: 0, dataRow : 0 , cellType : 'data'});
    
	
 // getRows 함수로 provider의 값 가져오기
    const rows = provider.getValues(0);
    document.getElementById('resultViewer').innerHTML = JSON.stringify(rows);
    
    //CRUD 드롭박스 선택했을 때 이벤트 주기
    gridView.onCellEdited = function (grid, itemIndex, dataRow, field ) {
		CUD(grid, itemIndex, dataRow, field ,provider);
	};
	
	
	//그리드2 데이터 수정했을 때 부모 그리드1 의 CRUD U로 변경해주기
    gridView2.onCellEdited = function (grid, itemIndex, dataRow, field ) {
		 console.log("뭐냐 >> ",gridView.getCurrent().itemIndex);
		 itemIndex = gridView.getCurrent().itemIndex;
		 // 부모 그리드에 CRUD "U" 표시해주기
		CUD(grid, itemIndex, dataRow, field ,provider);
	};
    
    
    // 저장 process
    $("#saveBtn").on("click",function(){
    	    var conf = confirm('저장하시겠습니까?');
    	    
    		if(conf){
    			gridView.commit();
      			try {
    	  				gridView.commit();
    	  				
    	  				provider_save.clearRows();
    	  				
    	  				var editArr = new Array();
    	  				//이거 뭔지 이해안감....
    	  				//어쨌든 CRUD를 실행한 행의 인덱스를 반환함
    	  				// 저장시, CRUD는 한개씩만 가능함
    	  				editArr = provider.getStateRows('created').concat(provider.getStateRows('updated'), provider.getStateRows('deleted'));
    	  				editArr = editArr.filter(Number.isFinite);
    	  				var saveArr = new Array();
    	  				var jsonData;
    	  				
    	  				console.log("editArr >> ",editArr);
    	  				
    	  				
    	  			 	if (editArr.length == 0) {
    	  			 		alert('변경사항이 없습니다.');
    	  				} else {
    	  					
    	  					for (var i = 0; i < editArr.length; i++) {
    	  						
    	  						var values = ["","","","","",
					                  "","","","","","","","","",""];
    	  						
								provider_save.addRow(values);
								
								// 일단 선택된 그리드1에 있는 데이터 넣어주기
// 								var curIndex = gridView.getCurrent().itemIndex;
								
								provider_save.setValue(i,"cud",provider.getValue(editArr[i],"cud"));
								provider_save.setValue(i,"reg_date",provider.getValue(editArr[i],"reg_date"));
								provider_save.setValue(i,"reg_user",provider.getValue(editArr[i],"reg_user"));
								provider_save.setValue(i,"title",provider.getValue(editArr[i],"title"));
								provider_save.setValue(i,"content",provider.getValue(editArr[i],"content"));
								provider_save.setValue(i,"seq",provider.getValue(editArr[i],"seq"));
								
        	  					// 만약 그리드2의 내용을 수정하지 않고 그리드 1만을 수정한다고 했을 때 
        	  					// 없는 그리드 2를 수정하려고 하니까 여기서 bounds 에러가 남.
        	  					// 근데 이건 내가 걱정할게 아닌게 원래대로 였으면 그리드2에 무조건 데이터가 넣어져 있어야함. 
								if(provider.getValue(editArr[i],"cud") == "U"){
									provider_save.setValue(i,"withme_no",provider2.getValue(i,"withme_no"));
									provider_save.setValue(i,"file_name",provider2.getValue(i,"file_name"));
									provider_save.setValue(i,"incruit_edate",provider2.getValue(i,"incruit_edate"));
									provider_save.setValue(i,"incruit_no",provider2.getValue(i,"incruit_no"));
									provider_save.setValue(i,"incruit_ssts",provider2.getValue(i,"incruit_ssts"));
									provider_save.setValue(i,"user_name",provider2.getValue(i,"user_name"));
									provider_save.setValue(i,"withme_content",provider2.getValue(i,"withme_content"));
									provider_save.setValue(i,"withme_hit",provider2.getValue(i,"withme_hit"));
									provider_save.setValue(i,"withme_title",provider2.getValue(i,"withme_title"));
								}
        	  				
								saveArr.push(provider_save.getJsonRow(i));
								
        	  					}
    		  						provider_save.fillJsonData([], {fillMode:'set'});
    		  						
    		  						console.log("saveArr >> ",saveArr);
    		  						
    		  						//저장하는 것 부터 손보면 될 것 같음.. 그냥 U일때 테이블 데이터 수정해주는 쿼리 추가해주면 될 듯.
//     		  						저장 ajax 호출 
//     		  						$.ajax({
//     		  							url: "/test/saveData",
//     		  							contentType:"application/json;charset=utf-8",
//     		  							type: "post",
//     		  							data: JSON.stringify(saveArr),
//     		  							dataType: "text",
//     		  							beforeSend: function (xhr) {
//     		  					            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//     		  					        },
//     		  					        async: false,
//     		  					        success: function(result){
//     		  					        	console.log("result >> ",result);
//     		  					        	if(result == "success"){
//     		  					        		location.reload();
//     		  					        	}
//     		  					        }
//     		  						})

    	  				} 

    			} catch (e) {
    				console.error(e);
    			} finally {
    			}
    		}
    	})
    
    
    
  });
  
  
 
  
</script>





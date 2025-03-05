<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<!-- 제이쿼리 파일 import -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!-- JSON JS 파일 import -->
<script type="text/javascript" src="/resources/js/jquery.serializejson.js"></script>

<!-- front basic css 파일 import -->
<link rel="stylesheet" type="text/css" href="/resources/css/front.css" />
<!-- MESUtil JS 파일 import -->
<script type="text/javascript" src="/resources/js/mes_common.js"></script>

<!-- <script type="text/javascript"  src="/resources/js/moment.min.js"></script> -->

<!-- ag차트 import -->
 <script type="text/javascript" src="/resources/js/ag-charts-community-8.2.1.min.js"></script>
 
 <!-- highCharts js import -->
<script type="text/javascript" src="/resources/Highcharts-11.4.8/code/highcharts.js"></script>
<script type="text/javascript" src="/resources/Highcharts-11.4.8/code/themes/gray.js"></script>
<script type="text/javascript" src="/resources/Highcharts-11.4.8/code/modules/boost.js"></script>
<script type="text/javascript" src="/resources/Highcharts-11.4.8/code/modules/exporting.js"></script>
<script type="text/javascript" src="/resources/Highcharts-11.4.8/code/modules/export-data.js"></script>
<script type="text/javascript" src="/resources/Highcharts-11.4.8/code/modules/accessibility.js"></script>

<!-- 리얼그리드 관련 파일 import -->
 <script type="text/javascript" src="/resources/realgrid/realgrid-lic.js"></script>
 <script type="text/javascript" src="/resources/realgrid/realgrid.2.7.2.min.js"></script>
 <link href="/resources/realgrid/realgrid-style.css" rel="stylesheet" />


<div class="contPage-head flrbox">
	<div class="titlebox fl">
		<h2 class="title itype1" >운반구 조회 및 등록</h2>
	</div>
	<div class="btnbox fr">
		<a href="javascript:void(0);" data-fc-auth="w" class="btn-ix" onclick="crtPrac.save();"><span class="txt">저장</span></a>
		<a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="crtPrac.search();"><span class="txt">조회</span></a>
	</div>
</div>

<div class="contPage-search searchSHWrap" id="div_form_crtPrac">
	<div class="border-box searchReq-box">
		<div class="searchReq-tablebox">
			<table>
				<colgroup>
					<col style="width: 5%;" />
					<col style="width: 10%;" />
					<col style="width: 5%;" />
					<col style="width: 10%;" />
					<col style="width: 5%;" />
					<col style="width: 15%;" />
					<col/>
					<col style="width: 20%;" />

				</colgroup>
				<tr>
					<th><span class="label-dot">운반 상태</span></th>
					<td>
						<div style="width: calc(100% - 50px)">
							<select class="select1" id="crt_ssts" name="crt_ssts" style="width: 100%;"></select>
						</div>
					</td>
					<th><span class="label-dot">운반구</span></th>
					<td>
						<div style="width: calc(100% - 50px)">
							<input type="text" class="crt_cd" id="crt_cd" name="crt_cd" value="" style="width: 100%;"/>
						</div>
					</td>
<!-- 					<th><span class="label-dot">RF-ID No</span></th> -->
<!-- 					<td> -->
<!-- 						<div style="width: calc(100% - 50px)"> -->
<!-- 							<input type="text" class="input1" id="crt_tag_no" name="crt_tag_no" style="width: 100%;"/> -->
<!-- 						</div> -->
<!-- 					</td> -->
					<td></td>
				</tr>
			</table>
		</div>
	</div>
</div>

<div class="contPage-body">
	<div class="base-list table-list">
		<div id="realgrid0"></div>
		<div id="chart0" style="width: 40%; height: 55%; float: left"></div>
	   	<div id="chart1" style="width: 60%; height: 55%; float: left; " ></div>
	   	<div id="chart" style="width: 100%; height: 100%;"></div>
	</div>
</div>

 <style>
  #realgrid0 {
    width: 100%;
    height: 300px;
  }
  
</style>


<script>
// 1. 전역변수 및 그리드 field, column 정의

var tabIdx = 0;
var tabClear = null;

var provider = [];
var gridView = [];
var fields = [];
var columns = [];
var layout = [];

var highChart = [];

var i = 0;
fields[i] = [
	  {fieldName:'CUD'                 }
	, {fieldName:'CRT_CD'              }
	, {fieldName:'CRT_NM'              }
	, {fieldName:'CRT_SSTS'            }
	, {fieldName:'CRT_DTM'   , dataType:"text", datetimeFormat:'yyyyMMddHHmmss'  } //String 타입으로 데이터 받아오고 화면에는 날짜 형식으로 출력하기 위해
	, {fieldName:'CRT_CNT' , dataType : 'number' } 
];

columns[i] = [
	  {name:'CUD',                 fieldName:'CUD',                 type:'data', width:50, 	header:'CUD', 			editable:true, 	sortable:false, lookupDisplay: true, values:['','C','R','U','D'], labels:['','C','R','U','D'], editor: {type: "dropdown", dropDownCount: 5}	}
	, {name:'CRT_CD',              fieldName:'CRT_CD',              type:'data', width:100, header:'운반구', 		editable:true, 	sortable:true, 	button: 'action', buttonVisibility: 'always',
		styleCallback: styleCallback	}
	, {name:'CRT_NM',              fieldName:'CRT_NM',              type:'data', width:150, header:'운반구 이름', 			editable:true, 	sortable:true	}
	, {name:'CRT_SSTS',            fieldName:'CRT_SSTS',            type:'data', width:150, header:'운반구 상태', 			editable:true, 	sortable:true	}
	, {name:'CRT_DTM',             fieldName:'CRT_DTM',           type:'data', width:80, 	header:'운반 일시',	editable:false, 	sortable:true, 	lookupDisplay: true, textFormat:'([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})$;$1-$2-$3 $4:$5:$6'	}
	, {name:'CRT_CNT',             fieldName:'CRT_CNT',           type:'data', width:80, 	header:'운반 개수',	editable:false, 	sortable:true, 	lookupDisplay: true , numberFormat: "#,##0" 	}
];

layout[i] = [
	  'CUD'
	, 'CRT_CD'
	, 'CRT_NM'
	, 'CRT_SSTS'
	, 'CRT_DTM'
	, 'CRT_CNT'
];

//CUD할 때 editable 할 수 있도록 callback 처리
function styleCallback(grid, dataCell){
	var rVal = {};
	var cud = grid.getValue(dataCell.index.itemIndex, "CUD");
	if (cud == "C") {
		rVal.editable = true;
	} else {
		rVal.editable = false;
	}
	return rVal;
}

setChart();

function setChart(){
	// TP용 기존 시간에 +6으로 찍음    UTC -12로 되어 있나...?
	Highcharts.setOptions({
		global: {
			timezoneOffset: 360
		}
	});

	for(var i = 0; i < 1; i++ ){
		chart[i] = Highcharts.chart('chart', {
			chart	: {zooming: {type: 'x'}	,marginBottom: 110 	},
			title	: {text: '' ,align: 'center'				},
			subtitle: {text: ''				  ,align: 'left'				},
			accessibility: {screenReaderSection: { beforeChartFormat: '<{headingTagName}>' + '{chartTitle}</{headingTagName}><div>{chartSubtitle}</div>' +
							'<div>{chartLongdesc}</div><div>{xAxisDescription}</div><div>' + '{yAxisDescription}</div>'	}	},
			tooltip: {	valueDecimals: 2},
			xAxis: {
				type: 'datetime'
				,labels: {
					enabled: true // Disable default x-axis labels
					,format: '{value:%H:%M:%S}'
					,style: {
						color: '#FFFFFF', // 레이블 텍스트 색상 (예: 주황색)
						fontSize: '14px',  // 폰트 크기
						fontWeight: 'bold' // 폰트 두께
					}
				},
				// 				tickInterval: 3600000 // 1시간 간격으로 눈금 표시
			},
			yAxis: [{ // Primary yAxis
				gridLineWidth: 0,
				labels: {
					format: '{value}',
					style: {
						color: 'gray'
					}
				}
			}
			]
// 			series: [{
// 				name: 'value',
// 				data: [],
// 				lineWidth: 1,
// 				color: 'red',
// 				yAxis: 0
// 			}]
		});
	}
}




$(function() {

	crtPrac = {
		init : function() {
			this.initGrid();
			this.initEvent();
			this.initCombo();
			this.initDisp();
		}

		, initGrid : function() {
			for (var idx = 0; idx < 1; idx++) {
				provider[idx] = new RealGrid.LocalDataProvider(false);
				gridView[idx] = new RealGrid.GridView('realgrid' + idx);
				provider[idx].setFields(fields[idx]);
				gridView[idx].setDataSource(provider[idx]);
// 			    setDefaultGrid(gridView[idx]);
				gridView[idx].headerSummaries.visible = false;
				gridView[idx].setRowIndicator({visible:false});
				gridView[idx].setStateBar({visible:false});
				gridView[idx].setCheckBar({visible:false});
				gridView[idx].setFooters({visible:false});
				gridView[idx].sortingOptions.enabled = true;
				gridView[idx].displayOptions.columnMovable = false;
				gridView[idx].displayOptions.selectionStyle = 'rows';
				gridView[idx].displayOptions.fitStyle = 'fill';
				gridView[idx].setColumns(columns[idx]);
				gridView[idx].setColumnLayout(layout[idx]);
				//gridView[idx].setEditOptions({insertable : true, appendable : true, deletable : true});
				gridView[idx].setEditOptions({ insertable: true,appendable : true,  deletable: true, editWhenFocused: true, commitWhenLeave: true, commitByCell : true });
				gridView[idx].setOptions({hideDeletedRows : true, softDeleting : true});
// 				gridView[idx].fixedOptions.colCount = 6;
				gridView[idx].sortMode = "explicit";
// 				gridView[idx].onContextMenuPopup = onContextMenuPopup;					//출력할 메뉴 설정
// 				gridView[idx].onContextMenuItemClicked = onContextMenuItemClicked;		//메뉴 클릭시
				gridView[idx].header.height = "46";
				// Header click 처리 Row Insert 공통
				gridView[idx].onCellClicked = function(grid, clickData) {
					// CRUD 헤더 클릭시 row생성
					MES_UTIL.HEADER(grid, clickData);
				};

				// CUD 처리
				gridView[idx].onCellEdited = function(grid, itemIndex, dataRow, field) {
					// CRUD 셀렉트박스 변경시
					MES_UTIL.CUD(grid, itemIndex, dataRow, field, provider[0]);
				};

				// CUD 처리
				// 이건 필요 없음
				gridView[idx].onCellButtonClicked = function(grid, index, column) {
					gridView[0].commit();
					var rowData = grid.getValues(index.itemIndex);
					var arg = {
						itemIndex : index.itemIndex
						, crt_cd : MES_UTIL.isNull(rowData.CRT_CD)?"":rowData.CRT_CD
					};
					var url = '/LINVEN017/LINVEN017_P1.html';
					var name = 'LINVEN017_P1';
					var width = 700;
					var height = 600;

					popup_open(url, arg, name, width, height);
				};
			}
		}

		, initEvent : function() {
			// 컬럼에 dropbox등에 이벤트 줄 때 씀
			
// 			setGridCombo("I090").then(function(rtnData) {
// 				rtnData.values.unshift("");
// 				rtnData.labels.unshift("");
// 				gridView[0].setColumnProperty('CRT_TP_FG', 'values', rtnData.values);
// 				gridView[0].setColumnProperty('CRT_TP_FG', 'labels', rtnData.labels);
// 			});

// 			setGridCombo2("C111", "C110_INV").then(function(rtnData) {
// 				gridView[0].setColumnProperty('LD_UNIT_FG', 'values', rtnData.values);
// 				gridView[0].setColumnProperty('LD_UNIT_FG', 'labels', rtnData.labels);
// 			});

// 			var arg = {};
// 			setCustomGridCombo("LINVEN017", "LINVEN017_FIND_CRT_MLPS_FG", arg).then(function(rtnData) {
// 				gridView[0].setColumnProperty('CRT_MLPS_FG', 'values', rtnData.values);
// 				gridView[0].setColumnProperty('CRT_MLPS_FG', 'labels', rtnData.labels);
// 			});

// 			setGridCombo("C040").then(function(rtnData) {
// 				rtnData.values.unshift("");
// 				rtnData.labels.unshift("");
// 				gridView[0].setColumnProperty('FAC_CD', 'values', rtnData.values);
// 				gridView[0].setColumnProperty('FAC_CD', 'labels', rtnData.labels);
// 			});

		}

		, initCombo : function() {
			// 검색 조건에 있는 콤보박스에 데이터 넣기
			
			// 운반 상태 combo
			var param = {
			"cd_group" : "crt_ssts" 
		    }
        
           $.ajax({
               url: "/test/getCrtCombo",
               contentType: "application/json;charset=utf-8",
               type: "post",
               data: JSON.stringify(param),
               dataType: "json",
               beforeSend: function (xhr) {
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
               },
               async: false,
               success: function (result) {
                   console.log("combo result >> ", result);
                   
                   //select box에 옵션 세팅해주기
                   var option = "<option value=''>&nbsp;</option>"
                   
                   if(result.length > 0){
						for(var i = 0; i < result.length; i++){
							option += "<option value='"+result[i].cd_item+"'>"+result[i].cd_item_nm+"</option>"
						}
                   }
                   
                   $("#crt_ssts").html(option);
               }
           });
			
			
			
			crtPrac.search();
			crtPrac.searchChart();

		}

		, callback : function(id) {
			switch (id) {
			}
		}

		, initDisp : function() {

		}

		, search : function() {

		// 리스트 그리드
		$(".overlay").show();

        // 파라미터 세팅
//         this.searchCond = $( '#div_form_crtPrac' ).serializeJson(); serializeJson 함수가 안됨;
        
		var param = {
			"crt_ssts" : $("#crt_ssts").val(), 
			"crt_cd" : $("#crt_cd").val()
		    }
        
       	console.log("param >> ", param);
       	
           $.ajax({
               url: "/test/getCrtData",
               contentType: "application/json;charset=utf-8",
               type: "post",
               data: JSON.stringify(param),
               dataType: "json",
               beforeSend: function (xhr) {
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
               },
               async: false,
               success: function (result) {
                   $(".overlay").hide();
                   
                   var getCrtData = result;
                   
                   console.log("그리드 데이터 >> ", getCrtData);
                   
                   if(result.length > 0){
                	   // 그리드 세팅
	                   provider[0].fillJsonData(getCrtData, { fillMode: "set" });
	                   
                	   //원형 차트 함수 호출 
                	   chart0(getCrtData);
                	   
                	   //라인형 차트 함수 호출
                	   chart1(getCrtData);
	                   
                   }
                   
               }
           });


		}
		, searchChart : function() {

			console.log("하이차트 데이터 세팅");
			
			//시리즈 세팅
			for(let i=0; i<3; i++){
				chart[0].addSeries({
				    name: '새로운 라인',
				    type: 'spline',
				    color: '#FF0000',
				    data: []
				});	
			}
			
			var arr = [["20240612343435",80],["20240612343435",50]];
			var arr2 = [["20240612343435",10],["20240612343437",100]];
			var arr3 = [["20240612343435",60],["20240612343437",20]];


			chart[0].series[0].setData(arr);
			chart[0].series[1].setData(arr2);
			chart[0].series[2].setData(arr3);
			

			}
		, save : function() {
			var idx = 0;
			gridView[idx].commit();
			try {
				var gridedit;
				var saveArr = new Array();
				gridedit = provider[idx].getStateRows("created").concat(provider[idx].getStateRows("updated"),provider[idx].getStateRows("deleted")) ;
				gridedit  = gridedit.filter(Number.isFinite);
				for(var i=0 ; i < gridedit.length ; i++){
					var obj = provider[idx].getJsonRow(gridedit[i]);
				    
					saveArr.push(obj);
				}

				if(gridedit.length == 0){
					alert('변경사항이 없습니다.');
				}else{

					console.log("저장 데이터 >> ", saveArr);
					$(".overlay").show();
					
					
					  $.ajax({
			               url: "/test/saveCrtData",
			               contentType: "application/json;charset=utf-8",
			               type: "post",
			               data: JSON.stringify(saveArr),
			               dataType: "json",
			               beforeSend: function (xhr) {
			               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			               },
			               async: false,
			               success: function (result) {
			                   $(".overlay").hide();
			                   
			                   console.log("저장 후 return 값 >> ", result);
			                   
			                   if(result.message > 0){
								   $(".overlay").hide();
								   
			                	   alert("정상적으로 처리되었습니다.");
			                	   
			                	   crtPrac.search();
			                   }
			                   
			                   
			               }
			           });

					
					
				}

			} catch (e) {
				console.error(e);
			}
		},
	};

	crtPrac.init();

});

// 원형 차트
var chart0 = function(data){

	$("#chart0").empty();

	console.log("차트 데이터 >> ", data);
	
	//문자로 넘어온 데이터 값 숫자로 변환해주기
	for(var i=0; i<data.length; i++){
	  data[i].CRT_CNT = Number(data[i].CRT_CNT)	
	}
	
	console.log("숫자로 변환한 차트 데이터 >> ", data);
	
	const options = {
		    container: document.getElementById('chart0'),
		    series: [
		        {
		            data: data,
		            type: 'pie',
		            calloutLabelKey: 'CRT_CD',
		            angleKey: 'CRT_CNT',    
		            sectorLabelKey: 'CRT_CNT',
				    tooltip : {renderer : tooltipRenderer},
// 				    calloutLabel: {
// 				    	offset: 10,
// 				    	fontWeight: 'bold',
// 		                formatter: ({ datum, sectorLabelKey = 'TOTAL' }) => {
// 		                    return datum.GB+"("+datum.WHS_MC_TP_CD+")";
// 		                },
// 		            },
// 				    sectorLabel: {
// 				    	fontWeight: 'bold',
// 		                formatter: ({ datum, sectorLabelKey = 'TOTAL' }) => {
// 		                    return (datum.TOTAL/total*100).toFixed(2)+"%";
// 		                },
// 		            },
		        },
		        
		    ],
		    
		    legend: {
		        enabled: true,
		    },
	}

	var chartObj = agCharts.AgChart.create(options);
}


//라인형 차트
var chart1 = function(data){

	$("#chart1").empty();

	//문자로 넘어온 데이터 값 숫자로 변환해주기
	for(var i=0; i<data.length; i++){
	  data[i].CRT_CNT = Number(data[i].CRT_CNT)	
	}
	
	const options = {
		    container: document.getElementById('chart1'),
		    series: [
		        {
		            data: data,
		            type: 'line',
		            xKey: "CRT_CD",
		            yKey: "CRT_CNT",
		            yName: "CRT_CNT"
		        },
		        
		    ],
		    
		    legend: {
		        enabled: true,
		    },
	}

	var chartObj = agCharts.AgChart.create(options);
}

function tooltipRenderer(params) {
	return {
		content: params.angleValue
		,title :params.datum.CRT_CD
	};
}

</script>


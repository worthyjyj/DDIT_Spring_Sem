<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 제이쿼리 파일 import -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>

<!-- front basic css 파일 import -->
<link rel="stylesheet" type="text/css" href="/resources/css/front.css" />
<!-- MESUtil JS 파일 import -->
<script type="text/javascript" src="/resources/js/mes_common.js"></script>

<!-- 리얼그리드 관련 파일 import -->
 <script type="text/javascript" src="/resources/realgrid/realgrid-lic.js"></script>
 <script type="text/javascript" src="/resources/realgrid/realgrid.2.7.2.min.js"></script>
 <link href="/resources/realgrid/realgrid-style.css" rel="stylesheet" />


<div class="contPage-head flrbox">
	<div class="titlebox fl">
		<h2 class="title itype1" >운반구 조회 및 등록</h2>
	</div>
	<div class="btnbox fr">
		<a href="javascript:void(0);" data-fc-auth="w" class="btn-ix" onclick="LINVEN017.save();"><span class="txt">저장</span></a>
		<a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="LINVEN017.search();"><span class="txt">조회</span></a>
	</div>
</div>

<div class="contPage-search searchSHWrap" id="div_form_LINVEN017">
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
							<select class="select1" id="fac_cd" name="fac_cd" style="width: 100%;"></select>
						</div>
					</td>
					<th><span class="label-dot">운반구</span></th>
					<td>
						<div style="width: calc(100% - 50px)">
							<input type="text" class="input1" id="crt_cd" name="crt_cd" style="width: 100%;"/>
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
		<div id="realgrid0" style="width: 100%; height: 100%;"></div>
	</div>
</div>

<script>
// 1. 전역변수 및 그리드 field, column 정의

var tabIdx = 0;
var tabClear = null;

var provider = [];
var gridView = [];
var fields = [];
var columns = [];
var layout = [];

var i = 0;
fields[i] = [
	  {fieldName:'CUD'                 }
	, {fieldName:'CRT_CD'              }
	, {fieldName:'CRT_NM'              }
	, {fieldName:'CRT_SSTS'            }
	, {fieldName:'CRT_DTM'   , dataType:"datetime", datetimeFormat:'yyyyMMddHHmmss'  } //String 타입으로 데이터 받아오고 화면에는 날짜 형식으로 출력하기 위해
];

columns[i] = [
	  {name:'CUD',                 fieldName:'CUD',                 type:'data', width:50, 	header:'CUD', 			editable:true, 	sortable:false, lookupDisplay: true, values:['','C','R','U','D'], labels:['','C','R','U','D'], editor: {type: "dropdown", dropDownCount: 5}	}
	, {name:'CRT_CD',              fieldName:'CRT_CD',              type:'data', width:100, header:'운반구', 		editable:true, 	sortable:true, 	button: 'action', buttonVisibility: 'always',
		styleCallback: styleCallback	}
	, {name:'CRT_NM',              fieldName:'CRT_NM',              type:'data', width:150, header:'운반구 이름', 			editable:true, 	sortable:true	}
	, {name:'CRT_SSTS',            fieldName:'CRT_SSTS',            type:'data', width:150, header:'운반구 상태', 			editable:true, 	sortable:true	}
	, {name:'CRT_DTM',             fieldName:'CRT_DTM',           type:'data', width:80, 	header:'운반 일시',	editable:true, 	sortable:true, 	lookupDisplay: true, datetimeFormat:'yyyy-MM-dd HH:mm:ss'	}
];

layout[i] = [
	  'CUD'
	, 'CRT_CD'
	, 'CRT_NM'
	, 'CRT_SSTS'
	, 'CRT_DTM'
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
			// 이런식으로 해서 데이터 넣고 조회 때리는 식으로 해야할 듯
			
			
			// 공장
// 			MES_UTIL.L_gfn_GetMasCdCombo( 'fac_cd' , 'C040' , 'BLANK' , 1 , LINVEN017.callback );

		}

		, callback : function(id) {
			switch (id) {
			}
		}

		, initDisp : function() {

		}

		, search : function() {
			var idx = 0;

			var url = "${pageContext.request.contextPath}/api/LINVEN017/LINVEN017_SEARCH0";
			if(PLT_CD == "JP" || PLT_CD == "HP"){
				url = "${pageContext.request.contextPath}/api/LINVEN017/LINVEN017_SEARCH1";
			}

			// 리스트 그리드
			$(".overlay").show();
			try {

				//조회부터 저장까지 해보고 혹시 탭 추가해서 하는거나 아니면 차트도 해보까..
				// 개발 공부 힘써야디.. 후
				this.searchCond = $( '#div_form_LINVEN017 ' ).serializeJson();
				HTGF.Api.get(url, this.searchCond).then( function(resData) {
					// grid 관련
					provider[idx].fillJsonData(resData.result,{fillMode: "set"} );

					//그리드 progressbar 숨기기
					$(".overlay").hide();

					// 시간 타이머
					FOOTER.setTimer(resData.timer);

				}).catch(function(e) {
				    if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
				})

			} catch (e) {
				console.error(e);
			} finally {
			}

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
					if (obj.CUD == "C" || obj.CUD == "U") {
						if (!MES_UTIL.isNull(obj.CRT_TAG_NO_1)) {
							if( PLT_CD == 'CP' || PLT_CD == 'IP' || PLT_CD == 'TP' ){
								if (obj.CRT_TAG_NO_1.length != 16){
									msg_alert('${menuId}' ,I18('#RF-ID는_16_자리여야_합니다!')  , '' ,I18('#확인') );
									return false;
								}
							}else{
								if (obj.CRT_TAG_NO_1.length != 10){
									msg_alert('${menuId}' ,I18('#RF-ID는_10_자리여야_합니다!')  , '' ,I18('#확인') );
									return false;
								}
							}
						}
						if (!MES_UTIL.isNull(obj.CRT_TAG_NO_2)) {
							if( PLT_CD == 'CP' || PLT_CD == 'IP' || PLT_CD == 'TP' ){
								if (obj.CRT_TAG_NO_2.length != 16){
									msg_alert('${menuId}' ,I18('#RF-ID는_16_자리여야_합니다!')  , '' ,I18('#확인') );
									return false;
								}
							}else{
								if (obj.CRT_TAG_NO_2.length != 10){
									msg_alert('${menuId}' ,I18('#RF-ID는_10_자리여야_합니다!')  , '' ,I18('#확인') );
									return false;
								}
							}
						}
					}
					saveArr.push(obj);
				}

				if(gridedit.length == 0){
					msg_alert('${menuId}' ,I18('#변경사항이_없습니다.')  , '' ,I18('#확인') );
				}else{

					// 필수체크
					// if (!MES_UTIL.gridKeyCheck(gridView[idx], provider[idx], gridedit, ["SPEC_CD"])) {
					// 	return false;
					// }
					$(".overlay").show();
					var url = '/api/LINVEN017/LINVEN017_SAVE';
					var sParam = {};
					HTGF.Api.post(url, saveArr, sParam).then( function(resData) {
						
						$(".overlay").hide();
						save_alert('${menuId}', I18('#데이터_처리에_성공했습니다.'), resData.resultCode, resData.resultMessage, I18('#확인'), 'LINVEN017.search()');
													
					}).catch(function(e) {
					    if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
					})

				}

			} catch (e) {
				console.error(e);
			}
		},
	};

	crtPrac.init();

});




</script>


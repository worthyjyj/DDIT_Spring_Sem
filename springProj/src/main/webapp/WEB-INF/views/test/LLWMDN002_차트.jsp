<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- //상단: title + btn -->
<!-- 상단: title + btn -->
<script src="/common/js/ag-chart/ag-charts-community-8.2.1.min.js"></script>
<div class="contPage-head flrbox">
	<div class="titlebox fl">
		<h2 class="title itype1" id="page_title"></h2>
		<a href="#" onclick="FOOTER.setFavor('${menuId}');" class="btn-favorite">favorite</a> <!-- 활성화 on 클래스 사용 -->
	</div>
	<div class="btnbox fr">
		<a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="LLWMDN002.excel();"><span class="ico-download"></span><span class="txt">${I18['#엑셀']}</span></a>
		<a data-fc-auth="m" href="#" class="btn-ix"><span class="ico-print"></span><span class="txt">${I18['#인쇄']}</span></a>
		<a data-fc-auth="d" href="#" class="btn-ix"><span class="ico-send"></span><span class="txt">${I18['#전송']}</span></a>
		<a data-fc-auth="w" href="#" onclick="LLWMDN002.save(); return false;" class="btn-ix type1"><span class="ico-save"></span><span class="txt">${I18['#저장']}</span></a>
		<a data-fc-auth="r" href="#" onclick="LLWMDN002.search(); return false;" class="btn-ix"><span class="ico-search1"></span><span class="txt">${I18['#조회']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="help_popup('${menuId}');"><span class="ico-help"></span><span class="txt">${I18['#도움말']}</span></a>
	</div>
</div>
<!-- //상단: title + btn -->
 
<div id="div_form_LLWMDN002" class="contPage-search searchSHWrap">
	
	<div class="border-box searchReq-box">
		<div class="searchReq-tablebox">
			<table>
				<colgroup>
					<col style="width: 6%;">
					<col style="width: 10%;">
					<col style="width: 6%;">
					<col style="width: 15%;">
					<col style="width: 6%;">
					<col style="width: 15%;">
					<col style="width: 6%;">
					<col style="width: 10%;">
				</colgroup>
				<tr>
					<th><span class="label-dot">${I18['#일자']}</span></th>
					<td>
						<div>
							<span style="width: calc(100% - 18px);">
							<input type="text" class="input1 monthpicker" id="wrkDate" name="wrkDate" readonly style="width: calc(100% - 10px);">
							</span>
						</div>
					</td>
					<th><span class="label-dot">${I18['#공장']}</span></th>
					<td>
						<div style="width: calc(100% - 18px);">
							<select id="fac_cd" name="fac_cd" class="select1" style="width: calc(100% - 10px);"></select>
						</div>
					</td>	
					<th><span class="label-dot">${I18['#창고타입']}</span></th>
					<td>
						<div style="width: calc(100% - 18px);">
							<select id="whsTpCd" name="whsTpCd" class="select1" style="width: calc(100% - 10px);" ></select>
						</div>
					</td>	
					<th><span class="label-dot">${I18['#창고']}</span></th>
					<td>
						<div style="width: calc(100% - 18px);">
							<select id="whsCd" name="whsCd" class="select1"style="width: calc(100% - 10px);"></select>
						</div>
					</td>
					</tr>
					<tr>
					<th><span class="label-dot">${I18['#설비타입']}</span></th>
					<td>
						<div style="width: calc(100% - 18px);">
							<select id="whsMcTpCd" name="whsMcTpCd" class="select1"style="width: calc(100% - 10px);"></select>
						</div>
					</td>	
					<th><span class="label-dot">${I18['#공정']}</span></th>
					<td>
						<div style="width: calc(100% - 18px);">
							<select id="whsProcCd" name="whsProcCd" class="select1"style="width: calc(100% - 10px);" ></select>
						</div>
					</td>	
					<th><span class="label-dot">${I18['#라인']}</span></th>
					<td>
						<div style="width: calc(100% - 18px);">
							<select id="whsLine" name="whsLine" class="select1"style="width: calc(100% - 10px);">
							</select>
						</div>
					</td>	
				</tr>
			</table>
		</div>
	</div>
	<%-- <div class="util-group">
		<div class="util-list">
			<a href="javascript: void(0);" class="btn-util-refresh" onclick="filter_refresh('${menuId}');">refresh</a>
			<a href="javascript: void(0);" class="btn-util-save" onclick="filter_save('${menuId}');">save</a>
			<a href="javascript: void(0);" class="btn-util-list" onclick="filter_list('${menuId}');">list</a>
		</div>
	</div> --%>
</div>

<!-- 검색조건 박스 -->
<div class="contPage-body">
	<div class="base-list table-list">
	   	<div id="realgrid0" style="width: 100%; height: 50%;"></div>
	   	<div id="chart0" style="width: 20%; height: 50%; float: left"></div>
	   	<div id="chart1" style="width: 80%; height: 50%; float: left; " ></div>
	</div>
</div>
<!-- //검색조건 박스 -->
<style>
.fv_cellDisableClr{
	background-color: #f0f0f0ff;
}
.cornsilk{
	background-color: cornsilk;
}
.yellow{
	background-color: #ffff33;
}

</style>

<script type="text/javascript">

var gridView = [];
var dataProvider = [];
var fields = [];
var columns = [];
var layout = [];
var pltCd =  '${USER_SESSION.extraData.pltCd}';
var userId = '${USER_SESSION.userId}';
var lang = '${lang}';

var comboValue = [];
var comboCode = [];
var i =0;
var total = 0;

fields[i] = [
	{fieldName :	'RANK'            		,dataType: "text"},
	{fieldName :	'GB'            		,dataType: "text"},
	{fieldName :	'WHS_MC_TP_CD'            		,dataType: "text"},
	{fieldName :	'WHS_PROC_CD'            		,dataType: "text"},
	{fieldName :	'TOTAL'           		,dataType: "number"},
	{fieldName :	'RATIO'           		,dataType: "number"},
	{fieldName :	'DATA1'	            	,dataType: "number"},
	{fieldName :	'DATA2'	            	,dataType: "number"},
	{fieldName :	'DATA3'	            	,dataType: "number"},
	{fieldName :	'DATA4'	            	,dataType: "number"},
	{fieldName :	'DATA5'	            	,dataType: "number"},
	{fieldName :	'DATA6'	            	,dataType: "number"},
	{fieldName :	'DATA7'	            	,dataType: "number"},
	{fieldName :	'DATA8'	            	,dataType: "number"},
	{fieldName :	'DATA9'	            	,dataType: "number"},
	{fieldName :	'DATA10'            	,dataType: "number"},
	{fieldName :	'DATA11'            	,dataType: "number"},
	{fieldName :	'DATA12'            	,dataType: "number"},
	{fieldName :	'DATA13'            	,dataType: "number"},
	{fieldName :	'DATA14'            	,dataType: "number"},
	{fieldName :	'DATA15'            	,dataType: "number"},
	{fieldName :	'DATA16'            	,dataType: "number"},
	{fieldName :	'DATA17'            	,dataType: "number"},
	{fieldName :	'DATA18'            	,dataType: "number"},
	{fieldName :	'DATA19'            	,dataType: "number"},
	{fieldName :	'DATA20'            	,dataType: "number"},
	{fieldName :	'DATA21'            	,dataType: "number"},
	{fieldName :	'DATA22'            	,dataType: "number"},
	{fieldName :	'DATA23'            	,dataType: "number"},
	{fieldName :	'DATA24'            	,dataType: "number"},
	{fieldName :	'DATA25'            	,dataType: "number"},
	{fieldName :	'DATA26'            	,dataType: "number"},
	{fieldName :	'DATA27'            	,dataType: "number"},
	{fieldName :	'DATA28'            	,dataType: "number"},
	{fieldName :	'DATA29'            	,dataType: "number"},
	{fieldName :	'DATA30'            	,dataType: "number"},
	{fieldName :	'DATA31'            	,dataType: "number"}
	
];

columns[i] = [
		  {name: 'RANK' 		,	fieldName:'RANK'    , 	  type:'data',   width:20,  header:{text:' '}, editable:false, sortable:true } 
	   	, {name: 'GB' 			,	fieldName:'GB'    , 	  type:'data',   width:60,  header:{text:I18('#라인')}, editable:false, sortable:true } 
	   	, {name: 'WHS_MC_TP_CD' ,	fieldName:'WHS_MC_TP_CD', type:'data',   width:60,  header:{text:I18('#설비')}, editable:false, sortable:true } 
	   	, {name: 'WHS_PROC_CD' 	,	fieldName:'WHS_PROC_CD',  type:'data',   width:60,  header:{text:I18('#공정')}, editable:false, sortable:true,	lookupDisplay: true, editor: {type: 'dropdown', dropDownCount: 5, textReadOnly: 'true'},	styleName: 'text-align-center'	}
	   	, {name: 'TOTAL' 		,	fieldName:'TOTAL' ,		  type:'number', width:80, header:{text:I18('#총_에러_건수')}, editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right' } 
	   	, {name: 'RATIO' 		,	fieldName:'RATIO' ,		  type:'number', width:80, header:{text:I18('#점유율(%)')}, editable:false, sortable:true,	numberFormat: '#,##0.##;c',	styleName: 'text-align-right'}
	   	, {name:'DATA1'			,   fieldName:'DATA1' ,       type:'number', width:40,  header:{text:'01'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'  }
		, {name:'DATA2'			,   fieldName:'DATA2' ,       type:'number', width:40,  header:{text:'02'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA3'			,   fieldName:'DATA3' ,       type:'number', width:40,  header:{text:'03'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA4'			,   fieldName:'DATA4' ,       type:'number', width:40,  header:{text:'04'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA5'			,   fieldName:'DATA5' ,       type:'number', width:40,  header:{text:'05'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA6'			,   fieldName:'DATA6' ,       type:'number', width:40,  header:{text:'06'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA7'			,   fieldName:'DATA7' ,       type:'number', width:40,  header:{text:'07'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA8'			,   fieldName:'DATA8' ,       type:'number', width:40,  header:{text:'08'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA9'			,   fieldName:'DATA9' ,       type:'number', width:40,  header:{text:'09'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA10'		,   fieldName:'DATA10',       type:'number', width:40,  header:{text:'10'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA11'		,   fieldName:'DATA11',       type:'number', width:40,  header:{text:'11'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA12'		,   fieldName:'DATA12',       type:'number', width:40,  header:{text:'12'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA13'		,   fieldName:'DATA13',       type:'number', width:40,  header:{text:'13'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA14'		,   fieldName:'DATA14',       type:'number', width:40,  header:{text:'14'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA15'		,   fieldName:'DATA15',       type:'number', width:40,  header:{text:'15'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA16'		,   fieldName:'DATA16',       type:'number', width:40,  header:{text:'16'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA17'		,   fieldName:'DATA17',       type:'number', width:40,  header:{text:'17'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA18'		,   fieldName:'DATA18',       type:'number', width:40,  header:{text:'18'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA19'		,   fieldName:'DATA19',       type:'number', width:40,  header:{text:'19'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA20'		,   fieldName:'DATA20',       type:'number', width:40,  header:{text:'20'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA21'		,   fieldName:'DATA21',       type:'number', width:40,  header:{text:'21'},        editable:false, sortable:true,	numberFormat: '#,##0',  styleName: 'text-align-right'}
		, {name:'DATA22'		,   fieldName:'DATA22',       type:'number', width:40,  header:{text:'22'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA23'		,   fieldName:'DATA23',       type:'number', width:40,  header:{text:'23'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA24'		,   fieldName:'DATA24',       type:'number', width:40,  header:{text:'24'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA25'		,   fieldName:'DATA25',       type:'number', width:40,  header:{text:'25'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA26'		,   fieldName:'DATA26',       type:'number', width:40,  header:{text:'26'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA27'		,   fieldName:'DATA27',       type:'number', width:40,  header:{text:'27'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA28'		,   fieldName:'DATA28',       type:'number', width:40,  header:{text:'28'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA29'		,   fieldName:'DATA29',       type:'number', width:40,  header:{text:'29'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA30'		,   fieldName:'DATA30',       type:'number', width:40,  header:{text:'30'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
		, {name:'DATA31'		,   fieldName:'DATA31',       type:'number', width:40,  header:{text:'31'},        editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-right'}
];


layout[i] = [
		  'RANK'
	   	, 'WHS_MC_TP_CD'
	   	, 'WHS_PROC_CD'
	   	, 'GB'  
	  	, 'TOTAL'
	  	, 'RATIO'
	  	, 'DATA1'	                    
		, 'DATA2'	                    
		, 'DATA3'	                    
		, 'DATA4'	                    
		, 'DATA5'	                    
		, 'DATA6'	                    
		, 'DATA7'	                    
		, 'DATA8'	                    
		, 'DATA9'	                    
		, 'DATA10'                    
		, 'DATA11'                    
		, 'DATA12'                    
		, 'DATA13'                    
		, 'DATA14'                    
		, 'DATA15'                    
		, 'DATA16'                    
		, 'DATA17'                    
		, 'DATA18'                    
		, 'DATA19'                    
		, 'DATA20'                    
		, 'DATA21'                    
		, 'DATA22'                    
		, 'DATA23'                    
		, 'DATA24'                    
		, 'DATA25'                    
		, 'DATA26'                    
		, 'DATA27'                    
		, 'DATA28'                    
		, 'DATA29'                    
		, 'DATA30'                    
		, 'DATA31'       
     
];


$(document).ready( function(){

	
	
	LLWMDN002 = {
		init: function() {
			this.initGrid();
			this.initCombo();
			this.initDisp();
			this.initEvent();
// 			LLWMDN002.search(true);
		}
		, initGrid: function() {
			
			for (var idx = 0; idx < 1; idx++) {
				dataProvider[idx] = new RealGrid.LocalDataProvider(false);
				dataProvider[idx].setFields(fields[idx]);
				gridView[idx] = new RealGrid.GridView('realgrid' + idx);
				gridView[idx].setDataSource(dataProvider[idx]);
				setDefaultGrid(gridView[idx]);
				gridView[idx].headerSummaries.visible = false;
				gridView[idx].setRowIndicator({visible:false});
				gridView[idx].setStateBar({visible:false});
				gridView[idx].setCheckBar({visible:false});
				gridView[idx].setFooters({visible:false});
				gridView[idx].displayOptions.columnMovable = false;
				gridView[idx].displayOptions.selectionStyle = 'rows';
				gridView[idx].onCellDblClicked = this.onCellDblClicked;
				gridView[idx].onCopy = this.onCopy;
				gridView[idx].displayOptions.fitStyle = 'fill'; 
				gridView[idx].setColumns(columns[idx]);
				gridView[idx].setEditOptions({ insertable: true, deletable: true, editWhenFocused: true, commitWhenLeave: true, commitByCell : true });
				gridView[idx].setOptions({hideDeletedRows: true, softDeleting: true});
				gridView[idx].displayOptions.selectionStyle = 'single';
				gridView[idx].sortingOptions.enabled = false;
				gridView[idx].sortMode = "explicit";
				gridView[idx].onContextMenuPopup = onContextMenuPopup;					//출력할 메뉴 설정
				gridView[idx].onContextMenuItemClicked = onContextMenuItemClicked;		//메뉴 클릭시
				gridView[idx].setColumnLayout(layout[idx]);
				gridView[idx].setRowStyleCallback(function(grid, item, fixed) {
				    var ret = {};
				    var color = grid.getValue(item.index, "RANK");

				    if (color == 'TOTAL') {
				      return 'color-yellow'
				    }
				});
				gridView[idx].layoutByColumn("RANK").spanCallback = function (grid, layout, itemIndex) {
				    var value = grid.getValue(itemIndex, "RANK");
				    if(value == "TOTAL"){
				        return 4; //가로 병합 수
				    }
				    
				    return 1;
				};


			}

		}
		, initDisp: function() {

			try {
				
			} catch (e) {
				console.error(e);
			} finally {
			} 


		}
		, initEvent: function() {

			$("#fac_cd").on("change", function(){
				// 콤보 창고타입
				LLWMDN002.whsTpCdSearch();
			});

			$("#whsTpCd").on("change", function(){
				// 콤보 창고
				LLWMDN002.codeSearch();
			});

			$("#whsCd").on("change", function(){
				//설비타입 콤보
				LLWMDN002.whsMcTpCdSearch();
			}); 

			$("#whsMcTpCd").on("change",function(){
				//공정 콤보
				LLWMDN002.whsProcCdSearch();
			});

			$("#whsProcCd").on("change",function(){
				//콤보 라인
				LLWMDN002.lineSearch();
			});
			
			$("#whsLine").on("change",function(){
				//콤보 라인
				LLWMDN002.search();
			});

		}
		, initCombo: function() {
			var today = MES_UTIL.gfn_Today();
			today = today.substring(0, 4) + "-" + today.substring(4, 6);			
			$("#wrkDate").val(today);

			//콤보 공장
			MES_UTIL.L_gfn_GetMasCdCombo("fac_cd", "C040", "", 0, LLWMDN002.callback);
			

		}
		, callback: function( strSvcID  ){
			switch ( strSvcID )
			{

			}
		}       

		 	 	
		, search: function(combo) {
			//그리드 데이터 초기화 처리 .
			dataProvider[0].clearRows();
			$(".overlay").show();
			try {
				var searchCond = {
						"PLT_CD": pltCd,
						"DATE_DT": $("#wrkDate").val().replace(/\-/g, ""),
						"FAC_CD": $("#fac_cd").val(),
						"WHS_TP_CD": $("#whsTpCd").val(),
						"WHS_LINE" :$("#whsLine").val(),
						"WHS_MC_TP_CD" : $("#whsMcTpCd").val(),
						"WHS_PROC_CD"	: $("#whsProcCd").val(),
						"WHS_CD"	: $("#whsCd").val()
					}

				var uri = "/api/LLWMDN002/search";
				

				HTGF.Api.get(uri, searchCond).then( function(resData) {
					$(".overlay").hide();

					
					var lastArray = {};

					if(resData.result.length < 1){
						
						chart([]);	// 차트1
						chart2([]);	// 차트2
						return;
					}
					
					for(let i = 0; i < resData.result.length; i++){
						var object = Object.keys(resData.result[i]);
						if(resData.result[i]["GB"]==undefined){
							resData.result[i]["GB"] = "0";
						}
						for(let k = 0; k<object.length; k++){
							if(object[k] != "GB" && object[k] != "WHS_PROC_CD" && object[k] != "WHS_MC_TP_CD"){
								if(lastArray[object[k]] == undefined){
									lastArray[object[k]] = 0;
								}
									lastArray[object[k]] =  (Number(resData.result[i][object[k]]) +Number(lastArray[object[k]]));

							

							}else{
								lastArray['RANK'] = "TOTAL";
							}
						}
					}
					
						lastArray.RATIO = lastArray.RATIO.toFixed(1);
						total = lastArray["TOTAL"]; 
// 						console.log("resData.result >> ", resData.result);
						chart(resData.result);	// 차트1
						chart2(resData.result);	// 차트2
						resData.result.push(lastArray);	// 맨 밑 row 추가
						dataProvider[0].fillJsonData(resData.result,{fillMode: "set"} );

// 					console.log("lastArray >> ",lastArray);
					
					FOOTER.setTimer(resData.timer);

					
				}).catch(function(e) {
				       $(".overlay").hide();
					   if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
				});
			} catch (e) {
				console.error(e);
			} finally {
			} 
		}
		, whsTpCdSearch: function() {
			var option = "";
			$("#whsTpCd").empty();
			try {

				var searchCond = { "PLT_CD" : pltCd
								  ,"FAC_CD" : $("#fac_cd").val()}


				var uri = "/api/LLWMDN001/COMBO_WHS_TP";
				

				HTGF.Api.get(uri, searchCond).then( function(resData) {
					for(let i = 0; i< resData.result.length; i++){
						if( i == 0){	
// 							option += "<option value=></option>"
							option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
						}else{
						    option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
			               
						}
						 $('#whsTpCd').html(option);
					}
					
					$("#whsTpCd").trigger('change'); 
				}).catch(function(e) {
					   if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
				});
			} catch (e) {
				console.error(e);
			} finally {
			} 
			
		}
		// 창고 콤보추가
		, codeSearch: function() {

			var option = "";
			$("#whsCd").empty();
			try {

				var searchCond = { "PLT_CD" : pltCd
								  ,"whs_tp" : $("#whsTpCd").val()}

				var uri = "/api/LLWMDN001/COMBO_WHS";
				

				HTGF.Api.get(uri, searchCond).then( function(resData) {
					for(let i = 0; i< resData.result.length; i++){
						if( i == 0){	
// 							option += "<option value=></option>"
							option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
						}else{
						    option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
			               
						}
						 $('#whsCd').html(option);
					}
					$("#whsCd").trigger('change'); 
				}).catch(function(e) {
					   if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
				});
			} catch (e) {
				console.error(e);
			} finally {
			} 
		}
		, whsMcTpCdSearch: function() {
			var option = '<option value="">&nbsp;</option>';
			$("#whsMcTpCd").empty();
			try {

				var whs_cd = $("#whsCd").val();

				var searchCond = { "PLT_CD" : pltCd
								  ,"whs_cd" : whs_cd}

				var uri = "/api/LLWMDN001/COMBO_WHS_MC_TP";
				

				HTGF.Api.get(uri, searchCond).then( function(resData) {
					for(let i = 0; i< resData.result.length; i++){
						if( i == 0){	
							option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
						}else{
						    option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
			               
						}
						 $('#whsMcTpCd').html(option);
					}

					$("#whsMcTpCd").trigger('change'); 
				}).catch(function(e) {
					   if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
				});
			} catch (e) {
				console.error(e);
			} finally {
			} 
			
		}
		//공정 콤보
		, whsProcCdSearch: function() {
			var option = '<option value="">&nbsp;</option>';
			$("#whsProcCd").empty();
			try {

				var whs_cd = $("#whsCd").val();
				var whs_mc_tp_cd = $("#whsMcTpCd").val();

				var searchCond = { "PLT_CD" : pltCd
								  ,"whs_cd" : whs_cd
								  ,"whs_mc_tp_cd" : whs_mc_tp_cd }

				var uri = "/api/LLWMDN001/COMBO_PROC";
				

				HTGF.Api.get(uri, searchCond).then( function(resData) {
					for(let i = 0; i< resData.result.length; i++){
						if( i == 0){	
							option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
						}else{
						    option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
			               
						}
						 $('#whsProcCd').html(option);
					}

					$("#whsProcCd").trigger('change'); 
				}).catch(function(e) {
					   if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
				});
			} catch (e) {
				console.error(e);
			} finally {
			} 
			
		}
		// 라인 콤보추가
		, lineSearch : function () {
			var option = '<option value="">&nbsp;</option>';
			$("#whsLine").empty();
			try {
				var whs_cd = $("#whsCd").val();
				var whs_mc_tp_cd = $("#whsMcTpCd").val();
				var whs_proc = $("#whsProcCd").val();

				var searchCond = { "PLT_CD" : pltCd
								  ,"whs_cd" : whs_cd
								  ,"whs_mc_tp_cd" : whs_mc_tp_cd
								  ,"whs_proc" : whs_proc  }

				var uri = "/api/LLWMDN001/COMBO_LINE";
				

				HTGF.Api.get(uri, searchCond).then( function(resData) {
					for(let i = 0; i< resData.result.length; i++){
						if( i == 0){	
							option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
						}else{
						    option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
			               
						}
						 $('#whsLine').html(option);
					}
					
					$("#whsLine").trigger('change'); 

				}).catch(function(e) {
					   if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
				});
			} catch (e) {
				console.error(e);
			} finally {
			} 
		}

		, save: function() {

		}

		,excel : function(){
			var arrGrid = [];
			arrGrid.push(gridView[0]);
			excel_down(arrGrid, "${menuId}");
		}

	};

	LLWMDN002.init();

});


var chart = function(data){

	$("#chart0").empty();

	const options = {
		    container: document.getElementById('chart0'),
		    series: [
		        {
		            data: data,
		            type: 'pie',
		            calloutLabelKey: 'GB',
		            angleKey: 'TOTAL',    
		            sectorLabelKey: 'TOTAL',
				    tooltip : {renderer : tooltipRenderer},
				    calloutLabel: {
				    	offset: 10,
				    	fontWeight: 'bold',
		                formatter: ({ datum, sectorLabelKey = 'TOTAL' }) => {
		                    return datum.GB+"("+datum.WHS_MC_TP_CD+")";
		                },
		            },
				    sectorLabel: {
				    	fontWeight: 'bold',
		                formatter: ({ datum, sectorLabelKey = 'TOTAL' }) => {
		                    return (datum.TOTAL/total*100).toFixed(2)+"%";
		                },
		            },
		        },
		        
		    ],
		    
		    legend: {
		        enabled: false,
		    },
	}

	var chartObj = agCharts.AgChart.create(options);
}

var chart2 = function(data){
	var chartArray = [];
	var series = [];
	for(let i = 0; i < data.length; i++){
		var object =  Object.keys(data[i]);
		var arrayList = [];

		for(let k = 0; k< object.length ; k ++){
			if(object[k].substring(0, 4) =="DATA" ){
				arrayList[arrayList.length] = {'date' :object[k].substring(4, 6) , "val" : data[i][object[k]] };
			}
		}

		// 배열정렬
		arrayList.sort(function (a, b) {
			  if (Number(a.date) > Number(b.date)) {
			    return 1;
			  }
			  if (Number(a.date) < Number(b.date)) {
			    return -1;
			  }
			  return 0;
		});
		/* arrayList.sort((a, b) => a.date - b.date); */
		
		chartArray[i] = arrayList;
		series[i] = {data : chartArray[i], type: 'line',xKey: 'date',yKey: 'val' , yName :data[i]["GB"]+"("+data[i]["WHS_MC_TP_CD"]+")"
				,label: {
					formatter: ({ value }) => value.toFixed(0),
				}

		};

	}
	$("#chart1").empty();

	const options = {
		    container: document.getElementById('chart1'),
		    autoSize: true,
		    series: series,
		    axes: [
				{
					type: 'number',
					position: 'left',
				},
				{
					type: 'category',
					position: 'bottom',
					label: {
						formatter: ({ value }) => value+I18('#일'),
		            },
					
				},
			],
			legend: {
				
				position: 'right',
				item: {
					marker: {
						shape: 'square',
						strokeWidth: 0,
					},
				},
			},
	}
	var chartObj = agCharts.AgChart.create(options);
}
function tooltipRenderer(params) {
	return {
		content: (params.angleValue/total*100).toFixed(2)+"%",
		title :params.datum.GB+"("+params.datum.WHS_MC_TP_CD+")"
	};
}


</script>
				
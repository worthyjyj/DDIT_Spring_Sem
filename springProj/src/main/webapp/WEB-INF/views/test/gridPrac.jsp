<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 필요한 파일 import 시작 -->
<!-- 제이쿼리 파일 import -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/js/crownix-viewer.min.js"></script>
<script type="text/javascript" src="/resources/js/crownix-viewer.storage.min.js"></script>
<!-- JSON JS 파일 import -->
<script type="text/javascript" src="/resources/js/jquery.serializejson.js"></script>
<!-- front basic css 파일 import -->
<link rel="stylesheet" type="text/css" href="/resources/css/front.css" />
<!-- MESUtil JS 파일 import -->
<script type="text/javascript" src="/resources/js/mes_common.js"></script>
<!-- 리얼그리드 관련 파일 import -->
 <script type="text/javascript" src="/resources/realgrid/realgrid-lic.js"></script>
 <script type="text/javascript" src="/resources/realgrid/realgrid.2.7.2.min.js"></script>
 <link href="/resources/realgrid/realgrid-style.css" rel="stylesheet" />
<!-- 필요한 파일 import 끝 -->

<div class="contPage-search searchSHWrap">
	<div id="div_form_LRELDZ827" class="border-box searchReq-box">
		<div class="searchReq-tablebox">
			<table>
				<colgroup>
					<col style="width: 5%;">
					<col style="width: 12%;">
					<col style="width: 5%;">
					<col style="width: 12%;">
					<col style="width: 20%;">
					<col />
				</colgroup>
				<tr>
					<th><span class="label-dot">공장</span></th>
					<td>
						<div style="width: calc(100% - 18px);">
							<select  id="facCd" name="facCd"  class="select1" style="width: calc(100% - 10px);" onchange="LRELDZ827.search();">
							</select>
						</div>
					</td>
					<th><span class="label-dot">일자</span></th>
					<td>
						<div>
							<span style="width: calc(100% - 18px);">
								<input type="date" id="schParam3"/>
							</span>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>

<div class="contPage-body">
	<div class="base-list table-list">
		<div id="realgrid0" style="width: 100%; height: 500px;"></div>
	</div>
</div>


<style>
	.multi-line-css {
		white-space: pre;
	}

	.font_style {
		text-decoration:line-through;
	}

	.back-color-yellow {
		background-color: yellow;
	}

	.top-text {
		vertical-align: top;
	}

	.top-text>div {
		margin-top: 2px;
	}
	
</style>

<script type="text/javascript">
var provider = [];
var gridView = [];
var fields = [];
var columns = [];
var layout = [];


/* 변수 선언 */
// var vPltCd = '${USER_SESSION.extraData.pltCd}';
// var LANG = '${lang}';
// var gStartDt = "";
// var gToday = MES_UTIL.gfn_Today();
// var initFlag = false;


fields[0] = [
	{fieldName:'MC_CD'                   }
	, {fieldName:'SPEC_CD'     }
	, {fieldName:'BLDG_PLN_SEQ'     , dataType:"number"           }
	, {fieldName:'BLDG_PLN_QTY'     , dataType:"number"           }
	, {fieldName:'BLDG_PRDT_QTY'    , dataType:"number"           }
	, {fieldName:'NEXT_BLDG_PLN_SEQ'    , dataType:"number"       }
	, {fieldName:'NEXT_BLDG_PLN_QTY'    , dataType:"number"       }
	, {fieldName:'NEXT_BLDG_PRDT_QTY'    , dataType:"number"      }
	, {fieldName:'SW'   }
];

columns[0] = [
	  {name:'MC_CD',             		  fieldName:'MC_CD',             type:'data', width:80,  header:'설비',	 editable:false, sortable:true, mergeRule:{criteria: "value"}, styleName: "mid-text"	}
	, {name:'SPEC_CD',                    fieldName:'SPEC_CD',           type:'data', width:250,  header:'규격', editable:false, sortable:true	}
	, {name:'BLDG_PLN_SEQ',               fieldName:'BLDG_PLN_SEQ',               numberFormat: "#,##0" , type:'data', width:80,	editable:false, sortable:true,	styleName: "text-align-right"	}
	, {name:'BLDG_PLN_QTY',               fieldName:'BLDG_PLN_QTY',               numberFormat: "#,##0" , type:'data', width:80, editable:false, sortable:true,	styleName: "text-align-right"	}
	, {name:'BLDG_PRDT_QTY',               fieldName:'BLDG_PRDT_QTY',             numberFormat: "#,##0" , type:'data', width:80,  	editable:false, sortable:true,	styleName: "text-align-right"	}
	, {name:'NEXT_BLDG_PLN_SEQ',               fieldName:'NEXT_BLDG_PLN_SEQ',      numberFormat: "#,##0" ,         type:'data', width:80,  	editable:false, sortable:true,	styleName: "text-align-right"	}
	, {name:'NEXT_BLDG_PLN_QTY',               fieldName:'NEXT_BLDG_PLN_QTY',      numberFormat: "#,##0" ,         type:'data', width:80,  	editable:false, sortable:true,	styleName: "text-align-right"	}
	, {name:'NEXT_BLDG_PRDT_QTY',               fieldName:'NEXT_BLDG_PRDT_QTY',    numberFormat: "#,##0" ,         type:'data', width:80,  	editable:false, sortable:true,	styleName: "text-align-right"	}
	, {name:'SW',               fieldName:'SW',               type:'data', width:80,  header:{text:'S/W'},	editable:false, sortable:true }
		
];

layout[0] = [
	'MC_CD'
	,'SPEC_CD'
	, {name: "DATA1_grp",	direction: "horizontal", header: '낮', items:[
	   	{name: "DATA1_A",	direction: "horizontal", hideChildHeaders:true, header: '계획',	items:['BLDG_PLN_SEQ', 'BLDG_PLN_QTY']}
		,{name: "DATA1_B",	direction: "horizontal", hideChildHeaders:true, header: '실적',	items:['BLDG_PRDT_QTY']}
	  ]}
	, {name: "DATA2_grp",	direction: "horizontal", header: '밤', items:[
		{name: "DATA2_A",	direction: "horizontal", hideChildHeaders:true, header: '계획',	items:['NEXT_BLDG_PLN_SEQ', 'NEXT_BLDG_PLN_QTY']}
		,{name: "DATA2_B",	direction: "horizontal", hideChildHeaders:true, header: '실적',	items:['NEXT_BLDG_PRDT_QTY']}
	  ]}
	,'SW'
];


$(function() {
	
	LRELDZ827 = {
		init : function() {

			this.initGrid();
			this.initEvent();
			this.initCombo();
			this.initDisp();
			this.search();
		}
		
		, initGrid : function() {
			for (var idx = 0; idx < 1; idx++) {
				provider[idx] = new RealGrid.LocalDataProvider(false);
				provider[idx].setFields(fields[idx]);
				gridView[idx] = new RealGrid.GridView('realgrid' + idx);
				gridView[idx].setDataSource(provider[idx]);
				gridView[idx].setRowIndicator({visible: true});
// 				setDefaultGrid(gridView[idx]);
				gridView[idx].setStateBar({visible : false});
				gridView[idx].setCheckBar({visible : false});
				gridView[idx].setHeader({visible : true});
				gridView[idx].headerSummaries.visible = false;
				gridView[idx].setFooters({visible : false});
				gridView[idx].displayOptions.columnMovable = false;
				gridView[idx].displayOptions.selectionStyle = 'rows';
				gridView[idx].displayOptions.fitStyle = 'fill';
				gridView[idx].setColumns(columns[idx]);
				gridView[idx].setColumnLayout(layout[idx]);
				gridView[idx].onCopy = this.onCopy;
				gridView[idx].setEditOptions({ insertable: true, deletable: true, editWhenFocused: true, commitWhenLeave: true, commitByCell : true });
				gridView[idx].setOptions({hideDeletedRows : true, softDeleting : true});
				gridView[idx].sortMode = "explicit";
// 				gridView[idx].onContextMenuPopup = onContextMenuPopup;					//출력할 메뉴 설정
// 				gridView[idx].onContextMenuItemClicked = onContextMenuItemClicked;		//메뉴 클릭시
				gridView[idx].onCellDblClicked = this.onCellDblClicked;
				gridView[idx].onCellButtonClicked = this.onCellButtonClicked;
				
			}

		}

		, onCellDblClicked : function(grid, clickData) {
			var rowData = grid.getValues(clickData.itemIndex);

			if (clickData.fieldName == 'BLDG_SPEC_CD') {
				var arg = {
					bldg_spec_cd : rowData.BLDG_SPEC_CD
					,fac_cd : $("#fac_cd").val()
					,mc_cd : rowData.BLDG_MC_CD
				};

				var url = '/LRELDZ827/LRELDZ827_P1.html';

				var name = 'LRELDZ827_P1';
				var width = 1200;
				var height = 500;
				popup_open(url, arg, name, width, height);
			}
		}

		, onCellItemClicked : function (grid, index, clickData) {

		}

		// ctrl c
		, onCopy : function(grid, selection, event) {
			MES_UTIL.copyToClipboard(grid);
			return false;
		}

		, onCellClicked : function(grid, clickData) {
		}

		, initEvent : function() {

		}
		
		, initCombo : function() {
			// 공장
// 			MES_UTIL.L_gfn_GetMasCdCombo( 'facCd' ,'C040' , '' , 1  , LRELDZ827.callback );

// 			MES_UTIL.L_gfn_GetCalHanta('dateFromTo','startDate','endDate', 'dateperiod','${menuId}', LRELDZ827.callback);
		}

		, callback : function(svcID, data) {
			switch (svcID) {
				case "facCd":
					LRELDZ827.search();
					break;
			}
		}
		
		, initDisp : function() {

		}

		, fnFindSpec : function(val) {
			// 규격
			var procCd = val;

			var arg = {
				PROC_CD: procCd
			};

			MES_UTIL.L_gfn_GetCustomCombo2('LRELDZ827', 'LRELDZ827_FIND_SPEC', arg, 'spec1', '', 0, LRELDZ827.callback);
		}


// 		, search : function() {
// 			 try {
// 			        var vURL = 'LRELDZ827_SEARCH';
// 			        $(".overlay").show();

// 			        var facCd = MES_UTIL.gfn_TransNullToEmpty($("#facCd").val());

// 			        this.searchCond = $('#div_form_LRELDZ827').serializeJson();
// 			        this.searchCond.startDate = MES_UTIL.gfn_TransNullToEmpty($('#startDate').val().replace(/\-/g, ""));

// // 			        console.log("searchCond >> ", this.searchCond);

// 			        HTGF.Api.get('/api/LRELDZ827/' + vURL, this.searchCond).then(function(resData) {
// 			            if (!MES_UTIL.gfn_IsNull(resData.result)) {
// 			                let json_data = [];
// 			                let BLDG_MC_CD = "";
// 			                let temp = 0;

// 			                for (let i = 0; i <= resData.result.length; i++) {
// 			                    // Sub Total 계산 (마지막행이거나 설비값이 달라질 경우)
// 			                    if (i === resData.result.length || BLDG_MC_CD !== resData.result[i].BLDG_MC_CD) {
// 			                    	 json_data.push({ BLDG_MC_CD: BLDG_MC_CD, BLDG_SPEC_CD: 'Sub Total'
// 		                                    , BLDG_PLN_SEQ: LRELDZ827.getResult(resData.result, "BLDG_PLN_SEQ"  , temp , i )
// 		                                    , BLDG_PLN_QTY: LRELDZ827.getResult(resData.result, "BLDG_PLN_QTY"  , temp , i ) 
// 		                                    , BLDG_PRDT_QTY: LRELDZ827.getResult(resData.result, "BLDG_PRDT_QTY"  , temp , i ) 
// 		                                    , NEXT_BLDG_PLN_SEQ: LRELDZ827.getResult(resData.result, "NEXT_BLDG_PLN_SEQ"  , temp , i )
// 		                                    , NEXT_BLDG_PLN_QTY: LRELDZ827.getResult(resData.result, "NEXT_BLDG_PLN_QTY"  , temp , i ) 
// 		                                    , NEXT_BLDG_PRDT_QTY: LRELDZ827.getResult(resData.result, "NEXT_BLDG_PRDT_QTY"  , temp , i ) 
// 		                                    , NNT_BLDG_PLN_SEQ: LRELDZ827.getResult(resData.result, "NNT_BLDG_PLN_SEQ"  , temp , i )
// 		                                    , NNT_BLDG_PLN_QTY: LRELDZ827.getResult(resData.result, "NNT_BLDG_PLN_QTY"  , temp , i ) 
// 		                                    , NNT_BLDG_PRDT_QTY: LRELDZ827.getResult(resData.result, "NNT_BLDG_PRDT_QTY"  , temp , i ) 
// 		                                    , SW_CNT:  LRELDZ827.getResult(resData.result, "SW_CNT"  , temp , i )
// 		                                    , L11_CNT: LRELDZ827.getResult(resData.result, "L11_CNT" , temp , i )
// 		                                    , CC1_CNT: LRELDZ827.getResult(resData.result, "CC1_CNT" , temp , i )
// 		                                    , CC2_CNT: LRELDZ827.getResult(resData.result, "CC2_CNT" , temp , i )
// 		                                    , CC3_CNT: LRELDZ827.getResult(resData.result, "CC3_CNT" , temp , i )
// 		                                    , BT1_CNT: LRELDZ827.getResult(resData.result, "BT1_CNT" , temp , i )
// 		                                    , BT2_CNT: LRELDZ827.getResult(resData.result, "BT2_CNT" , temp , i )
// 		                                    , TD_CNT:  LRELDZ827.getResult(resData.result, "TD_CNT"  , temp , i ) 
// 		                                    , BD1_CNT: LRELDZ827.getResult(resData.result, "BD1_CNT" , temp , i )
// 		                                    });
			                        
// 			                        if (i < resData.result.length) {
// 			                            BLDG_MC_CD = resData.result[i].BLDG_MC_CD;
// 			                            temp = i;
// 			                        }
// 			                    }

// 								//설비값이 같은 행은 json_data 바로 들어가게 하기 
// 			                    if (i < resData.result.length) {
// 			                        json_data.push(resData.result[i]);
// 			                    }
// 			                }

// // 			                console.log(json_data);

// 							//배열의 첫번째 값 삭제
// 			                json_data.shift();

// 							//subTotal 색깔넣기
// 			                gridView[0].setRowStyleCallback(function(grid, item, fixed) {
// 							    var ret = {};
// 							    var color = grid.getValue(item.index, "BLDG_SPEC_CD");

// 							    if (color == 'Sub Total') {
// 							      return 'color-yellow'
// 							    }
// 							});
							
// 			                provider[0].fillJsonData(json_data, { fillMode: "set" });

// 			                // Set timer
// 			                FOOTER.setTimer(resData.timer);
// 			            }
// 			            $(".overlay").hide();
// 			        }).catch(function(e) {
// 			            $(".overlay").hide();
// 			            if (e.status !== 400) {
// 			                msg_alert('${menuId}', 'Server Error' + e, '', I18('#확인'));
// 			            }
// 			        });
// 			    } catch (e) {
// 			        $(".overlay").hide();
// 			        console.error(e);
// 			    }
// 		}
		, search : function() {
			
			 let json_data = [
				 {
					 MC_CD : "A001"
					 ,SPEC_CD : "a"
					 ,BLDG_PLN_SEQ : 1
					 ,BLDG_PLN_QTY : 1
 					 ,BLDG_PRDT_QTY : 1
					 ,NEXT_BLDG_PLN_SEQ : 1
					 ,NEXT_BLDG_PLN_QTY : 1
					 ,NEXT_BLDG_PRDT_QTY : 1
					 ,SW : "0/1"
				 }
				 ,
				 {
					 MC_CD : "A001"
					 ,SPEC_CD : "b"
					 ,BLDG_PLN_SEQ : 1
					 ,BLDG_PLN_QTY : 1
 					 ,BLDG_PRDT_QTY : 1
					 ,NEXT_BLDG_PLN_SEQ : 1
					 ,NEXT_BLDG_PLN_QTY : 1
					 ,NEXT_BLDG_PRDT_QTY : 1
					 ,SW : "2/0"
				 }
				 ,
				 {
					 MC_CD : "A001"
					 ,SPEC_CD : "c"
					 ,BLDG_PLN_SEQ : 1
					 ,BLDG_PLN_QTY : 3
 					 ,BLDG_PRDT_QTY : 1
					 ,NEXT_BLDG_PLN_SEQ : 1
					 ,NEXT_BLDG_PLN_QTY : 1
					 ,NEXT_BLDG_PRDT_QTY : 1
					 ,SW : "0/0"
				 }
				 ,
				 {
					 MC_CD : "A002"
					 ,SPEC_CD : "b"
					 ,BLDG_PLN_SEQ : 22
					 ,BLDG_PLN_QTY : 0
 					 ,BLDG_PRDT_QTY : 1
					 ,NEXT_BLDG_PLN_SEQ : 1
					 ,NEXT_BLDG_PLN_QTY : 1
					 ,NEXT_BLDG_PRDT_QTY : 1
					 ,SW : "4/0"
				 }
				 ,
				 {
					 MC_CD : "A002"
					 ,SPEC_CD : "a"
					 ,BLDG_PLN_SEQ : 5
					 ,BLDG_PLN_QTY : 0
 					 ,BLDG_PRDT_QTY : 1
					 ,NEXT_BLDG_PLN_SEQ : 1
					 ,NEXT_BLDG_PLN_QTY : 1
					 ,NEXT_BLDG_PRDT_QTY : 1
					 ,SW : "9/0"
				 }
				 ,
				 {
					 MC_CD : "A003"
					 ,SPEC_CD : "b"
					 ,BLDG_PLN_SEQ : 22
					 ,BLDG_PLN_QTY : 0
 					 ,BLDG_PRDT_QTY : 1
					 ,NEXT_BLDG_PLN_SEQ : 1
					 ,NEXT_BLDG_PLN_QTY : 1
					 ,NEXT_BLDG_PRDT_QTY : 1
					 ,SW : "4/0"
				 }
				 ,
				 {
					 MC_CD : "A003"
					 ,SPEC_CD : "a"
					 ,BLDG_PLN_SEQ : 5
					 ,BLDG_PLN_QTY : 0
 					 ,BLDG_PRDT_QTY : 1
					 ,NEXT_BLDG_PLN_SEQ : 1
					 ,NEXT_BLDG_PLN_QTY : 1
					 ,NEXT_BLDG_PRDT_QTY : 1
					 ,SW : "9/0"
				 }
				 ];
			 
			//SUBtotal... 
			let json_data2 = []; 
			let mccd = json_data[0].MC_CD;
			let idx = 0; 
			 
			for(let i=0; i<=json_data.length; i++){
				let val1 = 0;
				let val2 = 0;
				let val3 = 0;
				let val4 = 0;
				let val5 = 0;
				let val6 = 0;
				let val7_1 = 0;
				let val7_2 = 0;
				
				if(i== json_data.length || mccd != json_data[i].MC_CD){
					for(k=idx; k<i; k++){
						val1 += json_data[k].BLDG_PLN_SEQ; 
						val2 += json_data[k].BLDG_PLN_QTY; 
						val3 += json_data[k].BLDG_PRDT_QTY; 
						val4 += json_data[k].NEXT_BLDG_PLN_SEQ; 
						val5 += json_data[k].NEXT_BLDG_PLN_QTY; 
						val6 += json_data[k].NEXT_BLDG_PRDT_QTY; 
						
						var slikeStd = json_data[k].SW.indexOf("/");
						val7_1 += Number(json_data[k].SW.slice(0,slikeStd));
						val7_2 += Number(json_data[k].SW.slice(slikeStd+1));
						
						
					}
					json_data2.push(
						{
						  MC_CD : "SUB_TOTAL"
						 ,SPEC_CD : ""
						 ,BLDG_PLN_SEQ : val1
						 ,BLDG_PLN_QTY : val2
	 					 ,BLDG_PRDT_QTY : val3
						 ,NEXT_BLDG_PLN_SEQ : val4
						 ,NEXT_BLDG_PLN_QTY : val5
						 ,NEXT_BLDG_PRDT_QTY : val6
						 ,SW : val7_1+"/"+val7_2
						}	
						
					)
					 
					    if(i < json_data.length){
					    	idx = i;
							mccd = json_data[i].MC_CD;
					    }
						
					
				}
				
				  if(i < json_data.length){
					// 모든 행 json_data2에 넣기..
					json_data2.push(json_data[i]);
				  }
					
			}
			 
			 
			//subTotal 색깔넣기
            gridView[0].setRowStyleCallback(function(grid, item, fixed) {
				    var ret = {};
				    var color = grid.getValue(item.index, "MC_CD");

				    if (color == 'SUB_TOTAL') {
				      return 'color-yellow'
				    }
				});
			 
			 provider[0].fillJsonData(json_data2, { fillMode: "set" });
			 
		}
		
		, excel : function() {
		    var arrGrid = [];
			arrGrid.push(gridView[tabIdx]);
		    excel_down(arrGrid, "${menuId}");
		}
		 , getResult : function(data,gubun , temp , index) {
	           if (gubun == "SW_CNT" || gubun == "L11_CNT" || gubun == "CC1_CNT" ||
	              gubun == "CC2_CNT" || gubun == "CC3_CNT" || gubun == "BT1_CNT" ||
	              gubun == "BT2_CNT" || gubun == "TD_CNT" || gubun == "BD1_CNT" ){
	              var valArray = [0,0];
	              for (let k = temp; k < index; k++) {
	                 var idx = data[k][gubun].indexOf('/');
	                 valArray[0] += Number(data[k][gubun].slice(0,idx));
	                 valArray[1] += Number(data[k][gubun].slice(idx+1));
	                }

	                return valArray[0] + "/" + valArray[1];
	           }else{
	               var valResult = 0;
	              for (let k = temp; k < index; k++) {
	                 valResult += NVL(data[k][gubun], 0);
	                }
	                return valResult;
	            }

	         
	         
	       }
	   };
			
	LRELDZ827.init();
});

function setSpecInfo(rowData, idx) {
	gridView[tabIdx].commit();
	gridView[tabIdx].setValue(idx, "SPEC_CD", rowData.SPEC_CD);

	if (gridView[tabIdx].getValue(idx, "CUD") != "C") {
		gridView[tabIdx].setValue(idx, 'CUD', 'U');
	}
}

$('#specCd').keydown(function(e) {
	if (e.keyCode == 13) {
		LRELDZ827.search();
	}
});

</script>

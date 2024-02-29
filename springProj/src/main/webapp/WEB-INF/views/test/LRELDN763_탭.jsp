<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 상단 : title + btn -->
<div class="contPage-head flrbox">
	<div class="titlebox fl">
		<h2 class="title itype1" id="page_title"></h2>
		<a href="javascript:void(0);" onclick="FOOTER.setFavor('${menuId}');" class="btn-favorite">favorite</a> <!-- 활성화 on 클래스 사용 -->
	</div>
	<div class="btnbox fr">
		<a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="LRELDN763.excel();"><span class="ico-download"></span><span class="txt">${I18['#엑셀']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="m" class="btn-ix"><span class="ico-print"></span><span class="txt">${I18['#인쇄']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="d" class="btn-ix"><span class="ico-send"></span><span class="txt">${I18['#전송']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="w" class="btn-ix"><span class="ico-save"></span><span class="txt">${I18['#저장']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="LRELDN763.search();"><span class="ico-search1"></span><span class="txt">${I18['#조회']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="help_popup('${menuId}');"><span class="ico-help"></span><span class="txt">${I18['#도움말']}</span></a>
	</div>
</div>
<!-- //상단 : title + btn -->

<!-- 검색조건 박스 - 20210107 인라인 스타일로 지정된 width 값이 전체적으로 변경 됨 -->
<div class="contPage-search searchSHWrap" id="div_form_LRELDN763">
	<input type="hidden" name="spec_grp_cd" id="spec_grp_cd">
	<div class="border-box searchReq-box">
		<div class="searchReq-tablebox">
			<table>
				<colgroup>
					<col style="width: 8%;">
					<col style="width: 10%;">
				    <col style="width: 8%;">
					<col style="width: 20%;"> 
					<col/>
				</colgroup>
				<tr>
					<th><span class="label-dot">${I18['#공장']}</span></th>
					<td>
						<div style="width: calc(100% - 50px);">
							<select id="fac_cd" name="fac_cd" class="select1" style="width: calc(100% - 12px);"></select>
						</div>
					</td> 
					<th><span class="label-dot" id="form1">${I18['#일자']}</span></th>
					<td>
						<div style="width: calc(100% - 18px);">
							<input type="text" class="input1 ico-cal rangepicker start-date"  style="width: calc(50% - 25px);" id="from_date" name="from_date" readonly>
							<span class="txt-bar">~</span>
							<input type="text" class="input1 ico-cal end-date" style="width: calc(50% - 25px);" id="to_date" name="to_date" readonly>
							<input id="dateperiod" name="dateperiod" type="hidden" class="input1">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<!-- //검색조건 박스 -->


<div class="contPage-body">
	<ul class="tab-bdtype">
		<li><a href="#" class="tag">T/D</a></li>
		<li><a href="#" class="tag">S/W</a></li>
		<li><a href="#" class="tag">C/C</a></li>
		<li><a href="#" class="tag">BELT</a></li>
		<li><a href="#" class="tag">I/L</a></li>
		<li><a href="#" class="tag">${I18['#완성비드']}</a></li>
	</ul>

	<div class="base-list table-list">
		<div id="realgrid0" style="width: 100%; height: 100%;"></div>
	</div>
	<div class="base-list table-list">
		<div id="realgrid1" style="width: 100%; height: 100%;"></div>
	</div>
	<div class="base-list table-list">
		<div id="realgrid2" style="width: 100%; height: 100%;"></div>
	</div>
	<div class="base-list table-list">
		<div id="realgrid3" style="width: 100%; height: 100%;"></div>
	</div>
	<div class="base-list table-list">
		<div id="realgrid4" style="width: 100%; height: 100%;"></div>
	</div>
	<div class="base-list table-list">
		<div id="realgrid5" style="width: 100%; height: 100%;"></div>
	</div>
</div>
<!-- //검색조건 박스 -->


<script>
	var PLT_CD = '${USER_SESSION.extraData.pltCd}';
	var LANG = '${lang}';

	var tabIdx = 0;
	var tabClear = null;

	var provider = [];
	var gridView = [];
	var fields = [];
	var columns = [];
	var layout = [];


var i =0;
	

	fields[i] = [
		  {fieldName:'PLT_CD'               	}
		, {fieldName:'CRT_CD'               	}
		, {fieldName:'SPEC_CD'               	}
		, {fieldName:'SCAN_DATE'              	,  dataType: "datetime", datetimeFormat: "yyyyMMdd"}
		, {fieldName:'SCAN_DTM'         		}
		, {fieldName:'SLS_FG'         			}
		, {fieldName:'SPEC_GRP_CD'    			}
		, {fieldName:'FROM_LOCATION'        	}
		, {fieldName:'TO_LOCATION'         		}
		, {fieldName:'LD_QLT_STS_FG_NM'         }
		, {fieldName:'LD_STS_FG_NM'           	}
		, {fieldName:'LD_QTY'           		}
		, {fieldName:'LD_WGT'           		}
		, {fieldName:'LD_LTH'           		}
		, {fieldName:'SCAN_INSPS_EPNO'          }

	];

	columns[i] = [
	      {name:'PLT_CD',               fieldName:'PLT_CD',             type:'data', width:80 ,  header:{text:I18('#사업장')}, editable:false, sortable:true	}
		, {name:'CRT_CD',               fieldName:'CRT_CD',             type:'data', width:100 ,  header:{text:I18('#운반구번호')}, editable:false, sortable:true	}
		, {name:'SPEC_CD',              fieldName:'SPEC_CD',            type:'data', width:250,  header:{text:I18('#규격')}, 		editable:false, sortable:true,	styleName: 'text-align-left'	}
		, {name:'SCAN_DATE',            fieldName:'SCAN_DATE',          type:'data', width:150,  header:{text:I18('#스캔날짜')}, 	editable:false, sortable:true	, datetimeFormat: "yyyy-MM-dd"}
		, {name:'SCAN_DTM',         	fieldName:'SCAN_DTM',           type:'data', width:250,  header:{text:I18('#스캔시간')}, 	editable:false, sortable:true	,textFormat :"([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})$;$1-$2-$3 $4:$5:$6"}
		, {name:'SLS_FG',         		fieldName:'SLS_FG',           	type:'data', width:100,  header:{text:I18('#유형')}, 		editable:false, sortable:true	}
		, {name:'SPEC_GRP_CD',    		fieldName:'SPEC_GRP_CD',      	type:'data', width:100,  header:{text:I18('#공정코드')}, 	editable:false, sortable:true	}
		, {name:'FROM_LOCATION',        fieldName:'FROM_LOCATION',      type:'data', width:100,  header:{text:I18('#출발지')}, 	editable:false, sortable:true,	numberFormat: '#,##0',	styleName: 'text-align-center'	}
		, {name:'TO_LOCATION',         	fieldName:'TO_LOCATION',        type:'data', width:120,  header:{text:I18('#목적지')}, 	editable:false, sortable:true	}
		, {name:'LD_QLT_STS_FG_NM',     fieldName:'LD_QLT_STS_FG_NM',   type:'data', width:100,  header:{text:I18('#품질코드')}, 	editable:false, sortable:true	}
		, {name:'LD_STS_FG_NM',         fieldName:'LD_STS_FG_NM',       type:'data', width:100,  header:{text:I18('#운반구_상태')}, editable:false, sortable:true	}
		, {name:'LD_QTY',           	fieldName:'LD_QTY',             type:'data', width:100,  header:{text:I18('#적재_수량')}, 	editable:false, sortable:true,	styleName: 'text-align-right'	}
		, {name:'LD_WGT',           	fieldName:'LD_WGT',             type:'data', width:100,  header:{text:I18('#적재_중량')}, 	editable:false, sortable:true,	styleName: 'text-align-right'	}
		, {name:'LD_LTH',           	fieldName:'LD_LTH',             type:'data', width:100,  header:{text:I18('#적재_길이')}, 	editable:false, sortable:true,	styleName: 'text-align-right'	}
		, {name:'SCAN_INSPS_EPNO',      fieldName:'SCAN_INSPS_EPNO',    type:'data', width:100,  header:{text:I18('#작업자')}, 	editable:false, sortable:true,	styleName: 'text-align-center'	}
	];

	layout[i] = [
		  'PLT_CD'
		, 'CRT_CD'
		, 'SPEC_CD'
		, 'SCAN_DATE'
		, 'SCAN_DTM'
		, 'SLS_FG'
		, 'SPEC_GRP_CD'
		, 'FROM_LOCATION'
		, 'TO_LOCATION'
		, 'LD_QLT_STS_FG_NM'
		, 'LD_STS_FG_NM'
		, 'LD_QTY'
		, 'LD_WGT'
		, 'LD_LTH'
		, 'SCAN_INSPS_EPNO'
	];

	$(function() {

		LRELDN763 = {
			init : function() {
				this.initGrid();
				this.initEvent();
				this.initDisp();
				this.initCombo();
			}
			, initGrid : function() {
				for (var idx = 0; idx < 6; idx++) {
					provider[idx] = new RealGrid.LocalDataProvider(false);
					provider[idx].setFields(fields[0]);
					gridView[idx] = new RealGrid.GridView('realgrid' + idx);
					gridView[idx].setDataSource(provider[idx]);
					setDefaultGrid(gridView[idx]);
					gridView[idx].setHeaderSummaries({visible:false});
					gridView[idx].setRowIndicator({visible:false});
					gridView[idx].setStateBar({visible:false});
					gridView[idx].setCheckBar({visible:false});
					gridView[idx].setFooters({visible:false});
					gridView[idx].setHeader({visible:true});
					gridView[idx].setRowIndicator({visible:false});
					// gridView[idx].setRowIndicator({visible: true, headText: I18("#순번")});
					// gridView[idx].setFixedOptions({colCount: 4});
					gridView[idx].displayOptions.columnMovable = false;
					gridView[idx].displayOptions.selectionStyle = 'rows';
					gridView[idx].displayOptions.fitStyle = 'fill';
					gridView[idx].sortMode = "explicit";
					gridView[idx].setColumns(columns[0]);
					gridView[idx].setColumnLayout(layout[0]);
					gridView[idx].setEditOptions({editable: true});
					gridView[idx].setEditOptions({ insertable: true, deletable: true, editWhenFocused: true, commitWhenLeave: true, commitByCell : true });
					gridView[idx].onCellEdited = this.onCellEdited;
					gridView[idx].onCellClicked = this.onCellClicked;
					gridView[idx].onCellDblClicked = this.onCellDblClicked;
					gridView[idx].onCellButtonClicked = this.onCellButtonClicked;
					gridView[idx].onContextMenuPopup = onContextMenuPopup;   // 출력할 메뉴 설정
					gridView[idx].onContextMenuItemClicked = onContextMenuItemClicked;   // 메뉴 클릭시
					gridView[idx].onCopy = this.onCopy;

				}
			}
			// CUD 처리
			, onCellEdited : function(grid, itemIndex, dataRow, field) {
			}

			, onCellClicked : function(grid, clickData) {
			}

			// button click
			, onCellButtonClicked : function(grid, index, column) {
			}

			// double click
			, onCellDblClicked : function(grid, clickData) {
			}

			// ctrl c
			, onCopy : function(grid, selection, event) {
				MES_UTIL.copyToClipboard(grid);
				return false;
			}

			, initEvent : function() {
				$('.tab-bdtype li .tag').on('click', function() {
					tabIdx = $(this).closest('li').index();

					// tab 클릭시 이벤트 처리
					if (tabClear !== null) {
						clearTimeout(tabClear);
					}

					if (tabIdx == 0) {
						$("#spec_grp_cd").val("DT");
					} else if (tabIdx == 1) {
						$("#spec_grp_cd").val("DS");
					} else if (tabIdx == 2) {
						$("#spec_grp_cd").val("FC");
					} else if (tabIdx == 3) {
						$("#spec_grp_cd").val("FB");
					} else if (tabIdx == 4) {
						$("#spec_grp_cd").val("FI");
					} else if (tabIdx == 5) {
						$("#spec_grp_cd").val("GU");
					}

					tabClear = setTimeout(function() {
						gridView[tabIdx].resetSize();
						LRELDN763.search();
					}, 30);

				});

				$('.tab-bdtype li:first-child .tag').trigger('click');
			}

			, initDisp : function() {
			}

			, initCombo : function() {
				// 공장
				MES_UTIL.L_gfn_GetMasCdCombo("fac_cd", "C040", "", 0, LRELDN763.callback);
				//일자
				MES_UTIL.L_gfn_GetCalHanta('datefromto', 'from_date', 'to_date', 'dateperiod', '${menuId}', LRELDN763.callback);
			}

			, search : function() {
				try {
                    var idx = $('.tab-bdtype li.on').index();;

					$(".overlay").show();

					var url = "${pageContext.request.contextPath}/api/LRELDN763/LRELDN763_SEARCH";

                    this.searchCond = $( '#div_form_LRELDN763 ' ).serializeJson();
					this.searchCond.from_Date = $("#from_date").val().replaceAll("-", "");;
					this.searchCond.to_Date = $("#to_date").val().replaceAll("-", "");;

					

					HTGF.Api.get(url, this.searchCond).then( function(resData) {
						console.log(resData);
						// 그리드에 데이터 넣기
						provider[idx].fillJsonData(resData.result,{fillMode: "set"} );

						// 시간 타이머
						FOOTER.setTimer(resData.timer);

						$(".overlay").hide();
					}).catch(function(e) {
						$(".overlay").hide();
	                   	if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
	               	});
				} catch (e) {
					$(".overlay").hide();
					console.error(e);
				}
			}

			, callback : function (id) {
				switch (id) {
				}
			}

			, excel : function() {
				var arrGrid = [];
				arrGrid.push(gridView[tabIdx]);
				excel_down(arrGrid, "${menuId}");
			}
		};

		LRELDN763.init();

	});
</script>
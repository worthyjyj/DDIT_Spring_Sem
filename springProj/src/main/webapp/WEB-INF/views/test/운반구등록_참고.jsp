<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/core/views/common/3rdparty/dhtmlx.jsp" />
<jsp:include page="/WEB-INF/core/views/common/3rdparty/dhtmlx-vault.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/5.14.0/css/all.min.css">

<div class="contPage-head flrbox">
	<div class="titlebox fl">
		<h2 class="title itype1" id="page_title"></h2>
		<a href="javascript:void(0);" onclick="FOOTER.setFavor('${menuId}');" class="btn-favorite">favorite</a> <!-- 활성화 on 클래스 사용 -->
	</div>
	<div class="btnbox fr">
	    <a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="LINVEN017.excel();"><span class="ico-download"></span><span class="txt">${I18['#엑셀']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="m" class="btn-ix"><span class="ico-print"></span><span class="txt">${I18['#인쇄']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="d" class="btn-ix"><span class="ico-send"></span><span class="txt">${I18['#전송']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="w" class="btn-ix" onclick="LINVEN017.save();"><span class="ico-save"></span><span class="txt">${I18['#저장']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="LINVEN017.search();"><span class="ico-search1"></span><span class="txt">${I18['#조회']}</span></a>
		<a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="help_popup('${menuId}');"><span class="ico-help"></span><span class="txt">${I18['#도움말']}</span></a>
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
					<th><span class="label-dot">${I18['#공장_1']}</span></th>
					<td>
						<div style="width: calc(100% - 50px)">
							<select class="select1" id="fac_cd" name="fac_cd" style="width: 100%;"></select>
						</div>
					</td>
					<th><span class="label-dot">${I18['#운반구']}</span></th>
					<td>
						<div style="width: calc(100% - 50px)">
							<input type="text" class="input1" id="crt_cd" name="crt_cd" style="width: 100%;"/>
						</div>
					</td>
					<th><span class="label-dot">RF-ID No</span></th>
					<td>
						<div style="width: calc(100% - 50px)">
							<input type="text" class="input1" id="crt_tag_no" name="crt_tag_no" style="width: 100%;"/>
						</div>
					</td>
					<td></td>
					<td>
						<div style="width: calc(100% - 50px)">
							<a id="btn_excel_upload" href="#" onclick="LINVEN017.upload(); return false;" class="btn-ix"><span class="ico-send"></span><span class="txt">EXCEL IMPORT</span></a>
							<div id="file-upload" style="display: none"></div>
						</div>
					</td>
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

<script type="text/javascript">
	var PLT_CD = '${USER_SESSION.extraData.pltCd}';
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
		, {fieldName:'CRT_TAG_NO_1'        }
		, {fieldName:'CRT_TAG_NO_2'        }
		, {fieldName:'CRT_TP_FG'           }
		, {fieldName:'LD_UNIT_FG'          }
		, {fieldName:'CRT_MLPS_FG'         }
		, {fieldName:'CRT_WGT'             , dataType: "number"	}
		, {fieldName:'FAC_CD'              }
		, {fieldName:'REG_DTM'             , dataType:"datetime", datetimeFormat:'yyyyMMddHHmmss'	}
		, {fieldName:'UDT_DTM'             , dataType:"datetime", datetimeFormat:'yyyyMMddHHmmss'	}
		, {fieldName:'MC_CD'               }
		, {fieldName:'LAST_USE_DTM'        , dataType:"datetime", datetimeFormat:'yyyyMMddHHmmss'	}
		, {fieldName:'LAST_USE_MC_CD'      }
		, {fieldName:'HNDL_DTM'            , dataType:"datetime", datetimeFormat:'yyyyMMddHHmmss'	}
	];

	columns[i] = [
		  {name:'CUD',                 fieldName:'CUD',                 type:'data', width:50, 	header:{text:I18('#CUD')}, 			editable:true, 	sortable:false, lookupDisplay: true, values:['','C','R','U','D'], labels:['','C','R','U','D'], editor: {type: "dropdown", dropDownCount: 5}	}
		, {name:'CRT_CD',              fieldName:'CRT_CD',              type:'data', width:100, header:{text:I18('#운반구')}, 		editable:true, 	sortable:true, 	button: 'action', buttonVisibility: 'always',
			styleCallback: styleCallback	}
		, {name:'CRT_TAG_NO_1',        fieldName:'CRT_TAG_NO_1',        type:'data', width:150, header:{text:'RF ID(1)'}, 			editable:true, 	sortable:true	}
		, {name:'CRT_TAG_NO_2',        fieldName:'CRT_TAG_NO_2',        type:'data', width:150, header:{text:'RF ID(2)'}, 			editable:true, 	sortable:true	}
		, {name:'CRT_TP_FG',           fieldName:'CRT_TP_FG',           type:'data', width:80, 	header:{text:I18('#운반구_유형')},	editable:true, 	sortable:true, 	lookupDisplay: true, editor: {type: "dropdown", dropDownCount: 5, textReadOnly: "true"}	}
		, {name:'LD_UNIT_FG',          fieldName:'LD_UNIT_FG',          type:'data', width:80, 	header:{text:I18('#단위')}, 			editable:true, 	sortable:true, 	lookupDisplay: true, editor: {type: "dropdown", dropDownCount: 5, textReadOnly: "true"}	}
		, {name:'CRT_MLPS_FG',         fieldName:'CRT_MLPS_FG',         type:'data', width:100, header:{text:I18('#용도')}, 			editable:true, 	sortable:true, 	lookupDisplay: true, editor: {type: "dropdown", dropDownCount: 5, textReadOnly: "true"},	styleName: "text-align-left"	}
		, {name:'CRT_WGT',             fieldName:'CRT_WGT',             type:'data', width:80, 	header:{text:I18('#운반구_중량')},	editable:true, 	sortable:true, 	numberFormat: "#,##0;f",	styleName: "text-align-right"	}
		, {name:'FAC_CD',              fieldName:'FAC_CD',              type:'data', width:80, 	header:{text:I18('#공장_1')}, 			editable:true, 	sortable:true, 	lookupDisplay: true, editor: {type: "dropdown", dropDownCount: 5, textReadOnly: "true"}	}
		, {name:'REG_DTM',             fieldName:'REG_DTM',             type:'data', width:80, header:{text:I18('#등록일시')}, 		editable:false, sortable:true, 	datetimeFormat:'yyyy-MM-dd HH:mm:ss'	}
		, {name:'UDT_DTM',             fieldName:'UDT_DTM',             type:'data', width:150, header:{text:I18('#최종사용일자')},	editable:false, sortable:true, 	datetimeFormat:'yyyy-MM-dd HH:mm:ss'	}
		, {name:'MC_CD',               fieldName:'MC_CD',               type:'data', width:40, 	header:{text:I18('#최종설비')}, 		editable:false, sortable:true	}
		, {name:'LAST_USE_DTM',        fieldName:'LAST_USE_DTM',        type:'data', width:150, header:{text:I18('#생산일자')}, 		editable:false, sortable:true, 	datetimeFormat:'yyyy-MM-dd HH:mm:ss'	}
		, {name:'LAST_USE_MC_CD',      fieldName:'LAST_USE_MC_CD',      type:'data', width:30, 	header:{text:I18('#생산설비')}, 		editable:false, sortable:true	}
		, {name:'HNDL_DTM',            fieldName:'HNDL_DTM',            type:'data', width:150, header:{text:I18('#수정일시')}, 		editable:false, sortable:true, 	datetimeFormat:'yyyy-MM-dd HH:mm:ss'	}
	];

	layout[i] = [
		  'CUD'
		, 'CRT_CD'
		, 'CRT_TAG_NO_1'
		, 'CRT_TAG_NO_2'
		, 'CRT_TP_FG'
		, 'LD_UNIT_FG'
		, 'CRT_MLPS_FG'
		, 'CRT_WGT'
		, 'FAC_CD'
		, 'REG_DTM'
		, 'UDT_DTM'
		, 'MC_CD'
		, 'LAST_USE_DTM'
		, 'LAST_USE_MC_CD'
		, 'HNDL_DTM'
	];

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

		LINVEN017 = {
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
				setDefaultGrid(gridView[idx]);
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
					gridView[idx].fixedOptions.colCount = 6;
					gridView[idx].sortMode = "explicit";
					gridView[idx].onContextMenuPopup = onContextMenuPopup;					//출력할 메뉴 설정
					gridView[idx].onContextMenuItemClicked = onContextMenuItemClicked;		//메뉴 클릭시
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
				setGridCombo("I090").then(function(rtnData) {
					rtnData.values.unshift("");
					rtnData.labels.unshift("");
					gridView[0].setColumnProperty('CRT_TP_FG', 'values', rtnData.values);
					gridView[0].setColumnProperty('CRT_TP_FG', 'labels', rtnData.labels);
				});

				setGridCombo2("C111", "C110_INV").then(function(rtnData) {
					gridView[0].setColumnProperty('LD_UNIT_FG', 'values', rtnData.values);
					gridView[0].setColumnProperty('LD_UNIT_FG', 'labels', rtnData.labels);
				});

				var arg = {};
				setCustomGridCombo("LINVEN017", "LINVEN017_FIND_CRT_MLPS_FG", arg).then(function(rtnData) {
					gridView[0].setColumnProperty('CRT_MLPS_FG', 'values', rtnData.values);
					gridView[0].setColumnProperty('CRT_MLPS_FG', 'labels', rtnData.labels);
				});

				setGridCombo("C040").then(function(rtnData) {
					rtnData.values.unshift("");
					rtnData.labels.unshift("");
					gridView[0].setColumnProperty('FAC_CD', 'values', rtnData.values);
					gridView[0].setColumnProperty('FAC_CD', 'labels', rtnData.labels);
				});

			}

			, initCombo : function() {
				var USER_ID = "${USER_SESSION.userId}";
				//운반구 등록 엑셀버튼 임포트
				if (USER_ID == "em110302" || USER_ID == "em070406" || USER_ID == "em150502" || USER_ID == "GMESDEV" || USER_ID == "em130501" || USER_ID == "41600391" || USER_ID == "em150408"){
					$("#btn_excel_upload").show();
				}else{
					$("#btn_excel_upload").hide();
				}

				// 공장
				MES_UTIL.L_gfn_GetMasCdCombo( 'fac_cd' , 'C040' , 'BLANK' , 1 , LINVEN017.callback );

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
			excel : function () {	// 엑셀 다운로드
				var idx = 0;
				gridView[idx].exportGrid({
					type: "excel",
					target: "local",
					fileName: "${menuId}.xlsx",
					headerSummary: "hidden",
					header: "visible",
					footer: "hidden",
					done: function () {  //내보내기 완료 후 실행되는 함수
						//alert("EXCEL 다운로드 완료!");
					}
				});
			},
			upload_x : function () {	// 엑셀 업로드
				var idx = 0;
				$("#excel_file").off("change").on("change", function (event) {	// change 이벤트 삭제 >> 추가
					excel_import(event, $(this), gridView[idx], provider[idx], 0, 1);
				});
				$('#excel_file').trigger('click');	// click 이벤트 실행
			}
			
			, upload : function () {	// 엑셀 업로드
				if($('.dhx_toolbar-button__icon').length <= 0){
					this.upload2();
				}

				setTimeout(function() {
					$('.dhx_toolbar-button__icon').trigger('click');
				}, 1000);

			}
			, upload2 : function () {	// 엑셀 업로드

				// 데이터 초기화
				provider[0].clearRows();
				
				var fileUploader = $('#file-upload')
	            .fileUpload({
	                category: 'TEST',     //영역 아이디. 파일이 저장되는 물리적 패스로 이용됩니다.
	                workId: 'LINVEN017', //'게시물 아이디
	                drm: true,    //파일 drm 여부
	                uploadUrl: "/api/file/upload",    //파일 업로드시 url
	                downloadUrl: "/api/file/download/",  //파일 다운로드 요청 url
	                // [다운로드시 권한 체크] 0.16.2 버전에서 추가됨.
	                // 다운로드를 실행한 유저가 메뉴에 읽기 권한이 있는지를 체크합니다.
	                // (주의: NoAuth, NoLogin 이 걸려있어도 Readable 권한을 체크하니 만약 누구나 접근가능한 페이지의 경우 checkDownloadAuth 를 false로 설정합니다.)
	                checkMenuReadableAuth: true,        //다운로드시 권한 체크를 할것인지에 대한 설정(아래 menuId 가 꼭 필요합니다. menuId 에 설정한 메뉴의 읽기권한 설정을 따르기 때문입니다.)
	                menuId: '${CURRENT_MENU_ID}',       //현재 화면의 메뉴 아이디(Haifer 에서 ${CURRENT_MENU_ID} 이름으로 jsp 로 전달하므로 그냥 복붙하시면 됩니다.)
	            })
	            .addEvent(function(vault) {  //vault 객체가 필요한 경우는 인자로 전달받은 vault 객체를 사용하면 됩니다.
	                return {
	                    eventName: "UploadFile",  //이벤트명
	                    callback: function(file){  //실행할 함수
	                            var param = { ID : file.uid , HEADERROWS : 2 }
	                			
			                     HTGF.Api.get("/api/filterLocal/uploadExcel", param).then( function(resData) {
				                     
									console.log("//////1////////"+ JSON.stringify( resData)  )
									let fieldName = provider[0].getFieldNames();
									let fCount = provider[0].getFieldCount();

									console.log( ">>>>>2>>>>>>>"+ fieldName )

									var realData = [];
									$.each(resData, function(index, item){
										realData[index] = {};
										$.each(item, function(key, value){
											if (fieldName[key] == "CUD") {
												realData[index][fieldName[key]] = "C";
											} else {
												realData[index][fieldName[key]] = value;
											}

										});
									});
									//console.log( ">>>>>3>>>>>>>"+ JSON.stringify(realData) )

									provider[0].fillJsonData(realData,{fillMode: "set"} );

									for(var i = 0; i < provider[0].getRowCount(); i ++){
										provider[0].setRowState(i,'created');
									}
	
								}).catch(function(e) {
								    if (e.status !== 400) return msg_alert('Excel', 'Server Error', '', I18('#확인'));
								}) 
	    					
	                       // return true;
	                    }
	                }
	            }).load();
			}
		};

		LINVEN017.init();

	});
</script>

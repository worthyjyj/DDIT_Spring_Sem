<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 상단 : title + btn -->
<div class="contPage-head flrbox">
   <div class="titlebox fl">
      <h2 class="title itype1" id="page_title"></h2>
      <a href="javascript:void(0);" onclick="FOOTER.setFavor('${menuId}');" class="btn-favorite">favorite</a> <!-- 활성화 on 클래스 사용 -->
   </div>
   <div class="btnbox fr">
      <a href="#" data-fc-auth="r" class="btn-ix" onclick="LOPRDN087.excel();"><span class="ico-download"></span><span class="txt">${I18['#엑셀']}</span></a>
      <a href="javascript:void(0);" data-fc-auth="m" class="btn-ix"><span class="ico-print"></span><span class="txt">${I18['#인쇄']}</span></a>
      <a href="javascript:void(0);" data-fc-auth="d" class="btn-ix"><span class="ico-send"></span><span class="txt">${I18['#전송']}</span></a>
      <a href="javascript:void(0);" data-fc-auth="w" class="btn-ix" onclick=""><span class="ico-save"></span><span class="txt">${I18['#저장']}</span></a>
      <a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="LOPRDN087.search();"><span class="ico-search1"></span><span class="txt">${I18['#조회']}</span></a>
      <a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="help_popup('${menuId}');"><span class="ico-help"></span><span class="txt">${I18['#도움말']}</span></a>
   </div>
</div>
<!-- //상단 : title + btn -->

<div class="contPage-search searchSHWrap" id="div_form_LOPRDN087">
   <div class="border-box searchReq-box">
      <div class="searchReq-tablebox">
         <table>
            <colgroup>
               <col style="width: 6%;">
               <col style="width: 20%;">
               <col style="width: 6%;">
               <col style="width: 8%;">
               <col style="width: 6%;">
               <col style="width: 10%;">
               <col>
            </colgroup>
            <tr>
               <th><span class="label-dot">${I18['#조회일자']}</span></th>
               <td>
                  <div style="width: calc(100% - 10px);">
                     <input type="text" id="date_from" name="DATE_FROM" class="input1 ico-cal rangepicker start-date" style="width: calc(45% - 10px);">
                     <span class="txt-bar">~</span>
                     <input type="text" id="date_to" name="DATE_TO" class="input1 ico-cal end-date" style="width: calc(45% - 10px);">
                     <input id="dateperiod" name="dateperiod" type="hidden" class="input1">
                  </div>
               </td>
               <th><span class="label-dot">${I18['#근무조']}</span></th>
               <td>
                  <div style="width: calc(100% - 10px);">
                     <select id='WRK_SHF' name='WRK_SHF' class="select1" style="width: calc(100% - 10px);">
                     </select>                     
                  </div>
               </td>               
               <th><span class="label-dot">${I18['#설비']}</span></th>
               <td>
                  <div style="width: calc(100% - 18px);">
                     <select id="MC_CD" name="MC_CD" class="select1" style="width: calc(100% - 20px);"></select>
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
      <li><a href="#" class="tag">SBC</a></li>
      <li><a href="#" class="tag">TRC</a></li>
      <li><a href="#" class="tag">SRC</a></li>
   </ul>
   
   <div class="base-list table-list">
      <div id="realgrid0" style="float:left; width:100%; height: 100%;"></div>
   </div>
   <div class="base-list table-list">
      <div id="realgrid1" style="float:left; width:100%; height: 100%;"></div>
   </div>
   <div class="base-list table-list">
      <div id="realgrid2" style="float:left; width:100%; height: 100%;"></div>
   </div>
</div>

<script type="text/javascript">
   var pltCd = '${USER_SESSION.extraData.pltCd}';
   var tabIdx = 0;
   var orgTabIdx = 0;
   var orgTabIdxFlag = true;
   var tabClear = null;
   var initFlag = false;

   var provider = [];
   var gridView = [];
   var fields = [];
   var columns = [];
   var layout = [];
   var i = 0;

   var comboValue = [];
   var comboCode = []; 


   $(function() {

      LOPRDN087 = {
         init : function() {
            this.initGrid();
            this.initEvent();
            this.initCombo();
            this.initDisp();

            orgTabIdxFlag = false;
         }
         , initGrid : function() {
            for (var idx = 0; idx < 3; idx++) {
               provider[idx] = new RealGrid.LocalDataProvider();
               gridView[idx] = new RealGrid.GridView("realgrid" + idx);
               gridView[idx].setDataSource(provider[idx]);
               setDefaultGrid(gridView[idx]);
            }
         }
         // cell click
         , onCellClicked : function(grid, clickData) {
         }
         // button click
         , onCellButtonClicked : function(grid, index, column) {

         }
         // CUD 처리
         , onCellEdited : function(grid, itemIndex, dataRow, field) {
            
         }
         // ctrl c
         , onCopy : function(grid, selection, event) {
         }
         , initEvent : function() {
            $('.tab-bdtype li .tag').on('click', function() {
               tabIdx = $(this).closest('li').index();

               // 탭중복 클릭 방지
               if (orgTabIdxFlag == true) {
                  orgTabIdx = tabIdx;
               }
               if (orgTabIdxFlag == false) {
                  if (tabIdx == orgTabIdx) {
                     return false;
                  } else {
                     orgTabIdx = tabIdx;
                  }
               }

               // 탭별 조회조건 처리
               if (initFlag == true){
                  LOPRDN087.fn_ComboMc();
               }

               // tab 클릭시 이벤트 처리
               if (tabClear !== null) {
                  clearTimeout(tabClear);
               }

               tabClear = setTimeout(function() {
                  //provider[tabIdx].clearRows();
                  gridView[tabIdx].resetSize();
               }, 30);

            });

            $('.tab-bdtype li:first-child .tag').trigger('click');
               
         }
         , initCombo : function() {
            MES_UTIL.L_gfn_GetCalHanta('datefromto', 'date_from', 'date_to', 'dateperiod', '${menuId}', LOPRDN087.callback);
            
            // 근무조
            MES_UTIL.L_gfn_GetMasCdCombo("WRK_SHF", "S060", "BLANK", 0, LOPRDN087.callback);

            // 설비 콤보 만들어야 함
            LOPRDN087.fn_ComboMc();
         }
         , fn_ComboMc : function() {
            //초기 데이터셋 정보를 만들기 위한 함수
            try {
               var param = { pltcd : pltCd };

               if(tabIdx == 0){
                  param.pgmid = "LOPRDN013"
               }else if(tabIdx == 1){
                  param.pgmid = "LOPRDN014"
               }else if(tabIdx == 2){
                  param.pgmid = "LOPRDN033"
               }

               HTGF.Api.get('${pageContext.request.contextPath}/api/LOPRDN087/findMC', param).then( function(resData) {
                  if ( resData.result.length > 0 ) {
                     // 검색 조건 설비 콤보
                     var vOption = ''; 
                     vOption = '<option value="">&nbsp;</option>';
                     for(var i = 0; i < resData.result.length ;i++){
                        vOption    += '<option value="' + resData.result[i].MCCD + '">' + resData.result[i].MCCD + '</option>';
                     }
                     
                     $("#MC_CD").html(vOption);
                     LOPRDN087.callback("MC_CD");
                  }
               })
            } catch(e) {
               console.log(e);
               console.error(e);
            } finally {
            }
         }
         , initDisp : function() {
            gridView[0].setEditOptions({ insertable: false, appendable: false, deletable: false }); 
            gridView[0].setOptions({ hideDeletedRows: false, softDeleting: false   });
            gridView[0].setRowIndicator({visible:false});
            gridView[0].setStateBar({visible:false});
            gridView[0].setCheckBar({visible:false});
            gridView[0].setFooters({visible:false});
            gridView[0].displayOptions.columnMovable = false;
            gridView[0].sortMode = "explicit";
            gridView[0].onContextMenuPopup = onContextMenuPopup;               //출력할 메뉴 설정
            gridView[0].onContextMenuItemClicked = onContextMenuItemClicked;      //메뉴 클릭시
            gridView[0].onCopy = this.onCopy;
            
            
            gridView[1].setEditOptions({ insertable: false, appendable: false, deletable: false }); 
            gridView[1].setOptions({ hideDeletedRows: false, softDeleting: false   });
            gridView[1].setRowIndicator({visible:false});
            gridView[1].setStateBar({visible:false});
            gridView[1].setCheckBar({visible:false});
            gridView[1].setFooters({visible:false});
            gridView[1].displayOptions.columnMovable = false;
            gridView[1].sortMode = "explicit";
            gridView[1].onContextMenuPopup = onContextMenuPopup;               //출력할 메뉴 설정
            gridView[1].onContextMenuItemClicked = onContextMenuItemClicked;      //메뉴 클릭시
            gridView[1].onCopy = this.onCopy;
            
            gridView[2].setEditOptions({ insertable: false, appendable: false, deletable: false }); 
            gridView[2].setOptions({ hideDeletedRows: false, softDeleting: false   });
            gridView[2].setRowIndicator({visible:false});
            gridView[2].setStateBar({visible:false});
            gridView[2].setCheckBar({visible:false});
            gridView[2].setFooters({visible:false});
            gridView[2].displayOptions.columnMovable = false;
            gridView[2].sortMode = "explicit";
            gridView[2].onContextMenuPopup = onContextMenuPopup;               //출력할 메뉴 설정
            gridView[2].onContextMenuItemClicked = onContextMenuItemClicked;      //메뉴 클릭시
            gridView[2].onCopy = this.onCopy;

         }

         , search : function() {
            //그리드 초기화 처리 .
            provider[tabIdx].clearRows();

            if (tabIdx == 0) {
               LOPRDN087.search_SBC();
            } else if (tabIdx == 1) {
               LOPRDN087.search_TRC();
            } else if (tabIdx == 2) {
               LOPRDN087.search_SBC();
            }

         }
         
         , search_SBC : function() {
            // progressbar 추가
            $(".overlay").show();

            var arr = $('#MC_CD').find('option').map(function() {return $(this).val();}).get();
            var str = "AND C.MC_CD IN ("; 

            for(let i =1; i<arr.length; i++){
               if(i == (arr.length - 1)){
                  str += "'"+arr[i]+"')"
               }else{
                  str += "'"+arr[i]+"'"+","
               }   
            }
//             console.log(str);

            var lang = '${lang}';
            
            var param = {lang : lang};
            param.cd_id = 'O016'
            param.plt_cd = 'DP'
            param.pln_shf = $("#WRK_SHF").val();
            param.mc_cd = $("#MC_CD").val();
            param.sdate = $("#date_from").val();
            param.edate = $("#date_to").val();
            param.gbn_query = str;

            var headercnt = 0;
            let column_data = [];

            // 구분값 생성
            var gbn1 = new Object();
            gbn1['name'] = 'CHK_ITEM_NM1';
            gbn1['fieldName'] = 'CHK_ITEM_NM1';
            gbn1['type'] = 'data';
            gbn1['width'] = '90';
            gbn1['header'] = {text: I18('#설비')};

            // 구분값 생성
            var gbn2 = new Object();
            gbn2['name'] = 'CHK_ITEM_NM2';
            gbn2['fieldName'] = 'CHK_ITEM_NM2';
            gbn2['type'] = 'data';
            gbn2['width'] = '90';
            gbn2['header'] = {text: I18('#일자')};
            gbn2['dataType'] = 'text';
            gbn2['textFormat'] = "([0-9]{4})([0-9]{2})([0-9]{2})$;$1-$2-$3";

            // 구분값 생성
            var gbn3 = new Object();
            gbn3['name'] = 'CHK_ITEM_NM3';
            gbn3['fieldName'] = 'CHK_ITEM_NM3';
            gbn3['type'] = 'data';
            gbn3['width'] = '90';
            gbn3['header'] = {text: I18('#조')};

            // 구분값 생성
            var gbn4 = new Object();
            gbn4['name'] = 'CHK_ITEM_NM4';
            gbn4['fieldName'] = 'CHK_ITEM_NM4';
            gbn4['type'] = 'data';
            gbn4['width'] = '90';
            gbn4['header'] = {text: I18('#작업자')};

            column_data.push(gbn1);
            column_data.push(gbn3);
            column_data.push(gbn2);
            column_data.push(gbn4);

            try {               
               HTGF.Api.get('/api/LOPRDN087/HEADER_SBC' , param).then( function(resData) {
                  headercnt = resData.result.length;
                   for(var i=0;i < resData.result.length;i++){
                      var obj1 = new Object();
                       obj1['name'] = resData.result[i].CD_ITEM_NM;
                       obj1['fieldName'] = resData.result[i].CD_ITEM_NM;
                      obj1['type'] = 'data';
                      obj1['width'] = '130';
                      obj1['styleName'] = "text-align-right";
                      obj1['header'] =  resData.result[i].CD_ITEM_NM;

                      column_data.push( obj1);
                    } 

                   setFieldsNColumns2(provider[tabIdx], gridView[tabIdx], column_data);   
                   HTGF.Api.get('/api/LOPRDN087/BODY_SBC' , param).then( function(resData2) {
                      // TOTAL 처리
                     var objtest = {};

                     for (var i = 0; i < resData2.result.length; i++) {
                         var currentItem = resData2.result[i];
                         var itemName = currentItem.CD_ITEM_NM;
                         var itemQty = Number(currentItem.QTY);
                     
                         if (!isNaN(itemQty)) {
                             if (objtest.hasOwnProperty(itemName)) {
                                 objtest[itemName] += parseFloat(itemQty.toFixed(2));
                             } else {
                                 objtest[itemName] = parseFloat(itemQty.toFixed(2));
                             }
                         }
                     }

                     for (var key in objtest) {
                         objtest[key] = objtest[key].toFixed(2);
                     }

                     
                      let json_data = fn_makeGridCustom2( column_data  , resData2.result , headercnt );

                      //데이터가 한줄 일 때 (비교대상이 없을 경우) text 공백처리 조건 및 값 넣기
                      if(json_data.length == 2){
                        for(var i=0 ; i < resData2.result.length; i++){
                           if(isNaN(Number(resData2.result[i].QTY))){
                              objtest[resData2.result[i].CD_ITEM_NM] = "";
                           }
                        }
                     }

                      
                     if(json_data.length !=0){
                        // json_data 에 TOTAL 값 넣어주기
                         json_data[0] = objtest;
                         objtest['CHK_ITEM_NM1'] ='TOTAL';
                     }

                      let json_data2 = [];

                        // 조별 소계 내기
                        if(!MES_UTIL.gfn_IsNull(json_data)){

                           let CHK_ITEM_NM1 = json_data[1].CHK_ITEM_NM1; //설비
                           let CHK_ITEM_NM3 = json_data[1].CHK_ITEM_NM3; //조
                           let temp = 1; 

                           
                            for (let i = 1; i < json_data.length ; i++) {
                               if (i === json_data.length ||
                                     CHK_ITEM_NM3 !== json_data[i].CHK_ITEM_NM3 || 
                                     CHK_ITEM_NM1 !== json_data[i].CHK_ITEM_NM1
                                     ) {
                                  
                                  json_data2.push({ CHK_ITEM_NM1: CHK_ITEM_NM1, CHK_ITEM_NM2: 'Sub Total', CHK_ITEM_NM3: CHK_ITEM_NM3
                                                , 압연부적합: LOPRDN087.getResult(json_data, "압연부적합"  , temp , i )
                                                , 성형리턴: LOPRDN087.getResult(json_data, "성형리턴"  , temp , i ) 
                                                , 완료: LOPRDN087.getResult(json_data, "완료"  , temp , i ) 
                                                , 잔량: LOPRDN087.getResult(json_data, "잔량"  , temp , i )
                                                , 썰물: LOPRDN087.getResult(json_data, "썰물"  , temp , i ) 
                                                , 트러블: LOPRDN087.getResult(json_data, "트러블"  , temp , i ) 
                                                , 재단부적합: LOPRDN087.getResult(json_data, "재단부적합"  , temp , i )
                                                , 시험용: LOPRDN087.getResult(json_data, "시험용"  , temp , i ) 
                                                , 기타: LOPRDN087.getResult(json_data, "기타"  , temp , i ) 
                                                , 합계:  LOPRDN087.getResult(json_data, "합계"  , temp , i )
                                                });

                                     if (i < json_data.length) {
                                           CHK_ITEM_NM1 = json_data[i].CHK_ITEM_NM1;
                                           CHK_ITEM_NM3 = json_data[i].CHK_ITEM_NM3;
                                                 temp = i;
                                             }
                               }


                              //설비값이 같은 행은 json_data 바로 들어가게 하기 
                                      if (i < json_data.length) {
                                          json_data2.push(json_data[i]);
                                      }
                                      
                               if(i === json_data.length-1){
                                  
                                  json_data2.push({CHK_ITEM_NM1: CHK_ITEM_NM1, CHK_ITEM_NM2: 'Sub Total', CHK_ITEM_NM3: CHK_ITEM_NM3
                                                , 압연부적합: LOPRDN087.getResult(json_data, "압연부적합"  , temp , i+1 )
                                                , 성형리턴: LOPRDN087.getResult(json_data, "성형리턴"  , temp , i+1 ) 
                                                , 완료: LOPRDN087.getResult(json_data, "완료"  , temp , i+1 ) 
                                                , 잔량: LOPRDN087.getResult(json_data, "잔량"  , temp , i+1 )
                                                , 썰물: LOPRDN087.getResult(json_data, "썰물"  , temp , i+1 ) 
                                                , 트러블: LOPRDN087.getResult(json_data, "트러블"  , temp , i+1 ) 
                                                , 재단부적합: LOPRDN087.getResult(json_data, "재단부적합"  , temp , i+1 )
                                                , 시험용: LOPRDN087.getResult(json_data, "시험용"  , temp , i+1 ) 
                                                , 기타: LOPRDN087.getResult(json_data, "기타"  , temp , i+1 ) 
                                                , 합계:  LOPRDN087.getResult(json_data, "합계"  , temp , i+1 )
                                                });

                                     if (i < json_data.length) {
                                           CHK_ITEM_NM1 = json_data[i].CHK_ITEM_NM1;
                                           CHK_ITEM_NM3 = json_data[i].CHK_ITEM_NM3;
                                                 temp = i;
                                             }
                                             
                               }


                                 
                            }

                            //총합계 맨앞에 push
                            json_data2.unshift(json_data[0]);

                        }


                        gridView[tabIdx].setRowStyleCallback(function(grid, item, fixed) {
                            var ret = {};
                            var color = grid.getValue(item.index, "CHK_ITEM_NM2");
                            var color2 = grid.getValue(item.index, "CHK_ITEM_NM1");

                            if (color == 'Sub Total' || color2 == 'TOTAL') {
                              return 'color-yellow'
                            }
                        });


                        gridView[tabIdx].layoutByColumn("CHK_ITEM_NM1").spanCallback = function (grid, layout, itemIndex) {
                            var value = grid.getValue(itemIndex, "CHK_ITEM_NM1");
                            
                            if(value == "TOTAL"){
                                return 4; //가로 병합 수
                            }
                        };
                        
                     // 그리드에 데이터 넣기
                     provider[tabIdx].fillJsonData(json_data2,{fillMode: "set"} );
                     
                     // 그리드 progressbar 숨기기
                     $(".overlay").hide();
                   }).catch(function(e) {
                     $(".overlay").hide();
                            if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
                        })                                   
               }).catch(function(e) {
                  $(".overlay").hide();
                         if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
                     });
            } catch (e) {
               console.error(e);
            } finally {
            }
            
         }
         , search_TRC : function() {
            $(".overlay").show();
            
            var lang = '${lang}';
            
            var param = {lang : lang};
            param.cd_id = 'O015'
            param.plt_cd = 'DP'
            param.pln_shf = $("#WRK_SHF").val();
            param.mc_cd = $("#MC_CD").val();
            param.sdate = $("#date_from").val();
            param.edate = $("#date_to").val();

            let column_data = [ ];
            var headercnt = 0;
            // 구분값 생성
            var gbn1 = new Object();
            gbn1['name'] = 'CHK_ITEM_NM1';
            gbn1['fieldName'] = 'CHK_ITEM_NM1';
            gbn1['type'] = 'data';
            gbn1['width'] = '90';
            //gbn['styleName'] = "text-align-right";
            gbn1['header'] = {text: I18('#설비')}   ;
            
            // 구분값 생성
            var gbn2 = new Object();
            gbn2['name'] = 'CHK_ITEM_NM2';
            gbn2['fieldName'] = 'CHK_ITEM_NM2';
            gbn2['type'] = 'data';
            gbn2['width'] = '90';
            gbn2['header'] = {text: I18('#일자')};
            gbn2['dataType'] = 'text';
            gbn2['textFormat'] = "([0-9]{4})([0-9]{2})([0-9]{2})$;$1-$2-$3";

            // 구분값 생성
            var gbn3 = new Object();
            gbn3['name'] = 'CHK_ITEM_NM3';
            gbn3['fieldName'] = 'CHK_ITEM_NM3';
            gbn3['type'] = 'data';
            gbn3['width'] = '90';
            gbn3['header'] = {text: I18('#조')};
            
            // 구분값 생성
            var gbn4 = new Object();
            gbn4['name'] = 'CHK_ITEM_NM4';
            gbn4['fieldName'] = 'CHK_ITEM_NM4';
            gbn4['type'] = 'data';
            gbn4['width'] = '90';
            gbn4['header'] = {text: I18('#작업자')};

            column_data.push(gbn1);
            column_data.push(gbn3);
            column_data.push(gbn2);
            column_data.push(gbn4);
            
            try {               
               HTGF.Api.get('/api/LOPRDN087/HEADER_TRC' , param).then( function(resData) {
                  headercnt = resData.result.length;
                   for(var i=0;i < resData.result.length;i++){
                      var obj1 = new Object();
                       obj1['name'] = resData.result[i].CD_ITEM_NM;
                       obj1['fieldName'] = resData.result[i].CD_ITEM_NM;
                      obj1['type'] = 'data';
                      obj1['width'] = '130';
                      obj1['styleName'] = "text-align-right";
                      obj1['header'] =  resData.result[i].CD_ITEM_NM;

                      column_data.push( obj1);
                    } 

                   setFieldsNColumns2(provider[1], gridView[1], column_data);   
                   HTGF.Api.get('/api/LOPRDN087/BODY_TRC' , param).then( function(resData2) {
                      // TOTAL 처리
                     var objtest = {};

                     for (var i = 0; i < resData2.result.length; i++) {
                         var currentItem = resData2.result[i];
                         var itemName = currentItem.CD_ITEM_NM;
                         var itemQty = Number(currentItem.QTY);
                     
                         if (!isNaN(itemQty)) {
                             if (objtest.hasOwnProperty(itemName)) {
                                 objtest[itemName] += parseFloat(itemQty.toFixed(2));
                             } else {
                                 objtest[itemName] = parseFloat(itemQty.toFixed(2));
                             }
                         }
                     }

                     for (var key in objtest) {
                         objtest[key] = objtest[key].toFixed(2);
                     }

                      let json_data = fn_makeGridCustom2( column_data  , resData2.result , headercnt );

                      //데이터가 한줄 일 때 (비교대상이 없을 경우) text 공백처리 조건 
                     if(json_data.length == 2){
                        for(var i=0 ; i < resData2.result.length; i++){
                           if(isNaN(Number(resData2.result[i].QTY))){
                              objtest[resData2.result[i].CD_ITEM_NM] = "";
                           }
                        }
                     }

                     if(json_data.length !=0){
//                         json_data 에 TOTAL 값 넣어주기
                         json_data[0] = objtest;
                         objtest['CHK_ITEM_NM1'] ='TOTAL';
                     
                     }

                      let json_data2 = [];

                     // 조별 소계 내기
                     if(!MES_UTIL.gfn_IsNull(json_data)){

                        let CHK_ITEM_NM1 = json_data[1].CHK_ITEM_NM1; 
                        let CHK_ITEM_NM3 = json_data[1].CHK_ITEM_NM3; 
                        let temp = 1; 

                        
                         for (let i = 1; i < json_data.length ; i++) {
                            if (i === json_data.length ||
                                  CHK_ITEM_NM3 !== json_data[i].CHK_ITEM_NM3 || 
                                  CHK_ITEM_NM1 !== json_data[i].CHK_ITEM_NM1
                                  ) {
                               
                               json_data2.push({ CHK_ITEM_NM1: CHK_ITEM_NM1, CHK_ITEM_NM2: 'Sub Total', CHK_ITEM_NM3: CHK_ITEM_NM3
                                             , 압연부적합: LOPRDN087.getResult(json_data, "압연부적합"  , temp , i )
                                             , 성형리턴: LOPRDN087.getResult(json_data, "성형리턴"  , temp , i ) 
                                             , 완료: LOPRDN087.getResult(json_data, "완료"  , temp , i ) 
                                             , 잔량: LOPRDN087.getResult(json_data, "잔량"  , temp , i )
                                             , 썰물: LOPRDN087.getResult(json_data, "썰물"  , temp , i ) 
                                             , 트러블: LOPRDN087.getResult(json_data, "트러블"  , temp , i ) 
                                             , 재단부적합: LOPRDN087.getResult(json_data, "재단부적합"  , temp , i )
                                             , 시험용: LOPRDN087.getResult(json_data, "시험용"  , temp , i ) 
                                             , 기타: LOPRDN087.getResult(json_data, "기타"  , temp , i ) 
                                             , 합계:  LOPRDN087.getResult(json_data, "합계"  , temp , i )
                                             });

                                  if (i < json_data.length) {
                                        CHK_ITEM_NM1 = json_data[i].CHK_ITEM_NM1;
                                        CHK_ITEM_NM3 = json_data[i].CHK_ITEM_NM3;
                                              temp = i;
                                          }
                            }


                           //설비값이 같은 행은 json_data 바로 들어가게 하기 
                                   if (i < json_data.length) {
                                       json_data2.push(json_data[i]);
                                   }
                                   
                            if(i === json_data.length-1){
                               
                               json_data2.push({CHK_ITEM_NM1: CHK_ITEM_NM1, CHK_ITEM_NM2: 'Sub Total', CHK_ITEM_NM3: CHK_ITEM_NM3
                                             , 압연부적합: LOPRDN087.getResult(json_data, "압연부적합"  , temp , i+1 )
                                             , 성형리턴: LOPRDN087.getResult(json_data, "성형리턴"  , temp , i+1 ) 
                                             , 완료: LOPRDN087.getResult(json_data, "완료"  , temp , i+1 ) 
                                             , 잔량: LOPRDN087.getResult(json_data, "잔량"  , temp , i+1 )
                                             , 썰물: LOPRDN087.getResult(json_data, "썰물"  , temp , i+1 ) 
                                             , 트러블: LOPRDN087.getResult(json_data, "트러블"  , temp , i+1 ) 
                                             , 재단부적합: LOPRDN087.getResult(json_data, "재단부적합"  , temp , i+1 )
                                             , 시험용: LOPRDN087.getResult(json_data, "시험용"  , temp , i+1 ) 
                                             , 기타: LOPRDN087.getResult(json_data, "기타"  , temp , i+1 ) 
                                             , 합계:  LOPRDN087.getResult(json_data, "합계"  , temp , i+1 )
                                             });

                                  if (i < json_data.length) {
                                        CHK_ITEM_NM1 = json_data[i].CHK_ITEM_NM1;
                                        CHK_ITEM_NM3 = json_data[i].CHK_ITEM_NM3;
                                              temp = i;
                                          }
                                          
                            }


                              
                         }

                         //총합계 맨앞에 push
                         json_data2.unshift(json_data[0]);

                     }


                     

                     gridView[1].setRowStyleCallback(function(grid, item, fixed) {
                         var ret = {};
                         var color = grid.getValue(item.index, "CHK_ITEM_NM2");
                         var color2 = grid.getValue(item.index, "CHK_ITEM_NM1");

                         if (color == 'Sub Total' || color2 == 'TOTAL') {
                           return 'color-yellow'
                         }
                     });


                     gridView[1].layoutByColumn("CHK_ITEM_NM1").spanCallback = function (grid, layout, itemIndex) {
                         var value = grid.getValue(itemIndex, "CHK_ITEM_NM1");
                         
                         if(value == "TOTAL"){
                             return 4; //가로 병합 수
                         }
                     };
                     
                     // 그리드에 데이터 넣기
                     provider[1].fillJsonData(json_data2,{fillMode: "set"} );
                     // 그리드 progressbar 숨기기
                     $(".overlay").hide();
                   }).catch(function(e) {
                     $(".overlay").hide();
                            if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
                        })                                   
               }).catch(function(e) {
                  $(".overlay").hide();
                         if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
                     });
            } catch (e) {
               console.error(e);
            } finally {
            }
         }
         , save : function() {
            //as-is 에 저장버튼이 없음 
         }
         , callback : function(id) {
            switch (id) {
               case "MC_CD" : // 코드로 HEADER 처리용
                  LOPRDN087.search();
                  initFlag = true;
               break;
            }
         }
         , excel : function() {
               var arrGrid = [];
               arrGrid.push(gridView[0]);
               excel_down(arrGrid, "${menuId}");
         }
         , getResult : function(data,gubun , temp , index) {
                 var valResult = 0;

                 for (let k = temp; k < index; k++) {
                       valResult = Number(valResult) + Number(data[k][gubun]);
                   }
                   return valResult.toFixed(2);

             }
      };
               
      LOPRDN087.init();

   });
   

</script>

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
      <a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="LLWMDN006.excel();"><span class="ico-download"></span><span class="txt">${I18['#엑셀']}</span></a>
      <a data-fc-auth="m" href="#" class="btn-ix"><span class="ico-print"></span><span class="txt">${I18['#인쇄']}</span></a>
      <a data-fc-auth="d" href="#" class="btn-ix"><span class="ico-send"></span><span class="txt">${I18['#전송']}</span></a>
      <a data-fc-auth="w" href="#" onclick="LLWMDN006.save(); return false;" class="btn-ix type1"><span class="ico-save"></span><span class="txt">${I18['#저장']}</span></a>
      <a data-fc-auth="r" href="#" onclick="LLWMDN006.search(); return false;" class="btn-ix"><span class="ico-search1"></span><span class="txt">${I18['#조회']}</span></a>
      <a href="javascript:void(0);" data-fc-auth="r" class="btn-ix" onclick="help_popup('${menuId}');"><span class="ico-help"></span><span class="txt">${I18['#도움말']}</span></a>
   </div>
</div>
<!-- //상단: title + btn -->
 
<div id="div_form_LLWMDN006" class="contPage-search searchSHWrap">
   
   <div class="border-box searchReq-box">
      <div class="searchReq-tablebox">
         <table>
            <colgroup>
               <col style="width: 5%;">
               <col style="width: 15%;">
               <col style="width: 5%;">
               <col style="width: 15%;">
               <col style="width: 5%;">
               <col style="width: 15%;">
               <col style="width: 5%;">
               <col style="width: 15%;">
            </colgroup>
            <tr>
               <th><span class="label-dot">${I18['#일자']}</span></th>
               <td>
                  <div>
                     <span style="width: calc(100% - 18px);">
                     <input type="text" class="input1 datepicker" id="wrkDate" name="wrkDate" style="width: calc(100% - 10px);">
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
                     <select id="whsCd" name="whsCd" class="select1" style="width: calc(100% - 10px);" ></select>
                  </div>
               </td>
            </tr>
            <tr>
               <th><span class="label-dot">${I18['#설비타입']}</span></th>
               <td>
                  <div style="width: calc(100% - 18px);">
                     <select id="whsMcTpCd" name="whsMcTpCd" class="select1"style="width: calc(100% - 10px);" ></select>
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
                     <select id="whsLine" name="whsLine" class="select1" style="width: calc(100% - 10px);" ></select>
                  </div>
               </td>   
               <th><span class="label-dot">${I18['#설비']}</span></th>
               <td>
                  <div style="width: calc(100% - 18px);">
                  <select id="whsMcCd" name="whsMcCd" class="select1" style="width: calc(100% - 10px);" ></select>
<!--                      <input type="text" id="whsMcCd" name="whsMcCd" class="input1" style="width: calc(100% - 10px);" /> -->
                  </div>
               </td>   
            </tr>
         </table>
      </div>
   </div>
</div>

<!-- 검색조건 박스 -->
<div class="contPage-body">
   <div class="base-list table-list">
         <div id="realgrid0" style="width: 100%; height: 50%;"></div>
         <div id="chart1" style="width: 98%; height: 50%; margin-left:20px;"  ></div>
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
var researchCnt = 0;
var flag = false;

var wrkDate = '${param.wrkDate}'; //일자 
if(wrkDate == null || wrkDate == ''){
   var today = MES_UTIL.gfn_Today();
   today = today.substring(0, 4) + "-" + today.substring(4, 6) + "-" + today.substring(6, 8);         
   $("#wrkDate").val(today);
   wrkDate = today;
}
var whsTpCd = '${param.whsTpCd}'; //창고타입
var whsCd = '${param.whsCd}'; //창고 
var whsMcTpCd = '${param.whsMcTpCd}'; //설비타입
var whsLine = '${param.whsLine}'; //라인 
var whsMcCd = '${param.whsMcCd}'; //설비
var fac_cd = '${param.fac_cd}' //공장 
var whsProcCd = '${param.whsProcCd}' //공정

var i = 0;
var maxNum = 0;
var array = [];

// var total = 0;

fields[i] = [
   {fieldName :   'RANK'                  ,dataType: "text"}, //순위 
   {fieldName :   'GB'                  ,dataType: "text"}, //코드
   {fieldName :   'TOTAL'                 ,dataType: "number"}, //건수
   {fieldName :   'ALM_RSN'                  ,dataType: "text"}, //에러내역 
   {fieldName :   'ACT_MTH_1'               ,dataType: "text"}, // Check Point
   {fieldName :   'DATA1'                  ,dataType: "number"},
   {fieldName :   'DATA2'                  ,dataType: "number"},
   {fieldName :   'DATA3'                  ,dataType: "number"},
   {fieldName :   'DATA4'                  ,dataType: "number"},
   {fieldName :   'DATA5'                  ,dataType: "number"},
   {fieldName :   'DATA6'                  ,dataType: "number"},
   {fieldName :   'DATA7'                  ,dataType: "number"},
   {fieldName :   'DATA8'                  ,dataType: "number"},
   {fieldName :   'DATA9'                  ,dataType: "number"},
   {fieldName :   'DATA10'               ,dataType: "number"},
   {fieldName :   'DATA11'               ,dataType: "number"},
   {fieldName :   'DATA12'               ,dataType: "number"},
   {fieldName :   'DATA13'               ,dataType: "number"},
   {fieldName :   'DATA14'               ,dataType: "number"},
   {fieldName :   'DATA15'               ,dataType: "number"},
   {fieldName :   'DATA16'               ,dataType: "number"},
   {fieldName :   'DATA17'               ,dataType: "number"},
   {fieldName :   'DATA18'               ,dataType: "number"},
   {fieldName :   'DATA19'               ,dataType: "number"},
   {fieldName :   'DATA20'               ,dataType: "number"},
   {fieldName :   'DATA21'               ,dataType: "number"},
   {fieldName :   'DATA22'               ,dataType: "number"},
   {fieldName :   'DATA23'               ,dataType: "number"},
   {fieldName :   'DATA24'               ,dataType: "number"}
];


//공장별로 시간대 다르게 주는 배열 생성
var arr = [];

if(pltCd == "DP" || pltCd == "KP" || pltCd == "MP" || pltCd == "TP"){
   arr = ["6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","1","2","3","4","5"];
}else if(pltCd == "CP" || pltCd == "JP" || pltCd == "HP"){
   arr = ["7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","1","2","3","4","5","6"];
}else if(pltCd == "IP"){
   arr = ["8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","1","2","3","4","5","6","7"];
}


   
columns[i] = [
        {name: 'RANK'       ,   fieldName:'RANK'    ,      type:'data',   width:40,  header:{text:'순위'}, editable:false, sortable:true } 
         , {name: 'GB'          ,   fieldName:'GB'    ,      type:'data',   width:60,  header:{text:I18('#코드')}, editable:false, sortable:true } 
         , {name: 'ALM_RSN' ,   fieldName:'ALM_RSN', type:'data',   width:240,  header:{text:I18('#에러_내역')}, editable:false, sortable:true } 
         , {name: 'ACT_MTH_1'    ,   fieldName:'ACT_MTH_1',  type:'data',   width:240,  header:'Check Point', editable:false, sortable:true,   lookupDisplay: true, editor: {type: 'dropdown', dropDownCount: 5, textReadOnly: 'true'},   styleName: 'text-align-center'   }
         , {name: 'TOTAL'       ,   fieldName:'TOTAL' ,        type:'number', width:30, header:{text:I18('#건수')}, editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right' } 
         , {name:'DATA1'         ,   fieldName:'DATA1' ,       type:'number', width:40,  header:{text:arr[0]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'  }
      , {name:'DATA2'         ,   fieldName:'DATA2' ,       type:'number', width:40,  header:{text:arr[1]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA3'         ,   fieldName:'DATA3' ,       type:'number', width:40,  header:{text:arr[2]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA4'         ,   fieldName:'DATA4' ,       type:'number', width:40,  header:{text:arr[3]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA5'         ,   fieldName:'DATA5' ,       type:'number', width:40,  header:{text:arr[4]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA6'         ,   fieldName:'DATA6' ,       type:'number', width:40,  header:{text:arr[5]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA7'         ,   fieldName:'DATA7' ,       type:'number', width:40,  header:{text:arr[6]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA8'         ,   fieldName:'DATA8' ,       type:'number', width:40,  header:{text:arr[7]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA9'         ,   fieldName:'DATA9' ,       type:'number', width:40,  header:{text:arr[8]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA10'      ,   fieldName:'DATA10',       type:'number', width:40,  header:{text:arr[9]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA11'      ,   fieldName:'DATA11',       type:'number', width:40,  header:{text:arr[10]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA12'      ,   fieldName:'DATA12',       type:'number', width:40,  header:{text:arr[11]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA13'      ,   fieldName:'DATA13',       type:'number', width:40,  header:{text:arr[12]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA14'      ,   fieldName:'DATA14',       type:'number', width:40,  header:{text:arr[13]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA15'      ,   fieldName:'DATA15',       type:'number', width:40,  header:{text:arr[14]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA16'      ,   fieldName:'DATA16',       type:'number', width:40,  header:{text:arr[15]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA17'      ,   fieldName:'DATA17',       type:'number', width:40,  header:{text:arr[16]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA18'      ,   fieldName:'DATA18',       type:'number', width:40,  header:{text:arr[17]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA19'      ,   fieldName:'DATA19',       type:'number', width:40,  header:{text:arr[18]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA20'      ,   fieldName:'DATA20',       type:'number', width:40,  header:{text:arr[19]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA21'      ,   fieldName:'DATA21',       type:'number', width:40,  header:{text:arr[20]},        editable:false, sortable:true,   numberFormat: '#,##0',  styleName: 'text-align-right'}
      , {name:'DATA22'      ,   fieldName:'DATA22',       type:'number', width:40,  header:{text:arr[21]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA23'      ,   fieldName:'DATA23',       type:'number', width:40,  header:{text:arr[22]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
      , {name:'DATA24'      ,   fieldName:'DATA24',       type:'number', width:40,  header:{text:arr[23]},        editable:false, sortable:true,   numberFormat: '#,##0',   styleName: 'text-align-right'}
];
      

layout[i] = [
       { name: 'HEAD1', direction: 'horizontal', items: ['RANK', 'GB', 'TOTAL','ALM_RSN','ACT_MTH_1'], header: {text:I18('#에러_코드')}}, //다국어처리 필요
      { name: 'HEAD2', direction: 'horizontal', 
         items: 
            [     'DATA1'                       
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
            ], 
         header: {text: ''}},
     
];


$(document).ready( function(){

   LLWMDN006 = {
      init: function() {
         this.initGrid();
         this.initCombo();
         this.initDisp();
         this.initEvent();
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
            gridView[idx].onContextMenuPopup = onContextMenuPopup;               //출력할 메뉴 설정
            gridView[idx].onContextMenuItemClicked = onContextMenuItemClicked;      //메뉴 클릭시
            gridView[idx].setColumnLayout(layout[idx]);


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
            LLWMDN006.whsTpCdSearch();
         });
         
         $("#whsTpCd").on("change", function(){
            // 콤보 창고
            LLWMDN006.codeSearch();
         });

         $("#whsCd").on("change", function(){
            //설비타입 콤보
            LLWMDN006.whsMcTpCdSearch();
         }); 

         $("#whsMcTpCd").on("change",function(){
            //공정 콤보
            LLWMDN006.whsProcCdSearch();
         });


         $("#whsProcCd").on("change",function(){
            //콤보 라인
            LLWMDN006.lineSearch();
         });
         
         $("#whsLine").on("change",function(){
            //콤보 설비
            LLWMDN006.whsMcCdSearch();
         });
         
         $("#whsMcCd").on("change",function(){
            //파라미터가 있을 때 재검색 시 검색된 파라미터가 세팅되도록 flag 처리
            researchCnt+=1;
            if(researchCnt > 1){
               flag = true;
            } 
            //콤보 콜백(파라미터 세팅 후 search)
            LLWMDN006.callback("whsMcCd"); 
         });
         
      }
      , initCombo: function() {

         // 공장
         MES_UTIL.L_gfn_GetMasCdCombo("fac_cd", "C040", "", 0, LLWMDN006.callback);

      }
      , callback: function( strSvcID  ){
         switch ( strSvcID )
         {   case "whsMcCd":
            if(MES_UTIL.gfn_TransNullToEmpty(whsMcTpCd) != ''){
               if(!flag){
               $("#wrkDate").val(wrkDate);
               $("#whsTpCd").val(whsTpCd);
               $("#whsCd").val(whsCd);
               $("#whsMcTpCd").val(whsMcTpCd);
               $("#whsLine").val(whsLine);
               $("#whsMcCd").val(whsMcCd); 
               $("#fac_cd").val(fac_cd); 
               $("#whsProcCd").val(whsProcCd); 
                }
            }
            LLWMDN006.search();
            break;
         }
      }       

              
      , search: function(combo) {
         //그리드 데이터 초기화 처리 .
         dataProvider[0].clearRows();

         $("#chart1").empty();

         $(".overlay").show();

           //header에 날짜 바꿔주기 
           var headerTxt = gridView[0].layoutByName("HEAD2").header.text = $("#wrkDate").val();
           gridView[0].layoutByName("HEAD2").header.text = headerTxt;

         try {
            var searchCond = {
                  "PLT_CD": pltCd,
                  "DATE_DT": $("#wrkDate").val().replace(/\-/g, ""),
                  "FAC_CD": $("#fac_cd").val(),
                  "WHS_TP_CD": $("#whsTpCd").val(),
                  "WHS_CD": $("#whsCd").val(),
                  "WHS_MC_TP_CD": $("#whsMcTpCd").val(),
                  "WHS_PROC_CD": $("#whsProcCd").val(),
                  "WHS_LINE": $("#whsLine").val(),
                  "WHS_MC_CD" : $("#whsMcCd").val()
               }

            var uri = "/api/LLWMDN006/search";
            

            HTGF.Api.get(uri, searchCond).then( function(resData) {
               $(".overlay").hide();


               if(resData.result.length > 0){

               chart(resData.result);   // 차트
               
               dataProvider[0].fillJsonData(resData.result,{fillMode: "set"} );
               
               FOOTER.setTimer(resData.timer);
               }
               

               
            }).catch(function(e) {
                   $(".overlay").hide();
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
//                      option += "<option value=></option>"
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
//                      option += "<option value=></option>"
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
      // 설비 콤보
      , whsMcCdSearch : function () {
         var option = '<option value="">&nbsp;</option>';
         $("#whsMcCd").empty();
         try {
            var whs_cd = $("#whsCd").val();
            var whs_mc_tp_cd = $("#whsMcTpCd").val();
            var whs_proc = $("#whsProcCd").val();
            var whs_line = $("#whsLine").val();


            var searchCond = { "PLT_CD" : pltCd
                          ,"whs_cd" : whs_cd
                          ,"whs_mc_tp_cd" : whs_mc_tp_cd
                          ,"whs_proc" : whs_proc  
                          ,"whs_line" : whs_line }

            var uri = "/api/LLWMDN001/COMBO_MC";
            
            HTGF.Api.get(uri, searchCond).then( function(resData) {
               for(let i = 0; i< resData.result.length; i++){
                  if( i == 0){   
                     option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
                  }else{
                      option += "<option value="+resData.result[i].CD_ITEM+">"+resData.result[i].CD_ITEM_NM+"</option>"
                        
                  }
                   $('#whsMcCd').html(option);
               }
               
               $("#whsMcCd").trigger('change'); 

            }).catch(function(e) {
                  if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
            });
         } catch (e) {
            console.error(e);
         } finally {
         } 
      }

   };

   LLWMDN006.init();

});


var chart = function(data){

   var chartArray = [];
   var series = [];
   for(let i = 0; i < data.length; i++){
      var object =  Object.keys(data[i]);
      var arrayList = [];

      for(let k = 0; k< object.length ; k ++){
         if(object[k].substring(0, 4) =="DATA"){
            arrayList[arrayList.length] = {'date' : Number(arr[(object[k].substring(4, 6)-1)]) , "val" : data[i][object[k]] , 'sort' : Number(object[k].substring(4))};
         }
      }

      // 배열정렬
      arrayList.sort(function (a, b) {
           if (a.sort > b.sort) {
             return 1;
           }
           if (a.sort < b.sort) {
             return -1;
           }
           return 0;
      });
      /* arrayList.sort((a, b) => a.date - b.date); */
      array.push(arrayList);

      
      chartArray[i] = arrayList;
      series[i] = {data : chartArray[i], type: 'line',xKey: 'sort', yKey: 'val' , yName :data[i]["GB"]
            ,label: {
               formatter: ({ value }) => value.toFixed(0),
            }
            ,tooltip : {renderer : tooltipRenderer2},

      };


      
   }
   
   $("#chart1").empty();
   
   // 최대값 구하기
   maxNum = findMaxNum(array);

   // 최대값 구한 후 array 비워주기
   array.length = 0;
   
   const options = {
          container: document.getElementById('chart1'),
           autoSize: true,
          series: series,
          axes: [
             //y축
            {
               type: 'number',
               position: 'left',
               max: maxNum+1 //y축 최대치일때 숫자가 잘리는 현상 때문에 max+1 값을 y축 최대값으로 맞춰줌
            },
            //x축
            {
               type: 'category',
               position: 'bottom',
               label: {
                        formatter: ({ value }) => getxLine(value),
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

function tooltipRenderer2(params) {
   return {
      content: params.datum.date+":"+params.yValue,
      title :  params.title
   };
}

function getxLine(val){

   var val2;
   var gubun;
   val = Number(val);

   //공장별로 x축 라벨명 바뀌도록 
   if(pltCd == "DP" || pltCd == "KP" || pltCd == "MP" || pltCd == "TP"){
      val2 = val+5; //6부터 시작
      gubun = "gu1";
   }else if(pltCd == "CP" || pltCd == "JP" || pltCd == "HP"){
      val2 = val+6; //7부터 시작
      gubun = "gu2";
   }else if(pltCd == "IP"){
      val2 = val+7; //8부터 시작
      gubun = "gu3";
   }

   // 공장별로 24시 이후 시간값 다르게 부여
   if(val >= 20 && gubun == "gu1"){
     switch(val){
     case 20:
        val2 = 1;
      break;
     case 21:
        val2 = 2;
      break;
     case 22:
        val2 = 3;
      break;
     case 23:
        val2 = 4;
      break;
     case 24:
        val2 = 5;
      break;
     } 
   }else if(val >= 19 && gubun == "gu2"){
      switch(val){
        case 19:
           val2 = 1;
         break;
        case 20:
           val2 = 2;
         break;
        case 21:
           val2 = 3;
         break;
        case 22:
           val2 = 4;
         break;
        case 23:
           val2 = 5;
         break;
        case 24:
           val2 = 6;
         break;
        } 
   }else if(val >= 18 && gubun == "gu3"){
      switch(val){
        case 18:
           val2 = 1;
         break;
        case 19:
           val2 = 2;
         break;
        case 20:
           val2 = 3;
         break;
        case 21:
           val2 = 4;
         break;
        case 22:
           val2 = 5;
         break;
        case 23:
           val2 = 6;
         break;
        case 24:
           val2 = 7;
         break;
        }
   }

 return val2.toString();
}

function findMaxNum(arr) {
     
     let maxNum = arr[0][0].val;
     let length = arr.length;
     
//      console.log("maxNum >> ", maxNum);
//      console.log("length >> ", length);
     
     for (let i = 0; i < arr.length; i++) {
        for(let j = 0 ; j < arr[i].length ; j++){
          if (arr[i][j].val > maxNum) {
            maxNum = arr[i][j].val;
          }
      }
     }
//      console.log("maxNum >> ", maxNum);
     return maxNum;
   }

</script>
            
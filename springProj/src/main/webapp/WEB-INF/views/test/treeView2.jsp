<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="popup-wrap windowtype">
   <div class="popup">
      <div class="pop-head bbtype">설비조회</div>
      <div class="pop-cont">
         <div class="contPage-head flrbox">
            <div class="btnbox fr">
               <a href="javascript:void(0);" onclick="LEZHEN201_P5.send_Data();" class="btn-ix"><span class=""></span><span class="txt">${I18['#선택']}</span></a>
            </div>
         </div>
         <div class="contPage-body">
            <div class="base-list table-list">
               <div id="realgrid0" style="width: 100%; height: 350px;"></div>
            </div>
         </div>
      </div>
      <a href="#" class="close" onclick="LEZHEN201_P5.popupClose(); return false;">close</a>
   </div>
</div>

<script type="text/javascript">

var provider = [];
var gridView = [];
var fields = [];
var columns = [];
var layout = [];

var start_step_mcNo = "";
var start_step_mcNm = "";

fields[0] = [
   {fieldName:'DESCRIPTION', dataType:'text'}
   ,{fieldName:'EQUIP_NO', dataType:'text'}
   ,{fieldName:'KEY1', dataType:'text'}
   ,{fieldName:'KEY2', dataType:'text'}
   ,{fieldName:'EQ_LEVEL', dataType:'text'}
   ,{fieldName:'PPARENT_NO', dataType:'text'}
   ,{fieldName:'CHILD_CNT', dataType:'text'}
   ,{fieldName:'LOC_INFO', dataType:'text'}
   ,{fieldName:'HASCHILD', dataType:'number'}

   ,{fieldName:'EQ_TYPE_DESC' , dataType:'text'}     
    ,{fieldName:'EQ_TYPE'      , dataType:'text'}     
    ,{fieldName:'DEPT_NO'      , dataType:'text'}     
    ,{fieldName:'DEPT_NM'      , dataType:'text'}     
    ,{fieldName:'MANEGER_BY'   , dataType:'text'}     
    ,{fieldName:'MANEGER_NAME' , dataType:'text'}     
    ,{fieldName:'UNIT_NO' , dataType:'text'}     
   
];
columns[0] = [
    {name:'DESCRIPTION'   , fieldName:'DESCRIPTION'   , type:'data', width:250,   header:{text:I18('#설비명_EZH')}, editable:false, sortable:true, styleName:'text-align-left'}
    ,{name:'EQUIP_NO'      , fieldName:'EQUIP_NO'      , type:'data', width:50,  editable:false, sortable:true, styleName:'text-align-left'}
   ,{name:'KEY1'         , fieldName:'KEY1'         , type:'data', width:50,  editable:false, sortable:true, styleName:'text-align-left'}
   ,{name:'KEY2'         , fieldName:'KEY2'         , type:'data', width:50,  editable:false, sortable:true, styleName:'text-align-left'}
   ,{name:'EQ_LEVEL'      , fieldName:'EQ_LEVEL'      , type:'data', width:50,  editable:false, sortable:true, styleName:'text-align-left'}
   ,{name:'PPARENT_NO'      , fieldName:'PPARENT_NO'   , type:'data', width:50,  editable:false, sortable:true, styleName:'text-align-left'}
   ,{name:'CHILD_CNT'      , fieldName:'CHILD_CNT'      , type:'data', width:50,  editable:false, sortable:true, styleName:'text-align-left'}
   ,{name:'LOC_INFO'      , fieldName:'LOC_INFO'      , type:'data', width:50,  editable:false, sortable:true, styleName:'text-align-left'}
   ,{name:'HASCHILD'      , fieldName:'HASCHILD'      , type:'data', width:50,  editable:false, sortable:true, styleName:'text-align-left'} 
];
layout[0] = [
   'DESCRIPTION'
];


var tabIdx = 0;
var tabClear = null;
var v_SPEC_FG = '${SpecFg}';
var v_SPEC_cd = '${SpecSz}';
var v_EQUIP_NO = '${param.EQUIP_NO}';
var v_MC_NM = '${param.MC_NM}';
var v_MC_NO = '${param.MC_NO}';
var v_p_menu = '${open_name}';
var v_gridYn = '${param.GRIDYN}';
var v_grididx = '${param.GRIDIDX}';
var v_griditemidx = '${param.GRIDITEMIDX}';

var v_EQ_TYPE_DESC = '${param.EQ_TYPE_DESC}';
var v_EQ_TYPE      = '${param.EQ_TYPE}';
var v_DEPT_NO      = '${param.DEPT_NO}';
var v_DEPT_NM      = '${param.DEPT_NM}';
var v_MANEGER_BY   = '${param.MANEGER_BY}';
var v_MANEGER_NAME = '${param.MANEGER_NAME}';
var v_UNIT_NO       = '${param.UNIT_NO}';



var setDs = []; 

var setDsCnt  = 0;  
var set_row = 0;

var EQUIP_NO = "";
var EQ_LEVEL = "";
var MC_NM = "";
var LOC_INFO = "";
var MC_NO = "";
var HASCHILD = "";

var EQ_TYPE_DESC = "";
var EQ_TYPE      = "";
var DEPT_NO      = "";
var DEPT_NM      = "";
var MANEGER_BY   = "";
var MANEGER_NAME = "";
var UNIT_NO     = "";


$(function() {
   
   LEZHEN201_P5 = {
      init : function() {
         this.initGrid();
         this.initEvent();
         this.initCombo();
         this.initDisp();
         LEZHEN201_P5.search();
         
      }
      
      , initGrid : function() {
         for (var idx = 0; idx < 1; idx++) {
            provider[idx] = new RealGrid.LocalTreeDataProvider();
            gridView[idx] = new RealGrid.TreeView("realgrid" + idx);
            provider[idx].setFields(fields[idx]);
            gridView[idx].setDataSource(provider[idx]);
            setDefaultGrid(gridView[idx]);
            gridView[idx].headerSummaries.visible = false;
            gridView[idx].setRowIndicator({visible: false});
            gridView[idx].setStateBar({visible: false});
            gridView[idx].setCheckBar({visible: false});
            gridView[idx].setFooters({visible: false});
            gridView[idx].displayOptions.columnMovable = false;
            gridView[idx].displayOptions.selectionStyle = 'rows';
            gridView[idx].displayOptions.fitStyle = 'fill';
            gridView[idx].setColumns(columns[idx]);
            gridView[idx].setColumnLayout(layout[idx]); 
            gridView[idx].setEditOptions({editable: false});
            gridView[idx].onCellDblClicked = this.onCellDblClicked;
            gridView[idx].onCellClicked = this.onCellClicked;
            gridView[idx].onCopy = this.onCopy;
            gridView[idx].onTreeItemExpanding = this.onTreeItemExpanding;
            gridView[idx].sortMode = "explicit";
            gridView[idx].onContextMenuPopup = onContextMenuPopup;               //출력할 메뉴 설정
            gridView[idx].onContextMenuItemClicked = onContextMenuItemClicked;      //메뉴 클릭시
         }
      }
      ,  onTreeItemExpanding : function (tree, itemIndex, rowId) {
          // false를 리턴하면 펼쳐지지 않는다.
          // return false;
          // expanding 중인 행이 자식이 하나도 없다면 hasChildren이 설정된 행이다.
          // 자식들을 가져와 그 행에 추가한다.
          if (provider[0].getChildCount(rowId) <= 0) {
            //펼치려는 행의 키 값을 가져와서 db에서 해당 행의 자식들을 가져온 후 addChildRow()를 사용해서 추가한다.
            //var key = treeProivder.getValue(rowId, "treeId");
            var mcCd = provider[0].getValue(rowId , "EQUIP_NO");

            var data = new Object();
            data.MC_CD = mcCd;
            HTGF.Api.get('/api/LEZHEN101/P1_mc_search', data).then(function(resData) {
               //step 체크를위한 변수
               var rowCount = 0;
               if(resData.result.length > 0){
                  resData.result.forEach(function(el) {
                        var bool_child = el.HASCHILD == 1 ? true : false;
                          var childId = provider[0].addChildRow(rowId, el, el.iconField, bool_child);
                          rowCount++;
                          if(setDs.length > 0 && setDsCnt >= 0){
                             if(el.EQUIP_NO == setDs[setDsCnt]){
                                set_row += rowCount;
                                setDsCnt = setDsCnt - 1; 
                             };
                          }
                        }) 
               }
                gridView[tabIdx].expand(set_row, false, false);
               
               
               $(".overlay").hide();
            }).catch(function(e) {
                if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
            })
            
           
          }

          return true;
        }
      , onCellDblClicked : function(grid, clickData) {
          var rowData = grid.getValues(clickData.itemIndex);
         var fieldName = clickData.fieldName;
         EQUIP_NO = rowData["EQUIP_NO"];
         EQ_LEVEL = rowData["EQ_LEVEL"];
         MC_NM = rowData["KEY1"];
         LOC_INFO = rowData["LOC_INFO"];
         MC_NO = rowData["KEY2"];
         HASCHILD = rowData["HASCHILD"];
         
         EQ_TYPE_DESC = rowData["EQ_TYPE_DESC"];
         EQ_TYPE      = rowData["EQ_TYPE"];
         DEPT_NO      = rowData["DEPT_NO"];
         DEPT_NM      = rowData["DEPT_NM"];
         MANEGER_BY   = rowData["MANEGER_BY"];
         MANEGER_NAME = rowData["MANEGER_NAME"];
         UNIT_NO = rowData["UNIT_NO"];

         if(v_gridYn == 'Y') {
            if(!MES_UTIL.isNull(v_MC_NO))
               opener.gridView[v_grididx].setValue(v_griditemidx, v_MC_NO, MC_NO);
            
            if(!MES_UTIL.isNull(v_MC_NM))
               opener.gridView[v_grididx].setValue(v_griditemidx, v_MC_NM, MC_NM);
            
            if(!MES_UTIL.isNull(v_EQUIP_NO))
               opener.gridView[v_grididx].setValue(v_griditemidx, v_EQUIP_NO, EQUIP_NO);
            
            if(!MES_UTIL.isNull(v_EQ_TYPE_DESC))
               opener.gridView[v_grididx].setValue(v_griditemidx, v_EQ_TYPE_DESC, EQ_TYPE_DESC);

            if(!MES_UTIL.isNull(v_EQ_TYPE))
               opener.gridView[v_grididx].setValue(v_griditemidx, v_EQ_TYPE, EQ_TYPE);

            if(!MES_UTIL.isNull(v_DEPT_NO))
               opener.gridView[v_grididx].setValue(v_griditemidx, v_DEPT_NO, DEPT_NO);

            if(!MES_UTIL.isNull(v_DEPT_NM))
               opener.gridView[v_grididx].setValue(v_griditemidx, v_DEPT_NM, DEPT_NM);

            if(!MES_UTIL.isNull(v_MANEGER_BY))
               opener.gridView[v_grididx].setValue(v_griditemidx, v_MANEGER_BY, MANEGER_BY);

            if(!MES_UTIL.isNull(v_MANEGER_NAME))
               opener.gridView[v_grididx].setValue(v_griditemidx, v_MANEGER_NAME, MANEGER_NAME);
            
            if(!MES_UTIL.isNull(v_UNIT_NO))
               opener.gridView[v_grididx].setValue(v_griditemidx, v_UNIT_NO, UNIT_NO);

            if(opener.gridView[v_grididx].getValue(v_griditemidx, "CUD") != "C"){
               opener.gridView[v_grididx].setValue(v_griditemidx, 'CUD', 'U'); 
            }
            
         } else {
            opener.set_MC(EQUIP_NO, EQ_LEVEL , MC_NM, LOC_INFO , MC_NO);
         }
            
            /* $("#edtSpecCd", opener.document).val(SPEC_CD); */
            window.close(); 
         
      }
      ,onCellClicked : function(grid, clickData) {             
         var rowData = grid.getValues(clickData.itemIndex);
         var fieldName = clickData.fieldName;
         EQUIP_NO = rowData["EQUIP_NO"];
         EQ_LEVEL = rowData["EQ_LEVEL"];
         MC_NM = rowData["KEY1"];
         LOC_INFO = rowData["LOC_INFO"];
         MC_NO = rowData["KEY2"];
         HASCHILD = rowData["HASCHILD"];

         EQ_TYPE_DESC = rowData["EQ_TYPE_DESC"];
         EQ_TYPE      = rowData["EQ_TYPE"];
         DEPT_NO      = rowData["DEPT_NO"];
         DEPT_NM      = rowData["DEPT_NM"];
         MANEGER_BY   = rowData["MANEGER_BY"];
         MANEGER_NAME = rowData["MANEGER_NAME"];
         UNIT_NO = rowData["UNIT_NO"];
         
      }
      , part_pop : function(eq_no) {
         var url = "/LEZHEN101/LEZHEN101_P2.html";
         var arg = {EQUIP_NO : eq_no};
         
         
         arg.TABLE_NAME = "LEZHEN101";
         var name = "LEZHEN101_P2";
         var width = 400;
         var height = 500;
         popup_open(url, arg, name, width, height);
      }
      , onCopy : function(grid, selection, event) {
         MES_UTIL.copyToClipboard(grid);
      }
      
      , initEvent : function() {
         
         $('.tab-bdtype li .tag').on('click', function() {
            tabIdx = $(this).closest('li').index();
            
            // tab 클릭시 이벤트 처리
            if (tabClear !== null) {
               clearTimeout(tabClear);
            }
            
            tabClear = setTimeout(function() {
               gridView[tabIdx].resetSize();
            }, 30);
         });
         $('.tab-bdtype li:first-child .tag').trigger('click');
         
         /* $('#iptSpec').keydown(function(e) {
            if (e.keyCode == 13) {
               LEZHEN201_P5.search();
            }
         }); */
         
      }
      
      , initCombo : function() {
         
      }
      
      , callback : function(svcID, data) {
         switch(svcID) {
            case '' :
               break;
         }
      }
      
      , initDisp : function() {
         $('#tabGrid0').hide();
      }
      , search : function(){
         console.log(v_MC_NM);
         if(MES_UTIL.gfn_TransNullToEmpty(v_MC_NM) == ""){
            LEZHEN201_P5.mc_search("0");
         }else{
            start_step_mcNo = "";
            start_step_mcNm = "";
            setDs = [];               //mc_nm , mc_no
            LEZHEN201_P5.init_step(v_MC_NM , "");
            
         }
         
      }
      , mc_search : function(parent_mc) {
         $(".overlay").show();
         var data = new Object();
         data.MC_CD = parent_mc;
         console.log("mc_searh param = " , data);
         console.log("mc_searh param = " , data);
         HTGF.Api.get('/api/LEZHEN101/P1_mc_search', data).then(function(resData) {
            console.log(resData);
            provider[tabIdx].setRows(resData.result, 'DESCRIPTION', true , "HASCHILD", "iconField");
            if(setDs.length > 0){
               console.log(setDs);
               setDsCnt = setDs.length - 2;
               gridView[tabIdx].expand(0, false, false);
            }
            $(".overlay").hide();
            return resData;
            return resData;
         }).catch(function(e) {
             if (e.status !== 400) return msg_alert('${menuId}', 'Server Error', '', I18('#확인'));
         })

         
      }
      ,set_tree : function(){
         var data = new Object();
         data.MC_CD = parent_mc;
         
      }
      , init_step : function(mc_nm , mc_no){
         $(".overlay").show();
         var data = new Object();
         if(mc_no == ""){
            data.param0 = "   AND UPPER(A.DESCRIPTION) = UPPER('"+ mc_nm +"')  ";
            data.param1 = "";
         }else{
            data.param0 = "";
            data.param1 = " AND  A.EQUIP_NO = '"+ mc_no + "'  ";
         }
         console.log("1");
         console.log(mc_nm , mc_no);
         console.log("2");
         HTGF.Api.get('/api/LEZHEN101/P1_mc_tree_search', data).then(function(resData) {

            if(resData.result.length > 0){
               if(mc_no == ""){
                  //기존 MC_NO와 NM이 같을경우
                  if(MES_UTIL.gfn_TransNullToEmpty(v_MC_NO) != ""){
                        for(var i = 0 ; i < resData.result.length; i++){
                           if(v_MC_NO == resData.result[i].EQUIP_NO){
                              setDs[setDs.length] = resData.result[i].EQUIP_NO;
                              var parent_no = resData.result[i].PARENT_NO;
                              LEZHEN201_P5.init_step("" , parent_no);
                              return;
                           };
                        }         
                  }else{
                     
                     if(resData.result[0].EQ_LEVEL != "2"){
                        LEZHEN201_P5.mc_search("0");
                        return;
                     }
                  }
                  
               }
               var parent_no = resData.result[0].PARENT_NO;
               
                  console.log(resData);
                  console.log(parent_no);
               if(MES_UTIL.gfn_TransNullToEmpty(parent_no) != ""){
                  setDs[setDs.length] = resData.result[0].EQUIP_NO;
                  console.log(setDs);
                  LEZHEN201_P5.init_step("" , parent_no);
               }else{
                  setDs[setDs.length] = resData.result[0].EQUIP_NO;
                  console.log("여기도탐");
                  LEZHEN201_P5.mc_search("0");
               }
               
            }{
               if(mc_nm != ""){
                  LEZHEN201_P5.mc_search("0");
               }
            }
            
            $(".overlay").hide();
         }).catch(function(e) {
             if (e.status !== 400) return msg_alert('${menuId}', 'init_step Error', '', I18('#확인'));
         })
      }
      , popupClose : function(){
         self.close();
      }
      , send_Data : function(){
         if(EQ_LEVEL == "0" ){
            opener.set_MC("", "" , "", "" , "");
             window.close();
              return;
         }else{ 
            if(v_gridYn == 'Y') {
               if(!MES_UTIL.isNull(v_MC_NO))
                  opener.gridView[v_grididx].setValue(v_griditemidx, v_MC_NO, MC_NO);
               
               if(!MES_UTIL.isNull(v_MC_NM))
                  opener.gridView[v_grididx].setValue(v_griditemidx, v_MC_NM, MC_NM);

               if(!MES_UTIL.isNull(v_EQUIP_NO))
                  opener.gridView[v_grididx].setValue(v_griditemidx, v_EQUIP_NO, EQUIP_NO);

               if(!MES_UTIL.isNull(v_EQ_TYPE_DESC))
                  opener.gridView[v_grididx].setValue(v_griditemidx, v_EQ_TYPE_DESC, EQ_TYPE_DESC);

               if(!MES_UTIL.isNull(v_EQ_TYPE))
                  opener.gridView[v_grididx].setValue(v_griditemidx, v_EQ_TYPE, EQ_TYPE);

               if(!MES_UTIL.isNull(v_DEPT_NO))
                  opener.gridView[v_grididx].setValue(v_griditemidx, v_DEPT_NO, DEPT_NO);

               if(!MES_UTIL.isNull(v_DEPT_NM))
                  opener.gridView[v_grididx].setValue(v_griditemidx, v_DEPT_NM, DEPT_NM);

               if(!MES_UTIL.isNull(v_MANEGER_BY))
                  opener.gridView[v_grididx].setValue(v_griditemidx, v_MANEGER_BY, MANEGER_BY);

               if(!MES_UTIL.isNull(v_MANEGER_NAME))
                  opener.gridView[v_grididx].setValue(v_griditemidx, v_MANEGER_NAME, MANEGER_NAME);
               
               if(!MES_UTIL.isNull(v_UNIT_NO))
                  opener.gridView[v_grididx].setValue(v_griditemidx, v_UNIT_NO, UNIT_NO);

               if(opener.gridView[v_grididx].getValue(v_griditemidx, "CUD") != "C"){
                  opener.gridView[v_grididx].setValue(v_griditemidx, 'CUD', 'U'); 
               }
               
            } else {
               opener.set_MC(EQUIP_NO, EQ_LEVEL , MC_NM, LOC_INFO , MC_NO);
            }
            window.close();
         };
      }
      
      
   };
   
   LEZHEN201_P5.init();
});
function setParts(eq_position, description){
   console.log("eq_position = " , eq_position,"description = " , description, "EQUIP_NO = " ,EQUIP_NO,"EQ_LEVEL = " , EQ_LEVEL ,"MC_NM = " , MC_NM,"LOC_INFO = " , LOC_INFO ,"MC_NO = " , MC_NO);
   opener.set_MC(EQUIP_NO, EQ_LEVEL , MC_NM, LOC_INFO , MC_NO);
   
   opener.set_dtl_Parts(eq_position, description);
   
   window.close(); 
   
}
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />

	<!-- 제이쿼리 파일 import -->
	<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>

    <!-- iFrame -->
    <link href="/resources/styles/iframe.css" rel="stylesheet" />
    

    <!-- RealGrid -->
    <link href="/resources/realgrid_demo/latest/realgrid-style.css" rel="stylesheet" />
    <script src="/resources/realgrid_demo/latest/realgrid-lic.js"></script>
    <script src="/resources/realgrid_demo/latest/realgrid.min.js"></script>
    <script src="/resources/realgrid_demo/latest/libs/jszip.min.js"></script>

    <!-- Custom -->
    <link href="/resources/index.css" rel="stylesheet" />
    <script src="/resources/index.js"></script>
  </head>

  <body>
    <div class="popup-wrap windowtype">
	   <div class="popup">
	      <div class="pop-head bbtype">설비조회</div>
	      <div class="pop-cont">
	         <div class="contPage-head flrbox">
	            <div class="btnbox fr">
	               <a href="javascript:void(0);" onclick="BOOKMARK_COPY.send_Data();" class="btn-ix"><span class=""></span><span class="txt">선택</span></a>
	            </div>
	         </div>
	         
	         
	      </div>
	      <a href="#" class="close" onclick="BOOKMARK_COPY.popupClose(); return false;">close</a>
	   </div>
	   <div class="col center-btn" style="width :100%">
             <button type="button" onclick="BOOKMARK_COPY.copy();">복사하기</button>
      </div>
    		<div class="contPage-body">
	        <div class="base-list table-list">
	           <div id="realgrid0" style="width: 50%; height: 350px; float: left"></div>
	        </div>
	     </div>
	     
	     
	     
	     <div class="contPage-body">
	        <div class="base-list table-list">
	           <div id="realgrid1" style="width: 50%; height: 350px; float: left" ></div>
	        </div>
	     </div>
	</div>

  </body>
</html>

<style>
.alternate-row {
  background: #f8f8f8;
}

.blue-column {
  color: blue;
}

#actions {
  height: 50px;
}

#realgrid {
  width: 100%;
  height: 450px; /* for WebKit */
}

.right-column {
  text-align: right;
}

.left-column {
  text-align: left;
}

.cursor {
  cursor: crosshair;
}

.orange-color{
  background: #ff8b00;
}
</style>
<script>
var provider = [];
var gridView = [];
var fields = [];
var columns = [];
var layout = [];


fields[0] = [
	  {fieldName:"MENU_NAME", dataType:"text"},
	  {fieldName:"MENU_ID", dataType:"text"},
	  {fieldName:"FOLDER_YN", dataType:"text"},
	  {fieldName:"DEPTH", dataType:"text"},
	  {fieldName:"ID", dataType:"text"},
	  {fieldName:"P_ID", dataType:"text"},
	  {fieldName:"PATH", dataType:"text"},
	]

columns[0] = [
	  {fieldName:"MENU_NAME", name:"MENU_NAME", width: 150, header:{text:"메뉴이름"}},
	  {fieldName:"MENU_ID", name:"MENU_ID", width: 50, header:{text:"메뉴아이디"}},
	  {fieldName:"ID", name:"P_ID", width: 50, header:{text:"아이디"}},
	  {fieldName:"P_ID", name:"P_ID", width: 50, header:{text:"부모아이디"}},
	  {fieldName:"DEPTH", name:"DEPTH", width: 50, header:{text:"DEPTH"}},
	];
	
fields[1] = [
		{fieldName:"MENU_NAME", dataType:"text"},
	  {fieldName:"MENU_ID", dataType:"text"},
	  {fieldName:"FOLDER_YN", dataType:"text"},
	  {fieldName:"DEPTH", dataType:"text"},
	  {fieldName:"ID", dataType:"text"},
	  {fieldName:"P_ID", dataType:"text"},
	  {fieldName:"PATH", dataType:"text"},
	  {fieldName:"SEQ", dataType:"text"},
	]

columns[1] = [
	  {fieldName:"MENU_NAME", name:"MENU_NAME", width: 150, header:{text:"메뉴이름"}},
	  {fieldName:"MENU_ID", name:"MENU_ID", width: 50, header:{text:"메뉴아이디"}},
	  {fieldName:"ID", name:"P_ID", width: 50, header:{text:"아이디"}},
	  {fieldName:"P_ID", name:"P_ID", width: 50, header:{text:"부모아이디"}},
	  {fieldName:"DEPTH", name:"DEPTH", width: 50, header:{text:"DEPTH"}},
	  {fieldName:"SEQ", name:"SEQ", width: 50, header:{text:"SEQ"}},
	];




var flag = true;
$(function() {
   
   BOOKMARK_COPY = {
      init : function() {
         this.initGrid();
         this.initEvent();
         this.initCombo();
         this.initDisp();
         BOOKMARK_COPY.search();
         
      }
      
      , initGrid : function() {
         for (var idx = 0; idx < 2; idx++) {
            provider[idx] = new RealGrid.LocalTreeDataProvider();
            gridView[idx] = new RealGrid.TreeView("realgrid" + idx);
            provider[idx].setFields(fields[idx]);
            gridView[idx].setDataSource(provider[idx]);
            gridView[idx].headerSummaries.visible = false;
            gridView[idx].setRowIndicator({visible: false});
            gridView[idx].setStateBar({visible: false});
            gridView[idx].setCheckBar({visible: true});
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
            gridView[idx].editOptions.movable = true;
            gridView[idx].setDataDropOptions({dropMode: 'copy'});
            gridView[idx].onItemChecked = this.onItemChecked;
            
            
         }
         
         gridView[0].onItemAllChecked = function (grid, checked) {
        	    console.log("onItemAllChecked: " + checked);
         }
         
        /*  gridView.dataDropOptions.dragCallback = (source, items, target) => {
        	    if (!(target instanceof HTMLDivElement)) {
        	        return false;
        	    }
        	    if (target.id === "div1") {
        	      return items.length > 1;
        	    }
        	    return true;
        	} */
         
      }
    
      , onCellDblClicked : function(grid, clickData) {
    	  
    	  
      }
      ,onCellClicked : function(grid, clickData) {
    	  
      }

      , initEvent : function() {
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
      }
      , search : function(){
    	 
         console.log("ㅇㄱ");
         
         let data = [
        	 {
           	    "ID": "A",
           	    "P_ID": "",
           	    "MENU_ID": "leftMenu1",
           	    "MENU_NAME": "User Folder",
           	    "PATH": "A",
           	    "FOLDER_YN" :"Y",
           	    "DEPTH" :"0"
           	  },
        	 {
           	    "ID": "B",
           	    "P_ID": "A",
           	    "MENU_ID": "leftMenu2",
           	    "MENU_NAME": "출하 모니터링",
           	    "PATH": "A.B",
           	 	"FOLDER_YN" :"N",
           	    "DEPTH" :"1"
           	  },
        	 {
           	    "ID": "C",
           	    "P_ID": "A",
           	    "MENU_ID": "leftMenu3",
           	    "MENU_NAME": "가류 D/B 사용 결과",
           	    "PATH": "A.C",
           	 	"FOLDER_YN" :"N",
           	    "DEPTH" :"1"
           	  },
        	 {
           	    "ID": "D",
           	    "P_ID": "A",
           	    "MENU_ID": "leftMenu4",
           	    "MENU_NAME": "메뉴 화면 관리",
           	    "PATH": "A.D",
           	 	"FOLDER_YN" :"N",
           	    "DEPTH" :"1"
           	  },
        	 {
           	    "ID": "E",
           	    "P_ID": "A",
           	    "MENU_ID": "leftMenu5",
           	    "MENU_NAME": "외관 검사자별 검사현황",
           	    "PATH": "A.E",
           	 	"FOLDER_YN" :"N",
           	    "DEPTH" :"1"
           	  },
        	 {
           	    "ID": "F",
           	    "P_ID": "A",
           	    "MENU_ID": "leftMenu6",
           	    "MENU_NAME": "출하 모니터링",
           	    "PATH": "A.F",
           	 	"FOLDER_YN" :"N",
           	    "DEPTH" :"1"
           	  },
        	 {
           	    "ID": "G",
           	    "P_ID": "A",
           	    "MENU_ID": "leftMenu7",
           	    "MENU_NAME": "생산속보",
           	    "PATH": "A.G",
           	 	"FOLDER_YN" :"N",
           	    "DEPTH" :"1"
           	  },
        	 {
           	    "ID": "H",
           	    "P_ID": "A",
           	    "MENU_ID": "leftMenu8",
           	    "MENU_NAME": "폴더2",
           	    "PATH": "A.H",
           	 	"FOLDER_YN" :"Y",
           	    "DEPTH" :"1"
           	  },
        	 {
           	    "ID": "I",
           	    "P_ID": "H",
           	    "MENU_ID": "leftMenu9",
           	    "MENU_NAME": "폴더2-??",
           	    "PATH": "A.H.I",
           	 	"FOLDER_YN" :"N",
           	    "DEPTH" :"2"
           	  },
        	 {
           	    "ID": "J",
           	    "P_ID": "",
           	    "MENU_ID": "leftMenu10",
           	    "MENU_NAME": "11",
           	    "PATH": "J",
           	 	"FOLDER_YN" :"Y",
           	    "DEPTH" :"0"
           	  },
        	 {
           	    "ID": "K",
           	    "P_ID": "J",
           	    "MENU_ID": "leftMenu11",
           	    "MENU_NAME": "재사용 브라더 재고 관리",
           	    "PATH": "J.K",
           	 	"FOLDER_YN" :"N",
           	    "DEPTH" :"1"
           	  }
        	
         ]

         let data2 = [
       	 	  {
           	    "ID": "EM230405-DP-0",
           	    "P_ID": "",
           	    "MENU_ID": "rightMenu1",
           	    "MENU_NAME": "최상위폴더1",
           	    "PATH": "EM2304050",
           	 	"FOLDER_YN" :"Y",
           	    "DEPTH" :"0",
           	    "SEQ"	:"0"
           	  },
       	 	  {
           	    "ID": "EM230405-DP-6",
           	    "P_ID": "EM230405-DP-0",
           	    "MENU_ID": "rightMenu1",
           	    "MENU_NAME": "메뉴1",
           	    "PATH": "EM2304050.EM2304056",
           	 	"FOLDER_YN" :"N",
           	    "DEPTH" :"1",
           	    "SEQ"	:"0"
           	  }
       	 	  ,{
           	    "ID": "??",
           	    "P_ID": "",
           	    "MENU_ID": "rightMenu2",
           	    "MENU_NAME": "최상위폴더2",
           	    "PATH": "EM2304051",
           	 	"FOLDER_YN" :"Y",
           	    "DEPTH" :"0",
           	    "SEQ"	:"0"
           	  }
       	 	  
//        	 	  ,{
//            	    "ID": "EM230405-47",
//            	    "P_ID": "EM230405-0",
//            	    "MENU_ID": "rightMenu2",
//            	    "MENU_NAME": "오른쪽첫번째 메뉴-첫번째 폴더",
//            	    "PATH": "EM230405-0.EM230405-47",
//            	 	"FOLDER_YN" :"Y",
//            	    "DEPTH" :"1",
//            	    "SEQ"	:"0"
//            	  },
//        	 	  {
//            	    "ID": "EM230405-48",
//            	    "P_ID": "EM230405-0",
//            	    "MENU_ID": "rightMenu3",
//            	    "MENU_NAME": "오른쪽첫번째 메뉴-두번째 폴더",
//            	    "PATH": "EM230405-0.EM230405-48",
//            	 	"FOLDER_YN" :"Y",
//            	    "DEPTH" :"1",
//            	    "SEQ"	:"1"
//            	  }
       	 	
       	 ]
         console.log(data);
         provider[0].setRows(data, "PATH",true, '', "");
         provider[1].setRows(data2, "PATH",true, '', "");
         
         gridView[0].expandAll();
         

      }
      , copy : function() {
          let index = gridView[1].getCurrent().dataRow-1;
          
          console.log("index >> ", index); 
          
          if(index < 0 ){
             alert("복사할 위치의 폴더를 선택해 주세요."); return;
          }
          if(provider[1].getJsonRow(index+1).FOLDER_YN  != "Y"){
             alert("복사는 폴더에만 가능합니다."); return;
          }
          
          gridView[1].expand(gridView[1].getCurrent().itemIndex,true);
          let rows = gridView[0].getCheckedRows(true);
          let folderCur;   
          let pIdArray = {};
          let createRow = BOOKMARK_COPY.createRow();
          
                
          for(let i=0; i<rows.length; i++){
             let data =  provider[0].getJsonRow(rows[i]);
             let pIdYn = false;
             let pId;
                
             if(data.DEPTH != "0"){
                for(let j = 0; j<rows.length; j++){
                   let arraydata = provider[0].getJsonRow(rows[j]);
                   if(data.P_ID == arraydata.ID && arraydata.DEPTH != "0"){
                      pIdYn = true;
                      pId = arraydata.ID;
                   }
                }
                if(!pIdYn){
                      let preID = data.ID;                                  //   ID 값 저장
                      data.P_ID = provider[1].getJsonRow(index+1).ID               //   부모아이디 바꿔주기
                      data.DEPTH = Number(provider[1].getJsonRow(index+1).DEPTH)+1;    //    상위폴더 DEPTH에 +1
                      pIdArray[data.ID+"Name"] =  "EM230405-DP-"+createRow;            //   생성할 아이디 값 
                      pIdArray[preID+"DEPTH"] =  data.DEPTH;                     //   하위폴더에서 값 가져오기 위해 배열에 DEPTH 저장
                      data.ID = "EM230405-DP-"+createRow;                        //   Id 변경해서 넣기
                      createRow = createRow+1;                              //    Id 추가됐으니까+1 
                      
                      
                      let dataRow = provider[1].addChildRow(index+1, data, 0, data.FOLDER_YN == 'Y' ? true : false); // -1은 최상위 노드
                      if(data.FOLDER_YN == 'Y'){
                         pIdArray[preID+"Row"] =  dataRow;
                         
                       }
                      // 폴더일 경우 ID를 이름으로 배열에 해당index 값을 넣기
                }else{
                      let preID = data.ID;                              //   ID 값 저장
                      data.P_ID = pIdArray[pId+"Name"];                     //   부모아이디 바꿔주기
                      data.DEPTH = Number(pIdArray[pId+"DEPTH"])+1;            //    상위폴더 DEPTH에 +1
                   pIdArray[data.ID+"Name"] =  "EM230405-DP-"+createRow;      //   생성할 아이디 값 
                      pIdArray[preID+"DEPTH"] =  data.DEPTH;                  //   하위폴더에서 값 가져오기 위해 배열에 DEPTH 저장
                      data.ID = "EM230405-DP-"+createRow;                     //   Id 변경해서 넣기
                      createRow = createRow+1;                           //    Id 추가됐으니까+1 
                      
                      
                   let dataRow = provider[1].addChildRow(pIdArray[pId+"Row"], data, 0, data.FOLDER_YN == 'Y' ? true : false); // -1은 최상위 노드
                    // 폴더일 경우 ID를 이름으로 배열에 해당index 값을 넣기
                      if(data.FOLDER_YN == 'Y'){
                       pIdArray[preID+"Row"] =  dataRow;
                         
                       }
                }
                
               
             }
          }
          console.log(pIdArray);
          
          
       }
       // id값 생성해주기
       , createRow : function(){
        let row = 0;
        let rowNum = provider[1].getRowCount();
        for(let i = 0; i< rowNum; i++){
           let rowData = provider[1].getJsonRow(i+1);
           let id = rowData.ID.split("-");
           if(row < id[2]){
              row = id[2];
           }
           
        }
          
       return Number(row)+1
       }
      
      
      
      , onItemChecked: function (grid, itemIndex, checked) {
          var dataRow = grid.getDataRow(itemIndex);
          // `this`를 통해 BOOKMARK_COPY 객체의 `checkNode` 함수 호출

    	  
    	  
    	  BOOKMARK_COPY.checkNode(grid, dataRow, checked);
          gridView[0].expand(itemIndex, true, true);


       
     },
        // checkNode 함수 (형제, 부모 노드 체크)
        checkNode: function (grid, dataRow, checked) {
          var provider = grid.getDataSource();

          // 형제 노드 체크 후 부모 노드 체크
          this.checkSiblingNode(grid, dataRow, checked);

          // 자식 노드 체크
          var desRows = provider.getDescendants(dataRow);
          if (desRows) {
            grid.checkRows(desRows, checked, false);
          }
        },
     // checkSiblingNode 함수 (형제 노드 체크)
        checkSiblingNode: function (grid, dataRow, checked) {
          console.log("start-rowId2 checkedValue: " + grid.isCheckedRow(2));
          var provider = grid.getDataSource();
          // 부모 노드
          var parent = provider.getParent(dataRow);
          // 형제 노드
          var sibling = parent == -1 ? provider.getChildren() : provider.getChildren(parent);
          console.log(sibling);
          var index = sibling.indexOf(dataRow);
          // 자기 자신은 제외
          if (index !== -1) sibling.splice(index, 1);

          if (checked) {
            for (var i in sibling) {
              var value = grid.isCheckedRow(sibling[i]);

              if (checked != value) {
                checked = false;
                break;
              }
            }
          } else {
            checked = false;
          }

          if (parent > -1) grid.checkRow(parent, checked, false, false);
          // checkBar.head 영역의 V표시 제어
          if (parent == -1) grid.setAllCheck(checked, false);
          if (parent > -1) this.checkSiblingNode(grid, parent, checked);
        }
    
      
   };
   
   BOOKMARK_COPY.init();
});

</script>

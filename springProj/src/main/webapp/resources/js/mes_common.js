var MES_UTIL = { 

	//=================================================================== MASTER
	//공통 function 호출 기능 처리  master(1)
	//  'comboFAC' , 'C040' 등 마스터 코드 조회시 처리 
	L_gfn_GetMasCdCombo : function(id , code , blank ,seq , callBack , orderby  ) {
		
		try {
			var cd_id = {mastercode:code , orderby : orderby};
			$.when(
				HTGF.Api.get('/api/codeLocal/default', cd_id).then( function(resData) {
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {
		
		}

	}
	//=================================================================== MASTER
	//공통 function 호출 기능 처리  master(1)
	//  'comboFAC' , 'C040' 등 마스터 코드 조회시 처리
	,L_gfn_GetMasCdCombo_1 : function(id , code , blank ,seq , callBack ) {

		try {
			var cd_id = {mastercode:code};
			$.when(
				HTGF.Api.get('/api/codeLocal/default', cd_id).then( function(resData) {
					MES_UTIL.drawCditemOnly(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}

	}
	//=================================================================== MASTER
	//공통 function 호출 기능 처리  master(1)
	//  'comboFAC' , 'C040' 등 마스터 코드 조회시 처리 ITEM_CD_NM , ITEM_CD_NM drawCditemnmOnly
	,L_gfn_GetMasCdCombo1_1 : function(id , code , blank ,seq , callBack ) {

		try {
			var cd_id = {mastercode:code};
			$.when(
				HTGF.Api.get('/api/codeLocal/default', cd_id).then( function(resData) {
					MES_UTIL.drawCditemnmOnly(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}

	}
	//공통 function 호출 기능 처리   master(2)
	//  'comboFAC' , 'M161','M160_GRP'  하위코드 호출시
	,L_gfn_GetMasCdCombo2 : function(id , code , subcode, blank ,seq , callBack , orderby ) {
		try {
			var cd_id = { mastercode:code , mastercodesub :subcode , orderby : orderby};
			$.when(
				HTGF.Api.get('/api/codeLocal/group1', cd_id ).then( function(resData) {
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	//공통 function 호출 기능 처리   master(2) >>> combo 바인딩용이 아닌 데이터 리턴용으로 신규 생성
	,L_gfn_GetMasCdComboDataonly : function(id , comboValue, comboCode, blank ,seq , callBack ) {
		try {
			var cd_id;
			$.when(
				HTGF.Api.get('/api/codeLocal/master001', cd_id ).then( function(resData) {
					if(blank == "BLANK"){
						comboValue.push(" ");
						comboCode.push(" ");
					}
					$.each(resData,function(index, item){
						comboValue.push(item.cditem);
						comboCode.push(item.cditemnm);
					})
				})
			).then(function (){
				callBack(id);
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	//공통 function 호출 기능 처리   master(2)
	//  'comboFAC' , 'M161','M160_GRP'  하위코드 호출시
	,L_gfn_GetMasCdCombo2_1 : function(id , code , subcode, blank ,seq , callBack , orderby ) {
		try {
			var cd_id = { mastercode:code , mastercodesub :subcode , orderby : orderby };
			$.when(
				HTGF.Api.get('/api/codeLocal/group1', cd_id ).then( function(resData) {
					MES_UTIL.drawCditemOnly(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	//공통 function 호출 기능 처리   master(3)
	//  'comboFAC' , 'M161', 'D', 'M160_GRP'  하위코드 호출시
	,L_gfn_GetMasCdCombo3 : function(id, code, code2, subcode, blank ,seq , callBack , orderby ) {
		try {
			var cd_id = { mastercode:code , mastercode2: code2, mastercodesub :subcode , orderby : orderby};
			$.when(
				HTGF.Api.get('/api/codeLocal/group2', cd_id ).then( function(resData) {
				
				console.log ( resData.length) 
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
		//공통 function 호출 기능 처리   master(3)
	//  'comboFAC' , 'M161', 'D', 'M160_GRP'  하위코드 호출시
	,L_gfn_GetMasCdCombo4 : function(id, code, code2, subcode, blank ,seq , callBack ) {
		try {
			var cd_id = { mastercode:code , mastercode2: code2, mastercodesub :subcode };
			$.when(
				HTGF.Api.get('/api/codeLocal/group5', cd_id ).then( function(resData) {
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	
	//=================================================================== MASTER
	//공통 function 호출 기능 처리  master(1) 하고 같은건데  이건   "000 - 설비전체" 이런식으로   "CD_ITEM - CD_ITEM_NM" 으로 콤보에 보여줌
	//  'comboFAC' , 'C040' 등 마스터 코드 조회시 처리 
	,L_gfn_GetMasCdCombo_Item_Item_nm : function(id , code , blank ,seq , callBack ,orderby) {  
		 
		try {
			var cd_id = {mastercode:code , orderby : orderby};
			$.when(
				HTGF.Api.get('/api/codeLocal/default', cd_id).then( function(resData) {
				
					MES_UTIL.drawItem_Itme_nm(resData ,blank,seq,id,callBack);
					
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {
		
		}

	}
	
	//공통 function 호출 기능 처리   master(2) 하고 같은건데  이건   "000 - 설비전체" 이런식으로   "CD_ITEM - CD_ITEM_NM" 으로 콤보에 보여줌
	//  'comboFAC' , 'M161', 'D'  하위코드 호출시
	,L_gfn_GetMasCdCombo2_Item_Item_nm : function(id, code, code2, blank ,seq , callBack , orderby ) {
		try {
			var cd_id = { mastercode : code , mastercodesub: code2, orderby : orderby};
			$.when(
				HTGF.Api.get('/api/codeLocal/group1', cd_id ).then( function(resData) {
					MES_UTIL.drawItem_Itme_nm(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	
	
	
	//공통 function 호출 기능 처리   master(3) 하고 같은건데  이건   "000 - 설비전체" 이런식으로   "CD_ITEM - CD_ITEM_NM" 으로 콤보에 보여줌
	//  'comboFAC' , 'M161', 'D', 'M160_GRP'  하위코드 호출시
	,L_gfn_GetMasCdCombo3_Item_Item_nm : function(id, code, code2, subcode, blank ,seq , callBack , orderby ) {
		try {
			var cd_id = { mastercode:code , mastercode2: code2, mastercodesub :subcode , orderby : orderby};
			$.when(
				HTGF.Api.get('/api/codeLocal/group2', cd_id ).then( function(resData) {
					MES_UTIL.drawItem_Itme_nm(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}

	//공통 function 호출 기능 처리   master(3) 하고 같은건데  이건   "000 - 설비전체" 이런식으로   "CD_ITEM key CD_ITEM value 로 " 으로 콤보에 보여줌
	//  'comboFAC' , 'M161', 'D', 'M160_GRP'  하위코드 호출시
	,L_gfn_GetMasCdCombo3_Item_code : function(id, code, code2, subcode, blank ,seq , callBack , orderby ) {
		try {
			var cd_id = { mastercode:code , mastercode2: code2, mastercodesub :subcode , orderby : orderby};
			$.when(
				HTGF.Api.get('/api/codeLocal/group2', cd_id ).then( function(resData) {
					MES_UTIL.drawCditemOnly(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	
	//공통 function 호출 기능 처리  com(1) 
	//  'comboFAC' , 'MASTER001'  하위코드 호출시
	,L_gfn_GetComCdCombo : function(id , blank ,seq , callBack ) {
		try {
			var cd_id ;
			$.when(
				HTGF.Api.get('/api/codeLocal/master001', cd_id ).then( function(resData) {
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	//공통 function 호출 기능 처리  com(1)
	//  'comboFAC' , 'MASTER001'  하위코드 호출시
	,L_gfn_GetComCdCombo_1 : function(id , blank ,seq , callBack ) {
		try {
			var cd_id ;
			$.when(
				HTGF.Api.get('/api/codeLocal/master001', cd_id ).then( function(resData) {
					MES_UTIL.drawCditemnmOnly(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	//공통 function 호출 기능 처리  com(2)
	//  'comboFAC' , 'MASTER002'  하위코드 호출시
	,L_gfn_GetComCdCombo2 : function(id , blank ,seq , callBack ) {
		try {
			var cd_id ;
			$.when(
				HTGF.Api.get('/api/codeLocal/master002', cd_id ).then( function(resData) {
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	
	,L_gfn_GetGridCdCombo_master0002 : function(cd_id, comboValue, comboCode, blank,callBack){
		 try {
		 	$.when(
				HTGF.Api.get('/api/codeLocal/master002', cd_id).then( function(resData) {
					if(blank == "BLANK"){
							comboValue.push(" ");
							comboCode.push(" ");
						}
						$.each(resData,function(k,v){
							comboValue.push(v.cditem);
							comboCode.push(v.cditemnm);
						})
				})
			).then(function (){
				callBack(cd_id);
			});
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}
	
	//공통 function 호출 기능 처리  com(3)  ( StxcSP0041 )
	//  'comboFAC' , 'StxcSP0041'   호출시
	,L_gfn_GetComCdCombo3 : function(id , gubun ,  blank ,seq , callBack ) {
		try {
			var cd_id ={STXC : '' ,GUBUN : gubun };
			$.when(
				HTGF.Api.get('/api/codeLocal/SP0041STXC', cd_id ).then( function(resData) {
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	
	//공통 function 호출 기능 처리  com(3)  ( SP101SPECFG )
	//  'comboFAC' , 'SP101SPECFG'   호출시
	,L_gfn_SP101SPECFG : function(id , param ,  blank ,seq , callBack ) {
		try {
			var params = param ;
			$.when(
				HTGF.Api.get('/api/codeLocal/SP101SPECFG', params ).then( function(resData) {
					MES_UTIL.drawUpper(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	
	//공통 function 호출 기능 처리  com(4)  ( SP2653SPEC )
	//  'comboFAC' , 'SP2653SPEC'   호출시
	,L_gfn_GetComCdCombo4 : function(id , param,  blank ,seq , callBack ) {
		try {
			var params = param ;
			$.when(
				HTGF.Api.get('/api/codeLocal/spec', params).then( function(resData) {
					MES_UTIL.drawUpper(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}

	//공통 function 호출 기능 처리  rr pattern001  ( RR_PATTERN001 )
	//  RR_PATTERN001 호출용 없어서 추가
	,L_gfn_GetComCdComboRRpattern001 : function(id , param,  blank ,seq , callBack ) {
		try {
			var params = param ;
			$.when(
				HTGF.Api.get('/api/codeLocal/RR_PATTERN001', params).then( function(resData) {
					MES_UTIL.drawUpper(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	
	//공통 function 호출 기능 처리  com(5)  ( COMM0010 )
	//  gfn_GetComCdCombo("YYYY_Combo", ds_YYYY, Form_1.cb_YYYY  , gv_sPltCd+"^COMM0010^Y_MIN:5,Y_MAX:0", "fn_CallBack" , "NONE", true, 5);
	//L_gfn_GetComCdCombo5('combo_GRP' , 'COMM0010^"Y_MIN":5,"Y_MAX":0' ,  'BLANK' , 0 , LCOMDN028.callback)  
	,L_gfn_GetComCdCombo5 : function(id , param,  blank ,seq , callBack , orderby) {
		try {
			var params = param.split('^');
			var url = '/api/codeLocal/' +params[0]
			var jsonStr = "{"+params[1]+"}";
			var sendParm = JSON.parse(jsonStr);
			if(orderby){
				sendParm.orderby = orderby;
			}
			
			$.when(
				HTGF.Api.get(url, sendParm).then( function(resData) {
					//console.log(" resData : " + resData );
					MES_UTIL.drawUpper(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}

	//공통 function 호출 기능 처리  com(5)  ( COMM0010 )
	// gfn_GetComCdCombo("MC_CD_Combo", ds_MC_CD, Form_1.cb_MC_CD, gv_sPltCd+"^LCOM1201^PLT_CD:"+gv_sPltCd+",PROC_CD:C,MC_FG:H,OMS_TROT:%,TNDM_TROT:%", "fn_CallBack", "BLANK", true, 0);
	// MES_UTIL.L_gfn_GetComCdCombo6('mc_cd' , 'LCOM1201^"PLT_CD":"' + PLT_CD + '","PROC_CD":"C","MC_FG":"H","OMS_TROT":"%","TNDM_TROT":"%"', 'BLANK', 1, LWRKDN320.callback);
	,L_gfn_GetComCdCombo6 : function(id , param,  blank ,seq , callBack ) {
		try {
			var params = param.split('^');
			var url = '/api/codeLocal/' +params[0]
			var jsonStr = "{"+params[1]+"}";
			var sendParm = JSON.parse(jsonStr);

			$.when(
				HTGF.Api.get(url, sendParm).then( function(resData) {
					//console.log(" resData : " + resData );
					MES_UTIL.drawUpperCdItemOnly(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}

	,draw : function (resData ,blank,seq,id,callBack){
		if ( resData.length > 0 ) {
			var vOption = '';

			if( blank == 'BLANK'){
				vOption 	+= '<option value="" >&nbsp;</option>';
				for(var i = 0;i < resData.length  ;i++){
					if( seq == i+1 ){
						vOption 	+= '<option value="' + resData[i].cditem + '" selected>' + resData[i].cditemnm + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].cditem + '">' + resData[i].cditemnm + '</option>';
					}
				}
			}else{
				for(var i = 0;i < resData.length  ;i++){
					if( seq == eval(i+1) ){
						vOption 	+= '<option value="' + resData[i].cditem + '" selected>' + resData[i].cditemnm + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].cditem + '">' + resData[i].cditemnm + '</option>';
					}
				}
			}
			// 2021.02.04 김승민 시점문제로 이전함수에서 호출 ex) L_gfn_GetComCdCombo
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			// $("#"+id).change();
		}else{
			var vOption = '<option value="">&nbsp;</option>';
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			//$("#"+id).change();
		}
	}
	,drawUpper : function (resData ,blank,seq,id,callBack){
		if ( resData.length > 0 ) {
			var vOption = '';

			if( blank == 'BLANK'){
				vOption 	+= '<option value="" >&nbsp;</option>';
			} else if (blank == 'TOTAL') {
				vOption 	+= '<option value="" >'+I18('#전체')+'</option>';
			} else if (blank == 'SELECT') {
				vOption 	+= '<option value="" >'+I18('#선택')+'</option>';
			}

			for(var i = 0;i < resData.length  ;i++){
				if( seq == eval(i+1) ){
					vOption 	+= '<option value="' + MES_UTIL.gfn_TransNullToEmpty(resData[i].CD_ITEM) + '" selected>' + MES_UTIL.gfn_TransNullToEmpty(resData[i].CD_ITEM_NM) + '</option>';
				}else{
					vOption 	+= '<option value="' + MES_UTIL.gfn_TransNullToEmpty(resData[i].CD_ITEM) + '">' + MES_UTIL.gfn_TransNullToEmpty(resData[i].CD_ITEM_NM) + '</option>';
				}
			}
			// 2021.02.04 김승민 시점문제로 이전함수에서 호출 ex) L_gfn_GetComCdCombo
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			// $("#"+id).change();
		}else{
			var vOption = '<option value="">&nbsp;</option>';
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			//$("#"+id).change();
		}
	}
	,drawCditemOnly : function (resData ,blank,seq,id,callBack){
		if ( resData.length > 0 ) {
			var vOption = '';

			if( blank == 'BLANK'){
				vOption 	+= '<option value="" >&nbsp;</option>';
				for(var i = 0;i < resData.length  ;i++){
					if( seq == i+1 ){
						vOption 	+= '<option value="' + resData[i].cditem + '" selected>' + resData[i].cditem + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].cditem + '">' + resData[i].cditem + '</option>';
					}
				}
			}else{
				for(var i = 0;i < resData.length  ;i++){
					if( seq == eval(i+1) ){
						vOption 	+= '<option value="' + resData[i].cditem + '" selected>' + resData[i].cditem + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].cditem + '">' + resData[i].cditem + '</option>';
					}
				}
			}
			// 2021.02.04 김승민 시점문제로 이전함수에서 호출 ex) L_gfn_GetComCdCombo
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			// $("#"+id).change();
		}else{
			var vOption = '<option value="">&nbsp;</option>';
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			//$("#"+id).change();
		}
	}

	,drawUpperCdItemOnly : function (resData ,blank,seq,id,callBack){
		if ( resData.length > 0 ) {
			var vOption = '';

			if( blank == 'BLANK'){
				vOption 	+= '<option value="" >&nbsp;</option>';
				for(var i = 0;i < resData.length  ;i++){
					if( seq == i+1 ){
						vOption 	+= '<option value="' + resData[i].CD_ITEM + '" selected>' + resData[i].CD_ITEM + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].CD_ITEM + '">' + resData[i].CD_ITEM + '</option>';
					}
				}
			}else{
				for(var i = 0;i < resData.length  ;i++){
					if( seq == eval(i+1) ){
						vOption 	+= '<option value="' + resData[i].CD_ITEM + '" selected>' + resData[i].CD_ITEM + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].CD_ITEM + '">' + resData[i].CD_ITEM + '</option>';
					}
				}
			}
			// 2021.02.04 김승민 시점문제로 이전함수에서 호출 ex) L_gfn_GetComCdCombo
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			// $("#"+id).change();
		}else{
			var vOption = '<option value="">&nbsp;</option>';
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			//$("#"+id).change();
		}
	}
	,drawCditemnmOnly : function (resData ,blank,seq,id,callBack){
		if ( resData.length > 0 ) {
			var vOption = '';

			if( blank == 'BLANK'){
				vOption 	+= '<option value="" >&nbsp;</option>';
				for(var i = 0;i < resData.length  ;i++){
					if( seq == i+1 ){
						vOption 	+= '<option value="' + resData[i].cditemnm + '" selected>' + resData[i].cditemnm + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].cditemnm + '">' + resData[i].cditemnm + '</option>';
					}
				}
			}else{
				for(var i = 0;i < resData.length  ;i++){
					if( seq == eval(i+1) ){
						vOption 	+= '<option value="' + resData[i].cditemnm + '" selected>' + resData[i].cditemnm + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].cditemnm + '">' + resData[i].cditemnm + '</option>';
					}
				}
			}
			// 2021.02.04 김승민 시점문제로 이전함수에서 호출 ex) L_gfn_GetComCdCombo
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			// $("#"+id).change();
		}else{
			var vOption = '<option value="">&nbsp;</option>';
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			//$("#"+id).change();
		}
	}
	,drawItem_Itme_nm : function (resData ,blank,seq,id,callBack){
		if ( resData.length > 0 ) {
			var vOption = '';

			if( blank == 'BLANK'){
				vOption 	+= '<option value="" >&nbsp;</option>';
				for(var i = 0;i < resData.length  ;i++){
					if( seq == i+1 ){
						vOption 	+= '<option value="' + resData[i].cditem + '" selected>' + resData[i].cditem + '  -  ' + resData[i].cditemnm + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].cditem + '">' + resData[i].cditem + '  -  ' + resData[i].cditemnm + '</option>';
					}
				}
			}else{
				for(var i = 0;i < resData.length  ;i++){
					if( seq == eval(i+1) ){
						vOption 	+= '<option value="' + resData[i].cditem + '" selected>' + resData[i].cditem + '  -  ' + resData[i].cditemnm + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].cditem + '">' + resData[i].cditem + '  -  ' + resData[i].cditemnm + '</option>';
					}
				}
			}
			// 2021.02.04 김승민 시점문제로 이전함수에서 호출 ex) L_gfn_GetComCdCombo
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			// $("#"+id).change();
		}else{
			var vOption = '<option value="">&nbsp;</option>';
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			//$("#"+id).change();
		}
	}

	//공통 function 호출 기능 처리
	//  'comboFAC' , 'C040' 등 마스터 코드 조회시 처리
	,L_gfn_GetMasCdRadio : function(id , code , blank ,seq , callBack ) {

		try {
			var cd_id = {mastercode:code};
			$.when(
				HTGF.Api.get('/api/codeLocal/default', cd_id).then( function(resData) {
					MES_UTIL.drawRadio(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}

	}
	//공통 function 호출 기능 처리  2
	//  'comboFAC' , 'M161','M160_GRP'  하위코드 호출시
	,L_gfn_GetMasCdRadio2 : function(id , code , subcode, blank ,seq , callBack ) {
		try {
			var cd_id = { mastercode:code , mastercodesub :subcode };
			$.when(
				HTGF.Api.get('/api/codeLocal/group1', cd_id ).then( function(resData) {
					MES_UTIL.drawRadio(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	//공통 function 호출 기능 처리  3
	//  'comboFAC' , 'MASTER001'  하위코드 호출시
	,L_gfn_GetComCdRadio : function(id , blank ,seq , callBack ) {
		try {
			var cd_id ;
			$.when(
				HTGF.Api.get('/api/codeLocal/master001', cd_id ).then( function(resData) {
					MES_UTIL.drawRadio(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	//공통 function 호출 기능 처리  3
	//  'comboFAC' , 'MASTER002'  하위코드 호출시
	,L_gfn_GetComCdRadio2 : function(id , blank ,seq , callBack ) {
		try {
			var cd_id ;
			$.when(
				HTGF.Api.get('/api/codeLocal/master002', cd_id ).then( function(resData) {
					MES_UTIL.drawRadio(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	,drawRadio : function (resData, blank, seq, id, callBack){
		if ( resData.length > 0 ) {
			var vOption = '';

			for(var i = 0; i < resData.length; i++){
				if( seq == eval(i) ){
					vOption	+= 	"<input type='radio' id='"+ id + resData[i].cditem +"' name='"+ id +"' value='"+ resData[i].cditem +"' checked >"
						+	"<label for='"+ id + resData[i].cditem +"'>"+ resData[i].cditemnm +"</label>";
				}else{
					vOption	+= 	"<input type='radio' id='"+ id + resData[i].cditem +"' name='"+ id +"' value='"+ resData[i].cditem +"' >"
						+	"<label for='"+ id + resData[i].cditem +"'>"+ resData[i].cditemnm +"</label>";
				}
			}
			// 2021.02.04 김승민 시점문제로 이전함수에서 호출 ex) L_gfn_GetComCdCombo
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			//$("#"+id).change();
		}else{
			var vOption = '<option value="">&nbsp;</option>';
			// 2021.02.04 김승민 시점문제로 이전함수에서 호출 ex) L_gfn_GetComCdCombo
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			//$("#"+id).change();
		}
	}
	,L_gfn_GetGridCdCombo : function(code, comboValue, comboCode, blank, callBack){
  		 var cd_id = {mastercode:code};
		 try {
		 	$.when(
				HTGF.Api.get('/api/codeLocal/default', cd_id).then( function(resData) {
						if(blank == "BLANK"){
							comboValue.push(" ");
							comboCode.push(" ");
						}
						$.each(resData,function(k,v){
							comboValue.push(v.cditem);
							comboCode.push(v.cditemnm);
						})
				})
			).then(function (){
				callBack(code);
			});
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}
	// CODE1 CODE2 CODE 두개일때 사용 가능 .(그리드 전용)
	,L_gfn_GetGridCdCombo2 : function(code, subcode , comboValue, comboCode, blank, callBack){
  		 var cd_id = { mastercode:code , mastercodesub :subcode };
		 try {
		 	$.when(
				HTGF.Api.get('/api/codeLocal/group1', cd_id).then( function(resData) {
						if(blank == "BLANK"){
							comboValue.push(" ");
							comboCode.push(" ");
						}
						$.each(resData,function(k,v){
							comboValue.push(v.cditem);
							comboCode.push(v.cditemnm);
						})
				})
			).then(function (){
				callBack(code);
			});
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}
	//공통 function 호출 기능 처리   master(3)  (그리드 전용)
	// CODE1 CODE2 SUBCODE 3개일때 사용 가능
	,L_gfn_GetGridCdCombo3 : function(code, code2, subcode , comboValue, comboCode, blank, callBack){
  		 var cd_id = { mastercode:code , mastercode2: code2, mastercodesub :subcode };
		 try {
		 	$.when(
				HTGF.Api.get('/api/codeLocal/group2', cd_id).then( function(resData) {
						if(blank == "BLANK"){
							comboValue.push(" ");
							comboCode.push(" ");
						}
						$.each(resData,function(k,v){
							comboValue.push(v.cditem);
							comboCode.push(v.cditemnm);
						})
				})
			).then(function (){
				callBack(code);
			});
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}
	// 메뉴, div('#div_form_' + 이름), requestMapping, ID, comboValue, comboCode, blank, callback
	// ex) MES_UTIL.L_gfn_GetCustomGridCdCombo('LQLTDN381', 'LQLTDN381', 'LQLTDN381_FIND_MC', 'mc_cd', comboValue, comboCode, 'BLANK', LQLTDN381.callback);
	// ex) MES_UTIL.L_gfn_GetCustomGridCdCombo('LQLTDN381', 'LQLTDN381_LAYER', 'LQLTDN381_LAYER_FIND_MC', 'lay_mc_cd', comboValue, comboCode, 'BLANK', LQLTDN381_LAYER.callback);
	,L_gfn_GetCustomGridCdCombo : function ( menu, div, map, id, comboValue, comboCode, blank, callBack ) {
		try {
			this.searchCond = $( '#div_form_' + div ).serializeJson();
			$.when(
				HTGF.Api.get('/api/' + menu + '/' + map , this.searchCond).then( function(resData) {
					if(blank == "BLANK"){
						comboValue.push(" ");
						comboCode.push(" ");
					}
					$.each(resData,function(index, item){
						comboValue.push(item.CD_ITEM);
						comboCode.push(item.CD_ITEM_NM);
					})
				})
			).then(function (){
				callBack(id);
			});
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}
	// 메뉴, requestMapping, arg, ID, comboValue, comboCode, blank, callback
	// ex) MES_UTIL.L_gfn_GetCustomGridCdCombo2('LQLTDN381', 'LQLTDN381_FIND_MC', arg, 'mc_cd', comboValue, comboCode, 'BLANK', LQLTDN381.callback);
	,L_gfn_GetCustomGridCdCombo2 : function ( menu, map, arg, id, comboValue, comboCode, blank, seq, callBack ) {
		 try {
			 $.when(
				 HTGF.Api.get('/api/' + menu + '/' + map, arg).then( function(resData) {
					 if(blank == "BLANK"){
						 comboValue.push(" ");
						 comboCode.push(" ");
					 }
					 $.each(resData,function(index, item){
						 comboValue.push(item.CD_ITEM);
						 comboCode.push(item.CD_ITEM_NM);
					 })
				 })
			 ).then(function (){
				 callBack(id);
			 });
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}

	// 메뉴, requestMapping, arg, ID, comboValue, comboCode, blank, callback
	// ex) MES_UTIL.L_gfn_GetCustomGridCdCombo2('LQLTDN381', 'LQLTDN381_FIND_MC', arg, 'mc_cd', comboValue, comboCode, 'BLANK', LQLTDN381.callback);
	,L_gfn_GetCustomGridCdCombo2_Item_Itme_nm : function ( menu, map, arg, id, comboValue, comboCode, blank, seq, callBack ) {
		 try {
			 $.when(
				 HTGF.Api.get('/api/' + menu + '/' + map, arg).then( function(resData) {
					 if(blank == "BLANK"){
						 comboValue.push(" ");
						 comboCode.push(" ");
					 }
					 $.each(resData,function(index, item){
						 comboValue.push(item.CD_ITEM);
						 comboCode.push(item.CD_ITEM + " - " + item.CD_ITEM_NM);
					 })
				 })
			 ).then(function (){
				 callBack(id);
			 });
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}

	// 메뉴, div('#div_form_' + 이름), requestMapping, ID, blank, seq, callback
	// ex) MES_UTIL.L_gfn_GetCustomCombo('LQLTDN381', 'LQLTDN381', 'LQLTDN381_FIND_MC', 'mc_cd', 'BLANK', 1, LQLTDN381.callback);
	// ex) MES_UTIL.L_gfn_GetCustomCombo('LQLTDN381', 'LQLTDN381_LAYER', 'LQLTDN381_LAYER_FIND_MC', 'lay_mc_cd', 'BLANK', 1, LQLTDN381_LAYER.callback);
	,L_gfn_GetCustomCombo : function ( menu, div, map, id, blank, seq, callBack ) {
		try {
			this.searchCond = $( '#div_form_' + div ).serializeJson();
			$.when(
				HTGF.Api.get('/api/' + menu + '/' + map , this.searchCond).then( function(resData) {
					MES_UTIL.drawUpper(resData, blank, seq, id, callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {
		}
	}
	,L_gfn_GetCustomComboCdItemOnly : function ( menu, div, map, id, blank, seq, callBack ) {
		try {
			this.searchCond = $( '#div_form_' + div ).serializeJson();
			$.when(
				HTGF.Api.get('/api/' + menu + '/' + map , this.searchCond).then( function(resData) {
					MES_UTIL.drawUpperCdItemOnly(resData, blank, seq, id, callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {
		}
	}
	// 메뉴, requestMapping, arg, ID, blank, seq, callback
	// ex) MES_UTIL.L_gfn_GetCustomCombo2('LQLTDN381', 'LQLTDN381_FIND_MC', arg, 'mc_cd', 'BLANK', 1, LQLTDN381.callback);
	,L_gfn_GetCustomCombo2 : function ( menu, map, arg, id, blank, seq, callBack ) {
		try {
			// this.searchCond = $( '#div_form_' + div ).serializeJson();
			$.when(
				HTGF.Api.get('/api/' + menu + '/' + map, arg).then( function(resData) {
					MES_UTIL.drawUpper(resData, blank, seq, id, callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {
		}
	}
	// 메뉴, requestMapping, arg, ID, blank, seq, callback
	// ex) MES_UTIL.L_gfn_GetCustomCombo2_Item_Item_nm('LQLTDN381', 'LQLTDN381_FIND_MC', arg, 'mc_cd', 'BLANK', 1, LQLTDN381.callback);
	,L_gfn_GetCustomCombo2_Item_Item_nm : function ( menu, map, arg, id, blank, seq, callBack ) {
		try {
			// this.searchCond = $( '#div_form_' + div ).serializeJson();
			$.when(
				HTGF.Api.get('/api/' + menu + '/' + map, arg).then( function(resData) {
					var vOption = "";
					if( blank == 'BLANK') {
						vOption += '<option value="" >&nbsp;</option>';
					}
					if ( resData.length > 0 ) {
						for(var i = 0;i < resData.length  ;i++){
							if( seq == i+1 ){
								vOption 	+= '<option value="' + resData[i].CD_ITEM + '" selected>' + resData[i].CD_ITEM_NM + '</option>';
							}else{
								vOption 	+= '<option value="' + resData[i].CD_ITEM + '">' + resData[i].CD_ITEM_NM + '</option>';
							}
						}
					}
					$("#"+ id).html(vOption);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {
		}
	}

	// 메뉴, requestMapping, arg, ID, blank, seq, callback
	// ex) MES_UTIL.L_gfn_GetCustomCombo3('LQLTDN381', 'LQLTDN381_FIND_MC', arg, 'mc_cd', 'BLANK', 1, LQLTDN381.callback);
	,L_gfn_GetCustomCombo3 : function ( menu, map, arg, id, blank, seq, callBack ) {
		try {
			// this.searchCond = $( '#div_form_' + div ).serializeJson();
			$.when(
				HTGF.Api.get('/api/' + menu + '/' + map, arg).then( function(resData) {
					var vOption = "";
					if( blank == 'BLANK') {
						vOption += '<option value="" >&nbsp;</option>';
					}
					if ( resData.length > 0 ) {
						for(var i = 0;i < resData.length  ;i++){
							if( seq == i+1 ){
								vOption 	+= '<option value="' + resData[i].CD_ITEM + '" selected>' + resData[i].CD_ITEM + '</option>';
							}else{
								vOption 	+= '<option value="' + resData[i].CD_ITEM + '">' + resData[i].CD_ITEM + '</option>';
							}
						}
					}
					$("#"+ id).html(vOption);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {
		}
	}
	//공통 function 호출 기능 처리 Global 화면용
	//gfn_GetMasCdCombo("PLT_Search", ds_PLT, Form_1.cbo_PLT, "default,HQ,C010", "fn_CallBack" , "BLANK", true, -1);
	,G_gfn_GetMasCdCombo : function(id ,pltcd, code , blank ,seq , callBack ) {

		try {
			var param = {P_PLT_CD:pltcd ,CD_ID:code};
			$.when(
				HTGF.Api.get('/api/codeGlobal/default', param).then( function(resData) {
					MES_UTIL.drawGlobal(resData,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}

	}
	// 메뉴, div('#div_form_' + 이름), requestMapping, ID, blank, seq, callback
	// ex) MES_UTIL.G_gfn_GetCustomCombo('LQLTDN381', 'LQLTDN381', 'LQLTDN381_FIND_MC', 'mc_cd', 'BLANK', 1, LQLTDN381.callback);
	// ex) MES_UTIL.G_gfn_GetCustomCombo('LQLTDN381', 'LQLTDN381_LAYER', 'LQLTDN381_LAYER_FIND_MC', 'lay_mc_cd', 'BLANK', 1, LQLTDN381_LAYER.callback);
	,G_gfn_GetCustomCombo : function ( menu, div, map, id, blank, seq, callBack ) {
		try {
			this.searchCond = $( '#div_form_' + div ).serializeJson();
			$.when(
				HTGF.Api.get('/api/' + menu + '/' + map , this.searchCond).then( function(resData) {
					var vOption = "";
					if( blank == 'BLANK') {
						vOption += '<option value="" >&nbsp;</option>';
					}
					if ( resData.length > 0 ) {
						for(var i = 0;i < resData.length  ;i++){
							if( seq == i+1 ){
								vOption 	+= '<option value="' + resData[i].CD_ITEM + '" selected>' + resData[i].CD_ITEM_NM + '</option>';
							}else{
								vOption 	+= '<option value="' + resData[i].CD_ITEM + '">' + resData[i].CD_ITEM_NM + '</option>';
							}
						}
					}
					$("#"+ id).html(vOption);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {
		}
	}
	// 메뉴, requestMapping, arg, ID, blank, seq, callback
	// ex) MES_UTIL.G_gfn_GetCustomCombo2('LQLTDN381', 'LQLTDN381_FIND_MC', arg, 'mc_cd', 'BLANK', 1, LQLTDN381.callback);
	,G_gfn_GetCustomCombo2 : function ( menu, map, arg, id, blank, seq, callBack ) {
		try {
			// this.searchCond = $( '#div_form_' + div ).serializeJson();
			$.when(
				HTGF.Api.get('/api/' + menu + '/' + map, arg).then( function(resData) {
					var vOption = "";
					if( blank == 'BLANK') {
						vOption += '<option value="" >&nbsp;</option>';
					}
					if ( resData.length > 0 ) {
						for(var i = 0;i < resData.length  ;i++){
							if( seq == i+1 ){
								vOption 	+= '<option value="' + resData[i].CD_ITEM + '" selected>' + resData[i].CD_ITEM_NM + '</option>';
							}else{
								vOption 	+= '<option value="' + resData[i].CD_ITEM + '">' + resData[i].CD_ITEM_NM + '</option>';
							}
						}
					}
					$("#"+ id).html(vOption);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {
		}
	}
	// 메뉴, div('#div_form_' + 이름), requestMapping, ID, comboValue, comboCode, blank, callback
	// ex) MES_UTIL.G_gfn_GetCustomGridCdCombo('LQLTDN381', 'LQLTDN381', 'LQLTDN381_FIND_MC', 'mc_cd', comboValue, comboCode, 'BLANK', LQLTDN381.callback);
	// ex) MES_UTIL.G_gfn_GetCustomGridCdCombo('LQLTDN381', 'LQLTDN381_LAYER', 'LQLTDN381_LAYER_FIND_MC', 'lay_mc_cd', comboValue, comboCode, 'BLANK', LQLTDN381_LAYER.callback);
	,G_gfn_GetCustomGridCdCombo : function ( menu, div, map, id, comboValue, comboCode, blank, callBack ) {
		try {
			this.searchCond = $( '#div_form_' + div ).serializeJson();
			$.when(
				HTGF.Api.get('/api/' + menu + '/' + map , this.searchCond).then( function(resData) {
					if(blank == "BLANK"){
						comboValue.push(" ");
						comboCode.push(" ");
					}
					$.each(resData,function(index, item){
						comboValue.push(item.CD_ITEM);
						comboCode.push(item.CD_ITEM_NM);
					})
				})
			).then(function (){
				callBack(id);
			});
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}
	// 메뉴, requestMapping, arg, ID, comboValue, comboCode, blank, callback
	// ex) MES_UTIL.G_gfn_GetCustomGridCdCombo2('LQLTDN381', 'LQLTDN381_FIND_MC', arg, 'mc_cd', comboValue, comboCode, 'BLANK', LQLTDN381.callback);
	,G_gfn_GetCustomGridCdCombo2 : function ( menu, map, arg, id, comboValue, comboCode, blank, seq, callBack ) {
		 try {
			 $.when(
				 HTGF.Api.get('/api/' + menu + '/' + map, arg).then( function(resData) {
					 if(blank == "BLANK"){
						 comboValue.push(" ");
						 comboCode.push(" ");
					 }
					 $.each(resData,function(index, item){
						 comboValue.push(item.CD_ITEM);
						 comboCode.push(item.CD_ITEM_NM);
					 })
				 })
			 ).then(function (){
				 callBack(id);
			 });
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}
 	,drawGlobal : function (resData,blank,seq,id,callBack){
		if ( resData.length > 0 ) {
			var vOption = '';

			if( blank == 'BLANK'){
				vOption 	+= '<option value="" >&nbsp;</option>';
				for(var i = 0;i < resData.length  ;i++){
					if( seq == i+1 ){
						vOption 	+= '<option value="' + resData[i].CD_ITEM + '" selected>' + resData[i].CD_ITEM_NM + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].CD_ITEM + '">' + resData[i].CD_ITEM_NM + '</option>';
					}
				}
			}else{
				for(var i = 0;i < resData.length  ;i++){
					if( seq == eval(i+1) ){
						vOption 	+= '<option value="' + resData[i].CD_ITEM + '" selected>' + resData[i].CD_ITEM_NM + '</option>';
					}else{
						vOption 	+= '<option value="' + resData[i].CD_ITEM + '">' + resData[i].CD_ITEM_NM + '</option>';
					}
				}
			}
			// 2021.02.04 김승민 시점문제로 이전함수에서 호출 ex) L_gfn_GetComCdCombo
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			//$("#"+id).change();
		}else{
			var vOption = '<option value="">&nbsp;</option>';
			// $("#"+id).trigger('change');
			$("#"+id).html(vOption);
			//$("#"+id).change();
		}
	}
	//orderby 입력시 정렬을 원하는 컬럽명을 써서 정렬
	,G_gfn_GetGridCdCombo : function(pltcd , code, comboValue, comboCode, blank, callBack, orderby){
  		 var param = {P_PLT_CD :pltcd , CD_ID:code, orderby : orderby};
		 try {
		 	$.when(
				HTGF.Api.get('/api/codeGlobal/default', param).then( function(resData) {
						if(blank == "BLANK"){
							comboValue.push(" ");
							comboCode.push(" ");
						}
						$.each(resData,function(k,v){
							comboValue.push(v.CD_ITEM);
							comboCode.push(v.CD_ITEM_NM);
						})
				})
			).then(function (){
				callBack(code);
			});
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}
	
	,G_gfn_GetGridCdCombo2 : function(pltcd , code1 , code2 , comboValue, comboCode, blank, callBack){
  		 var param = {PLT_CD :pltcd , CD_ID:code1 , CD_ITEM:code2 };
		 try {
		 	$.when(
				HTGF.Api.get('/api/codeGlobal/group1', param).then( function(resData) {
						if(blank == "BLANK"){
							comboValue.push(" ");
							comboCode.push(" ");
						}
						$.each(resData,function(k,v){
							comboValue.push(v.CD_ITEM);
							comboCode.push(v.CD_ITEM_NM);
						})
				})
			).then(function (){
				callBack(code1);
			});
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
	}
	
	//================================================================================================== SCRIPT 
	,getStrFormatDate: function(strDate) {
		 var year = strDate.substring(0, 4);
		 var month = strDate.substring(4, 6);
		 var date = strDate.substring(6, 8);
		 
		 return [year, month, date].join('-');
	}
	,getStrFormatDateTime: function(strDate) {
		 var year = strDate.substring(0, 4);
		 var month = strDate.substring(4, 6);
		 var date = strDate.substring(6, 8);

		 var hour = strDate.substring(8, 10);
		 var min = strDate.substring(10, 12);
		 var sec = strDate.substring(12, 14);

		 return [year, month, date].join('-') + " " + [hour, min, sec].join(':');
	}
	,leadingZeros : function( n , digits){
			var zero = '';
		  n = n.toString();
		
		  if (n.length < digits) {
		    for (i = 0; i < digits - n.length; i++)
		      zero += '0';
		  }
		  return zero + n;
	}
	,getTimeStampAddSec :function(tempDate, sec){
		var d = new Date(tempDate.substr(0,4)+'/'+tempDate.substr(4,2)+'/'+tempDate.substr(6,2)+' '+tempDate.substr(8,2)+':'+tempDate.substr(10,2)+':'+tempDate.substr(12,2));
		    d.setSeconds(Number(d.getSeconds()) + Number(sec));
		var s =
		    MES_UTIL.leadingZeros(d.getFullYear(), 4) +
		    MES_UTIL.leadingZeros(d.getMonth()+1, 2) +
		    MES_UTIL.leadingZeros(d.getDate(), 2) +
		    MES_UTIL.leadingZeros(d.getHours(), 2) +
		    MES_UTIL.leadingZeros(d.getMinutes(), 2) +
		    MES_UTIL.leadingZeros(d.getSeconds(), 2);
		  return s;
	}
	,getTimeStampAddMin :function(tempDate, min){
		var d = new Date(tempDate.substr(0,4)+'/'+tempDate.substr(4,2)+'/'+tempDate.substr(6,2)+' '+tempDate.substr(8,2)+':'+tempDate.substr(10,2)+':'+tempDate.substr(12,2));
		    d.setMinutes(Number(d.getMinutes()) + Number(min));
		var s =
		    MES_UTIL.leadingZeros(d.getFullYear(), 4) +
		    MES_UTIL.leadingZeros(d.getMonth()+1, 2) +
		    MES_UTIL.leadingZeros(d.getDate(), 2) +
		    MES_UTIL.leadingZeros(d.getHours(), 2) +
		    MES_UTIL.leadingZeros(d.getMinutes(), 2) +
		    MES_UTIL.leadingZeros(d.getSeconds(), 2);
		  return s;
	}
	,getTimeStampAddHour :function(tempDate, hour){
		var d = new Date(tempDate.substr(0,4)+'/'+tempDate.substr(4,2)+'/'+tempDate.substr(6,2)+' '+tempDate.substr(8,2)+':'+tempDate.substr(10,2)+':'+tempDate.substr(12,2));
		    d.setHours(Number(d.getHours()) + Number(hour));
		var s =
		    MES_UTIL.leadingZeros(d.getFullYear(), 4) +
		    MES_UTIL.leadingZeros(d.getMonth()+1, 2) +
		    MES_UTIL.leadingZeros(d.getDate(), 2) +
		    MES_UTIL.leadingZeros(d.getHours(), 2) +
		    MES_UTIL.leadingZeros(d.getMinutes(), 2) +
		    MES_UTIL.leadingZeros(d.getSeconds(), 2);
		  return s;
	}
	,getFormatDate : function(date, affix=''){
		var year = date.getFullYear();			  //yyyy
		var month = (1 + date.getMonth());		  //M
		month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
		var day = date.getDate();				   //d
		day = day >= 10 ? day : '0' + day;		  //day 두자리로 저장
		return  [year, month, day].join(affix); // affix(접사)가 없으면 공백으로 연결
	}
	
	, getHanta : function(id, callBack) {
		var param = "";
		var hantartn = "";
		$.when(
			HTGF.Api.get('/api/hantaLocal/hanta', param).then(function(resData) {
				// console.log('callback!!' + resData.HANTA);
				hantartn = resData.HANTA;
			})
		).then(function() {
			callBack(id , hantartn);
		});
	}
	
	, nvl : function(pStr) {
		return this.nvl2(pStr, '');
	}
	, nvl2 : function(pStr, pDefault) {
		var vResult = '';
		if (pStr == undefined || pStr == null || pStr == '') {
			if (pDefault == undefined || pDefault == null) {
				vResult = '';
			} else {
				vResult = pDefault;
			}
		} else {
			vResult = pStr;
		}
		return vResult;
	}
	, isNull : function (sValue){
		var v_ChkStr = new String(sValue);
		
		if (sValue == undefined) return true;
		if (new String(sValue).valueOf() == "undefined") return true;
		if (sValue == null) return true;
		if (sValue == "null") return true;
	   	if( ("x"+sValue == "xNaN") && ( new String(sValue.length).valueOf() == "undefined" ) ) return true;
		if (v_ChkStr == null) return true;
		if (v_ChkStr.toString().length == 0 ) return true;
		return false;
	}
	, allTrim : function (strText){
		var tStr = new String(strText);
		var tReturnStr="";
		var i;
	
		if ( strText != null ) {
			for ( var i = 0; i < tStr.length; i++ ) {
				if ( tStr.charAt(i) != " " ) {
					tReturnStr = tReturnStr + tStr.charAt(i);
				}
			}
		} else {
			return -1;
		}
		
		return tReturnStr;
	}
	
	,gfn_IsNull : function(sValue){
		var v_ChkStr = new String(sValue);

		if (sValue == undefined) return true;
		if (new String(sValue).valueOf() == "undefined") return true;
		if (sValue == null) return true;
		if (sValue == "null") return true;
	   	if( ("x"+sValue == "xNaN") && ( new String(sValue.length).valueOf() == "undefined" ) ) return true;
		if (v_ChkStr == null) return true;
		if (v_ChkStr.toString().length == 0 ) return true;

		return false;
	}
	,gfn_Right : function (sOrg, nSize){
		if( MES_UTIL.gfn_IsNull(sOrg) || MES_UTIL.gfn_IsNull(nSize) )		return "";
		
		if( sOrg.length < nSize )
			return sOrg;
		else
			return sOrg.substr(sOrg.length-nSize, nSize);
	}
	,gfn_Today : function (){
		var sToday = "";
		var objDate = new Date();
			objDate = new Date(Date.UTC(objDate.getFullYear(),objDate.getMonth(),objDate.getDate()));
			
			sToday  = objDate.getUTCFullYear().toString();
			sToday += MES_UTIL.gfn_Right("0" + (objDate.getUTCMonth() + 1), 2);
			sToday += MES_UTIL.gfn_Right("0" + objDate.getUTCDate(), 2);
		return sToday;
	}
	,gfn_TodayTime : function(){
		var strToday = "";
		var objDate = new Date();
		var sToday  = objDate.getFullYear().toString();
		sToday += MES_UTIL.gfn_Right("0" + (objDate.getMonth() + 1), 2);
		sToday += MES_UTIL.gfn_Right("0" + objDate.getDate(), 2);
		sToday += MES_UTIL.gfn_Right("0" + objDate.getHours(), 2);
		sToday += MES_UTIL.gfn_Right("0" + objDate.getMinutes(), 2);
		sToday += MES_UTIL.gfn_Right("0" + objDate.getSeconds(), 2);
		
		if(pltCd == "TP"){
			objDate = new Date(Date.UTC(objDate.getFullYear(),objDate.getMonth(),objDate.getDate(),objDate.getHours(),objDate.getMinutes(),objDate.getSeconds()));
			sToday  = objDate.getUTCFullYear().toString();
			sToday += MES_UTIL.gfn_Right("0" + (objDate.getUTCMonth() + 1), 2);
			sToday += MES_UTIL.gfn_Right("0" + objDate.getUTCDate(), 2);
			sToday += MES_UTIL.gfn_Right("0" + objDate.getUTCHours(), 2);
			sToday += MES_UTIL.gfn_Right("0" + objDate.getUTCMinutes(), 2);
			sToday += MES_UTIL.gfn_Right("0" + objDate.getUTCSeconds(), 2);
		}
		//strToday += objDate.getMilliseconds();
		return sToday;
	}
	, gfn_IsLeapYear: function (sDate) {
		var ret;
		var nY;
		
		if (MES_UTIL.gfn_IsNull(sDate)) {
			return false;
		}
		
		nY = parseInt(sDate.substring(0, 4), 10);
	
		if ((nY % 4) == 0) {
			if ((nY % 100) != 0 || (nY % 400) == 0) {
				ret = true;
			} else {
				ret = false;
			}
		} else {
			ret = false;
		}
		
		return ret;
	}
	, gfn_LastDateNum: function (sDate) {
		var nMonth, nLastDate;
	
		if(MES_UTIL.gfn_IsNull(sDate)) {
			return -1;
		}
		nMonth = parseInt(sDate.substr(4, 2), 10);
		if (nMonth == 1 || nMonth == 3 || nMonth == 5 || nMonth == 7  || nMonth == 8 || nMonth == 10 || nMonth == 12){
			nLastDate = 31;
		} else if( nMonth == 2 ) {
			if (MES_UTIL.gfn_IsLeapYear(sDate) == true) {
				nLastDate = 29;
			} else {
				nLastDate = 28;
			}
		} else {
			nLastDate = 30;
		}
		
		return nLastDate;
	}
	,gfn_AllTrim : function(strText){
		var tStr = new String(strText);
	    var tReturnStr="";
	    var i;
	
	    if ( strText != null ) {
	        for ( var i = 0; i < tStr.length; i++ ) {
	            if ( tStr.charAt(i) != " " ) {
	                tReturnStr = tReturnStr + tStr.charAt(i);
	            }
	        }
	    } else {
	        return -1;
	    }
	    
	    return tReturnStr;
	}
	
	,gfn_LTrim : function(sOrg, sTrim){
		var chk, pos;
	
		if( MES_UTIL.gfn_IsNull(sOrg) )			return "";
		if( MES_UTIL.gfn_IsNull(sTrim) )		sTrim = " ";
	
		for( pos = 0 ; pos < sOrg.length ; pos+=sTrim.length )
		{
			if( sOrg.substr( pos, sTrim.length ) != sTrim )
				break;
		}
		
		return sOrg.substr(pos);
	}
	
	,gfn_NVL : function(sValue, rValue){
		if( new String(sValue).valueOf() == "undefined") 
			return rValue;
		if( sValue == null )
			return rValue;
		if( sValue == "null" )
			return rValue;		
		if( ("x"+sValue == "xNaN") && ( new String(sValue.length).valueOf() == "undefined" ) )
			return rValue;
		if( sValue.length == 0 )
			return rValue;
		return sValue;
	}
	,gfn_AddDate : function(sDate, nOffset){
		if( MES_UTIL.gfn_IsNull(sDate) || MES_UTIL.gfn_IsNull(nOffset) )	return "";
	
	    var nYear = parseInt(sDate.substr(0, 4));
	    var nMonth = parseInt(sDate.substr(4, 2));
	    var nDate = parseInt(sDate.substr(6, 2)) + nOffset;
	
	    return MES_UTIL.gfn_MakeDate(nYear, nMonth, nDate);
	}
	,gfn_AddMonth : function(sDate, nOffset){
		if( MES_UTIL.gfn_IsNull(sDate) || MES_UTIL.gfn_IsNull(nOffset) )	return "";
	
	    var nYear = parseInt(sDate.substr(0, 4));
	    var nMonth = parseInt(sDate.substr(4, 2)) + nOffset;
	    var nDate = parseInt(sDate.substr(6, 2)); 
	    var nLastDate, sRet;
	    	if(nDate.toString().length==1)
			{
				nDate = "0"+nDate;
			}
	    sRet = MES_UTIL.gfn_MakeDate(nYear, nMonth, 1);
	    nLastDate = MES_UTIL.gfn_LastDateNum(sRet);
	    sRet = sRet.substr(0,6);
		    if( nDate > nLastDate )
				sRet += nLastDate.toString();
			else
				sRet += nDate.toString();
	    return sRet;
	}
	,gfn_MakeDate : function(nYear, nMonth, nDate){
		if( MES_UTIL.gfn_IsNull(nYear) || MES_UTIL.gfn_IsNull(nMonth) || MES_UTIL.gfn_IsNull(nDate) )	return "";
	
	    var objDate = new Date(Date.UTC(nYear, nMonth-1, nDate));
	    
		var sYear   = objDate.getUTCFullYear().toString();
		var sMonth  = MES_UTIL.gfn_Right("0" + (objDate.getUTCMonth() + 1), 2);
		var sDate   = MES_UTIL.gfn_Right("0" + objDate.getUTCDate(), 2);
		
		return sYear + sMonth + sDate;
	}
	, gfn_GetLastDate : function(sDate){
		var nMonth, nLastDate;
	
		if( MES_UTIL.gfn_IsNull(sDate) )		return -1;
		
		nMonth = parseInt(sDate.substr(4,2), 10);
		if( nMonth == 1 || nMonth == 3 || nMonth == 5 || nMonth == 7  || nMonth == 8 || nMonth == 10 || nMonth == 12 )
			nLastDate = 31;
		else if( nMonth == 2 )  
		{
			if( MES_UTIL.gfn_IsLeapYear(sDate) == true )
				nLastDate = 29;
			else
				nLastDate = 28;
		} 
		else 
			nLastDate = 30;

		return nLastDate;
	}
	, gfn_GetLastDayInfo: function(strDate){
		var s = "";

		if (strDate == null) {
			var date = new Date();
			s = new Date(date.getFullYear(), date.getMonth() + 1, 0);
		}
		else {
			var date = new Date(parseInt(strDate.substr(0, 4)), parseInt(strDate.substr(4, 2)) + 1, 0);
			s = (new Date(date)).getFullYear() + "-"
				+ (((new Date(date)).getMonth() + 1) + "").padStart(2, '0') + "-"
				+ ((new Date(date)).getDate() + "").padStart(2, '0');
		}
		return (s);
	}
	, gfn_GetFirstDate: function(pltCd, strDate){
		var s = "";
	
		if (strDate == null) {
			s =(new Date()).getFullYear() + "-"
				+ (((new Date()).getMonth() + 1) + "").padStart(2, '0') + "-"
				+ "01";
		}
		else {
			var date = new Date(parseInt(strDate.substr(0, 4)), parseInt(strDate.substr(4, 2)) -1, 1);
			s = (new Date(date)).getFullYear() + "-" 
				+ (((new Date(date)).getMonth() + 1) + "").padStart(2, '0') + "-" 
				+ ((new Date(date)).getDate() + "").padStart(2, '0');
			
			if (pltCd == "TP"){
				date = new Date(Date.UTC(parseInt(strDate.substr(0, 4)),parseInt(strDate.substr(4, 2)) -1, 1));
				s = (new Date(date)).getUTCFullYear() + "-"
				  + (((new Date(date)).getUTCMonth() + 1) + "").padStart(2, '0') + "-"
				  + ((new Date(date)).getUTCDate() + "").padStart(2, '0');
			}
		}
		return (s);
	}
	, gfn_GetBeforeMonth: function(strDate){
		var s = "";
		if (strDate == null) {
			s = MES_UTIL.gfn_AddMonth(MES_UTIL.gfn_Today() , -1);
		}
		else {			
			s = MES_UTIL.gfn_AddMonth(strDate , -1);
		}
		return (s);
	}
	//====================================================================================== 달력
	//공통 function -- 달력 날짜가져오기 공통 from to 달력
	,L_gfn_GetCalHanta : function( id, from ,to ,dateperiod , menu , callBack) {
		 var menu_id = { menuid : menu };
		 try {
		 	$.when(
				HTGF.Api.get('/api/hantaLocal/calhanta', menu_id ).then( function(resData) {
					if(resData.result != null){
						$("#"+from).val(resData.result.RTNDATE);
						$("#"+to).val(resData.result.RTNDATE);
						$("#"+dateperiod).val(resData.result.DATEPERIOD);
					}else{
						$("#"+from).val(MES_UTIL.getStrFormatDate(MES_UTIL.gfn_Today()));
						$("#"+to).val(MES_UTIL.getStrFormatDate(MES_UTIL.gfn_Today()));
						$("#"+dateperiod).val('31');
					}
				})
			).then(function (){
				callBack(id);
				// 2021.03.02 김승민 초기 셋팅후 change이벤트 발생되게
				$("#"+from).trigger('change');
				$("#"+to).trigger('change');
			    setDaterangepicker(dateperiod);
			});
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
 	}
 	//공통 function -- 달력 날짜가져오기 공통 single 달력
	// 
	,L_gfn_GetCalHantaSingle : function( id, cal , menu , callBack) {
		 var menu_id = { menuid : menu };
		 try {
		 	$.when(
				HTGF.Api.get('/api/hantaLocal/calhanta', menu_id ).then( function(resData) {
					$("#"+cal).val(resData.result.RTNDATE);
				})
			).then(function (){
				callBack(id);
				// 2021.03.02 김승민 초기 셋팅후 change이벤트 발생되게
				$("#"+cal).trigger('change');
			});
		 } catch (e) {
			console.error(e);
		 } finally {
			
		 }
 	}
	//공통 function -- 달력 날짜가져오기 공통 from to 달력
	,G_gfn_GetCalHanta : function( id, from ,to ,dateperiod , menu , callBack) {
		 var menu_id = { menuid : menu };
		 try {
		 	$.when(
				HTGF.Api.get('/api/hantaGlobal/calhanta', menu_id ).then( function(resData) {
					if(resData.result != null){
						$("#"+from).val(resData.result.RTNDATE);
						$("#"+to).val(resData.result.RTNDATE);
						$("#"+dateperiod).val(resData.result.DATEPERIOD);
					}else{
						$("#"+from).val(MES_UTIL.getStrFormatDate(MES_UTIL.gfn_Today()));
						$("#"+to).val(MES_UTIL.getStrFormatDate(MES_UTIL.gfn_Today()));
						$("#"+dateperiod).val('31');
					}
				})
			).then(function (){
				callBack(id);
			    // 2021.03.02 김승민 초기 셋팅후 change이벤트 발생되게
			    $("#"+from).trigger('change');
			    $("#"+to).trigger('change');
			    setDaterangepicker(dateperiod);
			});
		} catch (e) {
			console.error(e);
		} finally {
			
		}
	}
	
	//공통 function -- 달력 날짜가져오기 공통 single 달력 
	, G_gfn_GetCalHantaSingle : function( id, cal , menu , callBack) {
		 var menu_id = { menuid : menu };
		 try {
		 	$.when(
				HTGF.Api.get('/api/hantaGlobal/calhanta', menu_id ).then( function(resData) {
					$("#"+cal).val(resData.result.RTNDATE);
				})
			).then(function (){
				callBack(id);
				$("#"+cal).trigger('change');
			});
		 } catch (e) {
			console.error(e);
		 } finally {
			
		 }
	}
	//공통 function -- 달력 날짜가져오기 공통 from to 달력 startdate 1일 고정 .
	,L_gfn_GetCalHantaFirstOne : function( id, from ,to ,dateperiod , menu , callBack) {
		 var menu_id = { menuid : menu };
		 try {
		 	$.when(
				HTGF.Api.get('/api/hantaLocal/calhanta', menu_id ).then( function(resData) {
					$("#"+from).val( resData.result.RTNDATE.substr(0,resData.result.RTNDATE.length-2)+'01' );
					$("#"+to).val(resData.result.RTNDATE);
					$("#"+dateperiod).val(resData.result.DATEPERIOD);
				})
			).then(function (){
				callBack(id);
				// 2021.03.02 김승민 초기 셋팅후 change이벤트 발생되게
				$("#"+from).trigger('change');
				$("#"+to).trigger('change');
			    setDaterangepicker(dateperiod);
			});
		 } catch (e) {
			console.error(e);
		 } finally {
		 }
 	}
	//================================================================ GRID 
	, HEADER : function(grid,clickData) {
		if (clickData.cellType == 'header') {
			if (clickData.column == 'CUD') {
				grid.setEditOptions({appendable: true}); //21.08.04 choms 이렇게 안하면 키보드로 행추가 가능함.
				// 행 추가를 위한 수정내역 취소.
				grid.commit();
				// row add 
				grid.beginAppendRow();
				grid.showEditor();
				grid.setFocus();
				var curr = grid.getCurrent();
				// console.log(" Aft curr " + curr.itemIndex);
				grid.setValue(curr.itemIndex, "CUD", "C");
				grid.commit();
				grid.setEditOptions({appendable: false});
			}
		}
	}
	, ADD_ROW : function(grid) {
		grid.setEditOptions({appendable: true}); //21.08.04 choms 이렇게 안하면 키보드로 행추가 가능함.
		// 행 추가를 위한 수정내역 취소.
		grid.commit();
		// row add
		grid.beginAppendRow();
		grid.showEditor();
		grid.setFocus();
		var curr = grid.getCurrent();
		// console.log(" Aft curr " + curr.itemIndex);
		grid.setValue(curr.itemIndex, "CUD", "C");
		grid.commit();
		grid.setEditOptions({appendable: false});
	}

	,CUD : function(grid, itemIndex, dataRow, field ,dataProvider){
		var dataProvider = grid.getDataSource();
		var fieldName = dataProvider.getFieldName(field);
		var cudVal = grid.getValue(itemIndex, "CUD");

		// 수정한 칼럼 인덱스를 구해서 focus 줘야됨
		if( fieldName == "CUD" && cudVal == "C" ){
			//행 추가를 위한 수정내역 취소.
			grid.cancel();

			// c 처리
			var selectedRows = {};
			selectedRows['CUD'] = 'C';

			// 맨 아랫줄은 itemIndex+1 사용안됨
			if (dataProvider.getRowCount() == itemIndex+1) {    // 마지막줄 이면
				//하위 행 추가.
				// grid.beginInsertRow(itemIndex, true);
				// grid.commit(true);
				// grid.setValues(itemIndex+1, selectedRows);
				// grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.setEditOptions({appendable: true}); //21.08.04 choms 이렇게 안하면 키보드로 행추가 가능함.
				grid.beginAppendRow();
				grid.setValues(itemIndex+1, selectedRows);
				// grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.setEditOptions({appendable: false});
				grid.commit(true);
			} else {    // 마지막줄 아니면
				//하위 행 추가.
				grid.beginInsertRow(itemIndex+1, false);
				grid.setValues(itemIndex+1, selectedRows);
				grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.commit(true);
			}

		}else if ( fieldName == "CUD" && cudVal == "R" ){
			//행 추가를 위한 수정내역 취소.
			grid.cancel();

			//r 처리 행 데이터복사 처리
			var selectedRows = grid.getValues(itemIndex);
			selectedRows['CUD'] = 'C';

			// 맨 아랫줄은 itemIndex+1 사용안됨
			if (dataProvider.getRowCount() == itemIndex+1) {    // 마지막줄 이면
				//하위 행 추가.
				// grid.beginInsertRow(itemIndex, true);
				// grid.commit(true);
				// grid.setValues(itemIndex+1, selectedRows);
				// grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.setEditOptions({appendable: true}); //21.08.04 choms 이렇게 안하면 키보드로 행추가 가능함.
				grid.beginAppendRow();
				grid.setValues(itemIndex+1, selectedRows);
				grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.setEditOptions({appendable: false});
				grid.commit(true);
			} else {    // 마지막줄 아니면
				//하위 행 추가.
				grid.beginInsertRow(itemIndex+1, false);
				grid.setValues(itemIndex+1, selectedRows);
				grid.setCurrent({ itemIndex: itemIndex+1 });
				grid.commit(true);
			}

		}else if ( fieldName == "CUD" && cudVal == "D" ){
			grid.commit();
			grid.setValue(itemIndex, 'CUD', 'D');
		}else if ( fieldName == "CUD" && cudVal == "" ){
			grid.commit();
			if( $.inArray(dataRow, dataProvider.getStateRows('created')) > -1  ){
				dataProvider.removeRow(dataRow);
			}else{
				dataProvider.setRowState(dataRow, 'none', true);
			}
		}else{
			grid.commit();
			//CUD 이외의 행에서 값이 변경되었을때  CUD - U 처리
			if( cudVal != 'C' && cudVal != 'D'){
				grid.setValue(itemIndex, 'CUD', 'U');
			}else if(cudVal == 'D'){

			}else{
				grid.setValue(itemIndex, 'CUD', 'C');
			}
		}
	}
	, POP_CUD(grid, idx) {
		var cud = grid.getValue(idx, "CUD");
		if (cud != "C" && cud != "D") {
			grid.setValue(idx, "CUD", "U");
		}
	}
	, copyToClipboard : function(grid) {
		try {
			var sel = grid.getSelection();
			var cellIndex = grid.getCurrent();
			sel.style = 'block';
			sel.startColumn = cellIndex.column;
			sel.startItem = cellIndex.itemIndex;
			sel.startRow = cellIndex.dataRow;
			sel.endColumn = cellIndex.column;
			sel.endItem = cellIndex.itemIndex;
			sel.endRow = cellIndex.dataRow;
			grid.copyToClipboard(sel);
		} catch(err) {
			console.log(err);
		}
	}
	, gfn_DiffDate: function(sStartDate, sEndDate) {
		if (MES_UTIL.gfn_IsNull(sStartDate) || MES_UTIL.gfn_IsNull(sEndDate)) {
			return NaN;
		}
		var vFromDate = new Date(parseInt(sEndDate.substring(0, 4), 10), parseInt(sEndDate.substring(4, 6) - 1, 10), parseInt(sEndDate.substring(6, 8), 10));
		var vToDate = new Date(parseInt(sStartDate.substring(0, 4), 10), parseInt(sStartDate.substring(4, 6) - 1, 10), parseInt(sStartDate.substring(6, 8), 10));
		
		return parseInt((vFromDate - vToDate) / (1000 * 60 * 60 * 24));
	}
	, gfn_DiffMonth: function(sStartDate, sEndDate)          //DiffMonth
	{
		console.log('gfn_DiffMonth>>')
		if (MES_UTIL.gfn_IsNull(sStartDate) || MES_UTIL.gfn_IsNull(sEndDate)) {
			return NaN;
		}
console.log(sStartDate)
console.log(sStartDate)
		var nStartMon = eval(parseInt(sStartDate.substring(0, 4), 10)*12 + parseInt(sStartDate.substring(4, 6) - 1, 10));
		var nEndMon = eval(parseInt(sEndDate.substring(0, 4), 10)*12 + parseInt(sEndDate.substring(4, 6) - 1, 10));
		console.log(nStartMon)
		console.log(nEndMon)
		return parseInt(nEndMon - nStartMon);
	}

/*
    필수 키 값 체크. 값 없을 시 경고창과 해당 행으로 focus 시켜줌
    save 메소드에서 for문 돌릴때 사용. GCOMEN914 참고
    MES_UTIL.gridKeyCheck(gridView, dataProvider, gridEdit, ["PLT_CD", "MC_CD", "FAC_CD", "PROC_CD"])
*/
	, gridKeyCheck: function(gridView, dataProvider, idxArr, colArr) {
		if (idxArr.length <= 0) {
			msg_alert('' ,I18('#변경사항이_없습니다.')  , '' ,I18('#확인') );
			return false;
		}
		for (var idx = 0; idx < idxArr.length; idx++ ) {
			var jsonData = dataProvider.getJsonRow(idxArr[idx]);
			for (var i = 0; i < colArr.length; i++) {
				if (MES_UTIL.gfn_IsNull(jsonData[colArr[i]])) {
					var colName = gridView.getColumnProperty(colArr[i], 'header').text;
					// alert(colName + I18('#은_필수_입력사항입니다.'));
					msg_alert('' ,colName + I18('#은_필수_입력사항입니다.')  , '' ,I18('#확인') );
					gridView.setCurrent({dataRow: idxArr[idx]});
					return false;
				}
			}
		}
		return true;
	}
	
	,gfn_TransNullToEmpty : function(sValue){
	
		if( MES_UTIL.gfn_IsNull(sValue) )
		{
			return "";
		}
		return sValue;
	}
	,gfn_TransNullToNumber : function(sValue){
	
		if( MES_UTIL.gfn_IsNull(sValue) )
		{
			return 0;
		}
		return sValue;
	}
	,gfn_Round : function(nValue, nDigit){
	
		var nRound = 1;
	    for ( var i = 0; i < nDigit; i++) {
	        nRound = nRound * 10;
	    }
	
	    var nRetValue = nValue * nRound;
	    nRetValue = Math.round(nRetValue);
	    nRetValue = nRetValue / nRound;
	    return nRetValue;
	}

    , gfn_IsNum : function(sNum){ 
			var c;
			var point_cnt=0;
			var ret=true;
			
			if( MES_UTIL.gfn_IsNull(sNum) )		return false;
			
			for( i = 0 ; i < sNum.length ; i++ ){
			
				c = sNum.charAt(i);
				if( i == 0 && ( c == "+" || c == "-" ) );
				else if( c >= "0" && c <= "9" );
				else if( c == "." )
				{
					point_cnt++;
					if( point_cnt > 1 )
					{
						ret = false;
						break;
					}
				}
				else
				{
					ret = false;
					break;
				}
			}
			
			return ret;
	}

,gfn_MidCase : function(sOrg, sStart, sEnd, nStart)           //gfn_MidCase
{
	var pos_start, pos_end, ret_str;
	
	if( MES_UTIL.gfn_IsNull(sOrg) )		return "";	
	if( MES_UTIL.gfn_IsNull(sStart) )	sStart = "";
	if( MES_UTIL.gfn_IsNull(sEnd) )		sEnd = "";
	if( MES_UTIL.gfn_IsNull(nStart) )	nStart = 0;
		
	if( sStart == "" )
		pos_start = nStart;
	else
	{
		pos_start = MES_UTIL.gfn_PosCase(sOrg, sStart, nStart);
		if( pos_start < 0 )	return "";
	}
	if( sEnd == "" )
		pos_end = sOrg.length;
	else
	{
		pos_end = MES_UTIL.gfn_PosCase(sOrg, sEnd, pos_start+sStart.length, nStart);
		if( pos_end < 0 )	return "";
	}

	return sOrg.substring(pos_start+sStart.length, pos_end);
}
,gfn_PosCase : function(sOrg, sFind, nStart)                 //PosCase
{
	if( MES_UTIL.gfn_IsNull(sOrg) || MES_UTIL.gfn_IsNull(sFind) )		return -1;
	if( MES_UTIL.gfn_IsNull(nStart) )		nStart = 0;
	
	return sOrg.toLowerCase().indexOf(sFind.toLowerCase(), nStart);
}
	//EQS========================================================================================================================
	//공통 function 호출 기능 처리   EQS_COM_001
	//  'comboFAC' , 'PROC','MC_TP_CD'  하위코드 호출시
	,L_gfn_GetEQS_COM_001 : function(id , proc_cd , mc_tp_cd , lgsmd_fg , blank ,seq , callBack ) {
		try {
			var cd_id = { PROC_CD: proc_cd , MC_TP_CD : mc_tp_cd , LGSMD_FG : lgsmd_fg };
			$.when(
				HTGF.Api.get('/api/codeLocal/EQS_COM_001', cd_id ).then( function(resData) {
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	
		//공통 function 호출 기능 처리   EQS_COM_006
	//  'comboFAC' , SPEC1, SPEC2, MC_CD, TABLE_NAME
	,L_gfn_GetEQS_COM_006 : function(id , code1 , code2, code3, code4 , blank ,seq , callBack ) {
		try {
			var cd_id = { SPEC1:code1 , SPEC2:code2 , MC_CD:code3 , LGSMD_FG:code4 };
			$.when(
				HTGF.Api.get('/api/codeLocal/EQS_COM_006', cd_id ).then( function(resData) {
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	
		//공통 function 호출 기능 처리   EQS_COM_007
	//  'comboFAC' , 'MC_CD'
	,L_gfn_GetEQS_COM_007 : function(id , code , blank ,seq , callBack ) {
		try {
			var cd_id = { MC_CD:code };
			$.when(
				HTGF.Api.get('/api/codeLocal/EQS_COM_007', cd_id ).then( function(resData) {
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	}
	
	//공통 function 호출 기능 처리   EQS_COM_005
	//  'comboFAC' , 'MC_CD'
	,L_gfn_GetEQS_COM_005 : function(id ,  spec1 , spec2, tablenm, mc ,  blank ,seq , callBack ) {
		try {
			var cd_id = { SPEC1:spec1 , SPEC2:spec2 , TABLE_NAME : tablenm , MC_CD : mc };
			$.when(
				HTGF.Api.get('/api/codeLocal/EQS_COM_005', cd_id ).then( function(resData) {
					MES_UTIL.draw(resData ,blank,seq,id,callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}
	},

	//=================================================================== MASTER
	// 공통 function 호출 기능 처리
	// ex) MES_UTIL.gfn_GetEmsCdCombo("mtt_tp", "CM_MTTTP", "1", "BLANK", 0, LEMSCM004.callback);
	gfn_GetEmsCdCombo : function(id, cd_kind, use_fg, blank, seq, callBack) {

		try {
			var cd_id = {cd_kind:cd_kind , use_fg:use_fg};
			$.when(
				HTGF.Api.get('/api/codeEMS/list', cd_id).then( function(resData) {
					MES_UTIL.drawUpper(resData, blank, seq, id, callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}

	},

	//=================================================================== MASTER
	// 공통 function 호출 기능 처리
	// ex) MES_UTIL.gfn_GetBlocCdCombo("bloc_cd", "", "BLANK", 0, LEMSCM004.callback);
	gfn_GetBlocCdCombo : function(id, plc_cd, blank, seq, callBack) {

		try {
			var cd_id = {plc_cd: plc_cd};
			$.when(
				HTGF.Api.get('/api/codeEMS/bloc', cd_id).then( function(resData) {
					MES_UTIL.drawUpper(resData, blank, seq, id, callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}

	},

	//=================================================================== MASTER
	// 공통 function 호출 기능 처리
	// ex) MES_UTIL.gfn_GetEnrgCdCombo("enrg_cd", "", "BLANK", 0, LEMSCM004.callback);
	gfn_GetEnrgCdCombo : function(id, enrg_div, blank, seq, callBack) {

		try {
			var cd_id = {enrg_div: enrg_div};
			$.when(
				HTGF.Api.get('/api/codeEMS/enrg', cd_id).then( function(resData) {
					MES_UTIL.drawUpper(resData, blank, seq, id, callBack);
				})
			).then(function (){
				callBack(id);
				$("#"+id).trigger('change');
			});
		} catch (e) {
			console.error(e);
		} finally {

		}

	}

}

function loadingbar_off(){
	if( $('.loadingbar').attr("style") == "display: block;"){
		console.log(">>loading bar >>>"); 	
		$('.loadingbar').attr( "style", "display: none;" );
	} 
}

function page_fullmode(menuId){
	var url = '/FILTER/fullmode.html?menuId='+menuId;
	
	var name = menuId ;
	// 만들 팝업창 width 
	var width = (window.screen.width);
	// 만들 팝업창 height
	var height = (window.screen.height);

	options = "toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width="+width+", height="+height;
	window.open(url, name, options);
}

function page_fullmodeParam(menuId,param){
	//LQLTEN010 -> LQLTEN011 호출용

	var params = '&id='+param.id+'&SMPL_NO='+param.SMPL_NO+'&SPEC='+param.SPEC+'&ETUS_PRD_GRP_CD='+param.ETUS_PRD_GRP_CD ;
	var url = '/FILTER/fullmode.html?menuId='+menuId+params;

	var name = menuId ;
	// 만들 팝업창 width
	var width = (window.screen.width);
	// 만들 팝업창 height
	var height = (window.screen.height);

	options = "toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width="+width+", height="+height;

	window.open(url, name, param, options);
}
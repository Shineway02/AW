<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_tables = 's';
			var q_name = "cut";
			var q_readonly = ['txtNoa','txtProductno','txtSpec','txtProduct','txtDime','txtWidth','txtLengthb','txtEweight','txtSource','txtUno','txtTgg','txtCust','txtWorker','txtOweight'];
			var q_readonlys = ['txtNoq','txtOrdeno','txtNo2','txtWeight'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 7;
			brwCount = 7;
			brwCount2 = 7;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(
				['txtTggno', '', 'sss', 'noa,namea', 'txtTggno,txtTgg', 'sss_b.aspx'],
				['txtCustno', '', 'sss', 'noa,namea', 'txtCustno,txtCust', 'sss_b.aspx'],
				['txtCustno_', '', 'cust', 'noa,nick', 'txtCustno_,txtCust_', 'sss_b.aspx']
			);
			q_desc=1;
			$(document).ready(function() {
				$.fn.colorbox.settings.speed = 0;//清除q_box動畫效果
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('ucc', '', 0, 0, 0, "",'',1);
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [];
				q_mask(bbmMask);
				q_cmbParse("cmbCarno", '操作員,貼膜者,職訓員,新訓員,技師');
				q_cmbParse("cmbComp", '支援者,助理,貼膜者,指導員,調料員');
				$('#txtCuano').change(function(){
					var thisVal = $(this).val().trim();
					var A1 = thisVal.slice(0,1);
					if(A1.toUpperCase() == '1'){
						thisVal = '分條4尺'
					}else if(A1.toUpperCase() == '2'){
						thisVal = '分條700'
					}else if(A1.toUpperCase() == '3'){
						thisVal = '分條650'
					}else if(A1.toUpperCase() == '4'){
						thisVal = '分條400A'
					}else if(A1.toUpperCase() == '5'){
						thisVal = '分條400A2'
					}else if(A1.toUpperCase() == '6'){
						thisVal = '分條400B'
					}else if(A1.toUpperCase() == '7'){
						thisVal = '自剪800'
					}else if(A1.toUpperCase() == '8'){
						thisVal = '自剪650'
					}else if(A1.toUpperCase() == '9'){
						thisVal = '剪床NC'
					}else if(A1.toUpperCase() == 'A'){
						thisVal = '剪床ST'
					}else if(A1.toUpperCase() == 'B'){
						thisVal = '貼膜5尺'
					}else if(A1.toUpperCase() == 'C'){
						thisVal = '軸刀機'
					}else if(A1.toUpperCase() == 'D'){
						thisVal = '分條670'
					}
					$(this).val(thisVal);
					sum();
				});
				$('#txtUno').change(function(){
					if(q_cur==1 || q_cur==2){
						var thisVal = $(this).val();
						if(thisVal.length>0){
							if(thisVal.length==1){
								q_box('uccc_rad_b_awb.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy + "_" + r_cno, 'uccc', "95%", "95%", m_seek);
								return;
							}
							q_gt('y_getuccc2_awb','' + ';' + '' + ';' + '0' + ';' + '0' + ';' + '0' + ';' + thisVal + ";"+'0'+';',0,0,0,'','',1);
							var uccc_as = _q_appendData('y_getuccc2_awb','',true,true);
							if(uccc_as[0] != undefined){
								uccc_as = uccc_as.filter(function(item){
									return item.uno==thisVal;
								})
								$('#txtProductno').val(uccc_as[0].productno);
								$('#txtSpec').val(uccc_as[0].spec);
								$('#txtProduct').val(uccc_as[0].product);
								$('#txtDime').val(uccc_as[0].dime);
								$('#txtWidth').val(uccc_as[0].width);
								$('#txtLengthb').val(uccc_as[0].lengthb);
								$('#txtEweight').val(uccc_as[0].eweight);
								$('#txtGweight').val(uccc_as[0].eweight);
							}else{
								alert('無此庫存!');
								$('#txtProductno').val('');
								$('#txtSpec').val('');
								$('#txtProduct').val('');
								$('#txtDime').val(0);
								$('#txtWidth').val(0);
								$('#txtLengthb').val(0);
								$('#txtEweight').val(0);
							}
						}
						sum();
					}
				})
				$('#btnOrdes').click(function(){
					var t_dime = dec($('#txtDime').val());
					if(t_dime>0){
						q_box('ordes2cut_awb_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy, 'ordes2cut', "95%", "95%", m_seek);
					}
				})
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					default:
						break;
				}
			}
			function q_popPost(s1) {
                var ret;
                switch (s1) {
                }
            }
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordes2cut':
						if(!(q_cur==1 || q_cur==2))
							return;
						if (!b_ret || b_ret.length == 0) {
							b_pop = '';
							return;
						}
						ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtCustno,txtCust,txtDime,txtWidth,txtLengthb,txtMount,txtHweight,txtMemo,txtOrdeno,txtNo2',
									 b_ret.length, b_ret, 'custno,comp,dime,width,lengthb,mount,notv,sizea,noa,no2', 'txtOrdeno,txtNo2,txtDime');
						break;
					case 'uccc':
						if(q_cur==1){
							if (!b_ret || b_ret.length == 0) {
								$('#txtUno').val('').change();
								b_pop = '';
								return;
							}
							$('#txtUno').val(b_ret[0].uno).change();
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			var UccList = [];
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ucc':
						var as = _q_appendData("ucc", "", true);
                        UccList = new Array();
                        UccList = as;
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				var t_datea = $('#txtDatea').val().trim();
				if(t_datea.length==0 || !q_cd(t_datea)){
					alert('日期錯誤!');
					return;
				}
				sum();
				var t_type = $('#txtCuano').val().trim();
				var t_prx = $('#txtUno').val().trim();
				var t_noa = $('#txtNoa').val().trim();
				var t_maxUno = '';
				var t_idStr = '';
				for(var k=0;k<q_bbsCount;k++){
					var xBno = $('#txtBno_' + k).val().trim().toUpperCase();
					var xSpec = $('#txtSpec_' + k).val().trim();
					var xXButt = $('#txtXbutt_' + k).val().trim().toUpperCase();
					var xSize = $('#txtSize_' + k).val().trim().toUpperCase(); //需求
					var xStyle = $('#txtStyle_' + k).val().trim().toUpperCase();
					var xWeight = dec($('#txtWeight_' + k).val().trim());
					xWeight = (isNaN(xWeight)?0:xWeight);					if(xStyle.length==0){
						$('#txtStyle_' + k).val((t_type.indexOf('分條')>-1?'C':'F'));
					}
					if(xSpec.length==0 && xWeight != 0 && xXButt.slice(0,1) != 'X'){
						$('#txtSpec_' + k).val($('#txtSpec').val().trim());
					}					
					if(xBno.length>0 && xBno.slice(0,t_prx.length)==t_prx && xBno>t_maxUno){
						t_maxUno = xBno;
					}
					if(xBno.length==0 && xWeight != 0 && xXButt.slice(0,1) != 'X' && xSize!='下腳'){
						t_idStr += k + '@';
					}
				}
				q_func('qtxt.query.getUno_awb', 'uno.txt,getUno_awb,' + t_prx + ';' + t_idStr + ';' + t_maxUno + ';CUTS;' + t_noa,r_accy,1);
				var uno_as = _q_appendData('tmp0','',true,true);
				if(t_idStr.length>0 && uno_as[0]== undefined){
					alert('批號取得失敗!');
					return;
				}else if(uno_as[0] != undefined){
					uno_as.filter(function(item){
						$('#txtBno_' + item.xid).val(item.uno);
					});
				}
				if(q_cur===1)
					$('#txtWorker').val(r_name)
				
				
				
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll('' + t_datea, '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('cut_awb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function sum(){
				var tt_weight = 0;
				var t_productno = $('#txtProductno').val().trim();
				var t_type = $('#txtCuano').val().trim().toUpperCase();
				var o_dime = dec($('#txtDime').val().trim());
				o_dime = (isNaN(o_dime)?0:o_dime);
				var o_width = dec($('#txtWidth').val().trim());
				o_width = (isNaN(o_width)?0:o_width);
				var o_gweight = dec($('#txtGweight').val().trim());
				o_gweight = (isNaN(o_gweight)?0:o_gweight);
				for(var k=0;k<q_bbsCount;k++){
					var t_weight = 0;
					var n_width = dec($('#txtWidth_'+k).val().trim());
					n_width = (isNaN(n_width)?0:n_width);
					var n_lengthb = dec($('#txtLengthb_'+k).val().trim());
					n_lengthb = (isNaN(n_lengthb)?0:n_lengthb);
					var n_mount = dec($('#txtMount_'+k).val().trim());
					n_mount = (isNaN(n_mount)?0:n_mount);
					if(t_type.indexOf('分條')>-1 && o_width!=0){
						t_weight = o_gweight/o_width*n_width*n_mount;
					}else if(t_type.indexOf('自剪')>-1 || t_type.indexOf('剪床')>-1 || t_type.indexOf('貼膜')>-1 || t_type.indexOf('軸刀')>-1){
						var t_Density  = 0;
						UccList.filter(function(item){
							if(item.noa.toUpperCase()==t_productno.slice(1).toUpperCase()){
								t_Density = dec(item.density);
							}
						});
						if(t_Density==0 && t_productno.length==2){
							t_Density = 7.8;
							if(t_productno.slice(1,2)=='3'){
								t_Density = 7.93;
							}else if(t_productno.slice(1,2)=='A'){
								t_Density = 2.71;
							}else if(t_productno.slice(1,2)=='B'){
								t_Density = 8.5;
							}else if(t_productno.slice(1,2)=='P'){
								t_Density = 8.96;
							}else if(t_productno.slice(1,2)=='C'){
								t_Density = 8.96;
							}else if(t_productno.slice(1,2)=='F'){
								t_Density = 1.28;
							}else if(t_productno.slice(1,2)=='J'){
								t_Density = 9;
							}else if(t_productno.slice(1,2)=='N'){
								t_Density = 8.9;
							}else if(t_productno.slice(1,2)=='Q'){
								t_Density = 8.8;
							}else if(t_productno.slice(1,2)=='T'){
								t_Density = 4.6;
							}
						}
						t_weight = t_Density*o_dime*(n_width/1000)*(n_lengthb/1000)*n_mount;
					}
					t_weight = round(t_weight,1);
					q_tr('txtWeight_'+k,t_weight);
					tt_weight = q_add(tt_weight,t_weight);
				}
				q_tr('txtOweight',tt_weight);
			}

			function bbsAssign() {
				for(var j=0;j<q_bbsCount;j++){
					$('#txtXbutt_' + j).change(function(){
						var thisVal = $(this).val().trim().toUpperCase();
						var n = $(this)[0].id.split('_')[1];
						if(thisVal.slice(0,1)=='X'){
							$('#txtSize_' + n).val('下腳');
							$('#txtBno_' + n).val('');
						}
						sum();
					});
					$('#txtSize_' + j).change(function(){
						var n = $(this)[0].id.split('_')[1];
						var thisVal = $(this).val().trim().toUpperCase();
						if(thisVal.slice(0,1)=='0'){
							$(this).val('預售');
						}else if(thisVal.slice(0,1)=='1'){
							$(this).val('藍膜');
						}else if(thisVal.slice(0,1)=='2'){
							$(this).val('白膜');
						}else if(thisVal.slice(0,1)=='3'){
							$(this).val('低黏');
						}else if(thisVal.slice(0,1)=='4'){
							$(this).val('靠刀');
						}else if(thisVal.slice(0,1)=='5'){
							$(this).val('壓延');
						}else if(thisVal.slice(0,1)=='6'){
							$(this).val('撕膜');
						}else if(thisVal.slice(0,1)=='7'){
							$(this).val('切板');
						}else if(thisVal.slice(0,1)=='8'){
							$(this).val('餘料');
						}else if(thisVal.slice(0,1)=='9'){
							$(this).val('下腳');
						}else if(thisVal.slice(0,1)=='A'){
							$(this).val('修邊');
						}else if(thisVal.slice(0,1)=='B'){
							$(this).val('雙面');
						}else if(thisVal.slice(0,1)=='C'){
							$(this).val('透明');
						}else if(thisVal.slice(0,1)=='D'){
							$(this).val('磨砂貼膜');
						}
						sum();
					});
					$('#txtDime_'+j).change(function(){
						sum();
					});
					$('#txtWidth_'+j).change(function(){
						sum();
					});
					$('#txtLengthb_'+j).change(function(){
						sum();
					});
					$('#txtMount_'+j).change(function(){
						sum();
					});
				}
				_bbsAssign();
				bbsResize();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtCuano').val('分條');
				$('#txtDatea').val(q_date()).focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				var t_report = "report='z_cut_awb02'";
				q_box("z_cut_awb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_report + ";" + r_accy + ";" + $('#txtNoa').val(), '', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var t_no='0'
					if(r_name=="林鴻鳴")
						t_no=1
					if(r_name=="林謝素珍")
						t_no=2
					if(r_name=="林珮祺")
						t_no=3
					if(r_name=="林晏翎")
						t_no=5
					if(r_name=="沈志勳")
						t_no=6
					if(r_name=="羅翊辰")
						t_no=7
					if(r_name=="謝孟賢")
						t_no=8
				var t_noa=key_value.substr(0,7)+t_no+key_value.substr(7,3)
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(t_noa);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (dec(as['dime'])==0) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['uno'] = abbm2['uno'];
				if(abbm2['productno'].slice(0,1) != as['style']){
					as['productno'] = as['style']+abbm2['productno'].slice(1);
				}
				if(as['spec']==''){
					as['spec'] = abbm2['spec'];
				}
                as['noa'] = abbm2['noa'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				if (q_cur == 1) {
					$('#txtUno').css('color', 'black').css('background', 'white').prop('readonly',false);
				}
				//sum();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (q_cur == 1) {
					$('#txtUno').css('color', 'black').css('background', 'white').prop('readonly',false);
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
			function bbsResize(){
				var AllWidth = 0;
				$('.tbbs > tbody > tr:first > td').each(function(index){
					if(!($(this).css('display') == 'none')){//如果沒有隱藏則加寬度
						if(isNaN(parseInt($(this)[0].style.width))){
							console.log('第' + (index+1) + '個td未設定寬度。' + $(this).html() );
						}else{
							AllWidth = parseInt(AllWidth) + parseInt($(this)[0].style.width) + 4;// 4=預設左右框線共4px
						}
					}
				});
				$('.tbbs').css('table-layout','fixed');
				$('.tbbs').css('width',AllWidth + 'px');
				$('.dbbs').css('width',AllWidth + 'px');
				//console.log('.tbbs .dbbs 寬度已設為:' + AllWidth + 'px');
			}
			//table-layout: fixed;

		</script>
		<style type="text/css">
			#dmain {
				float:left;
				width:100%;
				min-width: 1410px;
			}
			.dview {
				float: left;
				width: 380px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 1000px;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr,.tbbs tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 110px;
			}
			.tbbm .tdZ {
				width: 10px;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 95%;
				float: left;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.dbbs {
				width: 950px;
			}
			.num {
				text-align: right;
			}
			*{
				font-size: medium;
			}
			input[type="checkbox"]{
				width:1rem;
				height:1rem;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td style="width:180px;"></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">裁剪日期</a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">裁剪單號</a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">單別</a></td>
						<td><input id="txtCuano" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">機台</a></td>
						<td><input id="txtMech" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">鋼捲編號</a></td>
						<td><input id="txtUno" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">鋼種</a></td>
						<td><input id="txtProductno" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">板面</a></td>
						<td><input id="txtSpec" type="text" class="txt c1"/></td>
						<td><input id="btnOrdes" type="button" class="txt c1" value="訂單匯入"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">中文名</a></td>
						<td><input id="txtProduct" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">原厚度</a></td>
						<td><input id="txtDime" type="text" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">原寬度</a></td>
						<td><input id="txtWidth" type="text" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">原長度</a></td>
						<td><input id="txtLengthb" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">原重量</a></td>
						<td><input id="txtEweight" type="text" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">領料重</a></td>
						<td><input id="txtGweight" type="text" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">鋼捲備註</a></td>
						<td colspan="3"><input id="txtSource" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">包裝方式</a></td>
						<td><input id="txtPlace" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">寬度公差＋</a></td>
						<td>
							<input id="txtWidth2" type="text" class="txt c1 num" style="width:75px;"/>
							<div style="float:left;width:20px;text-align: center;">－</div>
							<input id="txtWidth3" type="text" class="txt c1 num" style="width:75px;"/>
						</td>
						<td><span> </span><a class="lbl">內徑</a></td>
						<td><input id="txtCardealno" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">外徑</a></td>
						<td><input id="txtCardeal" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">交期</a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td colspan="2">
							<select id="cmbCarno" class="txt c1" style="margin-left:5px;width:75px;"/>
							<input id="txtTggno" type="text" class="txt c1" style="width:50px;"/>
							<input id="txtTgg" type="text" class="txt c1" style="width:90px;"/>
						</td>
						<td colspan="2">
							<select id="cmbComp" class="txt c1" style="margin-left:5px;width:75px;"/>
							<input id="txtCustno" type="text" class="txt c1" style="width:50px;"/>
							<input id="txtCust" type="text" class="txt c1" style="width:90px;"/>
						</td>
						<td><span> </span><a class="lbl">製表人</a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">備註</a></td>
						<td colspan="6"><input id="txtMemo" type="text" class="txt c1"/></td>
						<td><input id="txtOweight" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td colspan="8"><label style="float:left;font-size: 0.9rem;">1=分條4尺 2=分條700 3=分條650 4=分條400A 5=分條400A2 6=分條400B 7=自剪800 8=自剪650 9=剪床NC A=剪床ST B=貼膜5尺 C=軸刀機 D=分條670</label></td>
					</tr>
					<tr>
						<td colspan="8"><label style="float:right;font-size: 0.9rem;">0=預售 1=藍膜 2=白膜 3=低黏 4=靠刀 5=壓延 6=撕膜 7=切板 8=餘料 9=下腳 A=修邊 B=雙面 C=透明 D=磨砂貼膜</label></td>
					</tr>
				</table>
			</div>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:30px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a>裁剪單號</a></td>
						<td align="center" style="width:90px; color:black;"><a>裁剪日期</a></td>
						<td align="center" style="width:150px; color:black;"><a>鋼捲編號</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td style="text-align: center;" id='noa'>~noa</td>
						<td style="text-align: center;" id='datea'>~datea</td>
						<td style="text-align: left;" id='uno'>~uno</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:35px;"><input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;width:30px;" /></td>
					<td align="center" style="width:50px;"><a>序號</a></td>
					<td align="center" style="width:70px;"><a>編號</a></td>
					<td align="center" style="width:80px;"><a>客戶</a></td>
					<td align="center" style="width:40px;"><a>廢料</a></td>
					<td align="center" style="width:30px;"><a>型</a></td>
					<td align="center" style="width:80px;"><a>厚度</a></td>
					<td align="center" style="width:80px;"><a>寬度</a></td>
					<td align="center" style="width:80px;"><a>長度</a></td>
					<td align="center" style="width:60px;"><a>數量</a></td>
					<td align="center" style="width:80px;"><a>訂單重量</a></td>
					<td align="center" style="width:80px;"><a>理論重</a></td>
					<td align="center" style="width:50px;"><a>需求</a></td>
					<td align="center" style="width:130px;"><a>餘料編號</a></td>
					<td align="center" style="width:200px;"><a>注意事項</a></td>
					<td align="center" style="width:110px;"><a>訂單編號</a></td>
					<td align="center" style="width:50px;"><a>訂序</a></td>
					<td align="center" style="width:120px;"><a>板面</a></td>
					<td align="center" style="width:200px;"><a>摘要</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;width:30px;" /></td>
					<td><input type="text" id="txtNoq.*" class="txt c1" /></td>
					<td><input type="text" id="txtCustno.*" class="txt c1" /></td>
					<td><input type="text" id="txtCust.*" class="txt c1" /></td>
					<td><input type="text" id="txtXbutt.*" class="txt c1" /></td>
					<td><input type="text" id="txtStyle.*" class="txt c1" /></td>
					<td><input type="text" id="txtDime.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtWidth.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtLengthb.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtMount.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtHweight.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtWeight.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtSize.*" class="txt c1" /></td>
					<td><input type="text" id="txtBno.*" class="txt c1" /></td>
					<td><input type="text" id="txtMemo.*" class="txt c1" /></td>
					<td><input type="text" id="txtOrdeno.*" class="txt c1" /></td>
					<td><input type="text" id="txtNo2.*" class="txt c1" /></td>
					<td><input type="text" id="txtSpec.*" class="txt c1" /></td>
					<td><input type="text" id="txtScolor.*" class="txt c1" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
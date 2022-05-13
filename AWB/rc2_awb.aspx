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
			var q_name = "rc2";
			var q_readonly = ['txtNoa','txtTax','txtMoney','txtTotal','txtWorker','txtWorker2'];
			var q_readonlys = ['txtNoq','txtTotal','txtOrdeno','txtNo2'];
			var bbmNum = [['txtTotal',15,0,0,1],['txtTax',15,0,0,1],['txtMoney',15,0,0,1]];
			var bbsNum = [['txtDime',15,2,1,1],['txtWidth',15,2,1,1],['txtLengthb',15,1,1,1],['txtMweight',15,1,1,1],['txtWeight',15,1,1,1],['txtMount',15,0,0,1],['txtPrice',15,2,1,1],['txtTotal',15,0,1,1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 5;
			brwCount = 5;
			brwCount2 = 5;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(
				['txtTggno', 'lblTggno', 'tgg', 'noa,comp,tel', 'txtTggno,txtTgg,txtTel', 'tgg_b.aspx'],
				['txtProductno_', '', 'ucc', 'noa,product', 'txtProductno_', 'ucaucc_b.aspx'],
           		['txtStyle_', '', 'style', 'noa,product', 'txtStyle_', 'style_b.aspx']
			);
			q_desc=1;
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('style','',0,0,0,'','',1);
				q_gt('ucc','',0,0,0,'','',1);
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
				bbmMask = [['txtDatea', r_picd],['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('rc2.typea'));
				$('#cmbTypea').change(function(){
					changeUnoRead();
				});
				$('#txtPaytype').change(function(){
					var thisVal = $(this).val().trim().toUpperCase();
					if(thisVal=='1'){
						$(this).val('月結 60天');
					}else if(thisVal=='2'){
						$(this).val('月結現金');
					}else if(thisVal=='3'){
						$(this).val('月結 30天');
					}else if(thisVal=='4'){
						$(this).val('Ｌ／Ｃ');
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
                    case 'txtTggno':
                        var t_tggno = $('#txtTggno').val().trim();
						if(t_tggno.length>0){
							if(q_cur==1){
								for(var k=0;k<q_bbsCount;k++){
									$('#btnMinus_' + k).click();
								}
								q_gt('view_ordcs',"where=^^ tggno='"+t_tggno+"' and isnull(enda,0)=0 and cont=N'訂購' and isnull(productno,'') != '' ^^",0,0,0,'','',1);
								var ordcs_as = _q_appendData('view_ordcs','',true,true);
								if(ordcs_as[0] != undefined){
									q_gridAddRow(bbsHtm, 'tbbs',
										'txtProductno,txtProduct,txtStyle,txtSpec,txtClass,txtUnit,txtMemo,txtOrdeno,txtNo2,txtDime,txtWidth,txtLengthb,txtWeight,txtPrice,txtMount',
										ordcs_as.length, ordcs_as,
										'productno,product,style,spec,class,unit,memo,noa,no2,dime,width,lengthb,notv,price,mount',
									'txtOrdeno,txtNo2', '_');
								}
								sum();
							}
						}
                        break;
					case 'txtProductno_':
						setProduct(b_seq);
						break;
					case 'txtStyle_':
						setProduct(b_seq);
						break;
                }
            }
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			var uccArray = [];
			var styleArray = [];
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'style':
						styleArray = _q_appendData('style','',true,true);
						if(styleArray[0] == undefined){
							styleArray = [];
						}
						break;
					case 'ucc':
						uccArray = _q_appendData('ucc','',true,true);
						if(uccArray[0] == undefined){
							uccArray = [];
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function setProduct(n){
				var t_pno = $('#txtProductno_' + n).val().trim();
				var t_style = $('#txtStyle_' + n).val().trim();
				var usedName = '';
				if(t_pno.length>0){
					uccArray.filter(function(item){
						if(item.noa.trim()==t_pno){
							usedName += item.product.trim();
						}
					});
				}
				if(t_style.length>0){
					styleArray.filter(function(item){
						if(item.noa.trim()==t_style){
							usedName += item.product.trim();
						}
					});
				}
				$('#txtProduct_' + n).val(usedName);
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				var t_tggno = $('#txtTggno').val().trim().toUpperCase();
				var t_datea = $('#txtDatea').val().trim();
				var t_typea = $('#cmbTypea').val().trim();
				var t_noa = $('#txtNoa').val().trim();
				if(t_tggno.length<4){
					alert('廠商編號錯誤!');
					return;
				}
				if(t_datea.length==0 || !q_cd(t_datea)){
					alert('進貨日期錯誤!');
					return;
				}
				//取得批號
				var t_year = dec(t_datea.slice(0,r_len));
				var t_mon = dec((t_datea.slice(0,r_lenm)).slice(-2));
				t_year = (isNaN(t_year)?0:t_year);
				t_mon = (isNaN(t_mon)?0:t_mon);
				if(t_year==0 || t_mon==0){
					alert('進貨日期錯誤!(年度或日期)');
					return;
				}
				if(t_typea=='1'){
					var t_prx = (t_mon<10?t_mon:String.fromCharCode(t_mon+55));
					if(t_year<100){
						t_prx = t_year.slice(3,1) + t_prx + t_tggno.slice(2,3);
					}else{
						t_year = t_year-100;
						t_year = (t_year>=2?t_year+1:t_year);
						t_year = (t_year>=17?t_year+1:t_year);
						t_year = (t_year>=19?t_year+1:t_year);
						t_prx = String.fromCharCode(t_year+65) + t_prx + (t_tggno.slice(1)).slice(0,3);
					}
					var t_maxUno = '';
					var t_idStr = '';
					for(var k=0;k<q_bbsCount;k++){
						var xUno = $('#txtUno_' + k).val().trim().toUpperCase();
						var xPno = $('#txtProductno_' + k).val().trim().toUpperCase();
						var xDime = dec($('#txtDime_' + k).val().trim());
						xDime = (isNaN(xDime)?0:xDime);
						if(xUno.length>0 && xUno.slice(0,t_prx.length)==t_prx && xUno>t_maxUno){
							t_maxUno = xUno;
						}
						if(xUno.length==0 && xPno.length>0 && xDime != 0){
							t_idStr += k + '@';
						}
					}
					q_func('qtxt.query.getUno_awb', 'uno.txt,getUno_awb,' + t_prx + ';' + t_idStr + ';' + t_maxUno + ';RC2;' + t_noa,r_accy,1);
					var uno_as = _q_appendData('tmp0','',true,true);
					if(t_idStr.length>0 && uno_as[0]== undefined){
						alert('批號取得失敗!');
						return;
					}else if(uno_as[0] != undefined){
						uno_as.filter(function(item){
							$('#txtUno_' + item.xid).val(item.uno);
						});
					}
				}
				sum();
				if (q_cur === 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				$('#txtKind').val('A1');
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll('' + t_datea, '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('rc2_awb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}


			function sum(){
				var tt_money = 0;tt_tax = 0;
				for(var k=0;k<q_bbsCount;k++){
					var t_weight = dec($('#txtWeight_' + k).val());
					var t_price = dec($('#txtPrice_' + k).val());
					var t_class = $('#txtClass_' + k).val().trim().toUpperCase();
					var t_total = round(q_mul(t_weight,t_price),0);
					tt_money = q_add(tt_money,t_total);
					tt_tax = q_add(tt_tax,(t_class != 'N'?t_total:0));
					q_tr('txtTotal_'+k,t_total);
				}
				tt_tax = round(q_mul(tt_tax,0.05),0);
				q_tr('txtTax',tt_tax);
				q_tr('txtMoney',tt_money);
				q_tr('txtTotal',q_add(tt_money,tt_tax));
			}

			function bbsAssign() {
				for(var j=0;j<q_bbsCount;j++){
					$('#txtStyle_' + j).change(function(){
						var n = $(this)[0].id.split('_')[1];
						setProduct(n);
						sum();
					});
					$('#txtProductno_' + j).change(function(){
						var n = $(this)[0].id.split('_')[1];
						setProduct(n);
						sum();
					});
					$('#txtWeight_' + j).change(function(){
						sum();
					});
					$('#txtPrice_' + j).change(function(){
						sum();
					});
					$('#txtClass_' + j).change(function(){
						sum();
					});
					$('#txtUno_' + j).change(function(){
						var thisNoa = $('#txtNoa').val().trim();
						var thisVal = $(this).val().trim().toUpperCase();
						if(thisVal.length>0 && thisVal != 'ZZ'){
							q_gt('y_checkuno_awb',thisVal + ';' + thisNoa + ';RC2;',0,0,0,'','',1);
							var chUno_as = _q_appendData('y_checkuno_awb','',true,true);
							if(chUno_as[0] != undefined){
								alert('此鋼捲編號已存在! 入庫單號：' + chUno_as[0].noa);
								$(this).focus().select();
								return;
							}
						}
					});
					$('#btnRecord_' + j).click(function() {
						var n = replaceAll($(this).attr('id'), 'btnRecord_', '');
						q_box("z_rc2record.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";tgg=" + $('#txtTggno').val() + "&product=" + $('#txtProductno_' + n).val() + ";" + r_accy, 'z_vccstp', "95%", "95%", q_getMsg('popPrint'));
					});
				}
				_bbsAssign();
				changeUnoRead();
				bbsResize();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#cmbTypea').val('1');
				$('#txtCno').val('01');
				$('#txtDatea').val(q_date());
				$('#txtMon').val(q_date().slice(0,r_lenm));
				$('#txtTggno').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				t_where = "noa=" + $('#txtNoa').val();
				q_box("z_rc2stp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
                as['datea'] = abbm2['datea'];
                as['kind'] = abbm2['kind'];
                as['tggno'] = abbm2['tggno'];
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				changeUnoRead();
				sum();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				changeUnoRead();
			}

			function changeUnoRead(){
				var t_typea = $('#cmbTypea').val();
				for(var j=0;j<q_bbsCount;j++){
					if(q_cur==1 || q_cur==2){
						if(t_typea=='2'){
							$('#txtUno_' + j).val('').prop('readonly',true).css({
								color:t_color2,
								background:t_background2
							})
						}else{
							$('#txtUno_' + j).prop('readonly',false).css({
								color:'#000',
								background:t_background
							})
						}
					}
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
				min-width: 1210px;
			}
			.dview {
				float: left;
				width: 350px;
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
				width: 910px;
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
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:30px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:30px; color:black;"></td>
						<td align="center" style="width:90px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:90px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:90px; color:black;"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td style="text-align: center;" id='typea=cmbTypea'>~typea=cmbTypea</td>
						<td style="text-align: center;" id='datea'>~datea</td>
						<td style="text-align: center;" id='noa'>~noa</td>
						<td style="text-align: center;" id='tgg,4'>~tgg,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td><input id="txtInvono" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTgg' class="lbl"> </a></td>
						<td><input id="txtTggno" type="text" class="txt c1"/></td>
						<td colspan="4"><input id="txtTgg" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="5"><input id="txtTel" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="5"><input id="txtAddr" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><input id="txtKind" type="text" style="display: none;"/></td>
						<td><input id="txtCno" type="text" style="display: none;"/></td>
						<td><input id="txtMoney" type="text" style="display: none;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:35px;"><input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;width:30px;" /></td>
					<td align="center" style="width:50px;"><a id='lblNoq_s'> </a></td>
					<td align="center" style="width:110px;"><a id='lblUno_s'> </a></td>
					<td align="center" style="width:70px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:30px;"><a id='lblStyle_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblSpec_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblDime_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWidth_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblLengthb_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMweight_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblClass_s'> </a></td>
					<td align="center" style="width:50px;"><a>儲位</a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblRecord_s'></a></td>
					<td align="center" style="width:200px;"><a id='lblErrmemo_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblOrdeno_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblNo2_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;width:30px;" /></td>
					<td><input type="text" id="txtNoq.*" class="txt c1" /></td>
					<td><input type="text" id="txtUno.*" class="txt c1" /></td>
					<td><input type="text" id="txtProductno.*" class="txt c1" /></td>
					<td><input type="text" id="txtProduct.*" class="txt c1" /></td>
					<td><input type="text" id="txtStyle.*" class="txt c1" /></td>
					<td><input type="text" id="txtSpec.*" class="txt c1" /></td>
					<td><input type="text" id="txtDime.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtWidth.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtLengthb.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtMount.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtMweight.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtWeight.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtUnit.*" class="txt c1" /></td>
					<td><input type="text" id="txtPrice.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtTotal.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtClass.*" class="txt c1" /></td>
					<td><input type="text" id="txtStoreno.*" class="txt c1" /></td>
					<td><input type="text" id="txtMemo.*" class="txt c1" /></td>
					<td align="center"><input class="btn" id="btnRecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td><input type="text" id="txtErrmemo.*" class="txt c1" /></td>
					<td><input type="text" id="txtOrdeno.*" class="txt c1" /></td>
					<td><input type="text" id="txtNo2.*" class="txt c1" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
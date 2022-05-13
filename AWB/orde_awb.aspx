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
			var q_name = "orde";
			var q_readonly = ['txtNoa','txtTax','txtTotal'];
			var q_readonlys = ['txtNo2','txtC1','txtNotv','textNotv','txtWidth2','chkIscut'];
			var bbmNum = [['txtTax',15,0,0,1],['txtTotal',15,0,0,1]];
			var bbsNum = [['txtDime',15,2,1,1],['txtWidth',15,2,1,1],['txtLengthb',15,1,1,1],['txtWeight',15,1,1,1],['txtPrice',15,2,1,1],['txtTotal',15,0,1,1],['txtC1',15,1,1,1],['txtNotv',15,1,1,1],['txtWidth2',15,1,1,1],['txtWidth3',15,1,1,1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 5;
			brwCount = 5;
			brwCount2 = 5;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(
				['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtCustno2', 'lblCustno2', 'cust', 'noa,comp,tel,addr_home', 'txtCustno2,txtCust2,txtFax,txtAddr2', 'cust_b.aspx'],
				['txtProductno_', '', 'ucc', 'noa,product', 'txtProductno_', 'ucaucc_b.aspx'],
           		['txtStyle_', '', 'style', 'noa,product', 'txtStyle_', 'style_b.aspx']
			);
			q_desc=1;
			$(document).ready(function() {
				$.fn.colorbox.settings.speed = 0;//清除q_box動畫效果
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no2'];
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
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbCasetype", ',訂購,報價,預售,估價,出貨');
				$('#txtAgent').change(function(){
					var thisVal = $(this).val().trim();
					if(thisVal=='0'){
						$(this).val('');
					}else if(thisVal=='1'){
						$(this).val('林鴻鳴');
					}else if(thisVal=='2'){
						$(this).val('謝孟賢');
					}else if(thisVal=='3'){
						$(this).val('林謝素珍');
					}else if(thisVal=='4'){
						$(this).val('林香伶');
					}else if(thisVal=='5'){
						$(this).val('林香君');
					}
				});
				$('#txtWorker').change(function(){
					var thisVal = $(this).val().trim();
					if(thisVal=='0'){
						$(this).val('');
					}else if(thisVal=='1'){
						$(this).val('林鴻鳴');
					}else if(thisVal=='2'){
						$(this).val('謝孟賢');
					}else if(thisVal=='3'){
						$(this).val('林謝素珍');
					}else if(thisVal=='4'){
						$(this).val('林珮祺');
					}else if(thisVal=='5'){
						$(this).val('林晏翎');
					}
				});
				$('#btnQuatmemo').click(function(){
					$('.QuatMemo').toggle();
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
                    case 'txtCustno':
                        var t_custno = $('#txtCustno').val().trim();
						q_gt('cust',"where=^^ noa='"+t_custno+"' ^^",0,0,0,'','',1);
						var cust_as = _q_appendData('cust','',true,true);
						if(cust_as[0] != undefined){
							var telStr = cust_as[0].tel.slice(0,29) + ' FAX:' + cust_as[0].fax.slice(0,15);
							$('#txtTel').val(telStr);
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
				sum();
				if($('#txtWorker').val().trim()==''){
					$('#txtWorker').val(r_name);
				}
				$('#txtKind').val('A1');
				$('#txtMoney').val($('#txtTotal').val());
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll('' + $('#txtOdate').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('orde_awb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function sum(){
				var tt_total = 0;tt_tax = 0;
				for(var k=0;k<q_bbsCount;k++){
					var t_c1 = dec($('#txtC1_'+k).val());
					var t_weight = dec($('#txtWeight_'+k).val());
					var t_dweight = dec($('#txtWidth3_'+k).val());	//調整重量
					var t_per = round(q_mul(q_div(q_sub(t_weight,t_c1+t_dweight),t_weight),100),2);
					var t_price = dec($('#txtPrice_'+k).val());
					var t_class = $('#txtClass_' + k).val().trim().toUpperCase();
					var t_total = q_mul(t_weight,t_price)
					tt_total += t_total;
					if(t_class != 'N'){
						tt_tax += t_total
					}
					q_tr('txtTotal_'+k,t_total);
					q_tr('txtWidth2_'+k,t_per);
					$('#textNotv_'+k).val(q_sub(q_float('txtNotv_'+k),q_float('txtWidth3_'+k)))
				}
				q_tr('txtTotal',tt_total);
				q_tr('txtTax',round(q_mul(tt_tax,0.05),0));
			}

			function bbsAssign() {
				for(var j=0;j<q_bbsCount;j++){
					$('#txtSize_' + j).change(function(){
						var n = $(this)[0].id.split('_')[1];
						var thisVal = dec($(this).val());
						thisVal = (isNaN(thisVal)?0:thisVal);
						$('#txtMount_' + n).val(thisVal);
						sum();
					});
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
					$('#txtWidth3_' + j).change(function(){
						sum();
					});
				}
				_bbsAssign();
				bbsResize();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#cmbCasetype').val('訂購');
				$('#txtOdate').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				var t_where = "noa='" + $('#txtNoa').val() + "'";
				q_box("z_ordestp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
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
				as['mon'] = abbm2['mon'];
				as['type'] = abbm2['casetype'];
                as['noa'] = abbm2['noa'];
                as['odate'] = abbm2['odate'];
                as['kind'] = abbm2['kind'];
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				$('.QuatMemo').hide();
				sum();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
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
				width: 300px;
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
				color: blue;
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
				color: blue;
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
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCasetype' class="lbl"> </a></td>
						<td><select id="cmbCasetype" class="txt c1"></select></td>
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCustno' class="lbl"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan="5"><input id="txtComp" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="4"><input id="txtTel" type="text" class="txt c1"/></td>
						<td>
							<input id="chkAtax" type="checkbox" style="float:left;">
							<label for="chkAtax">美金</label>
						</td>
						<td><span> </span><a id='lblUnit' class="lbl"> </a></td>
						<td><input id="txtPostname" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSales' class="lbl"> </a></td>
						<td>
							<input id="txtSalesno" type="text" style="display:none;" class="txt c1"/>
							<input id="txtSales" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCustno2' class="lbl"> </a></td>
						<td><input id="txtCustno2" type="text" class="txt c1"/></td>
						<td colspan="4"><input id="txtCust2" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="5"><input id="txtAddr2" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAgent' class="lbl"> </a></td>
						<td><input id="txtAgent" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><button id="btnQuatmemo">報價備註</button></td>
						<td></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num"/></td>
					</tr>
					<tr class="QuatMemo">
						<td><span> </span><a id='lblM1' class="lbl"> </a></td>
						<td colspan="7"><input id="txtAddr" type="text" class="txt c1"/></td>
					</tr>
					<tr class="QuatMemo">
						<td><span> </span><a id='lblM2' class="lbl"> </a></td>
						<td colspan="7"><input id="txtOrdbno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="QuatMemo">
						<td><span> </span><a id='lblM3' class="lbl"> </a></td>
						<td colspan="7"><input id="txtPaytype" type="text" class="txt c1"/></td>
					</tr>
					<tr class="QuatMemo">
						<td><span> </span><a id='lblM4' class="lbl"> </a></td>
						<td colspan="7"><input id="txtOrdcno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="QuatMemo">
						<td><span> </span><a id='lblM5' class="lbl"> </a></td>
						<td colspan="7"><input id="txtUpfile2" type="text" class="txt c1"/></td>
					</tr>
					<tr class="QuatMemo">
						<td><span> </span><a id='lblM6' class="lbl"> </a></td>
						<td colspan="7"><textarea id="txtMemo2" cols="10" rows="5" style="height: 50px;" class="txt c1"> </textarea></td>
					</tr>
					<tr style="display:none">
						<td><input id="txtKind" type="text" style="display: none;"/></td>
						<td><input id="txtCno" type="text" style="display: none;"/></td>
						<td><input id="txtMoney" type="text" style="display: none;"/></td>
					</tr>
				</table>
			</div>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:30px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewCasetype'> </a></td>
						<td align="center" style="width:90px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:90px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td style="text-align: center;" id='casetype'>~casetype</td>
						<td style="text-align: center;" id='noa'>~noa</td>
						<td style="text-align: center;" id='comp,4'>~comp,4</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:35px;"><input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;width:30px;" /></td>
					<td align="center" style="width:50px;"><a id='lblNo2_s'> </a></td>
					<td align="center" style="width:70px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:30px;"><a id='lblStyle_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblSpec_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblDime_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWidth_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblLengthb_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit2_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblClassa_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblEnda_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:250px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:250px;"><a id='lblCuamemo_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblIscut_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblC1_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblNotv_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWidth2_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblWidth3_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblCancel_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;width:30px;" /></td>
					<td><input type="text" id="txtNo2.*" class="txt c1" /></td>
					<td><input type="text" id="txtProductno.*" class="txt c1" /></td>
					<td><input type="text" id="txtStyle.*" class="txt c1" /></td>
					<td><input type="text" id="txtProduct.*" class="txt c1" /></td>
					<td><input type="text" id="txtSpec.*" class="txt c1" /></td>
					<td><input type="text" id="txtDime.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtWidth.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtLengthb.*" class="txt c1 num" /></td>
					<td>
						<input type="text" id="txtMount.*" style="display:none;" class="txt c1 num" />
						<input type="text" id="txtSize.*" class="txt c1 num" />
					</td>
					<td><input type="text" id="txtUnit2.*" class="txt c1" /></td>
					<td><input type="text" id="txtWeight.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtUnit.*" class="txt c1" /></td>
					<td><input type="text" id="txtPrice.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtClass.*" class="txt c1" /></td>
					<td><input type="checkbox" id="chkEnda.*" class="txt c1" /></td>
					<td><input type="text" id="txtTotal.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtMemo.*" class="txt c1" /></td>
					<td><input type="text" id="txtSizea.*" class="txt c1" /></td>
					<td><input type="checkbox" id="chkIscut.*" class="txt c1" /></td>
					<td><input type="text" id="txtC1.*" class="txt c1 num" /></td>
					<td>
						<input type="text" id="textNotv.*" class="txt c1 num" />
						<input type="text" id="txtNotv.*" class="txt c1 num" style="display:none;"/>
					</td>
					<td><input type="text" id="txtWidth2.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtWidth3.*" class="txt c1 num" /></td>
					<td><input type="checkbox" id="chkCancel.*" class="txt c1" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
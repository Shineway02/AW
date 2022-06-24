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
			var q_name = "vcc";
			var q_readonly = ['txtNoa','txtAddr','txtTel','txtTax','txtMoney','txtTotal'];
			var q_readonlys = [];
			var bbmNum = [['txtTax', 15, 0, 1],['txtMoney', 15, 0, 1],['txtTotal', 15, 0, 1],['txtFloata', 15, 3, 1]];
			//111/06/24 鑫匯 厚 寬 長 只輸入到小數兩位 林小姐
			var bbsNum = [['txtDime', 10, 2, 0],['txtWidth', 10, 2, 0],['txtLengthb', 10, 2, 0],['txtMount', 15, 3, 1],['txtMount', 15, 3, 1],['txtMweight', 15, 3, 1],
											['txtWeight', 15, 3, 1],['txtPrice', 15, 3, 1],['txtTotal', 15, 3, 1],['txtGweight', 15, 3, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 7;
			brwCount = 7;
			brwCount2 = 7;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(
				['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],	
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtProductno_', '', 'ucc', 'noa,product', 'txtProductno_', 'ucaucc_b.aspx'],
           		['txtStyle_', '', 'style', 'noa,product', 'txtStyle_', 'style_b.aspx'],
				['txtUno_', '', 'view_uccc', 'uno,productno,product,spec,width,dime,lengthb,style,class,eweight,emount,eweight', '0txtUno_,txtProductno_,txtProduct_,txtSpec_,txtWidth_,txtDime_,txtLengthb_,txtStyle_,txtClass_,txtWeight_,txtMount_,txtGweight_', 'uccc_seek_b.aspx', '95%', '60%'],
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
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('vcc.typea'));
				$('#txtDatea').blur(function(){
					if(q_cur==1 || q_cur==2){
						if(!q_cd($('#txtDatea').val()) || $('#txtDatea').val().length==0){
							$('#txtDatea').val(q_date());
						}
						if($('#txtMon').val().length==0){
							$('#txtMon').val($('#txtDatea').val().slice(0,r_lenm));
						}
					}
				});
				$('#txtInvono').blur(function(){
					if(q_cur==1 || q_cur==2){
						var thisVal = $(this).val().trim().toUpperCase();
						if(thisVal.length>0 && thisVal.length<10 && thisVal.slice(0,1) != '0'){
							q_msg($('#txtInvono'),'發票號碼錯誤','',1000);
							$('#txtInvono').focus();
						}
						$('#txtInvono').val(thisVal);
					}
				})
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
				$('#btnGet').click(function() {
					var t_noa =$('#txtNoa').val()
					q_box("get_ps.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+"vno='"+t_noa + "';" + r_accy, 'gets', "95%", "95%", q_getMsg("popVcca"));
				});
				$('#txtAddr2').change(function(){
					var thisVal = $(this).val().trim();
					if(thisVal.length >= 2){
						q_gt('cust',"where=^^ (noa=N'"+thisVal+"') or (left(comp,2)=left('"+thisVal+"',2)) ^^",0,0,0,'FindAddr2','',1);
						var cust_as = _q_appendData('cust','',true,true);
						if(cust_as[0] != undefined){
							var r_1 = cust_as.filter(function(item){return item.noa==thisVal});
							if(r_1[0] != undefined){
								$('#txtAddr2').val(r_1[0].addr_fact + ' ' + r_1[0].comp.slice(0,4));
								$('#txtFax').val(r_1[0].tel);
							}else{
								$('#txtAddr2').val(cust_as[0].addr_fact + ' ' + cust_as[0].comp.slice(0,4));
								$('#txtFax').val(cust_as[0].tel);
							}
						}
					}else if(thisVal.length>0){
						alert('請至少輸入2個字');
						return;
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
					case 'txtCustno':
						var t_custno = $('#txtCustno').val();
						if(t_custno.length>0){
							q_gt('cust',"where=^^ noa='"+t_custno+"' ^^",0,0,0,'','',1);
							var cust_as = _q_appendData('cust','',true,true);
							if(cust_as[0] != undefined){
								$('#txtTel').val(cust_as[0].tel);
								$('#txtAddr').val(cust_as[0].addr_invo);
								$('#txtAddr2').val((cust_as[0].addr_fact.length==0?cust_as[0].addr_home:cust_as[0].addr_fact));
							}
							if(q_cur==1){
								for(var k=0;k<q_bbsCount;k++){
									$('#btnMinus_' + k).click();
								}
								q_gt('view_ordes',"where=^^ (isnull(custno,'')=N'"+t_custno+"') and (isnull(odate,'')>'094/06/31') and (isnull(enda,0)=0) and (isnull(cancel,0)=0) and (isnull(type,'')='訂購') ^^",0,0,0,'','',1);
								var ordes_as = _q_appendData('view_ordes','',true,true);
								if(ordes_as[0] != undefined){
									ordes_as = ordes_as.filter(function(item){
										item.weight = (dec(item.weight) != 0? dec(item.notv) : 0);
										return true;
									});
									q_gridAddRow(bbsHtm, 'tbbs',
										'txtProductno,txtProduct,txtStyle,txtSpec,txtClass,txtUnit,txtMemo,txtOrdeno,txtNo2,txtDime,txtWidth,txtLengthb,txtWeight,txtPrice,txtMount',
										ordes_as.length, ordes_as,
										'productno,product,style,spec,class,unit,memo,noa,no2,dime,width,lengthb,weight,price,mount',
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
				sum();
				if(dec($('#txtFloata').val())==0){
					$('#txtCoin').val('');
				}else{
					$('#txtCoin').val('USD');
				}
				
				if($('#txtDatea').val().substr(0,6)!=$('#txtMon').val() && $('#txtMemo').val().indexOf($('#txtMon').val().replace('/','年')+'月')==-1){
					$('#txtMemo').val($('#txtMemo').val()+' '+$('#txtMon').val().replace('/','年')+'月'+'帳款')
				}
				
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO"){
					q_gtnoa(q_name, replaceAll('' + $('#txtDatea').val(), '/', ''));
				}else{
					wrServer(s1);
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('vcc_awb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function sum(){
				var tt_money = 0;tt_tax = 0;
				var decM = (dec($('#txtFloata').val())==0?0:2)
				for(var k=0;k<q_bbsCount;k++){
					var t_weight = dec($('#txtWeight_' + k).val());
					var t_price = dec($('#txtPrice_' + k).val());
					var t_class = $('#txtClass_' + k).val().trim().toUpperCase();
					var t_total = round(q_mul(t_weight,t_price),decM);
					tt_money = q_add(tt_money,t_total);
					tt_tax = q_add(tt_tax,(t_class != 'N'?t_total:0));
					q_tr('txtTotal_'+k,t_total);
				}
				tt_tax = round(q_mul(tt_tax,0.05),decM);
				q_tr('txtTax',tt_tax);
				q_tr('txtMoney',tt_money);
				q_tr('txtTotal',q_add(tt_money,tt_tax));
			}

			function bbsAssign() {
				for(var j=0;j<q_bbsCount;j++){
					$('#txtWeight_' + j).change(function(){
						sum();
					})
					$('#txtPrice_' + j).change(function(){
						sum();
					})
					$('#txtClass_' + j).change(function(){
						sum();
					})
					$('#btnRecord_' + j).click(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						//t_where = "cust='" + $('#txtCustno').val() + "' and noq='" + $('#txtProductno_' + b_seq).val() + "'";
						t_where = "custno='" + $('#txtCustno').val() + "' and comp='" + $('#txtComp').val() + "' and productno='" + $('#txtProductno_' + b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "' and dime='"+$('#txtDime_'+b_seq).val()+"' and spec='" + $('#txtStyle_'+b_seq).val()+$('#txtSpec_'+b_seq).val()+"'";
						q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
					});
				}
				_bbsAssign();
				bbsResize();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtCno').val('01');
				$('#txtDatea').val(q_date()).focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				var t_report = "report='z_vcc_awb10'";
				q_box("z_vcc_awb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_report + ";" + r_accy + ";" + $('#txtNoa').val(), '', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
					var t_id = '0';
					if(r_userno=='001'){
						t_id = '1';
					}else if(r_userno=='002'){
						t_id = '8';
					}else if(r_userno=='003'){
						t_id = '6';
					}else if(r_userno=='006'){
						t_id = '7';
					}else if(r_userno=='021'){
						t_id = '3';
					}else if(r_userno=='022'){
						t_id = '5';
					}else if(r_userno=='023'){
						t_id = '2';
					}else{
						t_id = '0';
					}
					var t_noa=key_value.substr(0,7)+t_id+key_value.substr(7,3)
				if(q_cur==1)
					$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(t_noa);
				else
					$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
					
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				as['typea'] = abbm2['typea'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['datea'] = abbm2['datea'];
				as['custno'] = abbm2['custno'];
				as['kind'] = abbm2['kind'];
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
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
			}
		</script>
		<style type="text/css">
			#dmain {
				float:left;
				width:100%;
				min-width: 1300px;
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
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
						<td><input id="btnGet" type="button" value="領料單"/></td>
						<td></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
							<input id="txtCno" type="text" style="display:none;"/>
							<input id="chkAacc" type="checkbox" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCustno' class="lbl"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="4"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td><input id="txtInvono" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="5"><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td>
							<input id="txtFloata" type="text" class="txt c1 num"/>
							<input id="txtCoin" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="3"><input id="txtAddr" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="3"><input id="txtAddr2" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td><input id="txtFax" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSales' class="lbl"> </a></td>
						<td><input id="txtSalesno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num"/></td>
						<td></td>
						<td><input id="txtSales" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl"> </a></td>
						<td colspan="7"><input id="txtPart2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:30px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewTypea'> </a></td>
						<td align="center" style="width:90px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:90px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:90px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id='typea=cmbTypea' style="text-align: center;">~typea=cmbTypea</td>
						<td style="text-align: center;" id='datea'>~datea</td>
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
					<td align="center" style="width:50px;"><a id='lblNoq_s'> </a></td>
					<td align="center" style="width:140px;"><a id='lblUno_s'> </a></td>
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
					<td align="center" style="width:40px;"><a id='lblAprice_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblGweight_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblRecord_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblSize_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblOrdeno_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblNo2_s'> </a></td>
					<td align="center" style="width:140px;"><a>LOT.NO</a></td>
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
					<td><input type="text" id="txtClass.*" class="txt c1" /></td>
					<td><input type="text" id="txtTotal.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtGweight.*" class="txt c1 num" /></td>
					<td><input type="text" id="txtMemo.*" class="txt c1" /></td>
					<td align="center"><input class="btn"  id="btnRecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td><input type="text" id="txtSize.*" class="txt c1" /></td>
					<td><input type="text" id="txtOrdeno.*" class="txt c1" /></td>
					<td><input type="text" id="txtNo2.*" class="txt c1" /></td>
					<td><input type="text" id="txtRackno.*" class="txt c1" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
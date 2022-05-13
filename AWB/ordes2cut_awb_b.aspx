<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Language" content="en-us" />
	<title> </title>
	<script src="../script/jquery.min.js" type="text/javascript"> </script>
	<script src="../script/qj2.js" type="text/javascript"> </script>
	<script src='qset.js' type="text/javascript"> </script>
	<script src="../script/qj_mess.js" type="text/javascript"> </script>
	<script src="../script/qbox.js" type="text/javascript"> </script>
	<link href="../qbox.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
		var q_name = 'orde2cut', t_bbsTag = 'tbbs', t_content = "", afilter = [], bbsKey = ['noa', 'noq'], t_count = 0, as;
		var t_sqlname = 'orde2cut'; t_postname = q_name;
		var isBott = false;
		var txtfield = [], afield, t_data, t_htm;
		var i, s1;
		var bbsNum = [['txtUmount', 10, 2, 1],['txtMount',10, 2, 1],['txtWeight',10, 0, 1],['txtNotv',10, 2, 1],['txtInprice',10, 2, 1]];
		var q_readonlys = ['txtProductno', 'txtProduct', 'txtSpec','txtWidth','txtDime','txtLengthb','txtMount','txtWeight','txtNoa','txtNo2','txtMemo'];
		brwCount=-1;
		brwCount2 = 0;
		$(document).ready(function () {
			q_gt('style', '', 0, 0, 0, '','',1);
			q_gt('xmodel', '', 0, 0, 0, '','',1);
			main();
			setTimeout('parent.$.fn.colorbox.resize({innerHeight : "750px"})', 300);
		});
		function distinct(arr1){
			var uniArray = [];
			for(var i=0;i<arr1.length;i++){
				var val = arr1[i];
				if($.inArray(val, uniArray)===-1){
					uniArray.push(val);
				}
			}
			return uniArray;
		}
				
		function main() {
			if (dataErr){
				dataErr = false;
				return;
			}
			var w = window.parent;
			var t_where = '';
			t_where += w.$('#txtDime').val()+';';
			mainBrow(6, t_where, 'y_orde2cut_awb', t_postname,r_accy);
			w.$('#cboxTitle').text('若沒有找到相關資料，請注意類別的選取。').css('color','red').css('font-size','initial');
			parent.$.fn.colorbox.resize({
				height : "750px"
			});
		}
		function bbsAssign() {
			_bbsAssign();
			for (var j = 0; j < q_bbsCount; j++) {
				$('#vTr_'+j).bind('contextmenu', function(e) {
					e.preventDefault();
					var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
					SelChange(n);
				});
				$('#chkSel_'+j).change(function(){
					var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
					$(this).attr('checked',!$(this).attr('checked'));
					SelChange(n);
				});
			}
			bbsResize();
		}

		function SelChange(n){
			if(!$('#chkSel_'+n).attr('checked')){
				$('#chkSel_'+n).attr('checked',true);
			}else{
				$('#chkSel_'+n).attr('checked',false);
			}
			if($('#chkSel_'+n).attr('checked')){
				$('#vTr_'+n + ' td').css('background','#ff9c9c');
			}else{
				$('#vTr_'+n + ' td').css('background','#cad3ff');
			}
		}
		function q_gtPost(t_name) { 
			switch(t_name){
				case q_name:
					break;
			}
		}
		function readonly(t_para, empty) {
			_readonly(t_para, empty);
		}

		function refresh() {
			_refresh();
			$('#btnTop').hide();
			$('#btnPrev').hide();
			$('#btnNext').hide();
			$('#btnBott').hide();
			$('#checkAllCheckbox').click(function(){
				$('input[type=checkbox][id^=chkSel]').each(function(){
					if($(this).is(':visible')){
						var t_id = $(this).attr('id').split('_')[1];
						if(!emp($('#txtProductno_' + t_id).val())){
							SelChange(t_id);
						}
					}
				});
			});
			q_bbsCount = abbs.length;

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
	</script>
	<style type="text/css">
		.txt.c1 {
			width: 98%;
			float: left;
		}
		.txt {
			float:left;
		}
		.txt.num {
			text-align: right;
		}
		input[type="text"],input[type="button"] {     
			font-size: medium;
		}
		.dbbs .tbbs{
			margin:0;
			padding:2px;
			border:2px lightgrey double;
			border-spacing:1px;
			border-collapse:collapse;
			font-size:medium;
			color:blue;
			background:#cad3ff;
			width: 100%;
		}
		.dbbs .tbbs tr{
			height:35px;
		}
		.dbbs .tbbs tr td{
			text-align:center;
			border:2px lightgrey double;
		}
		.tbbs tr:first-child td{
			background: #003366;
			top: 0px;
			left: 0px;
			position: sticky;
		}

	</style>
</head>
<body ondragstart="return false" draggable="false"
ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
	<div id="dbbs" style="overflow: scroll;height:550px;" >
		<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width: 1600px;table-layout: fixed;'>
			<tr style='color:White; background:#003366;' >
				<td align="center" style="width:30px;"></td>
				<td align="center" style="width:90px;"><a>公司名稱</a></td>
				<td align="center" style="width:50px;"><a>類別</a></td>
				<td align="center" style="width:60px;"><a>名稱</a></td>
				<td align="center" style="width:60px;"><a>板面</a></td>
				<td align="center" style="width:60px;"><a>厚度</a></td>
				<td align="center" style="width:60px;"><a>寬度</a></td>
				<td align="center" style="width:60px;"><a>長度</a></td>
				<td align="center" style="width:70px;"><a>數量</a></td>
				<td align="center" style="width:30px;"><a>件</a></td>
				<td align="center" style="width:80px;"><a>訂量</a></td>
				<td align="center" style="width:40px;"><a>單位</a></td>
				<td align="center" style="width:90px;"><a>預交日</a></td>
				<td align="center" style="width:90px;"><a>訂單日期</a></td>
				<td align="center" style="width:50px;"><a>貨單</a></td>
				<td align="center" style="width:90px;"><a>單價</a></td>
				<td align="center" style="width:110px;"><a>憑證編號</a></td>
			</tr>
			<tr id="vTr.*" style='background:#cad3ff;'>
				<td align="center">
					<input id="chkSel.*" style="width:1rem;height:1rem;" type="checkbox"/>
					<input id="txtStyle.*" type="hidden"/>
				</td>
				<td><input class="txt c1" id="txtComp.*" type="text"/></td>
				<td><input class="txt c1" id="txtProductno.*" type="text"/></td>
				<td><input class="txt c1" id="txtProduct.*" type="text"/></td>
				<td><input class="txt c1" id="txtSpec.*" type="text" /></td>
				<td><input class="txt c1 num" id="txtDime.*" type="text" /></td>
				<td><input class="txt c1 num" id="txtWidth.*" type="text" /></td>
				<td><input class="txt c1 num" id="txtLengthb.*" type="text" /></td>
				<td><input class="txt c1 num" id="txtMount.*" type="text" /></td>
				<td><input class="txt c1" id="txtUnit2.*" type="text" /></td>
				<td><input class="txt c1 num" id="txtWeight.*" type="text" /></td>
				<td><input class="txt c1" id="txtUnit.*" type="text" /></td>
				<td><input class="txt c1" id="txtDatea.*" type="text" /></td>
				<td><input class="txt c1" id="txtOdate.*" type="text" /></td>
				<td><input class="txt c1" id="txtCasetype.*" type="text" /></td>
				<td><input class="txt c1 num" id="txtPrice.*" type="text" /></td>
				<td>
					<input class="txt c1" id="txtNoa.*" type="text" />
					<input id="txtNo2.*" type="text" style="display: none;" />
				</td>
			</tr>
		</table>
	</div>
	<!--#include file="../inc/brow_ctrl.inc"-->
	<div id="q_acDiv" style="display: none;"></div>
</body>
</html>
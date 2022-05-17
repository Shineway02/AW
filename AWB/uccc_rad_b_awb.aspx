<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'view_uccc', t_content = ' ', bbsKey = ['uno'], as;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			var q_readonly = ['textProduct', 'textStore'];
			brwCount = -1;
			brwCount2 = 0;
			aPop = new Array(
				['textProductno', '', 'ucc', 'noa', 'textProductno', 'ucc_b.aspx'], 
				['textStyle', '', 'style', 'noa,product', 'textStyle,textProduct', 'style_b.aspx'],
				['textStoreno', '', 'store', 'noa,store', 'textStoreno', 'store_b.aspx']
			);
			isLoadGt = 0;
			$(document).ready(function() {
				t_content += ' where=^^ 1=0 ^^';
				main();
			});
		
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				var w = window.parent;
				mainBrow(6, SeekStr(true),'y_getuccc2_awb',q_name,r_accy);
				w.$('#cboxTitle').text('若沒有找到相關資料，請注意類別的選取。').css('color', 'red').css('font-size', 'initial');
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			var SeekF = new Array();
			function mainPost() {
				q_getFormat();

				$('#textProductno').focus(function() {
					q_cur = 1;
				}).blur(function() {
					q_cur = 0;
				});

				$('#seekTable td').children("input:text").each(function() {
					SeekF.push($(this).attr('id'));
				});
				SeekF.push('btnToSeek');
				$('#seekTable td').children("input:text").each(function() {
					$(this).bind('keydown', function(event) {
						keypress_bbm(event, $(this), SeekF, 'btnToSeek');
					});
				});
				$('#btnToSeek').click(function() {
					Lock();
					seekData(SeekStr());
				});
				parent.$.fn.colorbox.resize({
					height : "750px"
				});

				$('#textBdime').keyup(function(e) {
					if(e.keyCode>=37 && e.keyCode<=40)
						return;
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				
				$('#textEdime').keyup(function(e) {
					if(e.keyCode>=37 && e.keyCode<=40)
						return;
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				
				$('#textWidth').keyup(function(e) {
					if(e.keyCode>=37 && e.keyCode<=40)
						return;
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});
				
				$('#textLengthb').keyup(function(e) {
					if(e.keyCode>=37 && e.keyCode<=40)
						return;
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
				});

			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'y_getuccc2_awb':
						if (isLoadGt == 1) {
							Unlock();
							abbs = _q_appendData('y_getuccc2_awb', "", true);
							isLoadGt = 0;
							refresh();
						}
						break;
					case q_name:
						break;
				}
			}

			function seekData(seekStr) {
				isLoadGt = 1;
				q_gt('y_getuccc2_awb', seekStr, 0, 0, 0, "");
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
				}
				_bbsAssign();
			}

			function SeekStr(isFirst) {
				t_pno = trim($('#textProductno').val());
				if(isFirst != undefined && isFirst==true){
					t_pno = 'ZZZZZ';
				}
				t_uno = trim($('#textUno').val());
				t_spec = trim($('#textSpec').val());
				t_bdime = q_float('textBdime');
				t_edime = q_float('textEdime');
				t_width = q_float('textWidth');
				t_lengthb = q_float('textLengthb');
				var t_where = "";
				t_where = t_pno + ';' + t_spec + ';' + t_bdime + ';' + t_width + ';' + t_lengthb + ';' + t_uno + ';'+t_edime+';';
				return t_where;
			}

			function refresh() {
				_refresh();
			}
		</script>
		<style type="text/css">
            #seekForm {
                margin-left: auto;
                margin-right: auto;
                width: 950px;
            }
            #seekTable {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            #seekTable tr {
                height: 35px;
            }
            #seekTable td {
                width: 100px;
            }
            .txt.c1 {
                width: 95%;
            }
            .lbl {
                float: right;
            }
            span {
                margin-right: 5px;
            }
            .num {
                text-align: right;
            }
            input {
                font-size: medium;
            }
            #q_acDiv {
            	width:auto;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false" ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();" ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();" >
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style="table-layout: fixed;">
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:10px;background: #003366;position: sticky;left: 0px;top: 0px;" ></td>
					<td align="center" style="width:180px;background: #003366;position: sticky;left: 0px;top: 0px;"><a>鋼捲編號</a></td>
					<td align="center" style="width:100px;background: #003366;position: sticky;left: 0px;top: 0px;"><a>鋼種</a></td>
					<td align="center" style="width:100px;background: #003366;position: sticky;left: 0px;top: 0px;"><a>板面</a></td>
					<td align="center" style="width:100px;background: #003366;position: sticky;left: 0px;top: 0px;"><a>厚度</a></td>
					<td align="center" style="width:80px;background: #003366;position: sticky;left: 0px;top: 0px;"><a>寬度</a></td>
					<td align="center" style="width:80px;background: #003366;position: sticky;left: 0px;top: 0px;"><a>長度</a></td>
					<td align="center" style="width:100px;background: #003366;position: sticky;left: 0px;top: 0px;"><a>可領料重量</a></td>
					<td align="center" style="width:100px;background: #003366;position: sticky;left: 0px;top: 0px;"><a>單價</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input name="sel" id="radSel.*" type="radio"/></td>
					<td align="center"><input id="txtUno.*" type="text" class="txt c1"/></td>
					<td align="center"><input id="txtProductno.*" type="text" class="txt c1"/></td>
					<td align="center"><input id="txtSpec.*" type="text" class="txt c1"/></td>
					<td align="center"><input id="txtDime.*" type="text" class="txt num c1"/></td>
					<td align="center"><input id="txtWidth.*" type="text" class="txt num c1"/></td>
					<td align="center"><input id="txtLengthb.*" type="text" class="txt num c1"/></td>
					<td align="center"><input id="txtEweight.*" type="text" class="txt c1 num"/></td>
					<td align="center"><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
		<div id="seekForm">
			<table id="seekTable" border="0" cellpadding='0' cellspacing='0'>
				<tr>
					<td><span class="lbl"><a id='lblProductno_rs'>鋼種</a></span></td>
					<td><input id="textProductno" type="text" class="txt c1"/></td>
					<td><span class="lbl"><a id='lblSpec'>版面</a></span></td>
					<td><input id="textSpec" type="text" class="txt c1"/></td>
				</tr>
				<tr>
					<td><span class="lbl"><a id='lblDime'>厚度</a></span></td>
					<td>
						<input id="textBdime" type="text" class="txt c1 num" style="width:42%"/>
						<a>~</a>
						<input id="textEdime" type="text" class="txt c1 num" style="width:42%"/>
					</td>
					<td><span class="lbl"><a id='lblWidth'>寬度</a></span></td>
					<td><input id="textWidth" type="text" class="txt c1 num"/></td>
					<td><span class="lbl"><a id='lblLengthb'>長度</a></span></td>
					<td><input id="textLengthb" type="text" class="txt c1 num"/></td>
					<td style="width: 5px;"> </td>
				</tr>
				<tr>
					<td><span class="lbl"><a id='lblOrdeno'>批號</a></span></td>
					<td colspan="3"><input id="textUno" type="text" class="txt c1"/></td>
					<td><input type="button" id="btnToSeek" value="查詢"></td>
				</tr>
			</table>
			<div id="q_acDiv" style="display: none;">
				<div> </div>
			</div>
		</div>
	</body>
</html>
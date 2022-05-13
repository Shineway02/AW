<!DOCTYPE html>
<html>
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			var q_name = "cut_s";
			aPop = new Array(
			);
			$(document).ready(function () {
				main();
			});

			function main() {
				mainSeek();
				q_gf('', q_name);
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();
				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
				q_mask(bbmMask);

				if (q_getPara('sys.dateshow') == 1) {
					if (r_len === 4) {
						$.datepicker.r_len = 4;
					}
					$('#txtBdate').datepicker();
					$('#txtEdate').datepicker();
				}
				$('#txtNoa').focus();
			}

			function q_seekStr() {
				var t_noa = $.trim($('#txtNoa').val());
				var t_bdate = $('#txtBdate').val();
				var t_edate = $('#txtEdate').val();
				var t_uno = $('#txtUno').val();
				var t_bno = $('#txtBno').val();

				t_edate = (t_edate.length==0?'char(255)':t_edate);
				var t_where = " 1=1 "
					+ q_sqlPara2("noa", t_noa)
					+ q_sqlPara2("uno", t_uno)
					+ q_sqlPara2("datea", t_bdate, t_edate);
				if (t_bno.length > 0){
					t_where += " and exists(select noa from view_cuts" + r_accy + " where view_cuts" + r_accy + ".noa=view_cut" + r_accy + ".noa and view_cuts" + r_accy + ".bno='" + t_bno + "')";
				}
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				background-color: #76a2fe;
			}
		</style>
	</head>

	<body ondragstart="return false" draggable="false"
		ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
		ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
		ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div style='width:400px; text-align:center;padding:15px;'>
			<table id="seek" border="1" cellpadding='3' cellspacing='2' style='width:100%;'>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a>裁剪單號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;"><a>裁剪日期</a></td>
					<td style="width:65%;  ">
						<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a>鋼捲批號</a></td>
					<td><input class="txt" id="txtUno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a>餘料編號</a></td>
					<td><input class="txt" id="txtBno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
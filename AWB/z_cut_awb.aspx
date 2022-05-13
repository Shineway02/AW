<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            var wPara = [];
            var ShowReport = '';
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_cut_awb');
                var isFind = false;
                var wPara = q_getHref();
                if(!(wPara.length>=2 && wPara[0].toUpperCase()=='REPORT')){
                    window.history.back();
                }else{
                    q_nameu = wPara[1];
                }
                ShowReport = wPara[1];
                $('#q_report').click(function(e) {
                    if(wPara.length>=2 && wPara[0].toUpperCase()=='REPORT'){
                        for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
                            if(ShowReport.toUpperCase() == $('#q_report').data().info.reportData[i].report.toUpperCase()){
                                $('#q_report div div').eq(i).show();
                                if($('#q_report div div').eq(i).find('span').eq(0).hasClass('nonselect')){
                                    $('#q_report div div').eq(i).click();
                                }
                                isFind = true;
                            }else{
                                $('#q_report div div').eq(i).hide();
                            }
                        }
                    }
                    if(!isFind){
                        window.history.back();
                    }
				});
			});
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_cut_awb',
					options : [{
                        type : '0',//[1]
                        name : 'xnameu',
                        value : (q_nameu.length>0?q_nameu:q_name)
					}, {
						type : '1',//[2.3]
						name : 'xdate'
					},{
	                    type : '0',//[4]
	                    name : 'r_len',
	                    value : r_len
	                },{
	                    type : '0',//[5]
	                    name : 'r_name',
	                    value : r_name
	                },{
	                    type : '0',//[6]
	                    name : 'xip',
						value : location.hostname
	                }, {
						type : '1',//[7,8]
						name : 'xnoa'
					}, {
						type : '5',//[9]
						name : 'xtable',
						value : ('#non@全部,進貨,裁剪').split(',')
					}, {
						type : '6',//[10]
						name : 'xuno'
					}]
				});
				
				q_popAssign();
				q_langShow();

                $('#txtXdate1').mask(r_picd);
                $('#txtXdate2').mask(r_picd);

				$('#q_report').click();
				if(q_getId2()[5]!=undefined){
					$('#txtXnoa1').val(q_getId2()[5]);
					$('#txtXnoa2').val(q_getId2()[5]);
					$('#txtXmon1').val("");
					$('#txtXmon2').val("");
					$('#txtXdate1').val("");
					$('#txtXdate2').val("");
					$('#txtXcust1a').val("");
					$('#txtXcust2a').val("");
					$('#btnOk').click();
				}
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {
				}
			 }

			function q_boxClose(s2) {
			}
		</script>
		<style type="text/css">
			select {
				font-size: medium;
			}
			.q_report .option div .c4 {
    			width: auto;
			}
			.num {
				text-align: right;
				padding-right: 2px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
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
				q_gf('', 'z_uno_awb');
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
                                if($('#q_report div div').eq(i).find('span').eq(0).hasClass('nonselect') && !isFind){
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
					fileName : 'z_uno_awb',
					options : [{
                        type : '0',
                        name : 'xnameu',
                        value : (q_nameu.length>0?q_nameu:q_name)
                    },{
						type : '1',
						name : 'xuno'
                    },{
						type : '1',
						name : 'xstoreno'
                    },{
						type : '6',
						name : 'xpno'
                    },{
						type : '6',
						name : 'xspec'
                    },{
						type : '1',
						name : 'xdime'
                    },{
						type : '1',
						name : 'xwidth'
                    },{
						type : '1',
						name : 'xlengthb'
                    },{
						type : '6',
						name : 'xstore'
                    },{
						type : '6',
						name : 'yuno'
                    },{
						type : '1',
						name : 'xdate'
                    },{
                        type : '2',
                        name : 'xtggno',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    },{
                        type : '2',
                        name : 'xsssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '5', 
                        name : 'xkind',
                        value : ['uccc@庫存', 'uccb@歷史庫存']
                    },{
						type : '1',
						name : 'ypno'
					}]
				});
				q_popAssign();
				q_langShow();
				$('#txtXdate1').mask(r_picd);
                $('#txtXdate2').mask(r_picd);
                $('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01').datepicker();
                $('#txtXdate2').val(q_date()).datepicker();

				$('#q_report').click();
				$('#txtXdime1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXdime2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
				$('#txtXwidth1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXwidth2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
				$('#txtXlengthb1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXlengthb2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
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
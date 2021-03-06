<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>${_res.get('Purchase.of.course')}</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">

<link type="text/css" href="/css/css/bootstrap.min.css" rel="stylesheet" />
<link type="text/css" href="/css/css/style.css" rel="stylesheet" />
<link href="/css/css/plugins/chosen/chosen.css" rel="stylesheet">
<link href="/css/css/plugins/chosen/chosen_style.css" rel="stylesheet">
<link href="/css/css/layer/need/laydate.css" rel="stylesheet">
<link href="/js/js/plugins/layer/skin/layer.css" rel="stylesheet">
<link href="/font-awesome/css/font-awesome.css?v=1.7" rel="stylesheet">

<!-- Morris -->
<link href="/css/css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet">
<!-- Gritter -->
<link href="/js/js/plugins/gritter/jquery.gritter.css" rel="stylesheet">
<link href="/css/css/animate.css" rel="stylesheet">
<link rel="shortcut icon" href="/images/ico/favicon.ico" />

<style type="text/css">
body {
	background-color: #eff2f4;
}
.student_list_wrap {
	position: absolute;
	top: 28px;
	left: 14.8em;
	width: 130px;
	overflow: hidden;
	z-index: 2012;
	background: #09f;
	border: 1px solide;
	border-color: #e2e2e2 #ccc #ccc #e2e2e2;
	padding: 6px;
}
.student_list_wrap li {
	display:block;
	line-height: 20px;
	padding: 4px 0;
	border-bottom: 1px dashed #E2E2E2;
	color: #FFF;
	cursor: pointer;
	margin-right:38px;
}
</style>
</head>
<body>
	<div id="wrapper">
				<div class="ibox-content">
				<form id="courseOrderForm" action="" method="post">
					<input type="hidden" id="studentId" name="courseOrder.studentid" value="${courseOrder.studentid }"/>
					<input type="hidden" id="orderId" name="courseOrder.id" value="${courseOrder.id }"/>
					<input type="hidden" id="paycount" value="${courseOrder.paycount }"/>
					<input type="hidden" name="courseOrder.version" value="${courseOrder.version + 1}">
					<input type="hidden" id="type" name="type" value="${type}"/>
					<fieldset style="width: 100%; padding-top:15px;">
						<p>
							<label>${_res.get("student.name")}：</label>${student.real_name }
							<label>${_res.get('name.of.subject')}：</label>${subject.subject_name }
							<label>${_res.get('total.sessions')}：</label>${courseOrder.classhour }${_res.get('session')}
							<label>实收：</label>${courseOrder.realsum }元
							<label>优惠：</label>${courseOrder.rebate }元
							<label>总已排：</label>${courseOrder.classhour-courseOrder.remainclasshour }${_res.get('session')}
						</p>
						<p>
							<label>预购课时：</label>
							<div style="margin-left:70px;">
							<c:forEach items="${coursePriceList}" var="course" varStatus="index">
							${course.course_name }(${course.unitprice }元/${_res.get('session')})：
							<input id="classhour" type="text" name="ks_${course.courseid }" value="${course.classhour }" size="2" maxlength="5"  onfocus="checkValue(this)" onBlur="computeZks()">课时&nbsp;
							<input type="hidden" id="price_ks_${course.courseid }" value="${course.unitprice }">
							<input type="hidden" id="yp_ks_${course.courseid }" value="${course.classhour-course.remainclasshour }">
							${_res.get("scheduled.classes")}：${course.classhour-course.remainclasshour }${_res.get('session')}
							<br/><br/>
							</c:forEach>
							<span id="courseInfo" style="color: red;"></span>
							</div>
						</p>
						<p>
							<label>总&nbsp;&nbsp;课&nbsp;&nbsp;时：</label>
							<input id="totalClasshour" type="text" style="text-align: right;" name="courseOrder.classhour" value="${courseOrder.classhour }" size='6' readonly="readonly"/>&nbsp;${_res.get('session')}
							<input id="oldzks" type="hidden" style="text-align: right;" name="courseOrder.classhour" value="${courseOrder.classhour }" size='6' readonly="readonly"/>
							<input id="ypzks" type="hidden" style="text-align: right;" name="remainclasshour" value="${courseOrder.classhour-courseOrder.remainclasshour }" size='6' readonly="readonly"/>
							原购：${courseOrder.classhour }${_res.get('session')}&nbsp;${_res.get("scheduled.classes")}：${courseOrder.classhour-courseOrder.remainclasshour }${_res.get('session')}
							<span id="classhourInfo" style="color: red;"></span>
						</p>
						<p>
							<label>总&nbsp;&nbsp;金&nbsp;&nbsp;额：</label>
							<input id="totalsum" type="text" style="text-align: right;" name="courseOrder.totalsum" value="${courseOrder.totalsum }" size='6' readonly="readonly"/>&nbsp;元
							<input id="oldtotalsum" type="hidden" style="text-align: right;" name="courseOrder.totalsum" value="${courseOrder.totalsum }" size='6' readonly="readonly"/>
							<span id="totalInfo" style="color: red;"></span>
						</p>
						<p>
							<label>转存金额：</label>
							<input id="zhuancun" type="text" style="text-align: right;" name="zhuancun" value="0" size='6' readonly="readonly"/>&nbsp;元
						</p>	
						<c:if test="${operator_session.qx_ordersupdate }">
						<p>
							<input type="button" value="${_res.get('admin.common.determine')}" onclick="return saveCourseOrder();" class="btn btn-outline btn-primary" />
						</p>
						</c:if>
					</fieldset>
				</form>
	 </div>	
	</div>
	<script src="/js/js/jquery-2.1.1.min.js"></script>
	<!-- Chosen -->
	<script src="/js/js/plugins/chosen/chosen.jquery.js"></script>
	<!-- layer javascript -->
	<script src="/js/js/plugins/layer/layer.min.js"></script>
	<script>
        layer.use('extend/layer.ext.js'); //载入layer拓展模块
    </script>
	<script>
	 $(".chosen-select").chosen({disable_search_threshold: 30});
		var config = {
			'.chosen-select' : {},
			'.chosen-select-deselect' : {
				allow_single_deselect : true
			},
			'.chosen-select-no-single' : {
				disable_search_threshold : 10
			},
			'.chosen-select-no-results' : {
				no_results_text : 'Oops, nothing found!'
			},
			'.chosen-select-width' : {
				width : "95%"
			}
		}
		for ( var selector in config) {
			$(selector).chosen(config[selector]);
		}

		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.iframeAuto(index);
		
		function searchCourse() {
			var subjectId = $("#subjectId").val();
			if ("" == subjectId) {
				$("#gmks").hide();
			} else {
				var queryUrl = "${cxt}/course/getCoursesBySubjectIdForJSON";
				$.ajax({
					type : "post",
					url : queryUrl,
					data : {
						"SUBJECT_ID" : subjectId
					},
					dataType : "json",
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					async : false,
					success : function(data) {
						var input = "";
						var priceInput = "<br/>";
						if(data.code==0){
							layer.msg(data.msg,2,5);
						}else{
							var sameprice = data.sameprice;
							$("#gmks").show();
							var subjectName = "";
							for (i in data.courses) {
								var courseId=data.courses[i].ID;
								var courseName=data.courses[i].COURSE_NAME;
								var price=data.courses[i].UNIT_PRICE;
								subjectName=data.courses[i].SUBJECT_NAME;
								if((parseInt(i)+1)/2==1){
								input += courseName
									+"("+ price + "元/${_res.get('session')})：<input id='classhour' type='text' name='ks_" + courseId + "' value='0' size='2' maxlength='5'  onfocus='checkValue(this)' onBlur='computeZks()'>课时;&nbsp;<br/><br/>";
								}else{
									input += courseName
									+"("+ price + "元/${_res.get('session')})：<input id='classhour' type='text' name='ks_" + courseId + "' value='0' size='2' maxlength='5'  onfocus='checkValue(this)' onBlur='computeZks()'>课时;&nbsp;";
								};		
								priceInput += "<input type='hidden' id='price_ks_" + courseId + "' value='"+price+"'>";
							}
							$("#courses").html(input);
							$("#price").html(priceInput);
						}
					}
				});
			}
		}

		$(function() {
			$("input[id='teachtype']").click(function() {
				var teachType = $(this).val();
				if(teachType == 1){
					$("#totalClasshour").val(0);
					$("#totalsum").val(0);
					$("#rebate").val(0);
					$("#realsum").val(0);
					$("#classorderid").val('');
					$("#km").show();
					$("#bc").hide();
				}else{
					$("#km").hide();
					$("#bc").show();
					$("#courses").html("");
					$("#gmks").hide();
					$("#totalClasshour").val(0);
					$("#totalsum").val(0);
					$("#rebate").val(0);
					$("#realsum").val(0);
					$("#subjectId").val('');
				}
			});
		});
		$(function() {
			$('#realsum').keyup(function() {
				var realsum = $(this).val();
				var totalsum = $("#totalsum").val();
				if(realsum==""){
					$("#realsum").val(totalsum);
					$("#rebate").val(0);
					$("#realsumInfo").text("");
				}else{
					if(realsum.match(/^([1-9]\d*[.5]*|[0]{1,1}[.5]*)$/)==null){
						$(this).val("");
						$("#realsumInfo").text("请输入正确的实收金额");
					}else{
						if(parseFloat(realsum)>parseFloat(totalsum)){
							$("#realsum").val(totalsum);
							$("#rebate").val(0);
							$("#realsumInfo").text("实收金额不能大于总金额。");
						}else{
							$("#realsumInfo").text("");
							var rebate = totalsum-realsum;
							$("#rebate").val(rebate);
						}
					}
				}
			});
		});
		function computeZks() {
			var totalClasshour = 0;
			var totalsum = 0;
			var rebate = 0;
			var hasChar = 0;
			var realsum = $("#realsum").val();
			$("input[id='classhour']").each(function() {
				var classhour = $(this).val();
				if (classhour.match(/^[0-9]+(.[0,5]{1})?$/) == null) {
					classhour = 0;
					$(this).val("");
				}
				var ksname = $(this).attr('name');
				var price = $("#price_" + ksname).val();
				var ypks = $("#yp_" + ksname).val();
				if(Number(classhour)<Number(ypks)){
					classhour=ypks;
					$(this).val(classhour);
					$("#courseInfo").text("预购课时不能小于已排课时");
				}else{
					$("#courseInfo").text("");
				}
				totalsum += parseFloat(price * classhour);
				totalClasshour += parseFloat(classhour);
			});
			var oldtotalsum = $("#oldtotalsum").val();
			if(oldtotalsum<totalsum){
				$("#totalInfo").text("调整后的总金额不能大于原总金额");
				return false;
			}else{
				$("#totalInfo").text("");
				$("#totalClasshour").val(totalClasshour);
				$("#totalsum").val(totalsum);
				$("#zhuancun").val(oldtotalsum-totalsum);
				return true;
			}
		}
		function chooseBanci(){
			var banciId = $("#classorderid").val();
			var fee=$("#bcfee_"+banciId).val();
			var ks=$("#bcks_"+banciId).val();
			$("#totalClasshour").val(ks);
			$("#totalsum").val(fee);
			$("#rebate").val(0);
			$("#realsum").val(fee);
		}

		function checkValue(obj){
			if($(obj).val()==0){
				$(obj).val("");
			}
		}
		
		function saveCourseOrder() {
			if(computeZks()){
				$.layer({
			        shade: [0],
			        border: [2, 0.3, '#000'],
			        area: ['auto','auto'],
			        dialog: {
			            msg: '请确认课时调整是否正确？',
			            btns: 2,                    
			            type: 4,
			            btn: ['确定','取消'],
			            yes: function(){
							$.ajax({
					            cache: true,
					            type: "POST",
					            url:"${cxt}/orders/update",
					            data:$('#courseOrderForm').serialize(),// 你的formid
					            async: false,
					            error: function(request) {
					            	parent.layer.msg("网络异常，请稍后重试。", 1,1);
					            },
					            success: function(data) {
						    		parent.layer.msg(data.msg, 6,0);
						    		if(data.code=='1'){//成功
						    			setTimeout("parent.layer.close(index)", 3000 );
						    			parent.window.location.reload();
						    		}
					            }
					        });
			            }
			        }
			    });
			}
		}
	</script>
	<!-- Mainly scripts -->
    <script src="/js/js/bootstrap.min.js?v=1.7"></script>
    <script src="/js/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="/js/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <!-- Custom and plugin javascript -->
    <script src="/js/js/hplus.js?v=1.7"></script>
    <script>
       $('li[ID=nav-nav1]').removeAttr('').attr('class','active');
    </script>
</body>
</html>
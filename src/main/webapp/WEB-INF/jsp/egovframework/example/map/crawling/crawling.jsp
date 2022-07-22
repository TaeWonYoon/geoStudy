<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>
<style>
	.chart_div {
		display: flex;
	}
</style>
<h3><a href="./crawlingList.do">그룹별 크롤링</a></h3>
<h1 style="text-align:center;">크롤링 총 개수<span id="totalCnt"></span></h1>
<div class="chart_div">
	<div style="width:600px;height:400px;">
        <canvas id="mychart" width="200" height="200"></canvas>
        <div id="mychart1Txt"  style="width:200px;height:200px;margin: 0 auto;"></div>
    </div>
    <div style="width:600px;height:400px;">
        <canvas id="mychart2" width="200" height="200"></canvas>
        <div id="mychart2Txt"  style="width:200px;height:200px;margin: 0 auto;"></div>
    </div>
    <div style="width:600px;height:400px;">
        <canvas id="mychart3" width="200" height="200"></canvas>
        <div id="mychart3Txt"  style="width:200px;height:200px;margin: 0 auto;"></div>
    </div>
</div>
<div class="chart_div">
	<div style="width:600px;height:400px;">
	    <canvas id="mychart4" width="200" height="200"></canvas>
	    <div id="mychart4Txt"  style="width:200px;height:200px;margin: 0 auto;"></div>
	</div>
</div>
    
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
 <script src="<c:url value='/js/chart.js'/>"></script>
 
<script>
	$(document).ready(function() {
		ctotal();
		cyear();
		cmonth();
		cday();
	})


	
	function ctotal() {
		
		var param = {
				type : ""
		};
		
		var tcallback = function(data) {
			if(data.result = "SUCCESS") {
				var str = "<br /> (" + data.crawlingList[0].data_val + ")개";
				$("#totalCnt").html(str);
			}
			
		}
		
		callAjax(param, "./crawlingTy.do", tcallback, true, "p"); // 데이터, url, 콜백, 신크
	}
	
	
	
	function cyear() {
		
		var param = {
				type : "year"
		}
		
		var ycallback = function(data) {
			if(data.result = "SUCCESS") {
				
console.log(data.crawlingList);
				chartFnc("mychart", "line", data.crawlingList, "년도 데이터", "red");	
			} else {
				var str = "<b> 년 " + data.resultMsg + "</b>"
				$("#mychart1Txt").html(str);
			}
		}
		
		
		callAjax(param, "./crawlingTy.do", ycallback, true, "p"); // 데이터, url, 콜백, 신크
	}
	
	function cmonth() {
		var nowDates = nowDate("m");
		var param = {
				type : "month"
			,	calendar : nowDates
		}
		
		var mcallback = function(data) {
			if(data.result == "SUCCESS") {
				chartFnc("mychart2", "line", data.crawlingList, "월 데이터", "pink");	
			} else {
				var str = "<b> 월 " + data.resultMsg + "</b>"
				$("#mychart2Txt").html(str);
			}
		}
		
		callAjax(param, "./crawlingTy.do", mcallback, true, "p"); // 데이터, url, 콜백, 신크
	}
	
	function cday() {
		var nowDates = nowDate("d");
		var param = {
				type : "day"
			,	calendar : nowDates
		}
		
		var dcallback = function(data) {
			if(data.result == "SUCCESS") {
				chartFnc("mychart3", "line", data.crawlingList, "일 데이터", "pink");	
			} else {
				var str = "<b> 일 " + data.resultMsg + "</b>"
				$("#mychart3Txt").html(str);
			}
		}
		
		
		callAjax(param, "./crawlingTy.do", dcallback, true, "p"); // 데이터, url, 콜백, 신크
	}
	
</script>
<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
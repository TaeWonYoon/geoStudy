<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>

<style>
	.chart_div {
		display: flex;
	}
	.chart_div2 {
		display: flex;
	}
</style>
<h3><a href="./crawling.do">전체 크롤링</a></h3>
<h1 style="text-align:center;">(2022년)신문사 별</h1>
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
<div class="chart_div2">
	<div style="width:600px;height:400px;">
        <canvas id="mychart4" width="200" height="200"></canvas>
        <div id="mychart4Txt"  style="width:200px;height:200px;margin: 0 auto;"></div>
    </div>
</div>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
 <script src="<c:url value='/js/chart.js'/>"></script>
<script>
function specificDate(type) { //특정 년 월 일 출력
	var today = new Date();

	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);
	
	var returnData = "";
	if(type == "y") {
		returnData = year;
	} else if(type == "m") {
		returnData = month;
	} else if(type == "d") {
		returnData = day;
	} 

	return returnData;
}

	
	$(document).ready(function() {
		ctotal();
		cyear();
		cmonth();
		cday();
	})
	
	
	function ctotal() {
		console.log("ctotal")
		var param = {
				type : ""
		};
		
		var tcallback = function(data) {
			//log("tdata",data)
			if(data.result = "SUCCESS") {
				
				chartFnc("mychart", "bar", data.crawlingList, "전체 데이터", "green","news_nsprc","news_cnt");
				$("#mychart1Txt").html("");
			} else {
				var str = "<b> " + data.resultMsg + "</b>"
				$("#mychart1Txt").html(str);
			}
			
		}
		
		callAjax(param, "./crawlingListTy.do", tcallback, true, "p"); // 데이터, url, 콜백, 신크
	}
	
	
	
	function cyear() {
		
		var param = {
				type : "year"
		}
		
		var ycallback = function(data) {
			if(data.result = "SUCCESS") {
				chartFnc("mychart2", "bar", data.crawlingList, "2022년 총 데이터", "pink");
				$("#mychart2Txt").html("");
			} else {
				var year = specificDate("y");
				var str = "<b>"+ year +"년 " + data.resultMsg + "</b>"
				$("#mychart2Txt").html(str);
			}
		}
		
		
		callAjax(param, "./crawlingListTy.do", ycallback, true, "p"); // 데이터, url, 콜백, 신크
	}
	
	function cmonth() {
		var nowDates = nowDate("m");
		var param = {
				type : "month"
			,	calendar : nowDates
		}
		
		var mcallback = function(data) {
			if(data.result == "SUCCESS") {
				chartFnc("mychart3", "bar", data.crawlingList, "이번달 데이터", "pink");
				$("#mychart3Txt").html("");
			} else {
				var month = specificDate("m");
				var str = "<b>"+ month +"월 " + data.resultMsg + "</b>"
				$("#mychart3Txt").html(str);
			}
		}
		
		callAjax(param, "./crawlingListTy.do", mcallback, true, "p"); // 데이터, url, 콜백, 신크
	}
	
	function cday() {
		var nowDates = nowDate("d");
		var param = {
				type : "day"
			,	calendar : nowDates
		}
		
		var dcallback = function(data) {
			log("ddata",data)
			if(data.result == "SUCCESS") {
				chartFnc("mychart3", "bar", data.crawlingList, "오늘 데이터", "black");
				$("#mychart4Txt").html("");
			} else {
				var month = specificDate("m");
				var day = specificDate("d");
				var str = "<b>"+ month +"월" +day +"일 " + data.resultMsg + "</b>"
				$("#mychart4Txt").html(str);
			}
		}
		
		
		callAjax(param, "./crawlingListTy.do", dcallback, true, "p"); // 데이터, url, 콜백, 신크
	}
</script>

<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
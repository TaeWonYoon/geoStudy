<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>

<%@ include file="/WEB-INF/jsp/egovframework/layout/leftMenu.jsp" %>

<div class="col-8" style="margin-left: 60px; height:1000px;" >
	
	<div style="margin-top: 1%;"></div> <!--  마진 태그 -->
	 <div style="text-align:center;font-size: 22px; font-weight:bold;" id="txtDate">
		상세 집계
	</div>

	<div class="row">
	    <div class="col">
	      <div style="width:600px;height:150px;">
		        <canvas id="mychart" width="200" height="200"></canvas>
		    </div>
	    </div>
    </div>
    
    <div style="margin-top: 40%;"></div> <!--  마진 태그 -->
    
    <div class="row m-1">
	    <div>
			<button type="button" class="btn btn-primary btn-lg" onclick="history.back();">뒤로가기</button> 
		</div>
    </div>
   
</div> <!-- contents -->

<form action="./detailChart.do" method="post" id="detailChart">
	<input type="hidden" name="chartDate">
	<input type="hidden" name="ty">
</form>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
<script src="<c:url value='/js/chart.js'/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/spin.js/2.3.2/spin.js"></script> <!--  로딩 이벤트 -->

<script>


var _startDate = backDate("30"); // 뺀날짜
var _endDate = nowDate("d"); //오늘날짜
var mychart = "";


$(document).ready(function() {
	detailChartList(); //차트 출력
})

function detailChartList(ty,allTy) {
		var dbTy = "${ty}";
		var dbDate = "${chartDate}";
		var nowYear = "${nowYear}"; 
		var year = "";
		var month = "";
		var startDate = "";
		var total = allTy == "all" ? "all" : "";
		var type = "";
		var tyTxt = "";
		var finishDate = "";
		
		//가져올 데이터 체크
		if(dbTy == "asos") {
			type = "a";
			tyTxt = "기상관측 일자료 데이터";
		}
		if(dbTy == "aws") {
			type = "aw";
			tyTxt = "농업기상 관측정보 데이터";
		}
		if(dbTy == "water") {
			type = "r";
			tyTxt = "저수지 수위정보 데이터";
		}
		if(dbTy == "news") {
			type = "c";
			tyTxt = "크롤링 데이터";
		}
		
		if(dbDate.length == 4) { //월 단위
			year = dbDate; 
		}
		
		if(dbDate.length == 2) { //일 단위
			year = nowYear; 
			month = dbDate;
		}
		
			
		if(year != "" && month != "") {
			startDate = dbTy == "water" ? year+month : year+'-'+month; //저수지 날짜타입 20120611  나머지 날짜타입 2012-06-11 형식변환
			finishDate = year + "0" +(parseInt(month) + 1); //저수지 날짜 계산 
		} else if(year != "" && month == "") {
			startDate = year;
			finishDate = parseInt(year)+1; //저수지 날짜 계산
		}
		
		var param = {
				type : type
			,	year : year
			,	startDate : startDate
			,   finishDate : finishDate
			,	month : month
			,	total : total
		};
		
		if(ty == "u") {
			mychart.data.datasets[0].data = "";
			mychart.data.labels = "";
			mychart.update(); 
		}
		
		var callback = function(data) {
			if(ty == "u") { //업데이트
				var labelsVals = [];
				var dataVal = [];
				 
				for(var i=0; i < data.list.length; i++) {
					labelsVals.push(data.list[i].label_val);
					dataVal.push(data.list[i].data_val);
				}
				mychart1.data.labels = labelsVals;
				mychart1.data.datasets[0].data = dataVal;
				mychart1.update();
			}  else { //초기
				if(data.result == "SUCCESS") {
					mychart1 = chartFnc("mychart", "line", data.list, tyTxt, "#ffe6e6");
				} else {
					mychart1 = chartFnc("mychart", "line", data.list, tyTxt, "#ffe6e6");
				}	
			}
		}
		
		callAjax(param, "./totalDataList.do", callback, true, "p"); // 데이터, url, 콜백, 신크
}




</script>
<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
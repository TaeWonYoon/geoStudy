<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>

<%@ include file="/WEB-INF/jsp/egovframework/layout/leftMenu.jsp" %>

<div class="col-8" style="margin-left: 60px;" >
	
	<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
	
	<div>
		<div style="text-align:center;font-size: 22px; font-weight:bold;">
			전체 집계
		</div>
		<div style="text-align:center;" >
			<b>(<span id="txtDate" style="font-size:21px;">오늘부터 30일전 데이터</span>)</b>
		</div>
	</div>
	<div>
		&nbsp;&nbsp;
			<select name="total" class="totalDateSearch">
				<option value="" selected>디폴트</option>
				<option value="all">연단위</option>
			</select>
			<select name="year" class="dateSearch">
				<option value="">년도</option>
			</select>
			<select name="month" class="dateSearch">
				<option value="">달</option>
			</select>
			<button type="button" class="btn btn-primary btn-sm"onclick="resetFnc()">초기화</button> 
			<span style="color:red">** 초기화시 오늘부터 30일 전 데이터</span>
		</div>
		
	<div class="row">
	    <div class="col">
	      <div style="width:500px;height:200px;">
		        <canvas id="mychart" class="mycharts" data-value="mychart1" width="300" height="180"></canvas>
		    </div>
	    </div>
	    <div class="col">
	      <div style="width:500px;height:200px;">
		        <canvas id="mychart2" class="mycharts" data-value="mychart2" width="300" height="180"></canvas>
		    </div>
	    </div>
    </div>
    
    <div style="margin-top: 21%;"></div> <!--  마진 태그 -->
    
    <div class="row">
	    <div class="col">
	      <div style="width:500px;height:200px;">
		        <canvas id="mychart3" class="mycharts" data-value="mychart3"  width="300" height="180"></canvas>
		    </div>
	    </div>
	    <div class="col">
	      <div style="width:500px;height:200px;">
		        <canvas id="mychart4" class="mycharts" data-value="mychart4" width="300" height="180"></canvas>
		    </div>
	    </div>
    </div>
    
</div> <!-- contents -->

<form action="./detailChart.do" method="post" id="detailChart">
	<input type="hidden" name="chartDate">
	<input type="hidden" name="ty">
	<input type="hidden" name="nowYear">
</form>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
<script src="<c:url value='/js/chart.js'/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/spin.js/2.3.2/spin.js"></script> <!--  로딩 이벤트 -->
<script src="<c:url value='/js/spinnerStart.js'/>"></script> <!--  로딩 이벤트 함수 -->
<script>

//공통 데이터
var _startDate = backDate("30"); // 뺀날짜
var _endDate = nowDate("d"); //오늘날짜
var mychart1 = "", mychart2 = "", mychart3 = "", mychart4 = ""; //차트 담을 객체 생성
var nowYear = nowDate("y");
var year = ""; //공통 데이터 년도
var month = ""; //공통 데이터 월
var total =  ""; //ty설정 연도 or 디폴트
var startDate =  _startDate; 

$(document).ready(function() {
	$("[name='total']").val("").attr("selected", true);
	dateFnc(); //셀렉트 날짜 출력
	init(); //차트 실행
})

function init(ty) { //차트 실행
	ctotalList(ty);
	atotalList(ty);
	awtotalList(ty);
	rtotalList(ty);
}

$(".totalDateSearch").change(function(){  //전체 집계
	total = $("[name='total']").val(); //연도별, 디폴트별 체크
	
	var str = total == "" ? "오늘부터 30일전 데이터" : "연도별 데이터";
	$("#txtDate").html(str);
	
	init("u"); //차트 실행
	
	$("[name='year']").val("").attr("selected", true);
	$("[name='month']").val("").attr("selected", true);
	
})

$(".dateSearch").change(function(){  //검색 이벤트
	
	if(month != "" && year == "") {
		alert('년도를 선택해주세요');
		return;
	}
	year = $("[name='year']").val();
	month = $("[name='month']").val();
	
	nowYear = year; //상세 페이지시 연도 가져오기
	
	var yearTxt = year + "년"; 
	var yearMonthTxt = year + month + "월";
	var str = month != "" ? yearMonthTxt : yearTxt; //UI Text
	
	$("#txtDate").html(str);
	$("#txtDate").html(str);
	
	$("[name='total']").val("").attr("selected", true);
	
	init("u") //차트 실행
})

function resetFnc() { //초기화
	location.reload();
}

function ctotalList(ty) { //크롤링
		
		if(year != "" && month != "") {
			startDate = year+'-'+month;
		} else if(year != "" && month == "") {
			startDate = year;
		}
		
		var param = {
				type : "c"
			,	startDate : startDate
			,	endDate : _endDate
			,	year : year
			,	month : month
			,	total : total
		};
		
		if(ty == "u") {
			mychart2.data.datasets[0].data = "";
			mychart2.data.labels = "";
			mychart2.update(); 
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
					mychart1 = chartFnc("mychart", "bar", data.list, "크롤링 데이터", "#ffe6e6");
				} else {
					mychart1 = chartFnc("mychart", "bar", data.list, "크롤링 데이터", "#ffe6e6");
				}	
			}
			
		}
		
		
		callAjax(param, "./totalDataList.do", callback, true, "p"); // 데이터, url, 콜백, 신크
}

function atotalList(ty) { //기상 관측
	
	if(year != "" && month != "") {
		startDate = year+'-'+month;
	} else if(year != "" && month == "") {
		startDate = year;
	}
	
	var param = {
			type : "a"
		,	startDate : startDate
		,	endDate : _endDate
		,	year : year
		,	month : month
		,	total : total
	};
	
	if(ty == "u") {
		mychart2.data.datasets[0].data = "";
		mychart2.data.labels = "";
		mychart2.update(); 
	}
	
	var callback = function(data) {
		if(ty == "u") { //업데이트
			var labelsVals2 = [];
			var dataVal = [];
			 
			for(var i=0; i < data.list.length; i++) {
				labelsVals2.push(data.list[i].label_val);
				dataVal.push(data.list[i].data_val);
			}
			mychart2.data.labels = labelsVals2;
			mychart2.data.datasets[0].data = dataVal;
			mychart2.update();
		}  else { //초기
			if(data.result = "SUCCESS") {
				mychart2 = chartFnc("mychart2", "line", data.list, "기상관측 일자료 데이터", "yellow");
			} else {
				mychart2 = chartFnc("mychart2", "line", data.list, "기상관측 일자료 데이터", "yellow");
			}
		}
	}
	
	callAjax(param, "./totalDataList.do", callback, true, "p"); // 데이터, url, 콜백, 신크
}

function awtotalList(ty) { //농업기상 차트
	
	if(year != "" && month != "") {
		startDate = year+'-'+month;
	} else if(year != "" && month == "") {
		startDate = year;
	}
	
	var param = {
			type : "aw"
		,	startDate : startDate
		,	endDate : _endDate
		,	year : year
		,	month : month
		,	total : total
	};
	
	if(ty == "u") {
		mychart3.data.datasets[0].data = "";
		mychart3.data.labels = "";
		mychart3.update(); 
	}
	
	var callback = function(data) {
		if(ty == "u") { //업데이트
			var labelsVals3 = [];
			var dataVal = [];
			 
			for(var i=0; i < data.list.length; i++) {
				labelsVals3.push(data.list[i].label_val);
				dataVal.push(data.list[i].data_val);
			}
			mychart3.data.labels = labelsVals3
			mychart3.data.datasets[0].data = dataVal
			mychart3.update();
		}  else { //초기
			if(data.result == "SUCCESS") {
				mychart3 = chartFnc("mychart3", "line", data.list, "농업기상 관측정보 데이터", "red");
			} else {
				mychart3 = chartFnc("mychart3", "line", data.list, "농업기상 관측정보 데이터", "red");
			}
		}
	}
	
	callAjax(param, "./totalDataList.do", callback, true, "p"); // 데이터, url, 콜백, 신크
}

function rtotalList(ty) { //저수지 차트
	spinnerStart();
	
	var endDate = _endDate.replaceAll("-","");
	var finishDate = 0;
	
	if(year != "" && month != "") {
		startDate = year+month;
		finishDate = year + "0" +(parseInt(month) + 1);
	} else if(year != "" && month == "") {
		startDate = year;
		finishDate = parseInt(year)+1;
	}
	
	if(ty == "u") {
		mychart4.data.datasets[0].data = "";
		mychart4.data.labels = "";
		mychart4.update(); 
	}
	
	var param = {
			type : "r"
		,	startDate :startDate
		,	endDate : endDate
		,	year : year
		,	month : month
		,	total : total
		,	finishDate : finishDate
	};
	
	var callback = function(data) {
		spinnerStop();
		if(ty == "u") { //업데이트
			var labelsVals4 = [];
			var dataVal = [];
			for(var i=0; i < data.list.length; i++) {
				labelsVals4.push(data.list[i].label_val.substring());
				dataVal.push(data.list[i].data_val);
			}
			mychart4.data.labels = labelsVals4
			mychart4.data.datasets[0].data = dataVal
			mychart4.update();
			
		}  else { //초기
			if(data.result == "SUCCESS") {
				spinnerStop()
				mychart4 = chartFnc2("mychart4", "line", data.list, "저수지 수위정보 데이터", "yellow");
			} else {
				spinnerStop()
				mychart4 = chartFnc2("mychart4", "line", data.list, "저수지 수위정보 데이터", "yellow");
			}
		}
	}
	
	callAjax(param, "./totalDataList.do", callback, true, "p"); // 데이터, url, 콜백, 신크
} 





// 차트 클릭이벤트
$(".mycharts").click(function(evt) { //차트 클릭이벤트
	
	var id = $(this).data("value"); //타입 구분
	
	if($("[name='year']").val() != "" || $("[name='total']").val() != ""){
		if($("[name='month']").val() == "") {
		    var activePoints = "";
		    var clickedElementindex = "";
		    var label = "";
		    
		    if(id == "mychart1") {
		    	activePoints = mychart1.getElementsAtEventForMode(evt, 'point', mychart1.options);
		    	clickedElementindex = activePoints[0].index;
		    	label = mychart1.data.labels[clickedElementindex];
		    	$("[name='ty']").val("news");
		    }
		    if(id == "mychart2") {
		    	activePoints = mychart2.getElementsAtEventForMode(evt, 'point', mychart2.options);
		    	clickedElementindex = activePoints[0].index;
		    	label = mychart2.data.labels[clickedElementindex];
		    	$("[name='ty']").val("asos");
		    }
		    if(id == "mychart3") {
		    	activePoints = mychart3.getElementsAtEventForMode(evt, 'point', mychart3.options);
		    	clickedElementindex = activePoints[0].index;
		    	label = mychart3.data.labels[clickedElementindex];
		    	$("[name='ty']").val("aws");
		    }
		    if(id == "mychart4") {
		    	activePoints = mychart4.getElementsAtEventForMode(evt, 'point', mychart4.options);
		    	clickedElementindex = activePoints[0].index;
		    	label = mychart4.data.labels[clickedElementindex];
		    	$("[name='ty']").val("water");
		    }
			    
			$("[name='chartDate']").val(label);
			$("[name='nowYear']").val(nowYear);
			$("#detailChart").submit();			
		} else {
			alert('시간 단위는 체크할 수 없습니다.');
			return;
		}
	} else {
		alert("시간 단위는 체크할 수 없습니다.");
	}
});

function dateFnc() { //년 월 생성
	var nowYear = nowDate("y"); //이번년도
	for(var i=1;i<=31;i++) {
		var str = "<option value='"+ i +"'>"+ i + "</option>";
		$("[name='day']").append(str);	
	}
	for(var i=1;i<=12;i++) {
		var str = "";
		if(i < 11) {
			str = "<option value='0"+ i +"'>"+ i + "</option>";
		} else {
			str = "<option value='"+ i +"'>"+ i + "</option>";	
		}
		 
		$("[name='month']").append(str);	
	}
	for(var i=nowYear;i>=1990;i--) {
		var str = "<option value='"+ i +"'>"+ i + "</option>";
		$("[name='year']").append(str);	
	}
	
}

</script>
<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
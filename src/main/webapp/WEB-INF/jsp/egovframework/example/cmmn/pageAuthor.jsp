<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
 <script>

 	$(document).ready(function() {
	 	var pageUrl = "${requestScope['javax.servlet.forward.request_uri']}"; //현재 매핑 url
	 	var level = "${userVO.level}";
	 	
	 	if(level == "" || level == undefined) level = 0;
	 	
	 	var param = {
				pageUrl : pageUrl,
	 			level : level
	 	}
	 	
	 	var pcallback = function(data) {
	 		if(data.result == "FAIL") {
	 			$("#body").html("");
	 			alert(data.resultMsg);
	 			location.replace(data.resultUrl);
	 		}
	 	}
	 	
	 
	 	callAjax(param, "/author/pageCeck.do " , pcallback, false, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
 	})
 	
</script>
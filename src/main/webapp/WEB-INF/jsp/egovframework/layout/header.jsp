<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> <%-- contextPath --%> 
<c:set var="resources" value="${pageContext.request.contextPath}/resources"/> <%-- resourcesPath --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://taewonyoon.github.io/developerLib/script.js"></script>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/myCommon.css'/>"/>

<style>
.li_idx {
	padding-right: 50px; 
}
.li_idx a:hover {
	background: #8c8c8c;
}
.test:after {
	clear: both; 
	overflow: hidden;
}
.body {
	clear: both; 
	overflow: hidden;
}
.l_m:hover {
	background:rgb(255, 221, 153) !important;
}
</style>
</head>
<body style="margin:0; padding: 0; overflow-x: hidden" id="body">
<script>
	$(document).ready(function() { //레프트 메뉴 현재페이지 체크(bgcolor)
		if(location.pathname == "/board/boardList.do" || location.pathname == "/board/boardDetail.do") {
			$(".lf_bg").eq(0).removeClass("bg-white");
			$(".lf_bg").eq(0).css("background", "#ffdd99");
		} else if(location.pathname == "/map/totalList.do") {
			$(".lf_bg").eq(1).removeClass("bg-white");
			$(".lf_bg").eq(1).css("background", "#ffdd99");
		} else if(location.pathname == "/map/map.do") {
			$(".lf_bg").eq(2).removeClass("bg-white");
			$(".lf_bg").eq(2).css("background", "#ffdd99");
		}
	})
</script>
<div>
	<div class="header bg-secondary" style="height:58px;" >
		<div style="float:left;">
			<ul class="nav fs-3 text" id="b_ul">
				<li class="nav-item li_idx">
				    <a class="nav-link text-info" aria-current="page" onclick="location.href='/'" href="#">공간인소프트</a>
				</li>
			</ul>
		</div>
		<div class="float-end">
			<ul class="nav fs-3 text" id="b_ul">
				<!-- 
				<li class="nav-item li_idx">
				    <a href="${ctx}/board/boardList.do" class="nav-link text-light">게시판</a>
				</li>
				
				<li class="nav-item li_idx">
				    <a href="${ctx}/map/totalList.do" class="nav-link text-light active">시각화차트</a>
				</li>
				
				<li class="nav-item li_idx">
				    <a href="${ctx}/map/map.do" class="nav-link text-light active">오픈레이어</a>
				</li>
				 -->
				<c:if test="${userVO.level eq 9}">
					<li class="nav-item li_idx">
					    <a href="${ctx}/user/userList.do" class="nav-link text-info fs-4" aria-current="page" href="#">관리자</a>
					</li>
				</c:if>
				
				<c:if test="${userVO == null}">
					<li class="nav-item li_idx">
						<a href="${ctx}/user/login.do" class="nav-link text-info fs-4"> 로그인 </a>
					</li>
				</c:if>
				
				<c:if test="${userVO != null}">
					<li class="nav-item li_idx">
						<a href="${ctx}/user/logout.do" class="nav-link text-info fs-4" onclick="alert('로그아웃 되었습니다.')"> 로그아웃 </a>
					</li>
				</c:if>
			</ul>
		</div>
	</div>

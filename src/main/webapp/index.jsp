<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>
<style>
	.idx_li {
		text-decoration: none;
		margin-right: 15px;
	}
</style>
	
<%@ include file="/WEB-INF/jsp/egovframework/layout/leftMenu.jsp" %>
<div class="col-6">

	<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
	
	<c:if test="${userVO != null}">
		<h3>${userVO.nm}(${userVO.id})님 환영합니다.</h3>
		
		<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
		<c:if test="${userVO.level eq 9}">
			<h3>관리자 기능</h3>
			<a href="${ctx}/user/mngrRegist.do" class="fs-5 idx_li"> 관리자등록 </a>  
			<a href="${ctx}/user/userList.do" class="fs-5 idx_li"> 회원리스트 </a> 
		</c:if>
		
		<a href="${ctx}/user/userUpdt.do" class="fs-5 idx_li"> 회원정보 수정 </a> 
<br /> 
<hr />
		</c:if>

	<div>
		<h3>회원가입 , 로그인</h3>
		<a href="${ctx}/user/regist.do" class="fs-5 idx_li"> 회원가입 </a>  &nbsp;
		<c:if test="${userVO == null}">
			<a href="${ctx}/user/login.do" class="fs-5 idx_li"> 로그인 </a> &nbsp;
		</c:if>
		<c:if test="${userVO != null}">
			<a href="${ctx}/user/logout.do" class="fs-5 idx_li"> 로그아웃 </a> &nbsp;
		</c:if>
		<c:if test="${userVO != null}">
			<a href="javascript:userDelete()" class="fs-5 idx_li"> 회원탈퇴 </a> &nbsp;
		</c:if>
	</div>
<hr />		
<br />
		<h3>게시판</h3>
		<a href="${ctx}/board/boardList.do" class="fs-5 idx_li"> 게시판 </a> &nbsp;
<hr />		
<br />
		<h3>시각화차트</h3>
		<a href="${ctx}/map/totalList.do" class="fs-5 idx_li"> 시각화차트 </a> &nbsp;
<hr />		
<br />
		<h3>오픈레이어</h3>
		<a href="${ctx}/map/map.do" class="fs-5 idx_li"> 오픈레이어 </a> &nbsp;
	</div>
	
<br />

</div> <!-- section contents 영역 -->
<script>
	$("#mapTest").click(function() {
		var param = {
				pk : 11
		}
		var dcallback = function() {};
		
		callAjax(param, "/user/userMap.do", dcallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람	
	})
	
	

	function userDelete() {
		
		if(confirm("정말 삭제하시겠습니가? \n 삭제 후에는 원할한 서비스를 이용하실수 없습니다.")) {
			
			var param = {
					pk : '${userVO.pk}'
			}
			
			var dcallback = function(data) {
				alert(data.resultMsg);
				if(data.result == "SUCCESS") {
					location.replace('${ctx}/user/logout.do');
				}
			}
			
			callAjax(param, "/user/userSttus.do", dcallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
		}
	}
</script>
	
<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
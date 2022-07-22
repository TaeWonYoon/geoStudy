<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>
<%@ include file="/WEB-INF/jsp/egovframework/example/cmmn/pageAuthor.jsp" %>
<%@ include file="/WEB-INF/jsp/egovframework/layout/leftMenu.jsp" %>

<div class="col-6">

	<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
	
	<form id="formData" name="frm" method="post" >
		<div class="container center-block" >
		
			<div class="border bg-light" style="width:800px;margin: 0 auto;">
			
				<div class="row g-3 m-2">
					<label for="" class="form-label fs-3 text-danger">관리자 등록</label>
				</div>
				
				<div class="row g-3 m-2">
					<label for="nm" class="form-label">이름</label>
					<div class="col-6">
					  	<input type="text" class="form-control"  placeholder="이름을 입력해주세요" name="nm" id="nm" maxlength="20">
					</div>	
				</div>
				
				<div class="row g-3 m-2">
					<label for="inputState" class="form-label">아이디</label>
					
					<div class="col-6">
				    	<input type="text" class="form-control" name="id" id="id" maxlength="30" placeholder="아이디를 입력해주세요" aria-label="Last name">
					</div>
				
					<div class="col-2">
					  	<button type="button" class="btn btn-primary" onclick="idCeek()">중복확인</button>
					</div>
				</div>
				
				<div class="row g-3 m-2">
					<label for="formGroupExampleInput" class="form-label">비밀번호</label>
					<div class="col-6">
						<input type="text" class="form-control"  placeholder="비밀번호를 입력해주세요" name="password" maxlength="50">
					</div>
				</div>
				
				<div class="row g-3 m-2">
					<label for="formGroupExampleInput" class="form-label">비밀번호 확인</label>
					<div class="col-6">
						<input type="text" class="form-control" placeholder="비멀번호 확인" name="passwordCeck" maxlength="50">
					</div>
					<span id="passwordMsg"></span>
				</div>
				 
				<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
				
				<button type="button" id="button" class="btn btn-danger m-4" onclick="regist()">회원가입</button>
			</div>
		</div>
	</form>
</div><!-- contents --> 


<script>

	var _idCeek = "N";
	
	function idCeek() { //아이디 체크
		var id = document.getElementById('id').value;
		
		if(id == "") {
			alert("아이디를 입력해주세요");
			document.getElementById('id').focus();
			return;
		}
	
		var param = {
				id : id
		}
		
		var icallback = function(data) {
			alert(data.resultMsg);
			if(data.result == 'SUCCESS') {
				_idCeek = "Y";
			} else if(data.result == 'FAIL') {
				_idCeek = "N";
				$("#id").focus();
			}
		}
		
		callAjax(param, "./idCeck.do", icallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
	}
	
	
	
	$('[name="passwordCeck"]').keyup(function() { //패스워드 비교
		var str = $('[name="password"]').val() != $('[name="passwordCeck"]').val() ? "비밀번호가 다릅니다." : "비밀번호가 일치합니다.";
		$("#passwordMsg").text(str);
		$("#passwordMsg").css("color", "red");
	})
	
	
	function regist() { //회원가입 버튼 클릭시 유효성 검사 및 가입
		
		if($('[name="nm"]').emptyCheck('이름을')) {
			$('[name="nm"]').focus();
			return;
		}
		
		if($('[name="id"]').emptyCheck('아이디를') && $('[name="id"]').length <= 30) {
			$('[name="id"]').focus();
			return;
		}
		
		if(_idCeek != "Y") {
			alert("중복확인을 해주세요.");
			return;
		}
		
		if($('[name="password"]').emptyCheck('패스워드를') && $('[name="password"]').length <= 50) {
			$('[name="password"]').focus();
			return;
		}
		
		if($('[name="password"]').val() != $('[name="passwordCeck"]').val()) {
			alert("패스워드 내용을 확인해주세요");
			$('[name="password"]').focus();
			return;
		}
		
		
		var param = {
				nm : $('[name="nm"]').val(),
				id : $('[name="id"]').val(),
				password : $('[name="password"]').val(),
		}
		
		var rcallback = function(data) {
			alert(data.resultMsg);
			if(data.result == "SUCCESS") {
				location.replace(data.resultUrl);
			} 
		}
		
		callAjax(param, "./mngrRegist.do", rcallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
	}
	
</script>

<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
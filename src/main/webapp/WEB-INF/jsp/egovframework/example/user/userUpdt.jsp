<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>
<%@ include file="/WEB-INF/jsp/egovframework/example/cmmn/pageAuthor.jsp" %>
	
<%@ include file="/WEB-INF/jsp/egovframework/layout/leftMenu.jsp" %>

<div class="col-6">

	<div style="margin-top: 2%;"></div> <!--  마진 태그 -->

	<form id="formData" name="frm" method="post" >
	
		<div class="container center-block" >
		
			<div class="border bg-light" style="width:800px;margin: 0 auto;">
				
				<div class="row g-3 m-2">
					<label for="" class="form-label fs-3 text-danger">회원정보수정</label>
				</div>
				<div class="row g-3 m-2">
					<label for="formGroupExampleInput" class="form-label">이름</label>
					<div class="col-6">
					  	<input type="text" class="form-control" name="nm" maxlength="20" value="${user.nm}">
					</div>	
				</div>
				<div class="row g-3 m-2">
					<label for="formGroupExampleInput" class="form-label">아이디</label>
					<div class="col-6">
					  	<input type="text" class="form-control" name="id" id="id" maxlength="30" value="${user.id}" disabled>
					</div>	
				</div>
				<div class="row g-3 m-2">
					<label for="formGroupExampleInput" class="form-label">비밀번호</label>
					<div class="col-6">
					  	<input type="password" class="form-control" name="password" maxlength="50" placeholder="비밀번호는 입력시에만 변경됩니다.">
					</div>	
				</div>
				<div class="row g-3 m-2">
					<label for="formGroupExampleInput" class="form-label">비밀번호확인</label>
					<div class="col-6">
					  	<input type="password" class="form-control" name="passwordCeck" maxlength="50">
					</div>	
				</div>
				<div class="row g-3 m-2">
					<div class="col-6">
					  	<span id="passwordMsg"></span>
					</div>	
				</div>
				
				<div class="row g-3 m-2">
					<div class="col-2">
						<button type="button" id="button" class="btn btn-primary" onclick="Updt()">수정</button>
					</div>	
				</div>
				
			</div>
			
		</div>
		
	</form>
	
</div>

<script>

	function Updt() { //유효성 검사 및 업데이트
	
		var nm = $("[name='nm']").val();
		var password = $("[name='password']").val();
		
		 
		if($('[name="id"]').emptyCheck('아이디를') && $('[name="id"]').length <= 30) {
			$('[name="id"]').focus();
			return;
		}
		
		if($('[name="password"]').val() != '') {
			if($('[name="password"]').val() != $('[name="passwordCeck"]').val()) {
				alert("패스워드 내용을 확인해주세요");
				$('[name="password"]').focus();
				return;
			}	
		}
		
		var param = {
				nm : nm
			,	password : password
				
		}
		
		var ucallback = function(data) {
			alert(data.resultMsg);
			if(data.result == "SUCCESS") {
				location.replace(data.resultUrl);
			} 
		}
		
		callAjax(param, "./userUpdt.do", ucallback, true, "p"); // 데이터, url, 콜백, 신크
	}
	
	
	$('[name="passwordCeck"]').keyup(function() { //패스워드 비교
		var str = $('[name="password"]').val() != $('[name="passwordCeck"]').val() ? "비밀번호가 다릅니다." : "비밀번호가 일치합니다.";
		$("#passwordMsg").text(str);
		$("#passwordMsg").css("color", "red");
	})
	
	
	
</script>



<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>

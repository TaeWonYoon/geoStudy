<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>


<%@ include file="/WEB-INF/jsp/egovframework/layout/leftMenu.jsp" %>

<div class="col-6">

	<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
	
	<div class="container">

		<div class="border bg-light" style="width:700px;margin: 0 auto;">
		
        	<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
        	
        	<div class="row g-3 fs-3 text-danger m-2" >
				<label for="formGroupExampleInput" class="form-label" >로그인</label>
			</div>
			
        	<div class="row g-3 m-2">
        		<div class="col-2">
					<label for="formGroupExampleInput" class="form-label">아이디</label>
				</div>
				<div class="col-4">
					<input type="text" class="form-control" name="id" id="id" maxlength="30" placeholder="아이디을 입력해주세요">
				</div>
			</div>
			
			<br />
			
			<div class="row g-3 m-2">
        		<div class="col-2">
					<label for="formGroupExampleInput" class="form-label">비밀번호</label>
				</div>
				<div class="col-4">
					<input type="password" class="form-control"  name="password" id="password"   maxlength="30" placeholder="비밀번호르 입력해주세요">
				</div>
			</div>
			
			<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
			
			<div class="row g-3 m-2">
				<div class="col-2">
					<button type="button" class="btn btn-warning"
							onclick="location.href='${ctx}/user/regist.do'">
							회원가입
					</button>
				</div>
				<div class="col-2">
					<button type="button" class="btn btn-danger" onclick="login()">
						로그인
					</button>
				</div>
			</div>
			<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
		</div>
		
	</div> <!-- 컨테이너 -->
	
</div><!-- contents --> 



<script>

	$(".id").click(function() {
		
		var idx = $(this).index();
		var str = "";
		
		if($(this).index() == "0") {
			$("#id").val("user");
		} else if($(this).index() == "1") {
			$("#id").val("admin");
		} else if($(this).index() == "2") {
			$("#id").val("map");
		}
		
	})

	$("#password").keyup(function(key) { //패스워드 엔터시 로그인
		 if(key.keyCode==13) { 
           	login();        
		}
	})
	
	$("#id").keyup(function(event){ //영문 숫자만 입력
		if (!(event.keyCode >=37 && event.keyCode<=40)) {    
			var inputVal = $(this).val();    
			$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));   
		}
	});
	

	function login() {
		
		if($('[name="id"]').val().length > 30) {
			alert("최대 입력가능한 수는 30글자입니다.");
			$('[name="id"]').focus();
			$('[name="id"]').val('');
			return;
		}
		
		if($('[name="password"]').val().length > 50) {
			alert("최대 입력가능한 수는 50글자입니다.");
			$('[name="password"]').focus();
			$('[name="password"]').val('');
			return;
		}
		
		var id = document.getElementById('id').value;
		var password = document.getElementById('password').value;
		
		var param = {
				id : id
			,	password : password
				
		}
		
		var lcallback = function(data) {
			if(data.result == "SUCCESS") { //성공시 처리
				alert(data.resultMsg);
				location.replace(data.resultUrl);
			} else {
				alert(data.resultMsg);
			}
		}
		
		callAjax(param, "./iogin.do", lcallback, true, "p"); // 데이터, url, 콜백, 신크
	}
	
</script>

<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
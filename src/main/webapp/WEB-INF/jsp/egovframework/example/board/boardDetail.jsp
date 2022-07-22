<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>
<%--
<%@ include file="/WEB-INF/jsp/egovframework/example/cmmn/pageAuthor.jsp" %> <!--  권한 페이지 막기 -->
 --%>
<style>
.a_b {text-decoration : none;border: 1px solid black;padding: 3px 6px 3px 6px;margin: 10px 9px 0 0;bacground: white;} /* 댓글 버튼 Css */
#realNm:hover {font-size: 19px;font-weight: bold;}
.tx_ct {text-align:center;}
</style>

<%@ include file="/WEB-INF/jsp/egovframework/layout/leftMenu.jsp" %>

<div class="col-6 m-2">

	<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
	<div style="margin-left: 2%;"></div> <!--  마진 태그 -->

	<form:form modelAttribute="boardVO" id="detailForm" name="detailForm" action="${ctx}/board/boardRegist.do" enctype="multipart/form-data">
		<input type="hidden" name="act" maxlength="30" value="${registerFlag}"/>
		<input type="hidden" name="redirectNum" value="${searchVO.redirectNum}"/>
		<input type="hidden" name="searchType"value="${searchVO.searchType}"/>
		<input type="hidden" name="searchKeyword" maxlength="30" value="${searchVO.searchKeyword}"/>
		
		<form:input type="hidden" path="pk" maxlength="30" value="${resultMap.pk}"/>
		
	    <div id="content_pop">
	    	<!-- 타이틀 -->
	    	<div id="title">
	    		<ul class="pagination">
	    			<li class="page-item">
	    				<span class="fs-3">
	    					<img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
	    				</span>
	    				<span class="fs-3">
	    					게시글 
		                    <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
		                    <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
	                    </span>
	                </li>
	    		</ul>
	    	</div>
	    	<!-- // 타이틀 -->
	    	<div id="table">
				<table class="table border ">
					<tr>
						<td class="tbtd_caption bg-info tx_ct bg-opacity-25"><spring:message code="title.study.sj" /></td>
						<td class="tbtd_content bg-info bg-opacity-10">
							<form:input path="sj"  value="${resultMap.sj}" class="form-control" maxlength="50"/>
						</td>
					</tr>
					<tr>
						<td class="tbtd_caption bg-info tx_ct bg-opacity-25">
							<label for="useYn"><spring:message code="title.study.cn" /></label>
						</td>
						<td class="tbtd_content bg-info bg-opacity-10">
							<form:textarea path="cn" rows="5" cols="58" class="form-control" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<td class="tbtd_caption bg-info tx_ct bg-opacity-25">
							<spring:message code="title.study.file" />
						</td>
						<td class="tbtd_content bg-info bg-opacity-10">
							<span id="realNm" style="cursor:pointer;border-bottom:2px solid red;">${resultMap.fileVO.fileRealNm}</span> 
							<c:if test="${userVO.level eq 9}">
								<button type="button" class="btn btn-secondary btn-sm" id="fileDelete" value="${resultMap.fileVO.filePk}">삭제</button>
							</c:if>
							<input type="file" name="files" id="files" />
						</td>
					</tr>
					<tr>
						<td class="tbtd_caption bg-info tx_ct bg-opacity-25">
							<label for="description"><spring:message code="title.sample.regUser" /></label>
						</td>
						<td class="tbtd_content bg-info bg-opacity-10">
							<c:if test="${registerFlag == 'create'}">
								<span class="text-danger">${userVO.nm}</span>
							</c:if>
							<c:if test="${registerFlag == 'modify'}">
								<span class="text-danger">${resultMap.nm}</span>
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="tbtd_caption bg-info tx_ct bg-opacity-25">
							<label for="regUser"><spring:message code="title.sample.regDate" /></label>
						</td>
						<td class="tbtd_content bg-info bg-opacity-10">
							<c:if test="${registerFlag == 'create'}">
								${nowDate}
							</c:if>
							<c:if test="${registerFlag == 'modify'}">
								<fmt:formatDate pattern="yyyy-MM-dd" value="${resultMap.rgsde}" />
							</c:if>
						</td>
					</tr>
				</table>
			</div>
			
			<div id="sysbtn" class="m-1 float-end"> <!-- 목록 등록 삭제 Ui -->
	    		<ul class="pagination">
	    			<li class="page-item" style="margin-right:20px;">
	                    <span class="btn_blue_l">
	                        <a href="javascript:history.back();" class="btn btn-info text-light bg-sm">
	                        	<spring:message code="button.list" /> <!-- 목록 -->
                        	</a>
	                    </span>
	                </li>
	                
	                <c:if test="${userVO != null && userVO.level eq 9}">
		    			<li class="page-item" style="margin-right:20px;">
		                    <span class="btn_blue_l">
		                        <a href="javascript:fn_egov_save();" class="btn btn-success bg-sm">
		                            <c:if test="${registerFlag == 'create'}">
		                            	<spring:message code="button.create" />
		                           	</c:if>
		                            <c:if test="${registerFlag == 'modify'}">
		                            	<spring:message code="button.modify" />
		                           	</c:if>
		                        </a>
		                    </span>
		                </li>
	                </c:if>
	                
	   			 	<c:if test="${userVO.level eq 9 && registerFlag == 'modify'}">
		    			<li class="page-item">
		                    <span class="btn_blue_l">
		                    	<a href="javascript:fn_egov_del();" class="btn btn-danger bg-sm">
		                       		삭제
		                       	</a>
		                    </span>
		                </li>
	             	</c:if>
	            </ul>
	    	</div>
	    </div>
	    <%--
	    <!-- 검색조건 유지 -->
	    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
	    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
	    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	     --%>
	</form:form>
	
	<c:if test="${registerFlag == 'modify'}">
	
		<div style="margin-top: 6%;"></div> <!--  마진 태그 -->
		
		<div style="width:680px;margin-left:10px;">
		
		   	<div id="title">
		   		<ul class="pagination">
		   			<li class="page-item">
		   				<img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
						<span class="fs-5">
							<spring:message code="title.study.answer" /><span id="answerCnt"></span>
						</span>
					</li>
		   		</ul>
		   	</div>
		   	
			<table class="table border" style="width:934px;">
	    		<thead class="bg-success bg-opacity-25">
	    			<tr>
		    			<td>아이디</td>
		    			<td>내용</td>
		    			<td>등록일</td>
		    			<td>여부</td>
	    			</tr>
	    		</thead>
	    		
	    		<tbody id="answerList" class="bg-success bg-opacity-10"></tbody>
	    	</table>
	    	
			<br />
			
	    	<table>
	    		<colgroup>
	    			<col width="?"/>
	   				<col width="150"/>
	   			</colgroup>
	    		
	    		<tr>
	    			<td class="tbtd_caption"><input type="text" name="answer" style="width:600px;" maxlength="30"></td>
	    			<td class="tbtd_content">
	    				&nbsp;&nbsp; <button type="button" id="answerRegist" class="btn btn-dark btn-sm">등록</button>
	    			</td>
	    		</tr>
	    		
	    	</table>
	    	
	    	<div id="page" style="margin-top: 10px;"></div> <!--  댓글 페이징 -->
		</div>
	</c:if>
<script>

	$(document).ready(function() {
		var type = "${registerFlag}"; //댓글, 수정 상태확인
		
		if(type == "modify") { //수정일때만 댓글 호출
			answerList();
		} 
		
		var files = "${resultMap.fileVO}"; //파일정보 담기
		
		if(files != "") {  //데이터 체크
			$("#files").css("display","none");			
		} else {
			$("#fileDelete").css("display","none");
		}
		
		
		var ceck = "${resultMap.cn}"; //컨텐츠
		var level = "${userVO.level}"; //유저 레벨
		
		if(level == 1) { //권한
			$("#sj").attr("disabled",true);
			$("#cn").attr("disabled",true);
		}
		
		if(ceck != '') {
			$("#cn").val(ceck);	
		}
	})
	
	$("#answerRegist").click(function() { //댓글 등록
		
		if($("[name='answer']").val().length > 30) {
			alert("30글자 이상 사용할 수 없습니다.");
			return;
		}
		
		var param = {
				cn : $("[name='answer']").val()
			,	boardPk : "${resultMap.pk}"
		}
		
		var rcallback = function(data) {
			alert(data.resultMsg);
			if(data.result == "SUCCESS") {
				$("[name='answer']").val("");
				answerList()
			}
		}
		
		callAjax(param, "./answerRegist.do", rcallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
	})
	
	function answerList(pageNum) { //댓글 리스트
		var num = pageNum || 1;
		var param = {
				boardPk : "${resultMap.pk}"
			,	num : pageNum
		}
		
		var scallback = function(data) {
			if(data.result == "SUCCESS") {
				ListDo(data, num);
				ListPage(data);
			} else if(data.result == "FAIL") { //댓글 0개일때 처리
				$("#answerList").empty();
				$("#page").empty();
				var str = "<td class='tbtd_caption' colspan='4' style='text-align:center;'>등록된 댓글이 없습니다.";
				$("#answerList").append(str);
			}
			
		}
		
		callAjax(param, "./answerList.do", scallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
	}
	
	function ListDo(data, num) { //댓글 리스트 데이터
		var data = data.answerList;
		$("#answerList").empty();
		
		var upk = '${userVO.pk}';
		
		for(var i=0;i < data.length; i++) {
			
			var front = "<td class='tbtd_caption' "
						+ "style='color:red;cursor:pointer;' onclick='deleteAnswer("+ data[i].pk +","+ data[i].userPk + ","+ num + ")'>"
						+ "<b>x</b></td>";
						
			var back = "<td class='tbtd_caption'> </td>";
			
			var replyTbody = "";
			
			replyTbody = ListReplyDo(data[i])
			
			
			var pkCeck = upk == data[i].userPk ?  front : back; //자기글인지 아닌지 체크 
			var tbody = "<tr class='tbodyF'>"
					    + "<td class='tbtd_caption'>"
					    	+ "<span style='color:red;'>˚</span> " + data[i].nm 
					    	+ "<br> <b class='replyWrite' style='border-top: 1px solid;cursor:pointer;'>답글쓰기</b>"
				    	+ "</td>"
						+ "<td class='tbtd_caption'> " + data[i].cn + "</td>"
						+ "<td class='tbtd_caption'> " + dateFormatter(data[i].rgsde) + "</td>"
						+ pkCeck
		 			  + "</tr>"
		 			  + "<tr class='viewWrite' style='display:none;background:#ffcccc;'>"
		 			  	+ "<td>"
		 			  		+ "답글"
	 			  		+ "</td>"
		 			  	+ "<td colspan='2'>"
		 			  		+ "<input type='text' name='cn' class='replyTxt' style='width:700px;'>"
	 			  		+ "</td>"
	 			  		+ "<td colspan='2'>"
	 			  			+ "<button type='button' class='replyRegist btn btn-danger btn-sm' data-val='"+data[i].pk+"' data-depth='"+ data[i].depth +"'>등록</button>"
 			  			+ "</td>"
		 			  + "</tr>"
		 			  + replyTbody;
		 			  log("replyTbody", replyTbody)
			$("#answerList").append(tbody); 
		}
	   
	}
	
	function ListReplyDo(data) { //댓글에 대한 답글 받기
		var tbody = "";
			
			var param = {
					depthPk : data.pk
				,	depth : Number(data.depth+1)
			}
			
			var callback = function(data) {
				if(data.result == "SUCCESS") {
					console.log(data);
					tbody += ListReplyWhileDo(data)
				}
			}
			callAjax(param, "./answerReplyList.do", callback, false, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
	
		return tbody;
	}
	
	function ListReplyWhileDo(reply) { //댓글에 관한 답글처리
		var replyList = reply.answerReplyList;
		var back = "<td class='tbtd_caption'> </td>";
		var upk = '${userVO.pk}';
		var tbody = "";		
		for(var j=0; j<replyList.length; j++) {		

			var front = "<td class='tbtd_caption' "
						+ "style='color:red;cursor:pointer;' onclick='deleteAnswer("+ reply.answerReplyList[j].pk +","+ reply.answerReplyList[j].userPk +")'>"
						+ "<b>x</b></td>";
			
			
			var pkCeck2 = upk == replyList[j].userPk ?  front : back; //자기글인지 아닌지 체크
			
			tbody += "<tr  style='background:#e6fffa;' class='bg-success bg-opacity-10' >"
					    + "<td class='tbtd_caption'>&nbsp; 답글 > " + replyList[j].nm + "</td>"
						+ "<td class='tbtd_caption'> " + replyList[j].cn + "</td>"
						+ "<td class='tbtd_caption'> " + dateFormatter(replyList[j].rgsde) + "</td>"
						+ pkCeck2
	  			  + "</tr>"
		}
		
		return tbody;
	}
	
	
	
	$(document).on('click','.replyRegist',function() { //댓글 등록
		
		var idx = $(".replyRegist").index(this); //현재 인덱스
		var depthPk = $(this).data("val"); //부모
		var dataDepth = $(this).data("depth"); //현재 깊이
		var depth = Number(dataDepth+1) //자식 
		var cn = $(".replyTxt").eq(idx).val(); //인덱스에 데이터
		
		var param = {
				depthPk : depthPk
			,	sttus : 1
			,	cn : cn
			,	userPk : '${userVO.pk}'
			,	depth : depth
		}
		
		var callback = function(data) {
			alert(data.resultMsg)
			if(data.result == "SUCCESS") {
				location.reload();
			}
		}
		
		callAjax(param, "./answerReplyRegist.do", callback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람	
	});
	
	$(document).on('click','.replyWrite',function() {
		var idx = $(".replyWrite").index(this); //현재 인덱스
		
		$(".viewWrite").eq(idx).toggle();
		
		
		$(".replyTxt").eq(idx).val("");
		$(".replyTxt").eq(idx).focus();
	});
	
	
	function ListPage(data) { //댓글 페이징
		$("#page").empty();
		var page = data.page;
		var first = "";
		var finish = "";
		var tntCnt = "("+page.count+"개)"; //총개수
		$("#answerCnt").text(tntCnt)
		
		if(page.prev == true) {
			var startPageNum = page.startPageNum - 1
			var prev ="<a href='javascript:answerList("+ startPageNum + ")' class='a_b'> " + "<" + "</a>";
			$("#page").prepend(prev);
		}
		
		var num = page.startPageNum;
		var pageStr = "";
		
		for(num; num <= page.endPageNum; num++) {
			pageStr = "<a href='javascript:answerList("+ num + ")' class='numBtn a_b' >" + num + "</a>";
			if(num == page.num){ //현재페이지 체크
				pageStr = "<a href='javascript:answerList("+ num + ")' class='nowNum a_b' >" + num + "</a>";
			} else {
				pageStr = "<a href='javascript:answerList("+ num + ")' class='numBtn a_b' >" + num + "</a>";
			}
			
			$("#page").append(pageStr);
		}
		
		if(page.next == true) {
			var endPageNum = page.endPageNum + 1
			var next ="<a href='javascript:answerList("+ endPageNum + ")' class='a_b'> " + ">" + "</a>";
			$("#page").append(next);
		}
		
		$("#page .numBtn").css("font-size", "17px");
		$("#page .numBtn").css("margin-right", "5px");
		$("#page .nowNum").css("font-weight", "bold");
		$("#page .nowNum").css("font-size", "20px");
	}
	
	function deleteAnswer(pk, userPk, num) { //댓글삭제
		
		var param = {
				pk : pk
			,	userPk : userPk
		}
		
		var dcallback = function(data) {
			alert(data.resultMsg)
			if(data.result == "SUCCESS") {
				answerList(num)
			}
		};
		
		if(confirm("정말 삭제하시겠습니까?")) {
			callAjax(param, "./deleteAnswer.do", dcallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람	
		}
		
	}

	function fn_egov_save() { //등록, 수정
		if( $('[name="sj"]').emptyCheck('제목을') ) return;
		if( $('[name="cn"]').emptyCheck('내용을') ) return;
		
		if( $('[name="sj"]').val().length > 50 ) {
			alert("최대 입력가능한 수는 50글자입니다.");
			$('[name="sj"]').focus();
			return;
		}
		
		if( $('[name="cn"]').val().length > 100 ) {
			alert("최대 입력가능한 수는 100글자입니다.");
			$('[name="cn"]').focus();
			return;
		}
		var type = "${registerFlag}"; //댓글, 수정 상태확인
		var alertMsg = type == "create" ? "등록이 완료 되었습니다." : "수정이 완료 되었습니다.";
		alert(alertMsg)
		document.detailForm.submit();
	}
	
	
	function fn_egov_del() { //게시글 삭제
		if(confirm("정말삭제하시겠습니까?")) {
			document.detailForm.act.value = "delete";
			fn_egov_save();
		}
	}
	
	
	$("#realNm").click(function() { //파일 다운로드
		var boardPk = "${resultMap.pk}";
		location.href = "./fileDownload.do?boardPk=" + boardPk;
	})
	
	$("#fileDelete").click(function() { //파일 삭제
		var filePk = $(this).val();
		
		//var formData = new FormData($('#formData')[0]);
		var param = {
				filePk : filePk
			,	fileUrlPath : '${resultMap.fileVO.fileUrlPath}'
			,	fileNm : '${resultMap.fileVO.fileNm}'
		}
		
		var dcallback = function(data) {
			alert(data.resultMsg);
			if(data.result == "SUCCESS") {
				$("#realNm").html("");
				$("#files").css("display","block");
				$("#fileDelete").css("display","none");
			}
			
		}
		
		if(confirm("사진을 정말 삭제하시겠습니까? \n확인후에는 복구할 수 없습니다.")) {
			callAjax(param, "./fileDelete.do", dcallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
		}
	})
	
	
</script>
<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
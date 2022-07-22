<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>
<%@ include file="/WEB-INF/jsp/egovframework/example/cmmn/pageAuthor.jsp" %>



<%@ include file="/WEB-INF/jsp/egovframework/layout/leftMenu.jsp" %>

<div class="col-6 m-2">

	<div style="margin-top: 2%;"></div> <!--  마진 태그 -->

    <form:form modelAttribute="searchVO" id="listForm" name="listForm" method="post">
    	<input type="hidden" name="num" id="fnum" value="1"/>
        <div id="content_pop">
        	<!-- 타이틀 -->
        	<div id="title">
        		<ul class="pagination">
        			<li class="page-item">
        				<span class="fs-3"><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/></span>
        				<span class="fs-3"> 게시판 리스트(${totCnt}개) </span>
       				</li>
        		</ul>
        	</div>
        	<!-- // 타이틀 -->
        	<div id="search" class="float-end">
        	
				<div class="row g-3">
					<div class="col-3">
					    <form:select path="searchType" class="form-select">
	        					<form:option value="alls">전체</form:option>
	        					<form:option value="sj">제목</form:option>
	        					<form:option value="cn">내용</form:option>
	        					<form:option value="nm">등록자</form:option>
	      				</form:select>
					</div>
      				<div class="col-5">
                    	<form:input path="searchKeyword" maxlength="30" class="form-control" placeholder="입력해주세요" />
                  	</div>
                    <div class="col-4">
       	                <a href="javascript:fn_egov_selectList();" class="btn btn-danger"><spring:message code="button.search" /></a>
				  	</div>
			  	</div>
			</div>        		
       	</div>
       	
<br /><br /><br />

       	<!-- List -->
       	<div id="table">
       		<table class="table " summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
       			<tr class="table-warning" style="text-align:center;">
       				<th align="center">No</th>
       				<th align="center"><spring:message code="title.study.sj" /></th>
       				<th align="center"><spring:message code="title.study.cn" /></th>
       				<th align="center"><spring:message code="title.sample.regDate" /></th>
       				<th align="center"><spring:message code="title.sample.regUser" /></th>
       			</tr>
       			<c:forEach var="list" items="${boardList}" end="${page.pageEnd}" varStatus="status">
           			<tr class="t_r">
           				<td align="center" >
							<c:if test="${page.num == 1 }"> ${status.count} </c:if>
                           	<c:if test="${page.num > 1 }"> ${status.count + status.end} </c:if>
						</td>
           				<td align="center">
           					<a href="javascript:detail('${list.pk}')" class="t_d text-primary">${list.sj}</a>
          				</td>
           				<td align="center" >${list.cn }&nbsp;</td>
           				<td align="center" >
           					<fmt:formatDate pattern="yyyy-MM-dd" value="${list.rgsde}" />
          				</td>
           				<td align="center" > ${list.nm}&nbsp;</td>
           			</tr>
          			</c:forEach>
       		</table>
       	</div>
       	<!-- /List -->
       	<div id="paging" >
       		<ul class="pagination" style="justify-content : center;">
       			  
					<c:if test="${page.prev}">
						<li class="page-item">        		
		                    <a href="javascript:fn_egov_selectList('${page.startPageNum - 1}')" class="page-link">
		                        Prev
		                    </a>
	                    </li>
	                </c:if>
	                
	                <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
	                	<li class="page-item">
		                    <a href="javascript:fn_egov_selectList('${num}')" id="page${num}" class="page-link">
		                        ${num}
		                    </a>
	                    </li>
	                </c:forEach>
	                
	                <c:if test="${page.next}">
	                	<li class="page-item">
		                    <a href="javascript:fn_egov_selectList('${page.endPageNum + 1}')" class="page-link">
		                         Next 
		                    </a>
	                    </li>
	                </c:if>
               </ul>
       	</div>
       	<c:if test="${userVO.level == 9}">
        	<div id="sysbtn" class="float-end">
        	  <ul class="pagination">
        	      <li>
        	          <span class="btn_blue_l">
       	             	 <a href="javascript:regist();" class="btn btn-warning btn-lg">
        	              	<spring:message code="button.create" />
						 </a>
                      </span>
                  </li>
              </ul>
        	</div>
       	</c:if>
   	</form:form>
</div> <!--  contents  -->
<form:form modelAttribute="boardVO" name="detailForm" method="post" action="${ctx}/board/boardDetail.do">
	<input type="hidden" name="pk" />
	<input type="hidden" name="redirectNum" value="${nowNum}"/>
   	<input type="hidden" name="searchType" value="${searchType}"/>
   	<input type="hidden" name="searchKeyword" value="${searchKeyword}"/>
</form:form>  
  
 </div> <!-- contents -->
<script>
	
	function detail(data) { //상세 페이지
		document.detailForm.pk.value = data;
		document.detailForm.submit();
	}
	
	function regist() { //등록 페이지
		location.href = '${ctx}/board/boardDetail.do';
	}
	
	function fn_egov_selectList(num) {  //검색 및 페이징처리
		
		if(num != "" && typeof num != "undefined") {
			document.getElementById('fnum').value = num;	
		} else {
			document.getElementById('fnum').value = 1;
		}
		
		document.listForm.method = "post";
		document.listForm.action = "${ctx}/board/boardList.do";
		document.listForm.submit();
	}
	
	$(document).ready(function() { 
		$("#page${nowNum}").css("font-weight", "bold"); //현재 페이지 번호 스타일
		$("#page${nowNum}").css("font-size", "16px"); //현재 페이지 번호 스타일
		$("#page${nowNum}").addClass("bg-warning"); //현재 페이지 번호 스타일
	})
	
	$(".t_r").hover(function() { //hover 백그라운드
		var idx = $(".t_r").index(this);
		$(".t_r").css("background", "white");
		$(".t_r").eq(idx).css("background", "#e6e6e6");
	})
	
	
</script>

<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
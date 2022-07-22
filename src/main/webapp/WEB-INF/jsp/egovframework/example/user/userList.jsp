<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="func" uri="/WEB-INF/jsp/egovframework/example/cmmn/tlds/common.tld" %>
<%@ include file="/WEB-INF/jsp/egovframework/layout/header.jsp" %>
<%@ include file="/WEB-INF/jsp/egovframework/example/cmmn/pageAuthor.jsp" %>

<%@ include file="/WEB-INF/jsp/egovframework/layout/leftMenu.jsp" %>

<div class="col-8">
	
	<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
	
	<div class="container">
        <div class="page_name">
               <h1>회원목록(${totCnt}명)</h1>
        </div>
		<form name="listForm" method="post">
           	<input type="hidden" name="num" id="fnum" value="1" />
       		<div class="page_search">
                  <table class="table">
                      <tbody>
                          <tr>
                              <th scope="col">검색어</th>
                              <td>
                             
                                  <div>
                                  	<select name="levelType">
                                      	<option value=""  >등급선택</option>
                                          <option value="1" ${ func:cmpr(levelType,'1','s') } >일반</option>
                                          <option value="4" ${ func:cmpr(levelType,'4','s') } >지도사용자</option>
                                          <option value="9" ${ func:cmpr(levelType,'9','s') } >관리자</option>
                                      </select>
                                      <select name="searchType" id="searchType">
                                      	<option value=""  >전체</option>
                                          <option value="nm" ${ func:cmpr(searchType,'nm','s') } >이름</option>
                                          <option value="id" ${ func:cmpr(searchType,'id','s') } >아이디</option>
                                      </select>
                                      <input type="text" name="keyword" value="${keyword}">
                                      <button type="button" class="btn btn-dark" onclick="fn_egov_selectList()">검색</button>
                                  </div>
                              </td>
                          </tr>
                          <tr>
                              <th scope="col">기간</th>
                              <td>
                                 	시작 날짜 <input type="date" name="startDate" value="${startDate}">
                                 	종료 날짜 <input type="date" name="finishDate" value="${finishDate}">
                              </td>
                          </tr>
					</tbody>
				</table>
			</div>
		</form>
			
		<div style="margin-top: 4%;"></div> <!--  마진 태그 -->
		
              <table class="tb_css table table-striped border">
                  <thead class="th_css table-warning">
                      <tr style="text-align:center;">
                          <th scope="col">번호</th>
                          <th scope="col">이름</th>
                          <th scope="col">아이디</th>
                          <th scope="col">상태</th>
                          <th scope="col">등급</th>
                          <th scope="col">등록일</th>
                          <th scope="col">여부</th>
                      </tr>
                  </thead>
                  <tbody class="tb_css " id="tbody">
                  	<c:forEach var="list" items="${list}" end="${page.pageEnd}" varStatus="status">
                  		<tr align="center">
                  			<td class="listtd">
							<c:if test="${page.num == 1 }"> ${status.count} </c:if>
                           	<c:if test="${page.num > 1 }"> ${status.count + status.end} </c:if>
						</td>
                  			<td>${list.nm}</td>
                  			<td>${list.id}</td>
                  			<td>
                  				<select name="sttus" class="confm" data-value="${list.pk}">
                					<option value="0"  ${ func:cmpr(list.sttus,'0','s') } >
                						${ func:keyVal('0' , '0,1', '미승인,승인') }
               						</option>
                					<option value="1"  ${ func:cmpr(list.sttus,'1','s') } >
                						${ func:keyVal('1' , '0,1', '미승인,승인') }
               						</option>
               					</select>
               				</td>
               				<td>
               					<select name="level" class="type" data-value="${list.pk}">
               						<option value="1"  ${ func:cmpr(list.level,'1','s') } >
                						${ func:keyVal('1' , '1,4,9', '사용자,지도사용자,관리자') }
               						</option>
                					<option value="4" ${ func:cmpr(list.level,'4','s') } >
                						${ func:keyVal('4' , '1,4,9', '사용자,지도사용자,관리자') }
               						</option>
               						<option value="9" ${ func:cmpr(list.level,'9','s') } >
                						${ func:keyVal('9' , '1,4,9', '사용자,지도사용자,관리자') }
               						</option>
               					</select>
               				</td>
                  			<td>${list.rgsde}</td>
                  			<td>
                  				<button type="button" class="btn btn-danger btn-sm" id="btnDel" onclick="userDelete('${list.pk}','9')">삭제</button>
                  			</td>
                  		</tr>
                  	
                  	</c:forEach>
                  </tbody>
              </table>
               <!-- /List -->
       	<div id="paging">
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
                    <a href="javascript:fn_egov_selectList('${num}')" id="page${num}" class="page-link text-dark fs-5" >
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
	</div>
</div>	<!-- contents -->
<script>


	/* link 태그 맨위에 삽입 부트스트랩 변경으로 주석처리
	function linkTag() { //상단에 링크태그 삽입
		var link = document.createElement("LINK");
		link.setAttribute("rel", "stylesheet");
		link.setAttribute("type", "text/css");
		link.setAttribute("href", "${ctx}/css/egovframework/common.css");
		document.head.appendChild(link);
	}
	*/
	
	$(document).ready(function() {
		//linkTag();	
		$("#page${nowNum}").addClass("bg-info"); //현재번호 css추가
	})
	
	function fn_egov_selectList(num) {
		if(num != "" && typeof num != "undefined") {
			document.getElementById('fnum').value = num;	
		} else {
			document.getElementById('fnum').value = 1;
		}
		
		document.listForm.action = "${ctx}/user/userList.do";
		document.listForm.submit();
		
	}
	
	
	$(".confm").change(function() { //회원 권한 변경
		var pk = $(this).data('value');
		var sttus = $(this).val();
		
		var param = {
				pk : pk
			,	sttus : sttus
		}
		
		var scallback = function(data) {
			alert(data.resultMsg);
		}
		
		callAjax(param, "./userSttus.do", scallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
	});
	

	$(".type").change(function() { //회원 권한 변경
		var pk = $(this).data('value');
		var level = $(this).val();
		
		var param = {
				pk : pk
			,	level : level
		}
		console.log(param);
		
		var scallback = function(data) {
			alert(data.resultMsg);
		}
		
		callAjax(param, "./userLevel.do", scallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
	});
	
	function userDelete(pk,sttus) { //회원 정보 삭제
		var param = {
				pk : pk
			,	sttus : sttus
		}
		var scallback = function(data) {
			alert(data.resultMsg);
			if(data.result == "SUCCESS") {
				location.reload();
			}
		}
		
		callAjax(param, "./userSttus.do", scallback, true, "p"); // 데이터, url, 콜백, 신크, f 폼데이터 p 파람
	}
	
</script>
 
 
 
<%@ include file="/WEB-INF/jsp/egovframework/layout/footer.jsp" %>
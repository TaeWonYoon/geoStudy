<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row body" > <!-- section contents 영역 -->
	<div class="col-1 bg-dark"  style="width:230px;height:911px;"> <!-- left 메뉴 -->
		<div style="margin-top: 2%;"></div> <!--  마진 태그 -->
		<p></p>
		<ul class="nav flex-column m-1">
		    <li class="nav-item m-1">
		    	<span class="fs-5 text-light lf_tx fs-4 m-2">게시판</span>
		    	<ul class="nav flex-column">
		    		<li class="nav-item border rounded-pill bg-white m-1">
		    			<a class="nav-link text-dark border rounded-pill bg-white lf_bg fw-bolder l_m" href="${ctx}/board/boardList.do">게시판</a>
	    			</li>
		    	</ul>
		    </li>
		    <li class="nav-item m-1">
		    	<span class="fs-5 text-light lf_tx fs-4 m-2">시각화차트</span>
		    	<ul class="nav flex-column m-1">
		    		<li class="nav-item">
		    			<a class="nav-link text-dark border rounded-pill bg-white lf_bg fw-bolder l_m" href="${ctx}/map/totalList.do">시각화차트</a>
		    		</li>
		    	</ul>
		    </li>
		    <li class="nav-item m-1">
		    	<span class="fs-5 text-light lf_tx fs-4 m-2">오픈레이어</span>
		    	<ul class="nav flex-column">
		    		<li class="nav-item m-1">
		    			<a class="nav-link text-dark border rounded-pill bg-white lf_bg fw-bolder l_m" href="${ctx}/map/map.do">기상관측</a>
		    		</li>
		    	</ul>
		    </li>
		    
		    <c:if test="${userVO == null}">
		    	<li class="nav-item m-1">
			    	<span class="fs-5 text-secondary lf_tx"></span>
			    </li>
				<li class="nav-item m-1 li_idx">
					<a href="${ctx}/user/login.do" class="fs-5 nav-link text-light fs-4"> 로그인 </a>
				</li>
			</c:if>

			<c:if test="${userVO != null}">
				<li class="nav-item m-1">
			    	<span class="fs-5 text-secondary lf_tx"></span>
			    </li>
				<li class="nav-item m-1 li_idx">
					<a href="${ctx}/user/logout.do" class="fs-5 nav-link text-light fs-4 " onclick="alert('로그아웃 되었습니다.')"> 로그아웃 </a>
				</li>
			</c:if>
 		</ul>
	</div>
	
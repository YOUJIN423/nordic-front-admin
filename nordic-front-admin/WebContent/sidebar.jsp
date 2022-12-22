<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<div id="side-bar" class="col-sm-2" style="font-size: 10pt;">
	    <div class="list-group">
	        <a class="list-group-item list-group-item-action" href="">로그아웃</a>
	        <a class="list-group-item"><b>메인</b></a>
	        <a class="list-group-item list-group-item-action" href="intro/admin/introduce.jsp">소개</a>
	        <a class="list-group-item list-group-item-action" href="origin/admin/origin.jsp">기원</a>
	        <a class="list-group-item"><b>미션 관리</b></a>
	        <a class="list-group-item list-group-item-action" href="mission/insert.jsp">미션 장소 등록</a>
	        <a class="list-group-item list-group-item-action" href="mission/list.jsp">미션 장소</a>
	        <a class="list-group-item list-group-item-action" href="missionList.jsp">미션 등록 현황</a>
	        <a class="list-group-item"><b>굿즈 관리</b></a>
	        <a class="list-group-item list-group-item-action" href="goods/goods_all.jsp">모든 굿즈</a>
	        <a class="list-group-item list-group-item-action" href="goods/requests_confirmed.jsp">확인된 요청</a>
	        <a class="list-group-item list-group-item-action" href="goods/requests_unconfirmed.jsp">미확인 요청</a>
	        <a class="list-group-item"><b>회원 관리</b></a>
	        <a class="list-group-item list-group-item-action" href="member/members.jsp">가입 회원 정보</a>
	        <a class="list-group-item"><b>리포트</b></a>
	        <a class="list-group-item list-group-item-action" href="goods/goods_best.jsp">최다 지급 굿즈</a>
 	        <a class="list-group-item list-group-item-action" href="<%= request.getContextPath()%>/points/top10.jsp">최다 적립 회원 TOP 10</a>
	        <a class="list-group-item list-group-item-action" href="">최다 미션 수행</a>
	        <a class="list-group-item list-group-item-action" href="">최다 미션 수행일</a>
	        <a class="list-group-item list-group-item-action" href="">최다 댓글 게시글</a>
	        <a class="list-group-item list-group-item-action" href="">최다 댓글 작성 회원</a>
	    </div>
	</div>
</body>
</html>
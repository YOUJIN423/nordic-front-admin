<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<style>
a {
	text-decoration: none;
    color: black;
}
</style>
</head>
<script>
	let token = localStorage.getItem('wtw-token') || '';
	
	$(document).ready(function(){
		if(token=='') {
			location.href="login.jsp";
		}
	});
</script>
<body>
	<header>
		<a href="/nordic-front-admin/"><h1>NORDIC WALKING</h1></a>
	</header>
	<div class="container mt-5 mb-5">
		<div class="row">
			<jsp:include page="sidebar.jsp" />
			<div class="col-sm-10 p-5">
				<h1 class="mb-5"><b>관리자 페이지</b></h1>
				<img alt="main" src="img/main_img.jpg">
			</div>
		</div>
	</div>
	<footer align="center">
		서비스 이용약관 | 개인정보 보호정책 | 청소년 보호정책<br> Copyright <strong>©노르딕워킹</strong>
		All rights reserved.
	</footer>
</body>
</html>
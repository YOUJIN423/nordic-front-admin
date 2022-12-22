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
<link rel="stylesheet" href="../css/header.css">
<link rel="stylesheet" href="../css/footer.css">
<style>
	*{
		color : black;
	}
	
	a {
		text-decoration: none;
	    color: black;
	}
</style>
<script>
	$(document).ready(function(){
		let token = localStorage.getItem('wtw-token') || '';
		$.ajax({
			type : "GET",
			url : "http://localhost:80/api/report/users/top-comment",
			headers: {
 		        'Authorization': `Bearer \${token}`,
 		    },
			success : function(data) {
				console.log(data);
				for (var i=0; i<data.data.length; i++) {
					var users = `
						<tr onclick="detail('\${data.data[i].create_member}')">
							<td>\${data.data[i].create_member}</td>
							<td>\${data.data[i].count}</td>
							<td>\${data.data[i].min}</td>
							<td>\${data.data[i].max}</td>
						</tr>
					`
					
					$("#tb").append(users);
				}
			}
		});
		
	});
	
	function detail(m) {
		location.href = "TopCommentMemberDetail.jsp?member_code="+m;
	}
</script>
</head>
<body>
	<header>
		<a href="/nordic-front-admin/"><h1>NORDIC WALKING</h1></a>
	</header>
	<div class="container mt-5 mb-5">
		<div class="row justify-content-center">
			<jsp:include page="../sidebar.jsp"/>
			<div class="col-sm-10 ps-5" id="report">
				<div>
					<table class="table text-center mx-auto" style="width:500px">
						<thead>
							<tr>
								<td><b>회원명<b></td>
								<td><b>작성한 댓글 수</b></td>
								<td><b>시작일자</b></td>
								<td><b>최근일자</b></td>
							</tr>
						</thead>
						<tbody id="tb"></tbody>
					</table>
				</div>
				<br>
				<div style="class="mt-5" id="d"></div>
			</div>
		</div>
	</div>
	<footer align="center">
		서비스 이용약관 | 개인정보 보호정책 | 청소년 보호정책<br> Copyright <strong>©노르딕워킹</strong>
		All rights reserved.
	</footer>
</body>
</html>
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

<script>
	function login() {
		var member_code = $("#member_code").val();
		var password = $("#password").val();
		
		/* 이전 페이지로 이동 */
		var referrer = document.referrer;
		if(referrer.includes('login')) {
			referrer = "missionList.jsp";	
		}
		
		$.ajax({
			method : "POST",
 			url : "http://localhost:80/api/member/login",
 			data : JSON.stringify({
 				"member_code" : member_code,
 				"password" : password
 			}),
 			contentType: 'application/json',
 			success: function(data) {
 				console.log(data.data.token);
 				localStorage.setItem('wtw-token', data.data.token);
 				localStorage.setItem('member_code',data.data.member_code)
	 			location.href = referrer;
	 			
 			}, error: function (data) {
				alert("아이디 혹은 비밀번호를 확인하세요.")
			}
		});
	}
</script>
</head>
<body>
	<header>
		<h1>NORDIC WALKING</h1>
	</header>
	<div class="container">
		<div class="row col-7 border mx-auto" style="margin-top: 50px;">
			<form id="frm" class="align-middle" style="height: 300px; display:grid; align-items:center;">
				<table class="mx-auto" style="height: 90px;  display:inline-block;">
					<tr>
						<td width="75px">아이디</td>
						<td><input type="text" id="member_code" name="member_code"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" id="password" name="password"></td>
						<td rowspan="2"><input type="button" id="loginBtn" 
							onclick="login()" class="btn btn-dark ms-2" value="로그인"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>

	<footer align="center">
		서비스 이용약관 | 개인정보 보호정책 | 청소년 보호정책<br> Copyright <strong>©노르딕워킹</strong>
		All rights reserved.
	</footer>
</body>
</html>
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
<style>
	a {
		text-decoration: none;
	    color: black;
	}
</style>

<script>
let token = localStorage.getItem('wtw-token') || '';

$(document).ready(function(){
	var pageNo = 1;
	list(pageNo);	
});

function list(pageNo) {

	
	$.ajax({
		type : "GET",
		url : "http://localhost:80/api/report/users/detail?page="+pageNo+"&member_code="+"<%=request.getParameter("member_code")%>",
		headers: {
		        'Authorization': `Bearer \${token}`,
		    },
		success : function(data) {
			var list = data.data.list;
			var mission_data;
			
			console.log(data);
			console.log(list);
			
			for(var i=0; i<list.length; i++) {
				
				var d = 
					` <tr class="m">
						<td>\${list[i].board_object}</td>
						<td>\${list[i].create_date}</td>
						<td>\${list[i].reply_desc}</td>
					</tr> `
					
				mission_data = mission_data + d;

			}
			
			$('tr.m').remove();
			$("#tb").append(mission_data);
			
			/* 페이징 */
			var total = data.data.pages;
			var pagenation = ``;
			
			var startPage = Math.floor((pageNo-1)/10)*10 + 1;
			var endPage = startPage+9;
			
			var prev;
			if(pageNo>10) {
				prev = `<a onclick=list(\${startPage-1})>[이전]</a>`
			} else {
				prev = `<a>[이전]</a>`
			}
			
			var pageList=``;
			var page;
			
			for(var j=0; j<=9; j++) {
				var p = startPage+j;
				
				if (p!=pageNo) {
					page = `<span><a onclick=list(\${p})> \${p} </a></span>`	
				} else {
					page = `<span><b> \${p} </b></span>`	
				}
				
				if(j==data.data.pages) {
					break;
				}
				
				pageList = pageList + page;
			}
			
			var later;
			if(endPage>total) {
				later = `<a>[다음]</a>`
			} else {
				later = `<a onclick=list(\${endPage+1})>[다음]</a>`
			}
			
			pagenation = prev+pageList+later;
			
			$("#page").html(pagenation);
		}
	});
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
					<table class="table text-center mx-auto" style="width:800px">
						<thead>
							<tr>
								<td><b>게시글<b></td>
								<td><b>등록일시</b></td>
								<td><b>내용</b></td>
							</tr>
						</thead>
						<tbody id="tb"></tbody>
					</table>
				</div>
				<div class="text-center" id="page"></div>
				<br>
			</div>
		</div>
	</div>
	<footer align="center">
		서비스 이용약관 | 개인정보 보호정책 | 청소년 보호정책<br> Copyright <strong>©노르딕워킹</strong>
		All rights reserved.
	</footer>
</body>
</html>
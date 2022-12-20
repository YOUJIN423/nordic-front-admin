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

<script>
	let token = localStorage.getItem('wtw-token') || '';
	var sd = '';
	var ed = '';
	
	$(document).ready(function(){
		list();	
	});
	
	function list() {
		console.log({"start":sd, "end":ed});
		
		$.ajax({
			type : "GET",
			url : "http://localhost:80/api/report/users/top-comment",
 		    data : {"start_date":sd, "end_date":ed},
			headers: {
 		        'Authorization': `Bearer \${token}`,
 		    },
			success : function(data) {
				console.log(data);
			}
		});
	}
	
	/* 날짜 출력 포맷 */
	function timeformat(t){
	    var year = t.getFullYear();
	    var month = "0" + (t.getMonth()+1);
	    var day = "0" + t.getDate();
	    return year + "-" + month.substr(-2) + "-" + day.substr(-2);
	}
	
	function period() {
		sd = $("#start").val();
		ed = $("#end").val();
		
		if(sd==''||ed=='') {
			if(sd=='') {
				sd = timeformat(new Date('1990-01-01'));							
			}
			
			if(ed=='') {
				ed = timeformat(new Date());
			}
		}
		list();
	}
</script>
</head>
<body>
	기간 조회 :
	<input type="date" id="start" name="start"> ~
	<input type="date" id="end" name="end">
	<input type="button" id="periodBtn" class="btn" onclick="period()" value="조회">
</body>
</html>
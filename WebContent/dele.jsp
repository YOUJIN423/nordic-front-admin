<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
$(document).ready(function () {
	let tes2 = $("#tes2");
	
	fetch("http://localhost/image/97")
		.then((data) => console.log(data));
})
</script>
<title>Insert title here</title>
</head>
<body>
	<b id="tes2"> </b>
</body>
</html>
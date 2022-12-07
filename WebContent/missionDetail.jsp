<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function(mission_no) {
		const urlstr = window.location.href;
		const url = new URL(urlstr);
		const urlParams = url.searchParams;
		const tag = urlParams.get("mission_no");
		
		let mission_name = $("#mission_name");
		let start = $("#start");
		let end = $("#end");
		let level_code = $("#level_code");
		let point = $("#point");
		let address1 = $("#address1");
		let address2 = $("#address2");
		let createA = document.createElement("a");

		
		var fetchurl = "http://localhost/missionByNo/" + tag;
		
		fetch(fetchurl)
		.then((response)=> response.json())
		.then((data) => html(data))
		
		function html(data){
			mission_name.text(data.mission_name);
			start.text(data.start_date);
			end.text(data.end_date);
			level_code.text(data.level_code);
			point.text(data.point);
			address1.text(data.address1);
			address2.text(data.address2);
			var imgurl = "<img src='http://localhost/image/"+tag+"' style='width: 300px; height: 300px;'/>";
			$("#zzz").append(imgurl);
			var imgur2 = "<a href='modi.jsp?mission_no="+tag+"' style='text-decoration: none;' > <input type='button' value='수정'/>  </a>";
			$("#here1").append(imgur2);
			var imgur3 = "<a href='dele.jsp?mission_no="+tag+"' style='text-decoration: none;' > <input type='button' value='삭제'/>  </a>";
			$("#here2").append(imgur3);
		}
	
	});
</script>
<script type="text/javascript">
	function goBack() {
		history.go(-1);
	}
</script>
</head>
<body>
	<pre>
미션명 : <b id="mission_name"></b> <br> 
기간 : <b id="start"></b> ~ <b id="end"></b> <br>
난이도 :  <b id="level_code"></b><br>
포인트 :  <b id="point"></b><br>
주소 :  <b id="address1"></b> <b id="address2"></b><br>
사진 :   <b id="zzz"></b><br>
<b id="here1"></b><b id="here2"></b> <input type="button" onclick="goBack()" value="글 목록">
</pre>
</body>
</html>
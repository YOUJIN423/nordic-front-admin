<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=68f650077e726d080433ae45c322df48&libraries=services,clusterer,drawing"></script>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function plzrun() {
	var koraddress = $("#tesx").val();
	console.log(koraddress);
	var mapContainer = document.getElementById("location"), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	// 주소로 좌표를 검색합니다
	geocoder
			.addressSearch(
					koraddress,
					function(result, status) {
						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {
							var coords = new kakao.maps.LatLng(result[0].y,
									result[0].x);
							// 결과값으로 받은 위치를 마커로 표시합니다
							var marker = new kakao.maps.Marker({
								map : map,
								position : coords
							});
							// 인포윈도우로 장소에 대한 설명을 표시합니다
							var infowindow = new kakao.maps.InfoWindow(
									{
										content : '<div style="width:150px;text-align:center;padding:6px 0;">미션 장소</div>'
									});
							infowindow.open(map, marker);
							// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
						}
					});
}
const urlstr = window.location.href;
const url = new URL(urlstr);
const urlParams = url.searchParams;
const tag = urlParams.get("mission_no");
const update_mumber = "updatemember";
$(document).ready(function() {
		plzrun();
		let mission_name = $("#mission_name");
		let start = $("#start");
		let end = $("#end");
		let level_code = $("#level_code");
		let point = $("#point");
		let address1 = $("#address1");
		let address2 = $("#address2");
		let tesx = $("#tesx");
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
			tesx.val(data.address1);
			address2.text(data.address2);
			var imgurl = "<img src='http://localhost/image/"+tag+"' style='width: 300px; height: 300px;'/>";
			$("#zzz").append(imgurl);
			var imgur2 = "<a href='modi.jsp?mission_no="+tag+"' style='text-decoration: none;' > <input type='button' value='수정'/>  </a>";
			$("#here1").append(imgur2);
			var imgur3 = "<button type='button' class='btn btn-danger' data-bs-toggle='modal' data-bs-target='#exampleModal'>탈퇴</button>";
			$("#here2").append(imgur3);
		}
	});
		
		function deleteButton() {
			var confirmMessage= $("#confirmMessage").val();
			if(confirmMessage==="지금삭제"){
				var deleteUrl = "http://localhost/mission/"+tag+"/"+update_mumber;
				$.ajax({
					url : deleteUrl,
					method : "delete",
					success :function(){
						alert("삭제되었습니다.")
						location.href = "list.jsp";
					}
				})
			}else{
				alert("잘못 입력 되었습니다")
			}
			
		}
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
	위치 :
	<div id="location" style="width: 30%; height: 350px;"></div>
	<br>
<b name="location"></b>
사진 :   <b id="zzz"></b><br>
<b id="here1"></b><b id="here2"></b> <input type="button"
			onclick="goBack()" value="글 목록">
			<input type="hidden" id="tesx">
</pre>
</body>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="z-index: 100">
		<div class="modal-content">
			<div class="modal-header" align="center">
				<h1 class="modal-title fs-5" id="exampleModalLabel"
					style="color: red" align="center">미션 삭제</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>

			<span class="bi bi-check" style="color: red"><span
				style="color: black;">삭제를 원하시면 "<span
					style="text-decoration: underline; color: red;">지금삭제</span>"를 입력하세요
			</span></span> <input type="text" id="confirmMessage">

			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-danger"
					onclick="deleteButton()">삭제</button>
			</div>
		</div>
	</div>
</div>
</html>
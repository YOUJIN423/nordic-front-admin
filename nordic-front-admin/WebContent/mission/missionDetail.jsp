<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=68f650077e726d080433ae45c322df48&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="../css/header.css">
<link rel="stylesheet" href="../css/footer.css">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>미션 상세</title>
<script type="text/javascript">
const urlstr = window.location.href;
const url = new URL(urlstr);
console.log("urlstr"+urlstr);
console.log("url"+url);
const urlParams = url.searchParams;
console.log("urlParams"+urlParams);
const tag = urlParams.get("mission_no");
console.log("tag : "+tag);
const update_mumber = "updatemember";
$(document).ready(function() {
		let token = localStorage.getItem('wtw-token') || '';
		let mission_name = $("#mission_name");
		let start = $("#start");
		let end = $("#end");
		let level_code = $("#level_code");
		let point = $("#point");
		let address1 = $("#address1");
		let address2 = $("#address2");
		let tesx = $("#tesx");
		let createA = document.createElement("a");

		var fetchurl = "http://localhost/api/mission/" + tag;
		
		fetch(fetchurl,{headers: {
	        'Authorization': `Bearer \${token}`,
	  	}})
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
			var modibutton = "<a href='modi.jsp?mission_no="+tag+"' style='text-decoration: none;' > <input class='btn btn-outline-secondary' type='button' value='수정'/>  </a>";
			$("#here1").append(modibutton);
			var deletebutton = "<button type='button' class='btn btn-danger' data-bs-toggle='modal' data-bs-target='#exampleModal'>삭제</button>";
			$("#here2").append(deletebutton);
			var whileurl = "http://localhost/api/countImage/"+tag;
	
			fetch(whileurl,{headers: {
		        'Authorization': `Bearer \${token}`,
		  	}})
				.then((response) => response.text(data))
				.then((data) => createImgTag(data))
			
			
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
							data.address1,
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
	});
	
		function createImgTag(data) {
			console.log("data : "+Number(data));
			var imgurl =""; 
			for(var count =0; count<data;count++){
				imgurl += "<img src='http://localhost/api/image/"+tag+"/"+count+"' style='width: 250px ; height: 142px' />";
			}
			console.log(imgurl);
			$("#imgplace").append(imgurl);
		}
		
		function deleteButton() {
			let token = localStorage.getItem('wtw-token') || '';
			var confirmMessage= $("#confirmMessage").val();
			if(confirmMessage==="지금삭제"){
				var deleteUrl = "http://localhost/api/mission/"+tag+"/"+update_mumber;
				$.ajax({
					url : deleteUrl,
					method : "delete",
					  headers: {
					        'Authorization': `Bearer \${token}`,
					  	},
					success :function(){
						alert("삭제되었습니다.")
						location.href = "list.jsp";
					}
				})
			}else{
				alert("잘못 입력 되었습니다")
			}
			
		}
		function goBack() {
			history.go(-1);
		}
</script>
</head>
<body>
	<header align="center">
		<h1>NORDIC WALKING</h1>
	</header>

	<div class="container-fluid mt-3">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="../sidebar.jsp"></jsp:include>
				<div id="main-content" class="col-sm-8"
					style="margin-left: 50px; margin-top: -10px">
					<div class="row" align="center">
						<div class="col-sm-4">
							<div class="fakeimg">
								<div id="location" style="height: 350px;"></div>
							</div>
						</div>
						<div class="col-sm-8"
							style="padding-left: 5%; font-size: large; width: 600px;">
							<label class="form-label">미션명 </label> <b id="mission_name"
								style="font-size: larger;"></b> <br> <label
								class="form-label">기간 </label> <b id="start"
								style="font-size: larger;"></b> ~ <b id="end"
								style="font-size: larger;"></b> <br> <label
								class="form-label">난이도 </label> <b style="font-size: larger;"
								id="level_code"></b> <br> <label class="form-label">포인트
							</label> <b id="point" style="font-size: larger;"></b> <br> <label
								class="form-label">주소 </label> <b id="address1"
								style="font-size: larger;"></b> <b id="address2"
								style="font-size: larger;"></b>
						</div>
						<br>
						<div class="fakeimg">
							<br>
							<div id="imgplace" align="center"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<br>
	<div align="center">
		<b id="here1"></b> <b id="here2"></b> <input
			class='btn btn-outline-secondary' type="button" onclick="goBack()"
			value="글 목록">
	</div>
	</div>

	<footer>
		<center>
			서비스 이용약관 | 개인정보 보호정책 | 청소년 보호정책<br> Copyright <strong>©노르딕워킹</strong>
			All rights reserved.
		</center>
	</footer>
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
<!DOCTYPE html><%@ page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=68f650077e726d080433ae45c322df48&libraries=services,clusterer,drawing"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link rel="stylesheet" href="../css/header.css">
<link rel="stylesheet" href="../css/footer.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	$(document).ready(function() {
		let token = localStorage.getItem('wtw-token') || '';
		const urlstr = window.location.href;
		const url = new URL(urlstr);
		const urlParams = url.searchParams;
		const tag = urlParams.get("mission_no");
		console.log(tag);

		let mission_name = $("#mission_name");
		let start_date = $("#start_date");
		let end_date = $("#end_date");
		let level_code = $("#level_code");
		let point = $("#point");
		let zip_code = $("#zip_code");
		let address1 = $("#address1");
		let address2 = $("#address2");
		let remark = $("#remark");
		
	
		var gettinurl = "http://localhost/api/mission/"+tag;

		fetch(gettinurl,{headers: {
	        'Authorization': `Bearer \${token}`,
	  	}})
			.then((response) => response.json())
			.then((data)=>insertdata(data))
			
		function insertdata(data){
			mission_name.val(data.mission_name);
			start_date.val(data.start_date);
			end_date.val(data.end_date);
			level_code.val(data.level_code);
			point.val(data.point);
			zip_code.val(data.zip_code);
			address1.val(data.address1);
			address2.val(data.address2);
			remark.val(data.remark);
			changeevent(address1);
		}	

		//insert------
		$("#submitBtn").click(function() {
			if ($("#mission_name").val() == "") {
				alert("이름을 입력하세요");
				$("#mission_name").focus();
				return false;
			}
			if ($("#start_date").val() == "") {
				alert("미션 시작 날짜를 입력하세요");
				$("#start_date").focus();
				return false;
			}
			if ($("#end_date").val() == "") {
				alert("미션 종료 날짜를 입력하세요");
				$("#end_date").focus();
				return false;
			}
			if ($("#level_code").val() == "") {
				alert("난이도를 설정해 주세요");
				$("#level_code").focus();
				return false;
			}
			if ($("#point").val() == "") {
				alert("포인트를 설정해 주세요");
				$("#point").focus();
				return false;
			}
			if ($("#zip_code").val() == "") {
				alert("우편번호를 입력해 주세요");
				$("#zip_code").focus();
				return false;
			}
			if ($("#address1").val() == "") {
				alert("주소를 입력해 주세요");
				$("#address1").focus();
				return false;
			}
			if ($("#uploadfiles").val() == "") {
				alert("사진이 없습니다");
				$("#uploadfiles").focus();
				return false;
			}
			
			var missioninsert = "http://localhost/api/mission/"+tag;
			$.ajax({
				url : missioninsert,
				method : "put",
				contentType : "application/json",  headers: {
			        'Authorization': `Bearer \${token}`,
			  	},
				data : JSON.stringify({
					mission_name : $("#mission_name").val(),
					start_date : $("#start_date").val(),
					end_date : $("#end_date").val(),
					level_code : $("#level_code").val(),
					point : $("#point").val(),
					remark : $("#remark").val(),
					zip_code : $("#zip_code").val(),
					address1 : $("#address1").val(),
					address2 : $("#address2").val(),
					update_member : "MODICHANGEVALUE",
				}),
				success : function(success) {
					var imageinsert = "http://localhost/api/image/MODICHANGEVALUE/"+tag;
					$.ajax({
						url : imageinsert ,
						type : "put",  headers: {
					        'Authorization': `Bearer \${token}`,
					  	},
						data : new FormData($("#upload-file-form")[0]),
						enctype : 'multipart/form-data',
						processData : false,
						contentType : false,
						cache : false,
						success : function() {
							location.href = "list.jsp";
						},
						error : function() {

						}
					});

				},
				error : function(error) {
					console.log(error);
				},
			});

		});//insert------
	});
</script>
<script type="text/javascript">
<script>
function post() {
	window.open("", "post", "width=200,height=300,scrollbars=yes");
}
</script>
<script>
function openDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			document.getElementById("zip_code").value = data.zonecode;
			document.getElementById("address1").value = data.address;
			$("#address2").focus();
		},
	}).open();
}

function changeevent(missionAddress) {
	var koraddress = $("#address1").val();
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
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
</script>
</script>
<style type="text/css">
html {
	box-sizing: border-box;
}

*, *:before, *:after {
	box-sizing: inherit;
}

body {
	background: #f5f5f5;
	color: #333;
	font-family: arial, helvetica, sans-serif;
	font-size: 32px;
}

h1 {
	font-size: 32px;
	text-align: center;
}

p {
	font-size: 20px;
	line-height: 1.5;
	margin: 40px auto 0;
	max-width: 640px;
}

pre {
	background: #eee;
	border: 1px solid #ccc;
	font-size: 16px;
	padding: 20px;
}

form {
	margin: 40px auto 0;
}

label {
	display: block;
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 10px;
}

input {
	border: 2px solid #333;
	border-radius: 5px;
	color: #333;
	font-size: 32px;
	margin: 0 0 20px;
	padding: .5rem 1rem;
	width: 100%;
}

button {
	background: #fff;
	border: 2px solid #333;
	border-radius: 5px;
	color: #333;
	font-size: 16px;
	font-weight: bold;
	padding: 1rem;
}

button:hover {
	background: #333;
	border: 2px solid #333;
	color: #fff;
}

.main {
	background: #fff;
	border: 5px solid #ccc;
	border-radius: 10px;
	margin: 40px auto;
	padding: 40px;
	width: 80%;
	max-width: 700px;
}
</style>
<title>Document</title>
</head>
<body>
	<header align="center">
		<h1>NORDIC WALKING</h1>
	</header>

	<div class="container-fluid">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="../sidebar.jsp"></jsp:include>
				<div id="main-content" class="col-sm-8"
					style="margin-left: 50px; margin-top: -10px">

					<div class="main">

						<form style="max-width: 400px;" id="upload-file-form"
							enctype="multipart/form-data">
							<div class="mb-3 mt-3">
								<label class="form-label">미션명</label><input type="text"
									id="mission_name" name="mission_name" class="form-control" />
							</div>
							<div class="mb-3 mt-3">
								<label class="form-label">시작일</label> <input
									class="form-control" type="date" name="start_date"
									id="start_date">
							</div>
							<div class="mb-3 mt-3">
								<label class="form-label">종료일</label> <input
									class="form-control" type="date" name="end_date" id="end_date">
							</div>
							<div class="mb-3 mt-3">
								<label class="form-label">난이도</label> <select
									class="form-control" name="level_code" id="level_code">
									<option value="">선택하세요</option>
									<option value="상">상</option>
									<option value="중">중</option>
									<option value="하">하</option>
								</select>
							</div>
							<div class="mb-3 mt-3">
								<label class="form-label">포인트</label> <input
									class="form-control" type="text" name="point" id="point" />
							</div>
							<div class="mb-3 mt-3">
								<label class="form-label">우편번호</label> <input
									class="form-control" type="text" size="5" maxlength="5"
									name="zip_code" id="zip_code" /> <input class="form-control"
									type="button" value="우편검색" onclick="openDaumPostcode()" />
							</div>
							<div class="mb-3 mt-3">
								<label class="form-label">주소</label> <input class="form-control"
									type="text" size="50" name="address1" id="address1" /> <input
									class="form-control" type="text" size="50" name="address2"
									id="address2" onfocus="changeevent()" />
							</div>
							<div colspan="2" id="map" style="width: 400px; height: 400px;"></div>
							<div class="mb-3 mt-3">
								<label class="form-label">사진</label> <input class="form-control"
									type="file" multiple="multiple" name="uploadfiles"
									id="uploadfiles">
							</div>
							<input class="form-control" type="button" id="submitBtn"
								value="전송" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<center>
			서비스 이용약관 | 개인정보 보호정책 | 청소년 보호정책<br> Copyright <strong>©노르딕워킹</strong>
			All rights reserved.
		</center>
	</footer>
</body>
</html>

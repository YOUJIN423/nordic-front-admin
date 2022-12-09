<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=68f650077e726d080433ae45c322df48&libraries=services,clusterer,drawing"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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

	function changeevent() {
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

<script>
	$(document).ready(function() {
		changeevent()
		$("#submitBtn").click(function() {
			$.ajax({
				url : "http://localhost/mission",
				method : "post",
				contentType : "application/json",
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
					use_yn : "Y",
					create_member : "changevalue",
					update_member : "changevalue",
				}),
				success : function(success) {
					$.ajax({
						url : "http://localhost/image/test",
						type : "POST",
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

		});
	});//document end
</script>
<title>Document</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>mission_name</th>
			<td><input type="text" id="mission_name" name="mission_name" /></td>
		</tr>
		<tr>
			<th>시작일</th>
			<td><input type="date" name="start_date" id="start_date"></td>
		</tr>
		<tr>
			<th>종료일</th>
			<td><input type="date" name="end_date" id="end_date"></td>
		</tr>
		<tr>
			<th>level_code</th>
			<td><select name="level_code" id="level_code">
					<option value="">선택하세요</option>
					<option value="상">상</option>
					<option value="중">중</option>
					<option value="하">하</option>
			</select></td>
		</tr>
		<tr>
			<th>point</th>
			<td><input type="text" name="point" id="point" /></td>
		</tr>
		<tr>
		<tr>
			<th>우편번호</th>
			<td><input type="text" size="5" maxlength="5" name="zip_code"
				id="zip_code" /> <input type="button" value="주소검색"
				onclick="openDaumPostcode()" /></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" size="50" name="address1" id="address1"
				 /> <br> <input type="text" size="50"
				name="address2" id="address2"  onfocus="changeevent()"/></td>
		</tr>
		<tr>
			<td colspan="2" id="map" style="width: 500px; height: 400px;"></td>
		</tr>
		<tr>
			<th>사진</th>
			<td>
				<form id="upload-file-form" enctype="multipart/form-data">
					<input type="file" multiple="multiple" name="uploadfiles"
						id="uploadfiles">
				</form>
			</td>
		</tr>
		<tr>
			<th>설명</th>
			<td><textarea name="remark" id="remark" cols="30" rows="10"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="button"
				id="submitBtn" value="전송" /></td>
		</tr>
	</table>
</body>
</html>

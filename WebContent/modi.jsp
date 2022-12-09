<!DOCTYPE html><%@ page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
	$(document).ready(function() {
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
		
		var gettinurl = "http://localhost/missionByNo/"+tag;

		fetch(gettinurl)
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
		}	

		//insert------
		$("#submitBtn").click(function() {
			var missioninsert = "http://localhost/mission/"+tag;
			$.ajax({
				url : missioninsert,
				method : "put",
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
					update_member : "MODICHANGEVALUE",
				}),
				success : function(success) {
					var imageinsert = "http://localhost/image/MODICHANGEVALUE/"+tag;
					$.ajax({
						url : imageinsert ,
						type : "put",
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
				id="zip_code" /> <!-- <input
                  type="button"
                  value="우편검색"
                  onclick="openDaumPostcode()"
                /> --></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" size="50" name="address1" id="address1" />
				<br> <input type="text" size="50" name="address2" id="address2" /></td>
		</tr>
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
		<!-- <script>
          var mapContainer = document.getElementById('map'), // 지도를 표시할 div
              mapOption = {
                  center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                  level: 3 // 지도의 확대 레벨
              };

          // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
          var map = new kakao.maps.Map(mapContainer, mapOption);
          </script> -->
	</table>
</body>
</html>

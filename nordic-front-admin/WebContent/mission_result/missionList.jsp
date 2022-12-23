<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f18f708ab83ac158fcf9835e92a5638f&libraries=services,clusterer,drawing"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="../css/header.css">
<link rel="stylesheet" href="../css/footer.css">
<style>
	a {
		text-decoration: none;
	    color: black;
	}
	table td {
		color: black
	}
	
	p {
		line-height: 15px
	}

</style>
<script>
	var pageNo; 		 // 페이지 번호
	var confirm = false; // 미승인
	var sd; 			 // 기간 조회 - start_date
	var ed; 			 // 기간 조회 - end_date
	let token = localStorage.getItem('wtw-token') || '';
	let member_code = localStorage.getItem('member_code') || '';
	
	$(document).ready(function(){
		pageNo = 1;
		list(pageNo);
	});
	
	/* 날짜 출력 포맷 */
	function Unix_timestamp(t){
	    var date = new Date(t*1);
	    var year = date.getFullYear();
	    var month = "0" + (date.getMonth()+1);
	    var day = "0" + date.getDate();
	    return year + "-" + month.substr(-2) + "-" + day.substr(-2);
	}
	
	/* 미션 수행 현황 리스트 */
	function list(pageNo) {
		
		/* 미승인건 체크박스 체크 여부 */
 		const checkbox = document.getElementById('check');
 		const is_checked = checkbox.checked;
		checked = is_checked;
		
 		if (typeof checked == "undefined") {
			is_checked = false;
		}
 		
		/* 미승인된 미션수 */
 		$.ajax({
 			type : "GET",
 			url : "http://localhost:80/api/admin/mission/result/count",
 			headers: {
 		        'Authorization': `Bearer \${token}`,
 		    },
			success : function(data) {
				console.log(data);
				var count = `
					<p><b>미승인 건 </b> : \${data.data}</p>
				`
				$("#count").html(count);
			}, error: function(data) {
				location.href = "../login.jsp"
			}
 		});

 		/* 리스트 출력 */
 		$.ajax({
			type : "GET",
			url : "http://localhost:80/api/admin/mission/result?page="+pageNo+"&checked="+checked,
			data : {"start_date":sd, "end_date":ed},
			headers: {
 		        'Authorization': `Bearer \${token}`,
 		    },
			success : function(data) {
				console.log(data);
				var list = data.data.list;
				var mission_data;
				
				for(var i=0; i<list.length; i++) {
					
					var date = Unix_timestamp(`\${list[i].create_date}`);
					var today = Unix_timestamp(new Date());
					
					var remark = `\${list[i].remark}`
					var confirm_member = `\${list[i].confirm_member}`
					
					var d = 
						` <tr class="m" onclick="detail(\${list[i].mission_history_no},\${pageNo})">
							<td><b style="color:red">\${date == today ? 'N':''}</b></td>
							<td>\${list[i].mission_history_no}</td>
							<td>\${list[i].member_code}</td>
							<td>\${list[i].mission_name}</td>
							<td>\${list[i].point}</td>
							<td>\${list[i].confirm_member==null?'':(list[i].confirm_yn=='Y'?'승인':'거절')}</td>
							<td>\${list[i].confirm_member==null?'':confirm_member}</td>
							<td>\${date}</td>
							<td>\${list[i].remark==null?'':remark}</td>
						</tr> `
						
					mission_data = mission_data + d;
				}
				
				$('tr.m').remove();
				$("#t").append(mission_data);
				
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
	
	/* 미션 수행 상세 정보 */
 	var b_no;
 	
	function detail(no, pageNo) {
		var dp = $("#detail").css("display");
 		
 		if (b_no!=no) {
 			$("#detail").css("display","block");
 		} else if(dp=="none") {
 			$("#detail").css("display","block");
 		} else if (dp=="block"){
 			$("#detail").css("display","none");
 		}
 		
 		b_no = no;
		
 		var path = "http://localhost:80/api/admin/mission/result/"+no;
		$.ajax({
			method : "GET",
			url : path,
			headers: {
 		        'Authorization': `Bearer \${token}`,
 		    },
			success : function(data) {
				console.log(data);
				var history = data.data.history;
				var history_img = data.data.history_img;
				var master = data.data.master;
				var master_img = data.data.master_img;
				
				var start_date = Unix_timestamp(`\${master.start_date}`); 
				var end_date = Unix_timestamp(`\${master.end_date}`); 
				var img_update_date = Unix_timestamp(`\${history_img.create_date}`);
				
				/* 미션 이미지 파일*/
				var mission_image = ``;
				
				if(master_img.confirm_file.startsWith('{')) {
					var file_name = JSON.parse(master_img.confirm_file);
					var name = file_name.picture;
					
					var jsonObjKey = [];
					var jsonObjVal = [];
					
					for(var i=0; i<name.length; i++){
					    jsonObjKey.push(Object.keys(name[i])[0]);
					    jsonObjVal.push(name[i][Object.keys(name[i])[0]]);
					    
					    var m_img = `
					    	<img src="http://localhost:80/api/mission/image/\${jsonObjVal[i]}?path=missionmaster" width="200px"
					    		onerror="this.src='http://localhost:80/api/mission/image/error.png?path=mission';">
					    `
					    mission_image = mission_image + m_img;
					};
				} else {
					var m_img = `
						<img src="http://localhost:80/api/mission/image/\${master_img.confirm_file}path=missionmaster" width="500px"
							onerror="this.src='http://localhost:80/api/mission/image/error.png?path=mission';">
					`
					mission_image = mission_image + m_img;
				}
				
				var info = `
					<div class="d-flex col-10 m-auto">
						<div id="master" class="col-7">
							<div class="row">
								<h3 class="mb-4">미션 인증 기준 정보</h3>
								<p><b>미션명</b> : \${master.mission_name}</p>
								<p><b>장소</b> : \${master.address1} \${master.address2} </p>
								<p><b>난이도</b> : \${master.level_code} | <b>포인트</b> : \${master.point} </p>
								<p><b>진행 기간 </b> : \${start_date} ~ \${end_date} <br>
							</div>
							<div class="row col-11">
								<div id="master_img" class="mt-2"></div>
								
							</div>
						</div>
						
						<div id="user" class="col-3">
							<div class="row">
	 							<h3 class="mb-4">미션 수행 정보</h3>
								<p>회원 아이디: \${history.member_code}</p>
								<p>등록일 : \${img_update_date}</p>
							</div>
							<img src="http://localhost:80/api/mission/image/\${history_img.confirm_file}?path=mission"
								width="400px" class="mt-3" onerror="this.src='http://localhost:80/api/mission/image/error.png?path=mission';">
		 					<div id="f" class="mt-5">
			 					<form id="frm" style="width:400px">
			 						<input type="radio" name="confirm" value="1" checked> 승인
			 						<input type="radio" name="confirm" value="2"> 거절
									<input type="text" name="remark" id="remark" placeholder="거절사유">
				 					<input type="button" id="confrimBtn" class="btn" value="등록" onclick="checkBtn(\${history.mission_history_no},\${pageNo})">
			 					</form>
	 						</div>
						</div>
					</div>
					<hr>
 				`
 				$("#detail").html(info);
 				$("#master_img").html(mission_image);
 				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
				    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				    level: 3 // 지도의 확대 레벨
				};  
				
				//지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				
				//주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
				
				//주소로 좌표를 검색합니다
				geocoder.addressSearch('서울 금천구 시흥동 산83-39', function(result, status) {
				
					// 정상적으로 검색이 완료됐으면 
					 if (status === kakao.maps.services.Status.OK) {
					
					    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					
					    // 결과값으로 받은 위치를 마커로 표시합니다
					    var marker = new kakao.maps.Marker({
					        map: map,
					        position: coords
					    });
					
					    // 인포윈도우로 장소에 대한 설명을 표시합니다
					    var infowindow = new kakao.maps.InfoWindow({
					        content: '<div style="width:150px;text-align:center;padding:6px 0;">미션 장소</div>'
					    });
					    infowindow.open(map, marker);
					
					    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					    map.setCenter(coords);
					} 
				}); 
			}
		});
	}
 	
 	/* 승인, 거절 버튼 */
 	function checkBtn(no, pageNo) {
 		var confirm_length = document.getElementsByName("confirm").length;
 		for(var i=0; i<confirm_length; i++) {
 			if(document.getElementsByName("confirm")[i].checked==true) {
 				var check = document.getElementsByName("confirm")[i].value;
 			}
 		}
 		
  		$.ajax({
 			method : "POST",
 			url : "http://localhost:80/api/admin/mission/result/"+no+"/"+check,
 			data : { 
 				"remark" : $("#remark").val() 
 			},
 			headers: {
 		        'Authorization': `Bearer \${token}`,
 		    },
 			success : function(data) {
 				console.log(data);
 				list(pageNo);
 				var member_code = data.data.member_code;
				var no = data.data.mission_history_no;
				
 				/* 승인 성공 + 포인트 지급 */
 				if(data.message == "승인 성공") {
 					fetch("http://localhost:80/api/admin/mission/result/point/add?mission_history_no="+no+"&member_code="+member_code, {
 						method: "POST",
 						headers : {
 							'Authorization': `Bearer \${token}`,
 						}
 					})
 					.then((response) => response.json())
 					.then((response) => console.log(response))
 					.then(alert("포인트 지급 완료"))
 				
 				/* 거절 성공 */
 				} else {
 					alert("거절 등록 완료");
 				}
 			},
 			error : function(data) {
 				console.log(data.responseJSON);
 				if(data.responseJSON.message == "거절 사유 미입력") {
 					alert("거절 사유를 입력하세요.");
 				} else if (data.responseJSON.message == "처리 완료된 미션입니다.") {
 					alert("이미 처리가 완료된 건입니다.")
 				}
 			}
 		});
 	}
 	
 	/* 미 승인건 조회 */
 	function check() {
 		list(1);
 	}
 	
 	/* 기간 조회 */
 	function period() {
 		sd = $("#start").val();
 		ed = $("#end").val();
 		
 		list(1);
 	}
</script>

</head>
<body>
	<header>
		<a href="/nordic-front-admin/"><h1>NORDIC WALKING</h1></a>
	</header>
	<div class="container mt-5 mb-5">
		<div class="row">
			<jsp:include page="../sidebar.jsp"/>
			<div class="col-sm-10 ps-5">
				<h1>미션 수행 등록 현황</h1>
				<div id="list" class="row">
						<div class="mt-3">
							<div id="count"></div>
						</div>
						<div>
							<span>
								<input type="checkbox" onclick="check()" value="check" id="check"> 미승인 조회 | 
								기간 조회 :
								<input type="date" id="start" name="start"> ~
								<input type="date" id="end" name="end">
								<input type="button" id="periodBtn" class="btn" onclick="period()" value="조회">
							</span>
						</div>
						
						<div>
							<table id="t" style="text-align:center; width: 100%"
								class="mt-3 table table-hover">
								<tr style="font-weight: bold;">
									<td style="width: 5%"></td>
									<td style="width: 10%">번호</td>
									<td style="width: 10%">회원명</td>
									<td style="width: 20%">미션명</td>
									<td style="width: 10%">포인트</td>
									<td style="width: 5%">승인</td>
									<td style="width: 10%">승인자</td>
									<td style="width: 10%">등록일</td>
									<td style="width: 20%">비고</td>
								</tr>
							</table>
						</div>
						
					<div id="page" class="mt-3 mb-5 text-center"></div>
					<hr>
					<div id="detail" style="display:none;" class="mt-5"></div>
				</div>
			</div>
		</div>
	</div>
	<footer align="center">
		서비스 이용약관 | 개인정보 보호정책 | 청소년 보호정책<br> Copyright <strong>©노르딕워킹</strong>
		All rights reserved.
	</footer>
</body>
<!-- </html><div id="map" style="width:510px; height:400px; margin-left:10px" class="mt-2 text-center"></div> -->
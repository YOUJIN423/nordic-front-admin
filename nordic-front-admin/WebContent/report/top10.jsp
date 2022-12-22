<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최다 적립 회원 TOP 10</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<script>

function topRanking() {

	var url = "http://localhost:80/api/points/top10";
	
	console.log (url);
	
	let token = localStorage.getItem('wtw-token') || '';
	
	fetch(url, {
	    method: "GET",
	    mode: 'cors',
	    headers: {
	    'Content-Type' : 'application/json',
	    'Authorization' : `Bearer \${token}`
	    }
	})
	
	.then(response => response.json())
	.then(response => {
	
	    $("#indexArea").empty();
	    $("#dataArea").empty();
	    console.log("랭킹10 불러오기")
	
	    var tableIndex = `
	            <th>아이디</th>
	            <th>이름</th>
	            <th>미션 수행 횟수</th>
	            <th>전체 획득 포인트</th>
	            <th>미션 시작일자</th>
	            <th>미션 종료일자</th>
	    `;
	
	    $("#indexArea").append(tableIndex);
	
	    console.log(response.data); // 정보 보기
	    console.log("길이: " + response.data.length);
	    console.log("키 : " + Object.keys(response.data[0]));
	    console.log("밸류 : " + Object.values(response.data[0]));
	    console.log(response.data[0]);
	
	    var tableColumnL = (response.data.length);  // 행 길이
	
	    
	
	    for (var j=0; j<tableColumnL; j++) {
	
	        var memValues = Object.values(response.data[j]);
	        console.log(memValues[3].toLocaleString());
	        $("#dataArea").append(`<tr>`);
	
	            var i=0;
	            while (i < (memValues.length-1) ) {
	
	                var data = memValues[i]
	                // if ( i == 1) var data = `<a href="#"> ${memValues[i]} </a>`;
	                
	                if ( i == 3 ) { var data = memValues[i].toLocaleString(); }
	
	                $("#dataArea").append(`<td>`+data+`</td>`);
	
	                i++;
	
	            }
	        $("#dataArea").append(`</tr`);
	
	    } // for end
    
	})
	
	.catch(error => {
	    console.log(error);
	    alert(error);
	});


} // topRanking function end

</script>
<style>
    table {
        text-align: center;
    }

    #wrapper {
        width:1200px;
    }
    
    #top10Title {
    	font-size:xx-large;
        text-align: right;
        margin-top: 30px;
        margin-bottom: 80px;
    }
</style>
<body>
<jsp:include page="../header.jsp"></jsp:include>
    <div class="container mt-5 mb-5">
        <div class="row">
        <jsp:include page="../sidebar.jsp"></jsp:include>
        <div class="col-sm-10 ps-5">
    <div id="wrapper">
    
<div class="container text-center">
        <div class="row">
          <div class="col" id="top10Title">
            최다 적립 회원 TOP 10
          </div>
          <div class="col">
          </div>
          <div class="col">
          </div>
        </div>
      </div>
<script>topRanking();</script>
    <div id="wrapper">
        <div id="topRankingDiv">
            <table class="table table-hover">
                <thead>
                    <tr id="indexArea">
                    </tr>
                </thead>
                <tbody id="dataArea"></tbody>
            </table>
            <br><br>
        </div>
        <br><br><br>
    </div>
</div></div></div></div>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
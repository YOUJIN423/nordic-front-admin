<script src="http://code.jquery.com/jquery-latest.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>미션 목록</title>
</head>
<style>
td {
	max-height: 236px;
}
</style>
<div class="container mt-3">
	<div class="mt-4 p-5 text-black rounded">
		<h1>The Nordic</h1>
		<p>걷기 보다 더 좋은 걷기</p>
	</div>
</div>
<hr style="border: 1px color= silver; margin-left: 5%" width="90%">

<body style="align-items:  center;">
	<script>
	//페이징 과정
	function pageing(data,n,mode) {
  	  let reallastpage = $("#endpage").val();
  	  (data[0].pagepart%8 === 0)? $("#endpage").val(parseInt(data[0].pagepart/8)) : $("#endpage").val(parseInt(data[0].pagepart/8+1));
  	  reallastpage = $("#endpage").val();
  	  let start =  ((n-1)*10)+1; 
  	  let lastpage = $("#endpage").val();
  	  
  	  let end = start+9;
  	  var pagestr = "";
  	  var first = "";
		  var last = "";
		
  	  if(start>10){
  		  first = first+ "<input class='btn btn-outline-secondary' type='button' onclick='changePage(1,1)' value='처음' /><input class='btn btn-outline-secondary' type='button' onclick='changePage("+(start-1)+","+(parseInt(start/10))+","+mode+")' value='이전' />";  
  	  }
  	  if(end >=lastpage ){ //총페이지 보다 마지막페이지가 큰 경우 마지막 페이지는 총 페이지 수와 같아야 한다
  		  end = lastpage;
  		  for(start ;start<=end ;start++){
  			  if(start != end){
  	      		  pagestr = pagestr+"<input class='btn btn-outline-secondary' id='inputremote' type='button' onclick='changePage("+start+","+(parseInt(start/10)+1)+","+mode+")' value='"+start+"'>";
  	  		  }else{
  	      		  pagestr = pagestr+"<input class='btn btn-outline-secondary' id='inputremote' type='button' onclick='changePage("+start+","+(parseInt((start-10)/10)+1)+","+mode+")' value='["+start+"]'>";
  	  		  }
  		  }
  	  }else{ //총 페이지보다 마지막 페이지가 작은 경우 10개를 추출해야 한다
  		  for(start ;start<=end ;start++ ){
  		  if(start !== end){
      		  pagestr = pagestr+"<input class='btn btn-outline-secondary' id='inputremote' type='button' onclick='changePage("+start+","+(parseInt(start/10)+1)+","+mode+")' value='"+start+"'>";
  		  }else{
      		  pagestr = pagestr+"<input class='btn btn-outline-secondary' id='inputremote' type='button' onclick='changePage("+start+","+(parseInt((start-10)/10)+1)+","+mode+")' value='"+start+"'>";
  		  }
  			}
  	  }
  	  if(end<reallastpage){ //마지막 페이지로 이동하는 버튼 추가 
  		  last = last+ "<input class='btn btn-outline-secondary' type='button' onclick='changePage("+start+","+(parseInt(lastpage/10))+","+mode+")' value='다음'>"+"<input class='btn btn-outline-secondary' type='button' onclick='changePage("+lastpage+","+(parseInt(lastpage/8))+","+mode+")' value='끝'>";  
  	  }
  	  var total = first + pagestr + last;
  	  $("#pagelist").html(total);
	}
		  
	//받은 데이터 list화 시켜줌
     function paser(data,n,mode) {
    	 console.log("mode : "+mode);
    	  if (data.length > 0) {
          var td = $("#listTable");

          var count = 0;
          for (i in data) {
            count = count + 1;
            
            var mission_no = data[i].mission_no;
            var mission_name = data[i].mission_name;
            var start_date = data[i].start_date;
            var end_date = data[i].end_date;
            var level_code = data[i].level_code;
            var point = data[i].point;
            var filejsoon = JSON.parse(data[i].confirm_file);
            var confirm_file = filejsoon.picture[0][0].toString();
            var confirm_file2 = data[i].confirm_file2;
            var pagepart = data[i].pagepart;
			
            if (count < 5) {
         var row = $(".tableRow").append(
                $("<td/>").append(													
                   	    "<div class='card' style='min-width: 275px ;' ><a href='missionDetail.jsp?mission_no="+mission_no+"'> <div class='card-header' style='min-height: 200px ;' ;> <img style='width: 250px ; height: 142px' src='http://localhost/api/image/" +mission_no
                        +"'></div></a><biv class='card-body'>미션명 : " +mission_name +"<br>기간 : "+start_date+"~"+end_date+"<br>난이도 : "+level_code+"<br>포인트 :"+point+"</div></div>" 
        )
              );
            } else {
              var row2 = $(".tableRow2").append(
                $("<td/>").append(
                	    "<div class='card' style='min-width: 275px ;' ><a href='missionDetail.jsp?mission_no="+mission_no+"'> <div class='card-header' style='min-height: 200px ;' ;> <img style='width: 250px ; height: 142px' src='http://localhost/api/image/" +mission_no
                        +"'></div></a><biv class='card-body'>미션명 : " +mission_name +"<br>기간 : "+start_date+"~"+end_date+"<br>난이도 : "+level_code+"<br>포인트 :"+point+"</div></div>" 
                      )
              );
            }
            td.append(row);
            td.append(row2);
            $(".datatable").append(td);
      	  pageing(data,n,mode);
          }
        }else{
        	var td = $("#listTable");
      	  	var row = $(".tableRow").append(
          		$("<td/>").append("<h1>mission이 없습니다</h1>")
          	)
          	td.append(row);
            $(".datatable").append(td);
            }
    	  
      }
	
		//first
      function page(nowpage){
    	  var url = "http://localhost/api/list?pageNum="+nowpage;
          fetch(url) 	
            .then((response) => response.json())
            .then((data) => paser(data,1))
            .catch(error => noresult());
      }
		
		
      function changePage(nowpage,start,mode){
    	  $("td").remove();
    	  console.log("mode : "+mode);
    	  if(mode==search){
    			var first = $("#firstval").val();
    			var second = $("#secondval").val();
    			var fetchurl = "http://localhost/api/search?first="+first+"&second="+second+"&pageNum="+nowpage;
    			console.log(fetchurl);
    			fetch(fetchurl)
    			.then((response) => response.json())
    			.then((data) => paser(data,start,"search"))
    	  }else{
    	  var url = "http://localhost/api/list?pageNum="+nowpage;
          fetch(url)
            .then((response) => response.json())
            .then((data) => paser(data,start,"list") )
    	  }
      }
      
		
      //select에 따른 html변화
     function searchchange(){
    	  
    	 var optionval= $("#searchoptions").val();
    	 console.log(optionval);
    	 if(optionval===""){
    		 $("#changearea").html("");
    	 }
    	 
    	 if(optionval==="missionname"){
    		 var changehtml = "<input type='text' id='firstval'> <input type='button' id='submitbutton' value='찾기' onclick='searchstart()'> "
        		 $("#changearea").html(changehtml);
    	 }
    	 
    	 if(optionval==="term"){
    		 var changehtml = "<input type='date' id='firstval' >~<input type='date' id='secondval'> <input type='button' id='submitbutton' value='찾기' onclick='searchstart()'> "
        		 $("#changearea").html(changehtml);
    	 }
    	 
     }
      
      //찾기 button을 누르면 작동 필요한건 nowpage와 paramter를 전달하는 방법
     function searchstart() {
    	  $("td").remove();
		var first = $("#firstval").val();
		var second = $("#secondval").val();
		console.log("first : "+first);
		console.log("second : "+second );
		if(second == null){
			//nowpage + first
			var fetchurl = "http://localhost/api/search?first="+first+"&second="+second+"&pageNum="+1;
			console.log(fetchurl);
			fetch(fetchurl)
			.then((response) => response.json())
			.then((data) => paser(data,1,"search"))
		}else{
			var fetchurl = "http://localhost/api/search?first="+first+"&second="+second+"&pageNum="+1;
			console.log(fetchurl);
			fetch(fetchurl)
			.then((response) => response.json())
			.then((data) => paser(data,1,"search"))
		}
		
	}
      $(document).ready(function () {
    	  page(1);
      });
    </script>
	<input id="endpage" type="hidden">
	<div class="container">
		<div class="container mt-3">
			<div id="listTable">
				<div class="tableRow" style="max-height: 800px; min-width: 600px"></div>
				<div class="tableRow2" style="max-height: 800px; min-width: 600px"></div>
			</div>
			<br>

			<spen id="pagelist"></spen>
			<spen id="search"> <select id="searchoptions"
				onchange="searchchange()"><option id="" value="">검색방법을
					선택하세요</option>
				<option id="term" value="term">기간</option>
				<option id="missionname" value="missionname">미션명</option></select> </spen>
			<span id="changearea"> </span>
		</div>
	</div>
</body>
</html>

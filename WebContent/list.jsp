<script src="http://code.jquery.com/jquery-latest.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
</head>
<body>
		<script>
		function selectNum(test){
			var n =test;
			return n;
		}
      function paser(data) {
    	  (data[0].pagepart%8 === 0)? $("#endpage").val(parseInt(data[0].pagepart/8)) : $("#endpage").val(parseInt(data[0].pagepart/8+1));
    	  
    	  let lastpage = $("#endpage").val();
    	  let start =  ((1-1)*10)+1;
    	  let end = start+9;
    	  var pagestr = ""
    	  var first = "";
		  var last = "";
		
    	  if(start>10){
    		  first = first+ "<input type='button' onclick='changePage(1)' value='[처음]'><input type='button' onclick='changePage("+(start-10)+")' value='[이전]'>";  
    	  }
    	  if(end >=lastpage ){
    		  console.log("start1 : "+start);
    		  console.log("end1 : "+end);
    		  console.log("lastpage1 : "+lastpage);
    		  end = lastpage;
    		  for(start ;start<=end ;start++ ){
    			  pagestr = pagestr+"<input id='inputremote' type='button' onclick='changePage("+start+")' value='["+start+"]'>";
    		  }
    	  }else{
    		  for(start ;start<=end ;start++ ){
    		  console.log("start"+start);
    		  console.log("end"+end);
    		  console.log("lastpage"+lastpage);
        		  pagestr = pagestr+"<input id='inputremote' type='button' onclick='changePage("+start+")' value='["+start+"]'>";
    			}
    	  }
    	  if(end>10){
    		  last = last+ "<input type='button' onclick='changePage(1)' value='[끝]'>";  
    	  }
    	  var total = first + pagestr + last;
    	  $("#testconter").html(total);
    	  
    	  if (data.length > 0) {
          var td = $(".listTable");

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
                   "<pre><a href='missionDetail.jsp?mission_no="+mission_no+"'> <img style='max-width: 200px ; min-height: 200px' src='" +
                  confirm_file2 +"'></a><br>미션명 : " +mission_name +"<br>기간 : "+start_date+"~"+end_date+"<br>난이도 : "+level_code+"<br>포인트 :"+point+"</pre>" 
                )
              );
            } else {
              var row2 = $(".tableRow2").append(
                $("<td/>").append(
                		  "<pre><a href=missionDetail.jsp?mission_no="+mission_no+"'> <img style='max-width: 200px ; min-height: 200px' src='C:\\Users\\hwangjoonsoung\\Desktop\\IntelliJ WorkSpace\\Nordic\\src\\main\\resources\\static\\img\\" +
                          confirm_file +"'></a><br>미션명 : " +mission_name +"<br>기간 : "+start_date+"~"+end_date+"<br>난이도 : "+level_code+"<br>포인트 :"+point+"</pre>" 
                )
              );
            }
            td.append(row);
            td.append(row2);
          }
          $(".datatable").append(td);
        }
      }
      function page(nowpage){
    	  var url = "http://localhost/list?pageNum="+nowpage;
          fetch(url)
            .then((response) => response.json())
            .then((data) => paser(data));
      }
      function changePage(nowpage){
    	  $("td").remove();
    		
    	  var url = "http://localhost/list?pageNum="+nowpage;
          fetch(url)
            .then((response) => response.json())
            .then((data) => paser(data) )
          .then(() => console.log(nowpage))
      }
      
      $(document).ready(function () {
    	  page(1);
      });
    </script>

	<div class="datatable">
		<table class="listTable" border="1">
			<tr class="tableRow" style="max-height: 900px; min-width: 600px"></tr>
			<tr class="tableRow2" style="max-height: 900px; min-width: 600px"></tr>
		</table>
		<input id="endpage" type="hidden">
		<center id="testconter"></center>
	</div>
</body>
</html>

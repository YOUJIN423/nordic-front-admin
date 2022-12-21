<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>(관리자) 확인된 모든 요청</title>
    <link href="<%=request.getContextPath()%>/goods/hidden_text.css" rel="stylesheet" type="text/css" />
    
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>
      function checkControl(box){
        const checkBoxes = $(".requests");
        //checkBoxes.forEach(cd => {
        for (var i = 0; i < checkBoxes.length; i ++)
           { checkBoxes[i].checked = false;}
            box.checked = true;
            getAll(1,"","",$("#start").val(),$("#end").val());
      }
      function getAll(pageNum,search="",keyword="", start="", end=""){
    	  let token = localStorage.getItem('wtw-token') || '';
    	  
        if ($("#aC").is(":checked")) {  // 관리자 체크박스가 checked 상태일 때
        var url = "http://localhost/api/requests/confirmed/y?"+ "start=" + start + "&end=" + end + "&search=" + search + "&keyword=" + keyword + "&pageNum=" + pageNum;
        $("#aC").checked = true;
        } else if($("#rC").is(":checked")){
        var url = "http://localhost/api/requests/confirmed/n?"+ "start=" + start + "&end=" + end + "&search=" + search + "&keyword=" + keyword + "&pageNum=" + pageNum;
        }
        else {
            var url = "http://localhost/api/requests/confirmed?"+ "start=" + start + "&end=" + end + "&search=" + search + "&keyword=" + keyword + "&pageNum=" + pageNum;
        }

        $.ajax({
            url: url,
            method: "get",
            contentType : "application/json",
            headers: {
		        'Authorization': `Bearer \${token}`,
		  	},
            data: { },
            success: function (success) {
              
              console.log(success.data.pages);
              console.log(success.data.list);
              console.log(success.data.list.length);
              $("#gbody").empty();
              var tbody = document.getElementsByTagName("tbody")[0];
              
              //$("#list").append(JSON.stringify(success.data));
              for (var i = 0; i< success.data.list.length; i++){
                var tbody = document.getElementsByTagName("tbody")[0];
                var rowData = success.data.list[i];

                var request_no = rowData.request_no;
                var goods_name = rowData.goods_name;
                var member_name = rowData.member_name;
                var remark = rowData.remark;
                if(remark == null){
                	remark = ".";
                }
                var create_date = rowData.create_date;
                var confirm_member = rowData.confirm_member;
                var goods_no = rowData.goods_no;
                var member_code = rowData.member_code;
                var refuse_yn = rowData.refuse_yn;
                if(refuse_yn == "N"){
                	refuse_yn = "수락";
                } else{
                	refuse_yn = "거절";
                }
                var update_date = rowData.update_date;
                var point = rowData.point;

                var tdRequestNo = document.createTextNode(request_no);
                var tdGoodsName = document.createTextNode(goods_name);
                var tdMemberName = document.createTextNode(member_name);
                var tdRemark = document.createTextNode(remark);
                var tdCreateDate = document.createTextNode(create_date);
                var tdConfirmMember = document.createTextNode(confirm_member);
                var tdGoodsNo = document.createTextNode(goods_no);
                var tdMemberCode = document.createTextNode(member_code);
                var tdRefuseYn = document.createTextNode(refuse_yn);
                var tdUdateDate = document.createTextNode(update_date);
                var tdPoint = document.createTextNode(point);

                var tr = document.createElement("tr");

                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var td4 = document.createElement("td");
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                var td7 = document.createElement("td");
                var td8 = document.createElement("td");
                var td9 = document.createElement("td");
                var td10 = document.createElement("td");
                var td11 = document.createElement("td");

                td1.appendChild(tdRequestNo);
                td3.appendChild(tdGoodsName);
                td5.appendChild(tdMemberName);
                td11.appendChild(tdRemark);
                td7.appendChild(tdCreateDate);
                td8.appendChild(tdConfirmMember);
                td2.appendChild(tdGoodsNo);
                td4.appendChild(tdMemberCode);
                td9.appendChild(tdRefuseYn);
                td10.appendChild(tdUdateDate);
                td6.appendChild(tdPoint);

                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td4);
                tr.appendChild(td5);
                tr.appendChild(td6);
                tr.appendChild(td7);
                tr.appendChild(td8);
                tr.appendChild(td9);
                tr.appendChild(td10);
                tr.appendChild(td11);

                tbody.appendChild(tr);  
              }
              paging(pageNum, success.data.pages, search, keyword);
            },
            error: function (error) {
              console.log(error);
            },
          });
      }
      function paging(pageNum, pages, search, keyword){
        				/* 페이징 */
				var total = pages
				var pagenation = ``;
				
				var startPage = Math.floor((pageNum-1)/10)*10 + 1;
				var endPage = startPage+9;
				
				var prev;
				if(pageNum>10) {
                    var temp = startPage-1;
                    console.log(temp);

          if(keyword == ""){
            prev = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onClick=getAll(\${temp},"","")>Previous</a></li>`
          } else{
            prev = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onClick=getAll(\${temp},"\${search}","\${keyword}")>Previous</a></li>`
          }

				} else {
					prev = `<li class="page-item"><a class="page-link" href="javascript:void(0);">Previous</a></li>`
				}
				
				var pageList=``;
				var page;
				
				for(var j=0; j<=9; j++) {
					var p = startPage+j;
          if(p > total){
            break;
          }
					if (p!=pageNum) {
            if(keyword == ""){
              page = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${p},"","")>\${p}</a></li>`;
            } else{
              page = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${p},"\${search}","\${keyword}")>\${p}</a></li>`;
            }
					} else {
						page = `<li class="page-item"><a class="page-link active" href="javascript:void(0);">\${p}</a></li>`;
					}
					
					if(j==pages) {
						break;
					}
					
					pageList = pageList + page;
				}
				
				var later;
				if(endPage>total) {
					later = `<li class="page-item"><a class="page-link" href="javascript:void(0);">Next</a></li>`
				} else {
					var temp = endPage + 1;
                    console.log(temp);
          if(keyword == ""){
            later = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${temp},"","")>Next</a></li>`
          } else{
            later = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${temp},"\${search}","\${keyword}")>Next</a></li>`
          }

				}
				
				pagenation = prev+pageList+later;
				

				$("#paget").html(pagenation);
      }
      
      $(document).ready(function () {
        getAll(1);
        $("#search_button").click(function(){
              getAll(1,$("#search").val(), $("#keyword").val())
        })
        $("#date_button").click(function(){
              getAll(1,"", "",$("#start").val(),$("#end").val());
        })
      });
    </script>
    <title>Document</title>
  </head>
    <body style="width:100%">
      <jsp:include page="../header.jsp"/>
  	<div class="container mt-5 mb-5">
		<div class="row">
			<jsp:include page="../sidebar.jsp"/>
			<div class="col-sm-10 ps-5">
				<h1>확인된 포인트 상품 요청</h1>	
				
	<div style="width:1200px;">
      <span id="dateSelect">
        <label for="start">시작날짜</label>
        <input type="date" id="start" style="width:200px;border-radius: 20px;">
        -
        <label for="end">끝날짜</label>
        <input type="date" id="end" style="width:200px;border-radius: 20px;">
        <button type="button" id="date_button" class="btn btn-dark">조회</button>
      </span>
    <br><br>
    <span id="acceptedList">
        <input type="checkbox" id="xC" onClick="checkControl(this)" class="requests form-check-input" checked> 
        <label for="xC" class="form-check-label"> 확인된 모든 요청 </label>
    </span>
    
    <span id="acceptedList">
        <input type="checkbox" id="aC" onClick="checkControl(this)" class="requests form-check-input"> 
        <label for="aC" class="form-check-label"> 지급된 요청만 </label>
    </span>
    <span id="rejectedList">
        <input type="checkbox" id="rC" onClick="checkControl(this)" class="requests form-check-input"> 
        <label for="rC" class="form-check-label"> 거절된 요청만 </label>
    </span>
    <br><br>
    <span>
      <select id="search" style="border-radius: 20px;">
        <option value="goods_no">굿즈번호</option>
        <option value="goods_name">굿즈명</option>
        <option value="member_code">신청회원코드</option>
        <option value="member_name">신청회원이름</option>
      </select>
      <input type="text" id="keyword" placeholder="검색" style="width:500px;border-radius: 20px;">
      <button type="button" id="search_button" class="btn btn-dark">검색</button>
      </span>
      <br><br>
      <table style="text-align:center; width: 100%"
								class="mt-3 table table-hover">
        <thead style="text-align: center;">
            <th>요청번호</th>
            <th>상품번호</th>
            <th>상품명</th>
            <th>멤버번호</th>
            <th>멤버명</th>
            <th>포인트</th>
            <th>요청일시</th>
            <th>확인자</th>
            <th>거절여부</th>
            <th>확인날짜</th>
            <th>기타</th>
        </thead>
        <tbody id="gbody" style="text-align: center;">

        </tbody>
    </table>
    <nav aria-label="Page navigation example"  style="margin-left:300px;">
      <ul class="pagination" id="paget">
      </ul>
    </nav>
  </div>
  </div></div></div>
    <jsp:include page="../footer.jsp"/>
  </body>
</html>
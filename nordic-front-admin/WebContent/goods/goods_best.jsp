<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>(관리자) 가장 잘 팔리는 굿즈</title>
     <link href="<%=request.getContextPath()%>/goods/hidden_text.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>
      function getAll(pageNum){
    	  let token = localStorage.getItem('wtw-token') || '';
        $.ajax({
            url: "http://localhost/api/goods/best?pageNum=" + pageNum,
            method: "get",
            contentType : "application/json",
            headers: {
		        'Authorization': `Bearer \${token}`,
		  	},
            data: { },
            success: function (success) {
              console.log(success.data.list);
              console.log(success.data.list.length);
              //$("#list").append(JSON.stringify(success.data));
              $("#gbody").empty();

              for (var i = 0; i< success.data.list.length; i++){
                var rowData = success.data.list[i];
                var cnt = rowData.cnt;
                var goods_no = rowData.goods_no;
                var goods_name = rowData.goods_name;
                var point = rowData.point;
                var first_date = rowData.first_date;
                var last_date = rowData.last_date;

                var tdCnt = document.createTextNode(cnt);
                var tdGoodsNo = document.createTextNode(goods_no);
                var tdGoodsName = document.createTextNode(goods_name);
                var tdPoint = document.createTextNode(point);
                var tdFirstDate = document.createTextNode(first_date);
                var tdLastDate = document.createTextNode(last_date);

                var tr = document.createElement("tr");
                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var td4 = document.createElement("td");
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                var td7 = document.createElement("td");
                var cont_button = document.createElement("button");
                var a = document.createElement("a");
                a.setAttribute("href",`goods_cont_admin.jsp?\${goods_no}`);
                a.appendChild(tdGoodsName);
                
                td1.appendChild(tdCnt);
                td2.appendChild(tdGoodsNo);
                td3.appendChild(a);
                td4.appendChild(tdPoint);
                td5.appendChild(tdFirstDate);
                td6.appendChild(tdLastDate);

                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td4);
                tr.appendChild(td5);
                tr.appendChild(td6);

                var tbody = document.getElementsByTagName("tbody")[0];

                tbody.appendChild(tr);  
              }
              paging(pageNum, success.data.pages);
            },
            error: function (error) {
              console.log(error);
            },
          });
      }
      function paging(pageNum, pages){
        				/* 페이징 */
				var total = pages
				var pagenation = ``;
				
				var startPage = Math.floor((pageNum-1)/10)*10 + 1;
				var endPage = startPage+9;
				
				var prev;
				if(pageNum>10) {
                    var temp = startPage-1;
                    console.log(temp);
                    prev = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onClick=getAll(\${temp})>Previous</a></li>`
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
			            page = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${p})>\${p}</a></li>`;

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
                    later = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${temp})>Next</a></li>`
				}
				
				pagenation = prev+pageList+later;
				

				$("#paget").html(pagenation);
      }

      $(document).ready(function () {
        let imgTag = document.getElementById("images");
        getAll(1);
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
				<h1>가장 많이 지급된 포인트 상품</h1>	
				<br>
	<div style="width:1200px;">

      <table style="text-align:center; width: 100%"
								class="mt-3 table table-hover">
        <thead>
            <th>지급횟수</th>
            <th>상품번호</th>
            <th>상품명</th>
            <th>포인트</th>
            <th>첫 지급 일시</th>
            <th>마지막 지급 일시</th>
        </thead>
        <tbody id="gbody">

        </tbody>
    </table>
	<div style="width:100%">
      <nav aria-label="Page navigation example" style="margin-left:300px;">
      <ul class="pagination" id="paget">
      </ul>
     </nav>
	</div>
    </div></div></div></div>
    <jsp:include page="../footer.jsp"/>
  </body>
</html>



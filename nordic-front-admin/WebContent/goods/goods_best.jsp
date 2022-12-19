<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>(관리자) 가장 잘 팔리는 굿즈</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
                var tdGoodName = document.createTextNode(goods_name);
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

                td1.appendChild(tdCnt);
                td2.appendChild(tdGoodsNo);
                td3.appendChild(tdGoodName);
                td4.appendChild(tdPoint);
                td5.appendChild(tdFirstDate);
                td6.appendChild(tdLastDate);
                cont_button.setAttribute("type","button");
                cont_button.setAttribute("value","상세정보보기");
                cont_button.setAttribute("onClick","location.href='goods_cont_admin.jsp?" + goods_no + "'");
                cont_button.setAttribute("style","width:100px;height:40px;")

                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td4);
                tr.appendChild(td5);
                tr.appendChild(td6);
                tr.appendChild(cont_button);

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
					prev = `<a onclick=getAll(` + temp + `)>[이전]</a>`
				} else {
					prev = `<a>[이전]</a>`
				}
				
				var pageList=``;
				var page;
				
				for(var j=0; j<=9; j++) {
					var p = startPage+j;
          if(p > total){
            break;
          }
					if (p!=pageNum) {
						page = `<span><a onclick=getAll(` + p + `)> ` + p + ` </a></span>`	
					} else {
						page = `<span><b> ` + p + ` </b></span>`	
					}
					
					if(j==pages) {
						break;
					}
					
					pageList = pageList + page;
				}
				
				var later;
				if(endPage>total) {
					later = `<a>[다음]</a>`
				} else {
					var temp = endPage + 1;
                    console.log(temp);
					later = `<a onclick=getAll(` + temp + `)>[다음]</a>`
				}
				
				pagenation = prev+pageList+later;
				

				$("#page").html(pagenation);
      }

      $(document).ready(function () {
        let imgTag = document.getElementById("images");
        getAll(1);
      });
    </script>
    <title>Document</title>
  </head>
  <body>

      <table border="1">
        <caption>가장 잘 팔리는 굿즈</caption>
        <thead>
            <th>지급횟수</th>
            <th>상품코드</th>
            <th>상품명</th>
            <th>포인트</th>
            <th>처음지급일시</th>
            <th>나중지급일시</th>
            <th>상세정보</th>
        </thead>
        <tbody id="gbody">

        </tbody>
    </table>

    <div id="page"></div>
  </body>
</html>



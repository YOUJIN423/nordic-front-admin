<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>(관리자) 모든 굿즈</title>
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
            getAll(1,"");
      }
      function getAll(pageNum=1,search="",keyword=""){
        console.log("첫" + keyword);
        let token = localStorage.getItem('wtw-token') || '';
        
        if ($("#aC").is(":checked")) {  // 관리자 체크박스가 checked 상태일 때
        var url = "http://localhost/api/goods/all/y?" + "pageNum=" + pageNum;
        $("#aC").checked = true;
        } else if($("#rC").is(":checked")){
        var url = "http://localhost/api/goods/all/n?" + "pageNum=" + pageNum;
        }
        else {
            var url = "http://localhost/api/goods/all?" + "search=" + search + "&keyword=" + keyword + "&pageNum=" + pageNum;
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
                var goods_name = rowData.goods_name;
                var point = rowData.point;
                var goods_no = rowData.goods_no;
                var goods_desc = rowData.goods_desc;
                var use_yn = rowData.use_yn;
                var create_member = rowData.create_member;
                var create_date = rowData.create_date;
                var update_member = rowData.update_member;
                var update_date = rowData.update_date;
                var cnt = rowData.cnt;

                var tdGoodsName = document.createTextNode(goods_name);
                var tdPoint = document.createTextNode(point);
                var tdGoodsNo = document.createTextNode(goods_no);
                var tdGoodsDesc = document.createTextNode(goods_desc);
                var tdCreateMember = document.createTextNode(create_member);
                var tdCreateDate = document.createTextNode(create_date);
                var tdUpdateMember = document.createTextNode(update_member);
                var tdUpdateDate = document.createTextNode(update_date);
                var tdCnt = document.createTextNode(cnt);

                var tr = document.createElement("tr");
                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var td4 = document.createElement("td");
                var td6 = document.createElement("td");
                var td7 = document.createElement("td");
                var td8 = document.createElement("td");
                var td9 = document.createElement("td");
                var td10 = document.createElement("td");
                // var cont_button = document.createElement("button");
                var a = document.createElement("a");
                a.setAttribute("href",`goods_cont_admin.jsp?\${goods_no}`);
                a.appendChild(tdGoodsName);
                
                td1.appendChild(tdGoodsNo);
                td2.appendChild(a);
                td3.appendChild(tdPoint);
                td4.appendChild(tdGoodsDesc);
                td6.appendChild(tdCreateMember);
                td7.appendChild(tdCreateDate);
                td8.appendChild(tdUpdateMember);
                td9.appendChild(tdUpdateDate);
                td10.appendChild(tdCnt);

                // cont_button.setAttribute("type","button");
                // cont_button.setAttribute("value","상세정보보기");
                // cont_button.setAttribute("onClick","location.href='goods_cont_admin.html?" + goods_no + "'");
                // cont_button.setAttribute("style","width:100px;height:40px;")
                
                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td4);
                tr.appendChild(td6);
                tr.appendChild(td7);
                tr.appendChild(td8);
                tr.appendChild(td9);
                tr.appendChild(td10);
                // tr.appendChild(cont_button);

                if(use_yn == "N"){
                	tr.setAttribute("style","color:gray;text-decoration:line-through;");
                }
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
        console.log("키워드" + keyword)
        
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
            
            console.log(page);
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
        let imgTag = document.getElementById("images");
        getAll(1,"");

        $("#create_button").click(function () {
          window.location.href="goods_createform.jsp"
        });
        $("#search_button").click(function(){
          getAll(1,$("#search").val(), $("#keyword").val())
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
				<h1>모든 포인트 상품 (관리자)</h1>	
				
	<div style="width:1200px;">
    <span id="acceptedList">
      <input type="checkbox" id="xC" onClick="checkControl(this)" class="requests form-check-input" checked> 
      <label for="xC" class="form-check-label"> 모든 굿즈 </label>
  </span>
  
  <span id="acceptedList">
      <input type="checkbox" id="aC" onClick="checkControl(this)" class="requests form-check-input"> 
      <label for="aC" class="form-check-label"> 사용가능 굿즈 </label>
  </span>
  <span id="rejectedList">
      <input type="checkbox" id="rC" onClick="checkControl(this)" class="requests form-check-input"> 
      <label for="rC" class="form-check-label"> 사용불가능 굿즈 </label>
  </span>
  <br><br>
    <span>
    <select id="search" style="border-radius: 20px;">
      <option value="goods_name">굿즈명</option>
      <option value="create_member">등록자</option>
      <option value="update_member">수정자</option>
    </select>
    <input type="text" id="keyword" placeholder="검색" style="width:500px;border-radius: 20px;"> 
    <button type="button" id="search_button" class="btn btn-dark">검색</button>
    </span>
    <span style="margin-left:200px;">
    <button type="button" id="create_button" name="create_button" class="btn btn-dark">굿즈 만들기</button>
	</span>
    <br><br>
      <table style="text-align:center; width: 100%"
								class="mt-3 table table-hover">
        <thead>
        	<th>상품번호</th>
            <th>상품명</th>
            <th>포인트</th>
            <th>상품설명</th>
            <th>등록자</th>
            <th>등록일</th>
            <th>수정자</th>
            <th>수정일</th>
            <th>총 요청 횟수</th>
        </thead>
        <tbody id="gbody" style="text-align: center;">

        </tbody>
    </table>
	<div style="width:100%">
      <nav aria-label="Page navigation example" style="margin-left:300px;">
      <ul class="pagination" id="paget">
      </ul>
     </nav>
	</div>
  </div>

  			</div>
		</div>
	</div>		
	<jsp:include page="../footer.jsp"/>
  </body>
</html>



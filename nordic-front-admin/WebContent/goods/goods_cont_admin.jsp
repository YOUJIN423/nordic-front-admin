<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>(관리자) 굿즈 상세정보</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>
const contentType = 'image/png';

      $(document).ready(function () {
        const goodsNo = location.href.split('?')[1];
        console.log(goodsNo); // data
        let token = localStorage.getItem('wtw-token') || '';
        $.ajax({
            url: "http://localhost/api/goods/" + goodsNo,
            method: "get",
            contentType : "application/json",
            headers: {
		        'Authorization': `Bearer \${token}`,
		  	},
            data: { },
            success: function (success) {
              console.log(success.data);
              console.log(success.data.goods_name);
              var dt = success.data;

              $("#goods_name").text(dt.goods_name);
              $("#point").text(dt.point);
              $("#goods_desc").text(dt.goods_desc);
              $("#create_date").text(dt.create_date);
              $("#goods_no").text(dt.goods_no);
              if(dt.remark == null){
            	  var temp = ".";
              } else{
            	  var temp = dt.remark;
              }
              $("#remark").text(temp);
              $("#create_member").text(dt.create_member);
              $("#update_date").text(dt.update_date);
              $("#update_member").text(dt.update_member);
              
              if(dt.use_yn == "N"){
            	  $("#state").html("<h2>삭제된 상품입니다.</h2>")
              }
              
              getImages(dt);
              getRequests(goodsNo,1);
            },
            error: function (error) {
              if(error.responseJSON.message.substring(0,4) == '0002'){
                alert("없는 상품입니다");
                location.href='goods_all.jsp';
              }
            },
          });

          $("#update_button").click(function () {
          window.localStorage.setItem("goods_no", goodsNo);
          console.log("콘솔" + goodsNo);
          window.location.href="goods_updateform.jsp"
          });
          $("#delete_button").click(function () {
            if(!confirm("삭제하시겠습니까?")){

            }else{
            $.ajax({
            url: "http://localhost/api/goods/" + goodsNo,
            method: "delete",
            contentType : "application/json",
            headers: {
		        'Authorization': `Bearer \${token}`,
		  	},
            data: { },
            success: function (success) {
              alert("굿즈 삭제 성공");
              location.href="goods_all.jsp";
            },
            error: function (error) {
              if(error.responseJSON.message.substring(0,4) == '0010'){
            	  alert("이미 삭제된 상품입니다.")
              } else{
            	  alert("실패했습니다.")
              }
            },
          });
        }
          });
      });

      function getImages(dt){
              //const firstImage = new Image(100,100);
              var img1 = document.getElementById("image1");
              var img2 = document.getElementById("image2");
              var img3 = document.getElementById("image3");
              var img4 = document.getElementById("image4");
              var img5 = document.getElementById("image5");

              
              if(dt.image1 != null){
              img1.setAttribute("src","http://localhost/api/goods/image/" + dt.image1);
              img1.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img1.setAttribute("SRC","noimage.png");
              if(dt.image2 != null){
              img2.setAttribute("src","http://localhost/api/goods/image/" + dt.image2);
              img2.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img2.setAttribute("SRC","noimage.png");
              if(dt.image3 != null){
              img3.setAttribute("src","http://localhost/api/goods/image/" + dt.image3);
              img3.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img3.setAttribute("SRC","noimage.png");
              if(dt.image4 != null){
              img4.setAttribute("src","http://localhost/api/goods/image/" + dt.image4);
              img4.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img4.setAttribute("SRC","noimage.png");
              if(dt.image5 != null){
              img5.setAttribute("src","http://localhost/api/goods/image/" + dt.image5);
              img5.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img5.setAttribute("SRC","noimage.png");
            
          }
      function getRequests(goodsNo,pageNum){
    	  let token = localStorage.getItem('wtw-token') || '';
        $.ajax({
          url: "http://localhost/api/requests/goods/" + goodsNo + "?pageNum=" + pageNum,
          method: "get",
          headers: {
		        'Authorization': `Bearer \${token}`,
		  	},
          success: function(success){
            console.log(success.data.list);


            console.log(success.data.pages);
              console.log(success.data.list);
              console.log(success.data.list.length);
              $("#rbody").empty();
              var rbody = document.getElementsByTagName("tbody")[1];
              
              //$("#list").append(JSON.stringify(success.data));
              for (var i = 0; i< success.data.list.length; i++){
                var rowData = success.data.list[i];
                var confirm_member = rowData.confirm_member;
                var confirm_yn = rowData.confirm_yn;
                if(confirm_yn == "N"){
                	confirm_yn = "미확인";
                } else{
                	confirm_yn = "확인";
                }
                var create_date = rowData.create_date;
                var create_member = rowData.create_member;
                var member_code = rowData.member_code;
                var refuse_yn = rowData.refuse_yn;
                if(refuse_yn == "N"){
                	refuse_yn = "수락";
                } else{
                	refuse_yn = "거절";
                }
                var remark = rowData.remark;
                if(remark == null){
                	remark = ".";
                }
                var request_no = rowData.request_no;
                var update_date = rowData.update_date;
                var update_member = rowData.update_member;
                var use_yn = rowData.use_yn;

                var tdConfirmMember = document.createTextNode(confirm_member);
                var tdConfirmYn = document.createTextNode(confirm_yn);
                var tdCreateDate = document.createTextNode(create_date);
                var tdMemberCode = document.createTextNode(member_code);
                var tdRefuseYn = document.createTextNode(refuse_yn);
                var tdRemark = document.createTextNode(remark);
                var tdRequestNo = document.createTextNode(request_no);
                var tdUpdateDate = document.createTextNode(update_date);
                var tdUseYn = document.createTextNode(use_yn);

                var tr = document.createElement("tr");
                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var td4 = document.createElement("td");
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                var td7 = document.createElement("td");
                var td9 = document.createElement("td");

                
                
                td4.appendChild(tdConfirmYn);
                td3.appendChild(tdCreateDate);
                td2.appendChild(tdMemberCode);
                td9.appendChild(tdRemark);
                td1.appendChild(tdRequestNo);
                if(confirm_yn == "확인"){
                	td7.appendChild(tdRefuseYn);
                	 td6.appendChild(tdUpdateDate);
                     td5.appendChild(tdConfirmMember);
                } 
               
                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td4);
                tr.appendChild(td5);
                tr.appendChild(td6);
                tr.appendChild(td7);
                tr.appendChild(td9);

                if(use_yn == "N"){
                	tr.setAttribute("style","color:gray;text-decoration:line-through;");
                }
                rbody.appendChild(tr);  
              }
              paging(pageNum, success.data.pages, goodsNo)
          },
          error: function(error){
            console.log(error);
          }
        })
      }
      function paging(pageNum, pages, goodsNo){
        				/* 페이징 */
				var total = pages
				var pagenation = ``;
				
				var startPage = Math.floor((pageNum-1)/10)*10 + 1;
				var endPage = startPage+9;
				
				var prev;
				if(pageNum>10) {
                    var temp = startPage-1;
                    console.log(temp);
					// prev = `<a onclick=getRequests(` + goodsNo + `,` + temp + `)>[이전]</a>`
          prev = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onClick=getRequests(\${goodsNo},\${temp})>Previous</a></li>`
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
            page = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getRequests(\${goodsNo},\${p})>\${p}</a></li>`;
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
          later = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getRequests(\${goodsNo},\${temp})>Next</a></li>`
          
				}
				
				pagenation = prev+pageList+later;
				

				$("#paget").html(pagenation);
      }
    </script>
    <title>Document</title>
  </head>
 <body style="width:100%">
 <jsp:include page="../header.jsp"/>
  	<div class="container mt-5 mb-5">
		<div class="row">
			<jsp:include page="../sidebar.jsp"/>
			<div class="col-sm-10 ps-5">
				<h1>포인트 상품 상세정보 (관리자)</h1>	
				<br>
				
    <div style="width:1200px;" id="all">

    
    <button type="button" id="update_button" name="update_button" class="btn btn-dark">수정</button>
    <button type="button" id="delete_button" name="delete_button" class="btn btn-dark">삭제</button>
    <br><br>
    <table id="ttable" style="text-align:center; width: 100%"
								class="mt-3 table table-hover">
								<div id="state"></div>
      <tbody>
        <tr>
          <th>상품번호</th>
          <td id="goods_no"></td>
        </tr>
        <tr>
          <th>상품명</th>
          <td id="goods_name"></td>
        </tr>
        <tr>
          <th>포인트</th>
          <td id="point"></td>
        </tr>
        <tr>
          <th>상품설명</th>
          <td id="goods_desc"></td>
        </tr>
        <tr>
          <th>사진1</th>
          <td>
          <img id="image1" src="/" width="100" height="100"></img>
          </td>
        </tr>
        <tr>
          <th>사진2</th>
          <td>
            <img id="image2" src="/" width="100" height="100"></img>
          </td>
        </tr>
        <tr>
          <th>사진3</th>
          <td>
            <img id="image3" src="/" width="100" height="100"></img>
          </td>
        </tr>
        <tr>
          <th>사진4</th>
          <td>
            <img id="image4" src="/" width="100" height="100"></img>
          </td>
        </tr>
        <tr>
          <th>사진5</th>
          <td>
            <img id="image5" src="/" width="100" height="100"></img>
          </td>
        </tr>
        <tr>
          <th>기타</th>
          <td id="remark"></td>
        </tr>
        <tr>
          <th>등록자</th>
          <td id="create_member"></td>
        </tr>
        <tr>
          <th>등록일</th>
          <td id="create_date"></td>
        </tr>
        <tr>
          <th>수정자</th>
          <td id="update_member"></td>
        </tr>
        <tr>
          <th>수정일</th>
          <td id="update_date"></td>
        </tr>
      </tbody>
  </table>
<br><br>
<table style="text-align:center; width: 100%"
								class="mt-3 table table-hover">
  <thead style="text-align: center;">
      <tr>
          <th>요청번호</th>
          <th>멤버번호</th>
          <th>요청일시</th>
          <th>확인여부</th>
          <th>확인자</th>
          <th>확인일시</th>
          <th>거절여부</th>
          <th>기타</th>
      </tr>
  </thead>
  <tbody id="rbody" name="rbody" style="text-align: center;"></tbody>
  
  <h1>해당 포인트 상품 요청 보기</h1>	
  <br>
</table>
	<div style="width:100%">
      <nav aria-label="Page navigation example" style="margin-left:300px;">
      <ul class="pagination" id="paget">
      </ul>
     </nav>
	</div>
</div>
</div></div></div>
 <jsp:include page="../footer.jsp"/>
  </body>
</html>



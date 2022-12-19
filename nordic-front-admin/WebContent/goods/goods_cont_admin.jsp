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
              $("#use_yn").text(dt.use_yn);
              $("#remark").text(dt.remark);
              $("#create_member").text(dt.create_member);
              $("#update_date").text(dt.update_date);
              $("#update_member").text(dt.update_date);
              
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
              alert(error);
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
              img1.setAttribute("SRC","default_pic_jy.jpg");
              if(dt.image2 != null){
              img2.setAttribute("src","http://localhost/api/goods/image/" + dt.image2);
              img2.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img2.setAttribute("SRC","default_pic_jy.jpg");
              if(dt.image3 != null){
              img3.setAttribute("src","http://localhost/api/goods/image/" + dt.image3);
              img3.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img3.setAttribute("SRC","default_pic_jy.jpg");
              if(dt.image4 != null){
              img4.setAttribute("src","http://localhost/api/goods/image/" + dt.image4);
              img4.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img4.setAttribute("SRC","default_pic_jy.jpg");
              if(dt.image5 != null){
              img5.setAttribute("src","http://localhost/api/goods/image/" + dt.image5);
              img5.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img5.setAttribute("SRC","default_pic_jy.jpg");
            
          }
      function getRequests(goodsNo,pageNum){
        $.ajax({
          url: "http://localhost/api/requests/goods/" + goodsNo + "?pageNum=" + pageNum,
          method: "get",
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
                var create_date = rowData.create_date;
                var create_member = rowData.create_member;
                var member_code = rowData.member_code;
                var refuse_yn = rowData.refuse_yn;
                var remark = rowData.remark;
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
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                var td7 = document.createElement("td");
                var td8 = document.createElement("td");
                var td9 = document.createElement("td");

                var td11 = document.createElement("td");

                
                td1.appendChild(tdConfirmMember);
                td2.appendChild(tdConfirmYn);
                td3.appendChild(tdCreateDate);
                td5.appendChild(tdMemberCode);
                td6.appendChild(tdRefuseYn);
                td7.appendChild(tdRemark);
                td8.appendChild(tdRequestNo);
                td9.appendChild(tdUpdateDate);
                td11.appendChild(tdUseYn);

                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td5);
                tr.appendChild(td6);
                tr.appendChild(td7);
                tr.appendChild(td8);
                tr.appendChild(td9);
                tr.appendChild(td11);


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
    <div style="width:800px;" class="mx-auto">

    
    <button type="button" id="update_button" name="update_button" class="btn btn-dark">수정</button>
    <button type="button" id="delete_button" name="delete_button" class="btn btn-dark">삭제</button>
    <br><br>
    <table border="1" width="1000">
      <caption>굿즈 상세정보(관리자)</caption>
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
          <th>등록일</th>
          <td id="create_date"></td>
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
          <th>사용여부</th>
          <td id="use_yn"></td>
        </tr>
        <tr>
          <th>기타</th>
          <td id="remark"></td>
        </tr>
        <tr>
          <th>생성자</th>
          <td id="create_member"></td>
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
<table border="1">
  <thead style="text-align: center;">
      <tr>
          <th>확인자</th>
          <th>확인여부</th>
          <th>요청일시</th>
          <th>요청한사람</th>
          <th>거절여부</th>
          <th>리마크</th>
          <th>요청번호</th>
          <th>확인일시</th>
          <th>사용여부</th>
      </tr>
  </thead>
  <tbody id="rbody" name="rbody" style="text-align: center;"></tbody>
</table>
<div id="page"></div>
<nav aria-label="Page navigation example">
  <ul class="pagination" id="paget">
  </ul>
</nav>
</div>
  </body>
</html>


